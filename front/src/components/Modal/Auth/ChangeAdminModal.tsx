import { useEffect, useState } from "react";
import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import styled from "styled-components";
import { queryClient } from "../../..";
import { passRequestApi } from "../../../api/AuthApi";
import { companyChangePhoneApi } from "../../../api/MyInfoApi";
import { IChangeAdmin } from "../../../interface/Auth/FormInputInterface";
import { alertModalState, contentModalState } from "../../../modules/Client/Modal/Modal";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import { MyInfoModalContainer } from "../../../theme/common";
import { formInvalid } from "../../../utils/FormInvalid";
import BigButton from "../../Common/Button/BigButton";
import Form from "../../Common/Container/Form";
import InputSet from "../../Common/Input/InputSet";
import PhoneAuthSet from "../../Common/Input/PhoneAuthSet";
import NicePhone from "../Nice/NicePhone";

export default function ChangeAdminModal({ type }: { type: string }) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const resetContentModal = useResetRecoilState(contentModalState);

  // pass 정보
  const [passData, setPassData] = useState<string>("");

  // api 호출
  const companyChangePhone = useSendData(companyChangePhoneApi);

  const { handleSubmit, setValue, register, watch } = useForm<IChangeAdmin>();

  // 휴대폰 인증 요청하기
  const getPass = useData<string, null>(
    ["getPass", null],
    () => passRequestApi(String(window.location.origin) + "/pass"),
    {
      enabled: false,
      onSuccess(item) {
        setPassData(item.data);
      },
    }
  );

  useEffect(() => {
    const listener = (event: StorageEvent) => {
      const pass = event.storageArea?.getItem("passData");

      const passType = sessionStorage.getItem("passType");

      if (pass) {
        const data = JSON.parse(pass);

        if (passType === "old") {
          setValue("phoneCheck", true);
          setValue("originalPhone", data.mobile);
          setValue("encData", data.encData);
        }

        if (passType === "new") {
          setValue("managerName", data.name);
          setValue("phone", data.mobile);
          setValue("changeEncData", data.encData);
          setValue("currentPhoneCheck", true);
        }

        setAlertModal({
          isModal: true,
          content: "휴대폰 인증이 완료되었습니다.",
        });

        setPassData("");
        sessionStorage.removeItem("passType");
      }
    };

    window.addEventListener("storage", listener);

    return () => {
      window.removeEventListener("storage", listener);
      localStorage.removeItem("passData");
    };
  }, []);

  const onClose = () => {
    setPassData("");
  };

  const onValid: SubmitHandler<IChangeAdmin> = (formData) => {
    const { phoneCheck, phone, password, encData, changeEncData } = formData;
    if (!phoneCheck) {
      setAlertModal({
        isModal: true,
        content: "휴대폰 인증을 완료해주세요.",
        title: "휴대폰 인증",
      });
      return;
    }
    // 정보 수정 api 실행
    companyChangePhone.mutate(
      { encData, changeEncData, password },
      {
        onSuccess() {
          queryClient.invalidateQueries("companyData");
          queryClient.invalidateQueries("companyMyHistory");
          setAlertModal({
            type: "check",
            isModal: true,
            content: "담당자 정보 변경이 완료되었습니다.",
            onClick() {
              resetContentModal();
              resetAlertModal();
            },
          });
        },
      }
    );
    // api 성공 시
  };
  const inValid: SubmitErrorHandler<IChangeAdmin> = (errors) => {
    const inputs = ["id", "password"];
    const currentError = formInvalid(errors, inputs);
    if (currentError) setAlertModal(currentError);
  };

  const phoneAuth = () => {
    sessionStorage.setItem("passType", "old");
    getPass.refetch();
  };

  const nextPhoneAuth = () => {
    sessionStorage.setItem("passType", "new");
    getPass.refetch();
  };

  return (
    <>
      <MyInfoSize>
        <MyInfoModalContainer>
          <Form onSubmit={handleSubmit(onValid, inValid)}>
            <div className="main">
              <div>
                <InputSet
                  placeholder="비밀번호를 입력하세요."
                  textCenter
                  type="password"
                  label="비밀번호"
                  bold
                  register={register("password", {
                    required: "비밀번호를 입력하세요.",
                  })}
                />
              </div>
              <div className="centerLine"></div>
              <div>
                <PhoneAuthSet
                  textCenter
                  label="기존 등록된 휴대폰 번호"
                  onClick={phoneAuth}
                  phoneNumber={watch("phoneCheck") ? (watch("originalPhone") as string) : ""}
                  phoneCheck={watch("phoneCheck")}
                />
                <PhoneAuthSet
                  textCenter
                  label="새로 등록할 휴대폰 번호"
                  onClick={nextPhoneAuth}
                  phoneNumber={watch("currentPhoneCheck") ? (watch("phone") as string) : ""}
                  phoneCheck={watch("currentPhoneCheck")}
                />
              </div>
            </div>
            <div className="buttonContainer">
              <BigButton white text="취소" onClick={resetContentModal} />
              <BigButton submit text="확인" />
            </div>
          </Form>
        </MyInfoModalContainer>
      </MyInfoSize>
      {passData && <NicePhone passData={passData} onClose={onClose} />}
    </>
  );
}

export const MyInfoSize = styled.div`
  width: 800px;
  .main {
    height: 300px;
  }
`;
