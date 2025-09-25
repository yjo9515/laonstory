import { useEffect, useState } from "react";
import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import { queryClient } from "../../..";
import { passRequestApi } from "../../../api/AuthApi";
import { committerChangePasswordApi, companyChangePasswordApi } from "../../../api/MyInfoApi";
import { IChangePassword } from "../../../interface/Auth/FormInputInterface";
import { alertModalState, contentModalState } from "../../../modules/Client/Modal/Modal";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import { MyInfoModalContainer } from "../../../theme/common";
import { formInvalid } from "../../../utils/FormInvalid";
import { Regex } from "../../../utils/RegularExpression";
import BigButton from "../../Common/Button/BigButton";
import Form from "../../Common/Container/Form";
import InputSet from "../../Common/Input/InputSet";
import PhoneAuthSet from "../../Common/Input/PhoneAuthSet";
import NicePhone from "../Nice/NicePhone";
import { MyInfoSize } from "./ChangeAdminModal";

export default function ChangePasswordModal({ type }: { type: string }) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const resetContentModal = useResetRecoilState(contentModalState);

  const { register, handleSubmit, watch, setValue } = useForm<IChangePassword>();

  // pass 정보
  const [passData, setPassData] = useState<string>("");

  // committer 비밀번호 변경 api
  const changeCommitterPassword = useSendData(committerChangePasswordApi);
  // company 비밀번호 변경 api
  const companyChangePassword = useSendData(companyChangePasswordApi);

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
          content: `본인인증이 완료되었습니다.`,
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

  const onClose = () => {
    setPassData("");
  };

  const phoneAuthClick = () => {
    if (watch("phoneCheck")) return;
    getPass.refetch();
  };

  const onValid: SubmitHandler<IChangePassword> = (formData) => {
    const { password, newPassword, confirmNewPassword, encData } = formData;

    if (newPassword.length < 9) {
      setAlertModal({
        isModal: true,
        content: "비밀번호를 영문, 숫자, 특수문자 포함 9자리 이상 입력해주세요.",
      });
      return;
    }
    if (!Regex.passwordRegex.test(newPassword)) {
      setAlertModal({
        isModal: true,
        content: "비밀번호를 영문, 숫자, 특수문자 포함 9자리 이상 입력해주세요.",
      });
      return;
    }
    //  비밀번호 일치 확인
    if (newPassword !== confirmNewPassword) {
      setAlertModal({
        isModal: true,
        content: "비밀번호가 다릅니다.",
      });
      return;
    }

    // 정보 수정 api 실행
    const data = { password, newPassword, encData };
    if (type === "committer") {
      changeCommitterPassword.mutate(data, {
        onSuccess() {
          // api 성공 시
          queryClient.invalidateQueries("committerData");
          queryClient.invalidateQueries("committerMyHistory");
          setAlertModal({
            type: "check",
            isModal: true,
            content: "변경이 완료되었습니다.",
            onClick() {
              resetContentModal();
              resetAlertModal();
            },
          });
        },
      });
    }
    if (type === "company") {
      companyChangePassword.mutate(data, {
        onSuccess() {
          // api 성공 시
          queryClient.invalidateQueries("companyData");
          queryClient.invalidateQueries("companyMyHistory");
          setAlertModal({
            type: "check",
            isModal: true,
            content: "변경이 완료되었습니다.",
            onClick() {
              resetContentModal();
              resetAlertModal();
            },
          });
        },
      });
    }
  };
  const inValid: SubmitErrorHandler<IChangePassword> = (errors) => {
    if (!watch("phone")) {
      setAlertModal({
        isModal: true,
        content: "휴대폰 인증을 완료해주세요.",
      });
      return;
    }
    const inputs = ["password", "newPassword", "confirmNewPassword"];
    const currentError = formInvalid(errors, inputs);
    if (currentError) setAlertModal(currentError);
  };

  return (
    <>
      <MyInfoSize>
        <MyInfoModalContainer>
          <Form onSubmit={handleSubmit(onValid, inValid)}>
            <div className="main">
              <div>
                <PhoneAuthSet
                  textCenter
                  phoneCheck={watch("phoneCheck")}
                  phoneNumber={watch("phone") as string}
                  onClick={phoneAuthClick}
                />
                <InputSet
                  textCenter
                  bold
                  placeholder="비밀번호를 입력하세요."
                  register={register("password", { required: "비밀번호를 입력해주세요." })}
                  type="password"
                  label="비밀번호"
                />
              </div>
              <div className="centerLine"></div>
              <div>
                <InputSet
                  textCenter
                  bold
                  placeholder="변경할 비밀번호를 입력하세요."
                  register={register("newPassword", {
                    required: "변경할 비밀번호를 입력해주세요.",
                  })}
                  type="password"
                  label="변경할 비밀번호"
                />
                <InputSet
                  textCenter
                  bold
                  placeholder="변경할 비밀번호를 한번 더 입력하세요. 입력하세요."
                  register={register("confirmNewPassword", {
                    required: "변경할 비밀번호를 한번 더 입력하세요. 입력해주세요.",
                  })}
                  type="password"
                  label="변경할 비밀번호 확인"
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
