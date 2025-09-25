import { useEffect, useState } from "react";
import {
  SubmitErrorHandler,
  SubmitHandler,
  UseFormRegister,
  useForm,
} from "react-hook-form";
import { useNavigate, useParams } from "react-router";
import { useSearchParams } from "react-router-dom";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import styled from "styled-components";
import {
  adminHandLoginApi,
  adminOTPLoginApi,
  checkInvitationCodeApi,
  committerLoginApi,
  invitationCommitterApi,
  loginPhoneCheckApi,
  passRequestApi,
  userLoginApi,
  userLoginSecoundApi,
} from "../../../api/AuthApi";
import DefaultClient from "../../../api/DefaultClient";
import { companyMyInfoApi } from "../../../api/MyInfoApi";
import InputSet from "../../../components/Common/Input/InputSet";
import InputSet1 from "../../../components/Common/Input/InputSet1";
import { evaluationReadyInput } from "../../../components/EvaluationRoomProceed/EvaluationRoomStep";
import CommitterAgree from "../../../components/EvaluationRoomProceed/Modal/CommitterAgree";
import {
  IAdminLogin,
  ICommitterInvitationCode,
  ICommitterLogin,
  IUserLogin,
  IUserLoginSecound,
} from "../../../interface/Auth/ApiDataInterface";
import {
  IAdminLoginResponse,
  IUserLoginResponse,
} from "../../../interface/Auth/ApiResponseInterface";
import { ILoginInput } from "../../../interface/Auth/FormInputInterface";
import {
  IInviteCommitter2
} from "../../../interface/Master/MasterData";
import { MyInfoRes } from "../../../interface/MyInfo/MyInfoResponse";
import { CommitterAdd } from "../../../interface/Partners/Committer/CommitterTypes";
import { userState } from "../../../modules/Client/Auth/Auth";
import {
  alertModalState,
  contentModalState,
  loadingModalState,
} from "../../../modules/Client/Modal/Modal";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import theme from "../../../theme";
import { useAuth } from "../../../utils/AuthUtils";
import { getCookie, removeCookie, setCookie } from "../../../utils/ReactCookie";
import { Regex } from "../../../utils/RegularExpression";
import RoleUtils from "../../../utils/RoleUtils";
import { refreshJwt } from "../../../utils/jwt";
import SystemLandingView from "../../../view/System/Landing/LandingView";
import Layout from "../../Common/Layout/Layout";

type LoginPhoneCheck = {
  name: string;
  phone: string;
};

