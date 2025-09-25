import { watch } from "fs";
import { useEffect, useState } from "react";
import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
import { useLocation, useNavigate } from "react-router";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import {
  adminHandLoginApi,
  adminOTPLoginApi,
  loginPhoneCheckApi,
  passRequestApi,
  ssoLoginApi,
  userLoginApi,
  userLoginSecoundApi,
} from "../../../api/AuthApi";
import DefaultClient from "../../../api/DefaultClient";
import { personalMyInfoApi, companyMyInfoApi } from "../../../api/MyInfoApi";
import {
  IAdminLogin,
  IUserLogin,
  IUserLoginSecound,
} from "../../../interface/Auth/ApiDataInterface";
import {
  IAdminLoginResponse,
  IUserLoginResponse,
} from "../../../interface/Auth/ApiResponseInterface";
import { ILoginInput } from "../../../interface/Auth/FormInputInterface";
import { MyInfoRes } from "../../../interface/MyInfo/MyInfoResponse";
import { userState } from "../../../modules/Client/Auth/Auth";
import { alertModalState, loadingModalState } from "../../../modules/Client/Modal/Modal";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import { useAuth } from "../../../utils/AuthUtils";
import { getCookie, removeCookie, setCookie } from "../../../utils/ReactCookie";
import PartnerLandingView from "../../../view/Partners/Landing/LandingView";
import Layout from "../../Common/Layout/Layout";
import LoginInternalView from "../../../view/Auth/Login/LoginInternalView";

interface LoginProps {
  type: "user" | "admin";
  route?: string;
}

type LoginPhoneCheck = {
  name: string;
  phone: string;
};

