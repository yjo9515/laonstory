import { useLocation, useNavigate } from "react-router";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import { logoutApi, ssoLoginApi } from "../api/AuthApi";
import DefaultClient from "../api/DefaultClient";
import { companyMyInfoApi, personalMyInfoApi } from "../api/MyInfoApi";
import { MyInfoRes } from "../interface/MyInfo/MyInfoResponse";
import { ssoLoginCheckState, userState } from "../modules/Client/Auth/Auth";
import { loadingModalState } from "../modules/Client/Modal/Modal";
import { useData, useSendData } from "../modules/Server/QueryHook";
import { getCookie, removeCookie, setCookie } from "./ReactCookie";
import { useEffect, useState } from "react";

export const useAuth = (): {
  logOut: (fn?: () => void, type?: "user" | "admin") => void;
  checkAuth: () => void;
  ssoLogin: (wpsso: string) => void;
} => {
  const navigate = useNavigate();
  const userData = useRecoilValue(userState);
  const ssoLoginCheck = useRecoilValue(ssoLoginCheckState);
  const userSetData = useSetRecoilState(userState);
  const setLoadingModal = useSetRecoilState(loadingModalState);
  const logoutCheckSetData = useSetRecoilState(ssoLoginCheckState);
  const resetUserData = useResetRecoilState(userState);
  const loadingModal = useSetRecoilState(loadingModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const location = useLocation();
  const token = getCookie("token");
  const role = getCookie("role");
  const authority = getCookie("authority");
  const passCheck = getCookie("pass");
  const sessionUserData = window.sessionStorage.getItem("user");

  const logout = useSendData<{}, {}>(logoutApi);

  const [ssoLoginRetry, setSsoLoginRetry] = useState(0);

  const { refetch: getPersonalInfo } = useData<MyInfoRes, null>(
    ["personalData", null],
    personalMyInfoApi,
    {
      enabled: false,
      onError() {
        logOut();
      },
    }
  );
  // company 내정보 api
  const { refetch: getCompanyInfo } = useData<MyInfoRes, null>(
    ["companyData", null],
    companyMyInfoApi,
    {
      enabled: false,
      onError() {
        logOut();
      },
    }
  );

  const ssoLoginData = useSendData<any, string>(ssoLoginApi, {
    onMutate() {
      loadingModal({
        isButton: false,
        isModal: false,
        isBlockChain: false,
      });
    },
    onSuccess(data) {
      // console.log("4. sso 로그인 요청 성공");
      const { access_token, ...info } = data.data.data;
      setCookie("role", "admin");
      setCookie("authority", "admin");
      setCookie("token", access_token);

      DefaultClient.defaults.headers.common["Authorization"] = "Bearer " + access_token;
      userSetData({
        role: process.env.REACT_APP_ROLE_SYSTEM_ADMIN as string,
        ...info,
      });
      resetLoadingModal();

      logoutCheckSetData({
        ssoCheck: true,
        logoutCheck: false,
      });

      if (
        (location.pathname === "/west" || location.pathname === "/west/") &&
        process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL"
      )
        navigate("/west/partners/dashboard", { replace: true });
    },
    onError(e: any) {
      if (ssoLoginRetry >= 2) {
        console.log("타임아웃");
        setTimeout(() => {
          navigate("/west/login/fail", { replace: true });
        }, 2000);
      } else {
        setSsoLoginRetry(ssoLoginRetry + 1);
      }

      // logOut(() => console.log(""), "admin");
      // console.log("에러. sso 로그인 요청 실패");
      resetLoadingModal();
    },
  });

  const ssoLogin = async (wpsso: string) => {
    // console.log("3. sso 로그인 시도");
    setLoadingModal({
      isButton: false,
      isModal: true,
    });
    await ssoLoginData.mutateAsync(wpsso);
  };

  const logOut = (fn?: <T>(val?: T) => void, type?: "admin" | "user") => {
    const WPSSO = getCookie("WPSSO");
    logout.mutate(
      {},
      {
        onSuccess() {
          if (fn) {
            fn();
          }
          let redirectUrl = "/";
          // if (!type || type === "user") redirectUrl = "/";
          // if (type === "admin") redirectUrl = "/west";

          if (WPSSO) {
            logoutCheckSetData({
              ssoCheck: true,
              logoutCheck: true,
            });
          }

          localStorage.removeItem("passData");
          removeCookie("token");
          removeCookie("role");
          removeCookie("authority");
          removeCookie("passGo");
          removeCookie("pass");
          sessionStorage.removeItem("user");
          resetUserData();
          // if (location.pathname !== "/") navigate(redirectUrl, { replace: true });
          if(process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL"){
            navigate("/west/login/fail", {replace: true});
          }else{
            // if (location.pathname !== "/") navigate(redirectUrl);
            window.location.href = "/";
          }          
          // window.location.href = "/";
          // window.location.href = redirectUrl;
        },
        onError() {},
      }
    );
  };

  useEffect(() => {
    if (ssoLoginRetry > 0 && ssoLoginRetry <= 2) {
      const WPSSO = getCookie("WPSSO");
      setTimeout(() => {
        ssoLogin(WPSSO);
      }, 2000);
    }
  }, [ssoLoginRetry]);

  const checkAuth = () => {
    // 배포시 확인
    const WPSSO = getCookie("WPSSO");
    //  const WPSSO = 'test'
     
    if (
      (!token || !ssoLoginCheck.ssoCheck) &&
      // location.pathname.includes("/west") &&
      location.pathname !== "/west/login/fail" &&
      process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL" &&
      !ssoLoginCheck.logoutCheck
    ) {
      if (WPSSO) {
        // console.log("SSO 키 검증 시도");
        ssoLogin(WPSSO);
      } else {
        setTimeout(() => {
          navigate("/west/login/fail", { replace: true });
        }, 2000);
      }
    }

    if (
      location.pathname !== "/west" &&
      location.pathname !== "/" &&
      !location.pathname.includes("/login") &&
      !location.pathname.includes("/join") &&
      !location.pathname.includes("/pass") &&
      !location.pathname.includes("/service-guide") &&
      !location.pathname.includes("/agreement/qr/") &&
      !location.pathname.includes("/brower-check")
    ) {
      if (!token || !role || !userData || !authority || !sessionStorage.getItem("user")) {
        let type: "admin" | "user" = "user";
        if (location.pathname.includes("/west")) type = "admin";
        if (type === "user" && !passCheck) {
          // console.log("로그아웃 1");
          logOut(() => console.log(""), type);
        }
        if (!sessionStorage.getItem("user")) {
          // console.log("로그아웃 2");
          logOut(() => console.log(""), type);
        }
        // if (type === "admin" && WPSSO) {
        //   ssoLogin.mutateAsync(WPSSO);
        // } else {
        //   logOut(() => console.log(""), type);
        // }
      }
      if (authority === "personal") {
        DefaultClient.defaults.headers.common["Authorization"] = "Bearer " + token;
        getPersonalInfo();
      }
      if (authority === "company") {
        DefaultClient.defaults.headers.common["Authorization"] = "Bearer " + token;
        getCompanyInfo();
      }
      if (authority === "admin") {
      }
    }

    // if (
    //   token &&
    //   role &&
    //   role === "admin" &&
    //   (location.pathname === "/" || location.pathname === "/west")
    // ) {
    //   navigate("/west/system/dashboard", { replace: true });
    // }

    if (location.pathname.includes("/login") || location.pathname.includes("/join")) {
      if ((token && !sessionUserData) || (sessionUserData && !token)) {
        if (role === "admin" && WPSSO) {
          ssoLogin(WPSSO);
          navigate("/west", { replace: true });
        } else {
          logOut();
        }
      }
    }
  };

  return { logOut, checkAuth, ssoLogin };
};