export default function Login() {
  const setAlertModal = useSetRecoilState(alertModalState);
  const contentModal = useSetRecoilState(contentModalState);
  const resetContentModal = useResetRecoilState(contentModalState);
  const loadingModal = useSetRecoilState(loadingModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const userData = useSetRecoilState(userState);
  const resetUserData = useResetRecoilState(userState);
  const userLoginData = useRecoilValue(userState);
  const navigate = useNavigate();
  const params = useParams();
  const type = params.type;
  const { isTokenExpired, refreshToken } = refreshJwt();
  const { logOut } = useAuth();
  const logout = () => {
    logOut(undefined);
  };

  // admin user 로그인 바꾸기
  const [isAdmin, setIsAdmin] = useState(false);

  // 로그인 여부 체크
  const [isLogined, setIsLogined] = useState(false);
  const [loginPassCheck, setLoginPassCheck] = useState(false);
  const [passProgress, setPassProgress] = useState<boolean>(false);

  useEffect(() => {
    if (userLoginData.role && getCookie("token")) return setIsLogined(true);
    setIsLogined(false);
  }, [userLoginData.role]);

  const changeAdmin = (val: boolean) => {
    // if (!loginPassCheck) {
    //   onLoginInfoReset();
    // }
    reset();
    setLoginType("loginTypeLeft");
    setIsAdmin((prev) => val);
  };

  // admin 로그인 방식 바꾸기
  const [loginType, setLoginType] = useState("loginTypeLeft");
  const changeLoginType = (type: string) => {
    // if (!loginPassCheck) {
    //   onLoginInfoReset();
    // }
    localStorage.setItem("loginType", type);
    setLoginType(type);
  };

  const { register, handleSubmit, reset, getValues, watch } =
    useForm<ILoginInput>();

  // 평가위원 초대 폼
  const { register: readyRegister, watch: readyWatch } =
    useForm<evaluationReadyInput>();

  // 평가위원 로그인 api
  const committerLogin = useSendData<IUserLoginResponse, ICommitterLogin>(
    committerLoginApi
  );
  // user 제안업체 로그인 api
  const userLogin = useSendData<IUserLoginResponse, IUserLogin>(userLoginApi);
  // user 제안업체 로그인 2차 api
  const userLoginSecound = useSendData<IUserLoginResponse, IUserLoginSecound>(
    userLoginSecoundApi
  );
  // user OTP 로그인 api
  const adminOTPLogin = useSendData<IAdminLoginResponse, IAdminLogin>(
    adminOTPLoginApi
  );
  // user 지문 로그인 api
  const adminHandLogin = useSendData<IAdminLoginResponse, IAdminLogin>(
    adminHandLoginApi
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

  const goPage = (linkType: string) => {
    if (RoleUtils.getClientRole(userLoginData.role) === "committer") {
      if (linkType === "room") navigate("/user/system/evaluation-room");
      if (linkType === "myInfo") navigate("/user/system/my-info");
    }
    if (RoleUtils.getClientRole(userLoginData.role) === "company") {
      if (linkType === "room") navigate("/user/system/evaluation-room");
      if (linkType === "myInfo") navigate("/user/system/my-info");
    }
  };

  // 평가위원 로그인 버튼 클릭 시 이벤트
  const onCommitterLoginClick = () => {
    contentModal({
      isModal: true,
      subText: "",
      onClose() {
        reset();
      },
      content: <CommitterLoginModal register={register} />,
      title: "평가위원 본인인증",
      onClick() {
        const { name, phone, birth, encData } = getValues();
        if (!name) {
          setAlertModal({
            isModal: true,
            content: "이름을 입력해주세요.",
          });
        }
        if (!phone) {
          setAlertModal({
            isModal: true,
            content: "전화번호를 입력해주세요.",
          });
        }
        if (!birth) {
          setAlertModal({
            isModal: true,
            content: "생년월일을 입력해주세요.",
          });
        }
        const committerData = { encData };
        committerLogin.mutate(committerData, {
          onSuccess(data) {
            const { access_token, ...info } = data.data.data;
            setCookie("role", "user");
            setCookie("token", access_token);
            DefaultClient.defaults.headers.common["Authorization"] =
              "Bearer " + access_token;
            setCookie("authority", "committer");
            userData({
              ...info,
              role: process.env.REACT_APP_ROLE_COMMITTER as string,
            });
            resetContentModal();
          },
        });
      },
      buttonText: "확인",
    });
  };

  const onValid: SubmitHandler<ILoginInput> = (formData) => {
    // ------------------------------ 로그인 api 연결
    if (
      userLogin.isLoading ||
      adminOTPLogin.isLoading ||
      adminHandLogin.isLoading
    )
      return;
    setCookie("type", String(params.type));
    const { id, password, phone, birth, name } = formData;
    const apiData = { id, password };
    if (!isAdmin) {
      // 로그인 성공 시 권한에 따라 회원정보 수정 및 라우팅
      // if (loginType === "loginTypeLeft") {
      //   onCommitterLoginClick();
      // }
      if (loginType === "loginTypeRight") {
        userLogin.mutate(apiData, {
          onSuccess(data) {
            const { access_code } = data.data.data;

            setCookie("access_code", access_code);

            getPass.refetch();
          },
        });
      }
    }

    if (isAdmin) {
      if (loginType === "loginTypeLeft") {
        adminOTPLogin.mutate(apiData, {
          onSuccess(data) {
            const { access_token, ...info } = data.data.data;
            setCookie("role", "admin");
            setCookie("pass", "checkTrue");
            setCookie("authority", "admin");
            setCookie("token", access_token);
            DefaultClient.defaults.headers.common["Authorization"] =
              "Bearer " + access_token;
            userData({
              role: process.env.REACT_APP_ROLE_SYSTEM_ADMIN as string,
              ...info,
            });
            navigate("/west/system/dashboard");
          },
        });
      }
      if (loginType === "loginTypeRight") {
        loadingModal({
          isModal: true,
          isButton: true,
          type: "default",
          subText: `OTP 앱을 확인해주세요.\n지문인식 인증을 진행해주세요.`,
          onClick() {
            resetLoadingModal();
          },
        });

        adminHandLogin.mutate(apiData, {
          onSuccess(data) {
            resetLoadingModal();
            const { access_token, ...info } = data.data.data;
            setCookie("role", "admin");
            setCookie("pass", "checkTrue");
            setCookie("authority", "admin");
            setCookie("token", access_token);
            DefaultClient.defaults.headers.common["Authorization"] =
              "Bearer " + access_token;
            userData({
              role: process.env.REACT_APP_ROLE_SYSTEM_ADMIN as string,
              ...info,
            });
            navigate("/west/system/dashboard");
            // if (type === "partners") navigate("/west/partners/dashboard");
            // if (type === "system") navigate("/west/system/dashboard");
          },
        });
      }
    }
  };
  const inValid: SubmitErrorHandler<ILoginInput> = (errors) => {
    const inputs = ["id", "password", "name", "phone", "birth"];
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

  // user 로그인 2차 전화번호 인증
  const userPhoneLogin = useSendData<any, LoginPhoneCheck>(loginPhoneCheckApi);

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
    if (process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL") {
      setIsAdmin(true);
    }
    const listener = (event: StorageEvent) => {
      const pass = event.storageArea?.getItem("passData");
      const loginType = localStorage.getItem("loginType");

      if (pass && event.key === "passData") {
        const data = JSON.parse(pass);

        if (loginType === "loginTypeRight") {
          const item = {
            id: watch("id"),
            // name: data.name,
            // phone: data.mobile,
            // birth: data.birth,
            encData: data.encData,
            accessCode: getCookie("access_code"),
          };

          userLoginSecound.mutate(item, {
            onSuccess(userInfo) {
              const { access_token, role, info, isChangePassword } =
                userInfo.data.data;

              setCookie("token", access_token);
              DefaultClient.defaults.headers.common["Authorization"] =
                "Bearer " + access_token;

              setCookie("role", "user");
              setCookie("authority", "company");
              getCompanyInfo();

              setCookie("pass", "checkTrue");
              setLoginPassCheck(true);

              setPassProgress(false);
              localStorage.removeItem("passData");
              localStorage.removeItem("loginType");

              if (isChangePassword) {
                setAlertModal({
                  isModal: true,
                  content:
                    "비밀번호를 변경한지 90일이 지났습니다.\n비밀번호를 변경해주세요.",
                });
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
        } else {
          const item = {
            // name: data.name,
            // phone: data.mobile,
            // birth: data.birth,
            encData: data.encData,
          };

          committerLogin.mutateAsync(item, {
            onSuccess(data) {
              const { access_token, ...info } = data.data.data;
              setCookie("pass", "checkTrue");
              setLoginPassCheck(true);
              setCookie("role", "user");
              setCookie("token", access_token);
              DefaultClient.defaults.headers.common["Authorization"] =
                "Bearer " + access_token;
              setCookie("authority", "committer");
              localStorage.removeItem("passData");
              localStorage.removeItem("loginType");
              userData({
                ...info,
                role: process.env.REACT_APP_ROLE_COMMITTER as string,
              });
              resetContentModal();
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

        setPassData("");
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
    if (isAdmin) setLoginPassCheck(true);
    if (getCookie("pass") && isLogined) setLoginPassCheck(true);
    if (getCookie("token")) setLoginPassCheck(true);

    return () => {
      setLoginPassCheck(false);
    };
  }, [isAdmin]);

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
    setPassData("");
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
    localStorage.removeItem("passData");
    localStorage.removeItem("loginType");
    sessionStorage.removeItem("user");
    resetUserData();
  };



  const [ searchParams ] = useSearchParams();
  const invitationCode = searchParams.get("invitation");

  const checkInvitationCode = useSendData<any, ICommitterInvitationCode>(
    checkInvitationCodeApi
  );

  const {
    register: invitationRegister, 
    setValue: invitationSetValue, 
    watch: invitationWatch, 
    reset: invitationReset
  } = useForm<CommitterAdd>({});


  const setContentModal = useSetRecoilState(contentModalState);

    // 평가위원 초대 api
    const inviteCommitter = useSendData<string, IInviteCommitter2>(
      invitationCommitterApi
    );

  const onInviteCommitter = (data: IInviteCommitter2) => {
    inviteCommitter.mutate(data, {
      onSuccess() {
        setAlertModal({
          content: (
            <span
              style={{
                textAlign: "center",
                lineHeight: theme.fontType.bodyLineHeight.lineHeight,
              }}
            >
              {/* 평가위원에게 회원가입 링크가 발송되었습니다.
                <br /> 회원가입 진행 후 자동 승인되어 회원으로 등록됩니다. */}
              평가위원이 등록 되었습니다.
            </span>
          ),
          onClick: () => {
            resetContentModal();
            invitationReset();
          },
          type: "check",
          isModal: true,
        });
      },
      onError(error) {
        console.error("Error inviting committer:", error);
      },
    });
  };

  useEffect(() => {
    if (invitationCode) {
      checkInvitationCode.mutate(
        { code: invitationCode },
        {
          onSuccess(res) {
            const {
              data: { data },
            } = res;

            if (data) {
              
              setContentModal({
                content: (
                  <CommitterAgree register={readyRegister} isCommitter={true} isSignup={true}/>
                ),
                isModal: true,
                subText: "",
                title: "약관 동의",
                buttonText: "제출",
                onClick() {
                  setAlertModal({
                    isModal: true,
                    content: "약관 동의 내용을 제출하시겠습니까?",
                    onClick() {
                      if (
                        !readyWatch("agree1")
                      ) {
                        setAlertModal({
                          isModal: true,
                          content: "모든 약관에 동의해야 합니다.",
                        });
                        return;
                      }
                      setAlertModal({
                        isModal: true,
                        content: "정상적으로 제출되었습니다.",
                        onClick() {
                          resetContentModal();
                          console.log(res.data.data)
                          invitationSetValue('email', res.data.data)
                          setContentModal({
                            isModal: true,
                            title: "평가위원 등록",
                            subText: (
                              <p
                                style={{
                                  textAlign: "center",
                                  lineHeight:
                                    theme.fontType.bodyLineHeight.lineHeight,
                                }}
                              >
                                평가위원의 정보를 입력해주세요.
                              </p>
                            ),
                            content: <CommitterAddInput register={invitationRegister} />,
                            buttonText: "저장",
                            onClick() {
                              onInviteCommitter({
                                            email: invitationWatch("email"),
                                            phone: invitationWatch("phone"),
                                            name: invitationWatch("name"),
                                            birth: invitationWatch("birthday"),
                                            code: invitationCode ?? "",
                                          });
                            }
                          });
                        },
                        type: "check",
                      });
                    },
                  });
                },
              });
            } else {
              setAlertModal({
                isModal: true,
                type: "error",
                content: "만료된 초대 코드입니다.",
                title: "평가위원 초대",
              });
            }
          },
        }
      );
    }
  }, []);

  return (
    <>
      {/* {invitationModalOpen && <CommitterAddInput />} */}

      <Layout
        notSideBar={true}
        notInfo={true}
        fullWidth
        fullHeight
        loginWidth
        notHeadTitle
        notBackground
        logoColor
        notHeader
        notBackgroundSystem
      >
        <SystemLandingView
          changeAdmin={changeAdmin}
          register={register}
          onSubmit={handleSubmit(onValid, inValid)}
          isAdmin={isAdmin}
          loginType={loginType}
          changeLoginType={changeLoginType}
          userData={userLoginData}
          isLogined={isLogined}
          onLogout={logout}
          goPage={goPage}
          onCommitterLoginClick={onCommitterLoginClick}
          passData={passData}
          loginPassCheck={loginPassCheck}
          onLoginPhoneCheck={onLoginPhoneCheck}
          onCancelLoginPhone={onCancelLoginPhone}
          passDataReset={passDataReset}
        />
      </Layout>
    </>
  );
}

const CommitterLoginModal = ({
  register,
}: {
  register: UseFormRegister<ILoginInput>;
}) => {
  return (
    <CommitterLoginModalContainer>
      <InputSet
        type="text"
        label="이름"
        register={register("name")}
        placeholder="이름을 입력해주세요."
      />
      <InputSet
        type="text"
        label="전화번호"
        register={register("phone")}
        placeholder="전화번호를 입력해주세요."
      />
      <InputSet
        type="text"
        label="생년월일"
        register={register("birth")}
        placeholder="생년월일을 입력해주세요."
      />
    </CommitterLoginModalContainer>
  );
};

const CommitterLoginModalContainer = styled.div`
  width: 600px;
  display: flex;
  flex-direction: column;
  gap: 16px;
`;

const CommitterAddInputBlock = styled.div`
  width: 752px;
  height: 320px;
  margin-top: 64px;
  display: flex;
  flex-direction: column;
  gap: 28px;
`;

export function CommitterAddInput({register}: {register: UseFormRegister<CommitterAdd>}) {
  

  return (
    <CommitterAddInputBlock>
      <InputSet1
        type="text"
        label="이름"
        placeholder="이름을 입력해 주세요."
        register={register("name", { required: "이름을 111입력해주세요." })}
      />
      <InputSet1
        type="text"
        label="생년월일"
        placeholder="생년월일을 입력해 주세요. (ex: 20220101)"
        register={register("birthday", {
          required: "생년월일을 입력해주세요.",
          pattern: {
            value: Regex.numberRegex,
            message: "숫자만 입력해주세요.",
          },
        })}
      />
      <InputSet1
        type="text"
        label="휴대폰 번호"
        placeholder="숫자만 입력해 주세요.(ex: 01012345678)"
        register={register("phone", {
          required: "휴대폰 번호를 입력해 주세요.",
          pattern: {
            value: Regex.phoneRegExp,
            message: "알맞은 형식의 휴대폰 번호를 숫자만 입력하세요.",
          },
        })}
      />
      <InputSet1
        type="text"
        label="이메일(선택)"
        readOnly={true}
        placeholder="이메일을 입력해 주세요."
        register={register("email", {
          required: "이메일을 입력해 주세요.",
          pattern: {
            value: Regex.emailRegex,
            message: "알맞은 형식의 이메일을 입력하세요.",
          },
        })}
      />
    </CommitterAddInputBlock>
  );
}