export default function Login(props: LoginProps) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const loadingModal = useSetRecoilState(loadingModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const userData = useSetRecoilState(userState);
  const resetUserData = useResetRecoilState(userState);
  const userLoginData = useRecoilValue(userState);
  const navigate = useNavigate();
  const WPSSO = getCookie("WPSSO");
  const { logOut, ssoLogin } = useAuth();

  // 로그인 여부 체크
  const [isLogined, setIsLogined] = useState(false);
  const [loginPassCheck, setLoginPassCheck] = useState(false);
  const [passProgress, setPassProgress] = useState<boolean>(false);

  useEffect(() => {
    if (userLoginData.id && getCookie("token")) return setIsLogined(true);
    setIsLogined(false);
  }, [userLoginData.id]);

  useEffect(() => {
    if (props.type === "admin") setLoginPassCheck(true);
    if (getCookie("pass") && isLogined) setLoginPassCheck(true);
    if (getCookie("token")) setLoginPassCheck(true);
    return () => {
      setLoginPassCheck(false);
    };
  }, [props.type]);

  // admin 로그인 방식 바꾸기
  const [loginType, setLoginType] = useState("otp");

  const changeLoginType = (type: string) => {
    setLoginType(type);
  };

  const { register, handleSubmit, reset, watch } = useForm<ILoginInput>();

  // user 로그인 api
  const userLogin = useSendData<IUserLoginResponse, IUserLogin>(userLoginApi);
  // user 로그인 2차 api
  const userLoginSecound = useSendData<IUserLoginResponse, IUserLoginSecound>(userLoginSecoundApi);

  // user OTP 로그인 api
  const adminOTPLogin = useSendData<IAdminLoginResponse, IAdminLogin>(adminOTPLoginApi);
  // user 지문 로그인 api
  const adminHandLogin = useSendData<IAdminLoginResponse, IAdminLogin>(adminHandLoginApi);
  // user 로그인 2차 전화번호 인증
  const userPhoneLogin = useSendData<any, LoginPhoneCheck>(loginPhoneCheckApi);

  // personal 내정보 api
  const { refetch: getPersonalInfo } = useData<MyInfoRes, null>(
    ["personalData", null],
    personalMyInfoApi,
    {
      enabled: false,
      onSuccess(data) {
        setCookie("authority", "personal");

        userData({
          ...data.data,
          role: process.env.REACT_APP_ROLE_PERSONAL as string,
        });
      },
    }
  );
  // company 내정보 api
  const { refetch: getCompanyInfo } = useData<MyInfoRes, null>(
    ["companyData", null],
    companyMyInfoApi,
    {
      enabled: false,
      onSuccess(data) {
        setCookie("authority", "company");
        userData({
          ...data.data,
          role: process.env.REACT_APP_ROLE_COMPANY as string,
        });
      },
    }
  );

  // 휴대폰 인증 요청하기
  const [passData, setPassData] = useState<string>("");
  const getPass = useData<string, null>(
    ["getPass", null],
    () => passRequestApi(String(window.location.origin) + "/pass"),
    {
      enabled: false,
      onSuccess(item) {        
        setPassProgress(true);
        setPassData(item.data);
      },
    }
  );

  const passDataReset = () => {
    setPassData("");
  };

  useEffect(() => {
    const listener = (event: StorageEvent) => {
      // console.log("--------------------- event ", event);
      const pass = event.storageArea?.getItem("passData");
      if (pass && event.key === "passData") {
        const data = JSON.parse(pass);

        const item = {
          id: watch("id"),
          // name: data.name,
          // phone: data.mobile,
          encData: data.encData,
          accessCode: getCookie("access_code"),
        };

        userLoginSecound.mutate(item, {
          onSuccess(userInfo) {
            const { access_token, role, info, isChangePassword } = userInfo.data.data;
            setCookie("role", "user");
            setCookie("token", access_token);

            DefaultClient.defaults.headers.common["Authorization"] = "Bearer " + access_token;

            if (role === process.env.REACT_APP_ROLE_PERSONAL) {
              setCookie("authority", "personal");
              getPersonalInfo();
            }

            if (role === process.env.REACT_APP_ROLE_COMPANY) {
              setCookie("authority", "company");
              getCompanyInfo();
            }

            setCookie("pass", "checkTrue");
            setLoginPassCheck(true);

            setPassProgress(false);
            passDataReset();
            removeCookie("access_code");
            reset();

            if(isChangePassword) {
              setAlertModal({
                    isModal: true,
                content: '비밀번호를 변경한지 90일이 지났습니다.\n비밀번호를 변경해주세요.'
              })
            }
          },
          onError(error: any) {
            setAlertModal({
              isModal: true,
              content: error.response?.data?.message,
              type: "check",
              onClick() {
                setLoginPassCheck(false);
                setIsLogined(false);
                onLoginInfoReset();
                // logOut();
              },
            });
          },
        });
      }
    };

    window.addEventListener("storage", listener);

    return () => {
      window.removeEventListener("storage", listener);
      localStorage.removeItem("passData");
      setPassData("");
    };
  }, []);

  useEffect(() => {
    if (!getCookie("pass")) {
      onLoginInfoReset();
    }
  }, []);

  const onLoginPhoneCheck = () => {
    getPass.refetch();
  };

  const onCancelLoginPhone = () => {
    localStorage.removeItem("passData");
    onLoginInfoReset();
  };

  const onLoginInfoReset = () => {
    reset();
    passDataReset();
    setPassProgress(false);
    removeCookie("token");
    removeCookie("role");
    removeCookie("authority");
    removeCookie("pass");
    removeCookie("access_code");
    sessionStorage.removeItem("user");
    resetUserData();
  };

  // 인증요청버튼 이벤트
  // const authClick = () => {
  //   const id = watch("id");

  //   if (!id) {
  //     setAlertModal({
  //       isModal: true,
  //       content: "사번을 입력하세요.",
  //     });
  //     return;
  //   }

  //   loadingModal({
  //     isModal: true,
  //     isButton: true,
  //     subText: `OTP 앱을 확인해주세요.\n일회용 비밀번호를 생성하신 후 확인을 눌러주세요.`,
  //   });
  // };

  // const ssoLogin = useSendData<any, string>(ssoLoginApi, {
  //   onSuccess(data) {
  //     const { access_token, ...info } = data.data.data;
  //     setCookie("role", "admin");
  //     setCookie("authority", "admin");
  //     setCookie("token", access_token);

  //     DefaultClient.defaults.headers.common["Authorization"] = "Bearer " + access_token;
  //     userData({
  //       role: process.env.REACT_APP_ROLE_SYSTEM_ADMIN as string,
  //       ...info,
  //     });
  //     resetLoadingModal();
  //     navigate("/west/partners/dashboard");
  //   },
  //   onError() {
  //     // logOut(() => console.log(""), "admin");
  //     resetLoadingModal();
  //   },
  // });

  const onValid: SubmitHandler<ILoginInput> = (formData) => {
    // ------------------------------ 로그인 api 연결
    if (userLogin.isLoading || adminOTPLogin.isLoading || adminHandLogin.isLoading) return;

    if (props.type === "user") {
      if (localStorage.getItem("passData")) {
        localStorage.removeItem("passData");
      }
      // 로그인 성공 시 권한에 따라 회원정보 수정 및 라우팅
      userLogin.mutate(formData, {
        onSuccess(data) {
          const { access_code } = data.data.data;

          setCookie("access_code", access_code);

          getPass.refetch();
        },
        onError() {
          reset();
          resetLoadingModal();
        },
      });
    }
    if (props.type === "admin") {
      const { id, password } = formData;
      if (loginType === "otp") {
        const data = { id, password };
        adminOTPLogin.mutate(data, {
          onSuccess(data) {
            const { access_token, ...info } = data.data.data;
            setCookie("role", "admin");
            setCookie("authority", "admin");
            setCookie("token", access_token);
            setCookie("pass", "checkTrue");
            DefaultClient.defaults.headers.common["Authorization"] = "Bearer " + access_token;
            userData({
              role: process.env.REACT_APP_ROLE_SYSTEM_ADMIN as string,
              ...info,
            });
            navigate("/west/partners/dashboard");
            alert("Dd");
          },
        });
      }
      if (loginType === "hand") {
        const data = { id };

        loadingModal({
          isFinger: true,
          isModal: true,
          isButton: true,
          subText: `지문인증을 확인 중입니다.\n잠시만 기다려주세요.`,
          onClick() {
            resetLoadingModal();
          },
        });

        adminHandLogin.mutate(data, {
          onSuccess(data) {
            const { access_token, ...info } = data.data.data;
            resetLoadingModal();
            setCookie("role", "admin");
            setCookie("authority", "admin");
            setCookie("token", access_token);
            setCookie("pass", "checkTrue");
            DefaultClient.defaults.headers.common["Authorization"] = "Bearer " + access_token;
            userData({
              role: process.env.REACT_APP_ROLE_SYSTEM_ADMIN as string,
              ...info,
            });
            navigate("/west/partners/dashboard");
          },
        });
      }

      if (loginType === "sso") {
        if (WPSSO) {
          ssoLogin(WPSSO);
        } else {
          setAlertModal({
            isModal: true,
            content: (
              <span>
                사내포털 연동을 위한 정보가 없습니다.
                <br />
                모바일 OTP 또는 지문인증 로그인을 이용해주세요.
              </span>
            ),
          });
        }
      }
    }
  };
  const inValid: SubmitErrorHandler<ILoginInput> = (errors) => {
    const inputs = ["id", "password"];
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
    <>
      {/* <div>111</div> */}
      <Layout
        notSideBar={true}
        notInfo={true}
        fullWidth
        loginWidth
        notHeadTitle
        notBackground
        logoColor
        useFooter={process.env.REACT_APP_SOURCE_DISTRIBUTE === "OUTSIDE" ? true : false}
        notBackgroundSystem
        noBottom
        notHeader
      >
        {process.env.REACT_APP_SOURCE_DISTRIBUTE === "OUTSIDE" ? (
          <PartnerLandingView
            register={register}
            onSubmit={handleSubmit(onValid, inValid)}
            loginType={loginType}
            changeLoginType={changeLoginType}
            // authClick={authClick}
            isLogined={isLogined}
            type={props.type}
            routeType={props.route}
            passData={passData}
            passProgress={passProgress}
            loginPassCheck={loginPassCheck}
            onLoginPhoneCheck={onLoginPhoneCheck}
            onCancelLoginPhone={onCancelLoginPhone}
            passDataReset={passDataReset}
          />
        ) : (
          <LoginInternalView />
        )}
      </Layout>
    </>
  );
}
