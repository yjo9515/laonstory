import { useEffect, useState } from "react";
import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
import { useParams } from "react-router";
import { useNavigate } from "react-router";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import { findIdApi, findPasswordApi, passRequestApi } from "../../../api/AuthApi";
import { IFindId, IFindPassword } from "../../../interface/Auth/ApiDataInterface";
import { ILoginFindInput } from "../../../interface/Auth/FormInputInterface";
import { alertModalState } from "../../../modules/Client/Modal/Modal";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import { Regex } from "../../../utils/RegularExpression";
import LoginFindView from "../../../view/Auth/Login/LoginFindView";
import Layout from "../../Common/Layout/Layout";

export default function LoginFind() {
  // 리다이렉트
  const navigate = useNavigate();
  const params = useParams();
  // alertModal 용 recoil atom 수정 함수 불러오기
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetALertModal = useResetRecoilState(alertModalState);
  //  아이디 비밀번호 구분용 탭
  const [findType, setFindType] = useState<string>("id");
  // pass 정보
  const [passData, setPassData] = useState<string>("");
  // 아이디 비밀번호 전환 탭
  const tabClick = (type: string) => {
    // 탭 클릭시마다 초기화
    reset();
    setFindType(type);
  };

  useEffect(() => {
    if (params.type) setFindType(params.type);
  }, [params.type]);

  //  useForm Hook
  const {
    register,
    handleSubmit,
    setValue,
    reset, // 탭이 바뀔 때마다 값이 초기화 됨
    watch,
  } = useForm<ILoginFindInput>();

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
        setValue("phoneNumber", data.mobile);
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

  // 아이디 찾기 api
  const findId = useSendData<string, IFindId>(findIdApi);
  // 비밀번호 찾기 api
  const findPassword = useSendData<string, IFindPassword>(findPasswordApi);

  // =================================================== 폼관련

  //  input button click event
  /** 아이디/비밀번호 찾기 본인인증 버튼 */
  const phoneCheckClick = () => {
    //================================ 핸드폰 인증 api 연결자리
    if (watch("phoneCheck")) return;
    getPass.refetch();
  };

  // form의 값들이 예외처리를 통과한 후에 발동
  const onValid: SubmitHandler<ILoginFindInput> = (formData) => {
    // ===================== 아이디 찾기
    if (findType === "id") {
      const { email } = formData;
      //================================아이디 api 실행
      findId.mutate(
        { email },
        {
          onSuccess() {
            setAlertModal({
              isModal: true,
              content: `이메일이 발송되었습니다.\n이메일을 확인해주세요.`,
            });
          },
        }
      );
    }
    // ===================== 비밀번호 찾기
    if (findType === "password") {
      const { phoneCheck, newPassword, confirmNewPassword, id, phoneNumber, encData } = formData;
      const data = { id, password: newPassword, encData };
      if (!phoneCheck) {
        setAlertModal({
          content: "본인인증을 완료해주세요.",
          isModal: true,
        });
        return;
      }

      if (newPassword.length < 9) {
        setAlertModal({
          isModal: true,
          content: "비밀번호를 영문, 숫자, 특수문자(!,@,#,$,%,?,&,*) 포함 9자리 이상 입력해주세요.",
        });
        return;
      }
      if (!Regex.passwordRegex.test(newPassword)) {
        setAlertModal({
          isModal: true,
          content: "비밀번호를 영문, 숫자, 특수문자(!,@,#,$,%,?,&,*) 포함 9자리 이상 입력해주세요.",
        });
        return;
      }
      if (newPassword !== confirmNewPassword) {
        setAlertModal({
          content: "비밀번호가 서로 다릅니다.",
          isModal: true,
        });
        return;
      }

      // ===============================비밀번호 찾기 api 실행

      // console.log(data);

      findPassword.mutate(data, {
        onSuccess() {
          // // api 성공 시
          setAlertModal({
            isModal: true,
            content: "비밀번호 변경이 완료되었습니다.",
            type: "check",
            onClick() {
              resetALertModal();
              navigate("/");
            },
          });
        },
      });
    }
  };
  // 예외처리 발생시 실행되는 함수
  const inValid: SubmitErrorHandler<ILoginFindInput> = (errors) => {
    const inputs = ["email", "id", "newPassword", "confirmNewPassword"];
    for (let i = 0; i < inputs.length; i++) {
      const currentError = errors[inputs[i]];
      if (currentError?.message) {
        setAlertModal({
          content: currentError.message,
          title: "입력되지 않은 값",
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
      useFooter
      notBackgroundSystem
      notHeader
    >
      <LoginFindView
        findType={findType}
        tabClick={tabClick}
        register={register}
        onSubmit={handleSubmit(onValid, inValid)}
        phoneCheckClick={phoneCheckClick}
        phoneCheck={watch("phoneCheck")}
        phoneNumber={watch("phoneNumber") as string}
        watch={watch}
        passData={passData}
        onPassDataReset={onPassDataReset}
      />
    </Layout>
  );
}
