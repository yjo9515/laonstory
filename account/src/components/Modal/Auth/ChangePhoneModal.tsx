import { useEffect, useState } from "react";
import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import styled from "styled-components";
import { queryClient } from "../../..";
import { passRequestApi } from "../../../api/AuthApi";
import { personalChangePhoneApi } from "../../../api/MyInfoApi";
import { IChangePhone } from "../../../interface/Auth/FormInputInterface";
import { IPersonalChangePhoneData } from "../../../interface/MyInfo/ApiData";

import { alertModalState, contentModalState } from "../../../modules/Client/Modal/Modal";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import { MyInfoModalContainer } from "../../../theme/common";
import { formInvalid } from "../../../utils/FormInvalid";
import InputButton from "../../Common/Button/InputButton";
import InputSet from "../../Common/Input/InputSet";
import PhoneAuthSet from "../../Common/Input/PhoneAuthSet";
import NicePhone from "../Nice/NicePhone";

export default function ChangePhoneModal({ type }: { type: string }) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const resetContentModal = useResetRecoilState(contentModalState);

  const { register, handleSubmit, setValue, watch } = useForm<IChangePhone>();

  // personal 전화번호 변경 api
  const personalChangePhone = useSendData<string, IPersonalChangePhoneData>(personalChangePhoneApi);
  // pass 정보
  const [passData, setPassData] = useState<string>("");

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
      if (pass) {
        const data = JSON.parse(pass);

        setValue("phoneCheck", true);
        setValue("name", data.name);
        setValue("phone", data.mobile);
        setValue("encData", data.encData);

        setAlertModal({
          isModal: true,
          content: "휴대폰 인증이 완료되었습니다.",
        });

        setPassData("");
      }
    };

    window.addEventListener("storage", listener);

    return () => {
      window.removeEventListener("storage", listener);
      localStorage.removeItem("passData");
    };
  }, []);

  //  ======================= 버튼 클릭 이벤트
  const phoneAuth = () => {
    getPass.refetch();
  };

  const onClose = () => {
    setPassData("");
  };

  const onValid: SubmitHandler<IChangePhone> = (formData) => {
    const { phoneCheck, password, phone, encData } = formData;
    if (!phoneCheck) {
      setAlertModal({
        isModal: true,
        content: "휴대폰 인증을 완료해주세요.",
      });
      return;
    }
    // 정보 수정 api 실행
    const data = { password, encData };
    personalChangePhone.mutate(data, {
      onSuccess() {
        queryClient.invalidateQueries("personalData");
        queryClient.invalidateQueries("personalMyHistory");
        setAlertModal({
          title: "변경완료",
          type: "check",
          isModal: true,
          content: "변경이 성공적으로 완료되었습니다.",
          isLoading: true,
          onClick() {
            resetContentModal();
            resetAlertModal();
          },
        });
      },
    });
    // api 성공 시
  };
  const inValid: SubmitErrorHandler<IChangePhone> = (errors) => {
    const inputs = ["password"];
    const currentError = formInvalid(errors, inputs);
    if (currentError) setAlertModal(currentError);
  };

  return (
    <>
      <MyInfoModalContainer>
        <form onSubmit={handleSubmit(onValid, inValid)}>
          <div className="main">
            <div>
              <InputSet
                textCenter
                bold
                placeholder="비밀번호를 입력하세요"
                register={register("password", { required: "비밀번호를 입력해주세요." })}
                type="password"
                label="비밀번호"
              />
            </div>
            {/* <div className="centerLine"></div> */}
            <div>
              <PhoneAuthSet
                phoneNumber={watch("phoneCheck") ? (watch("phone") as string) : ""}
                textCenter
                onClick={phoneAuth}
                phoneCheck={watch("phoneCheck")}
              />
            </div>
          </div>
          <div className="buttonContainer">
            <InputButton text="취소" onClick={resetContentModal} />
            <InputButton submit text="확인" />
          </div>
        </form>
      </MyInfoModalContainer>
      {passData && <NicePhone passData={passData} onClose={onClose} />}
    </>
  );
}
