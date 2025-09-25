import { useEffect, useState } from "react";
import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
import { useNavigate } from "react-router";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import { passRequestApi } from "../../../api/AuthApi";
import { ILoginPhoneInput } from "../../../interface/Auth/FormInputInterface";
import { alertModalState } from "../../../modules/Client/Modal/Modal";
import { useData } from "../../../modules/Server/QueryHook";
import LoginPhoneView from "../../../view/Auth/Login/LoginPhoneView";
import Layout from "../../Common/Layout/Layout";

export default function LoginPhone() {
  // 리다이렉트
  const navigate = useNavigate();
  // alertModal 용 recoil atom 수정 함수 불러오기
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const { register, handleSubmit, setValue, watch } = useForm<ILoginPhoneInput>();
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

        // ============================== api 연동 성공 시 자리
        setValue("phoneCheck", true);
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

  const onPassDataReset = () => {
    setPassData("");
  };

  //  input button click
  /** 아이디/비밀번호 찾기 본인인증 버튼 */
  const phoneCheckClick = () => {
    if (watch("phoneCheck")) return;
    getPass.refetch();
    //================================ 핸드폰 인증 api 연결자리

    // ============================== api 연동 성공 시 자리
    // setValue("phoneCheck", true);

    // setAlertModal({
    //   isModal: true,
    //   content: `본인인증이 완료되었습니다.\n
    //   전화번호 변경을 누르시면 완료됩니다.`,
    // });
  };

  // form의 값들이 예외처리를 통과한 후에 발동
  const onValid: SubmitHandler<ILoginPhoneInput> = (formData) => {
    const { phoneCheck } = formData;
    if (!phoneCheck) {
      setAlertModal({
        content: "본인인증을 완료해주세요.",
        isModal: true,
      });
      return;
    }

    //================================아이디/비밀번호 찾기 api 실행

    // api 성공 시
    setAlertModal({
      isModal: true,
      content: "전화번호 변경이 완료되었습니다.",
      type: "check",
      onClick() {
        resetAlertModal();
        navigate("/");
      },
    });
  };
  const inValid: SubmitErrorHandler<ILoginPhoneInput> = (errors) => {
    const inputs = ["id", "password", "changePhone"];
    for (let i = 0; i < inputs.length; i++) {
      const currentError = errors[inputs[i]];
      if (currentError?.message) {
        setAlertModal({
          content: currentError.message,
          isModal: true,
        });
        break;
      }
    }
    return;
  };

  return (
    <Layout
      notSideBar={true}
      notInfo={true}
      fullWidth
      loginWidth
      notHeadTitle
      notBackground
      logoColor
      notBackgroundSystem
      notHeader
    >
      <LoginPhoneView
        register={register}
        onSubmit={handleSubmit(onValid, inValid)}
        phoneCheckClick={phoneCheckClick}
        phoneCheck={watch("phoneCheck")}
        phoneNumber={watch("phone") as string}
        passData={passData}
        onPassDataReset={onPassDataReset}
      />
    </Layout>
  );
}
