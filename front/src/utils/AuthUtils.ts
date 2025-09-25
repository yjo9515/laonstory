import { useLocation, useNavigate } from "react-router";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import { committerRefreshTokenApi, companyRefreshTokenApi, logoutApi, masterRefreshTokenApi, ssoLoginApi } from "../api/AuthApi";
import DefaultClient from "../api/DefaultClient";
import { ssoLoginCheckState, userState } from "../modules/Client/Auth/Auth";
import {
  alertModalState,
  contentModalState,
  loadingModalState,
} from "../modules/Client/Modal/Modal";
import { useSendData } from "../modules/Server/QueryHook";
import { getCookie, removeCookie, setCookie } from "./ReactCookie";
import { parseJwt } from "./jwt";


export const useAuth = (): { 
  logOut: (fn?: () => void) => void;
  checkAuth: () => void;
 } => {
  const navigate = useNavigate();
  const logout = useSendData<{}, {}>(logoutApi);
  const userData = useRecoilValue(userState);
  const userSetData = useSetRecoilState(userState);
  const setLoadingModal = useSetRecoilState(loadingModalState);
  const resetUserData = useResetRecoilState(userState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const ssoLoginCheck = useRecoilValue(ssoLoginCheckState);
  const logoutCheckSetData = useSetRecoilState(ssoLoginCheckState);
  const location = useLocation();
  const token = getCookie("token");
  const role = getCookie("role");

  const sessionUserData = window.sessionStorage.getItem("user");
  const WPSSO = getCookie("WPSSO");

  const logOut = (fn?: <T>(val?: T) => void) => {
    logout.mutate(
      {},
      {
        onSuccess() {
          if (fn) {
            fn();
          }
          removeCookie("token");
          removeCookie("role");
          removeCookie("authority");
          removeCookie("pass");
          sessionStorage.removeItem("user");
          resetUserData();
          // if (location.pathname !== "/") navigate(`/partners`, { replace: true });
          window.location.href = "/";
        },
        onError() {
          removeCookie("token");
          removeCookie("role");
          removeCookie("authority");
          removeCookie("pass");
          sessionStorage.removeItem("user");
          resetUserData();
          // if (location.pathname !== "/") navigate(`/partners`, { replace: true });
          window.location.href = "/";
        }
      }
    );
  };

  const ssoLoginData = useSendData<any, string>(ssoLoginApi, {
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

      if (location.pathname === "/") navigate("/west/system/dashboard", { replace: true });
    },
    onError() {
      // logOut(() => console.log(""), "admin");
      // console.log("에러. sso 로그인 요청 실패");
      resetLoadingModal();
    },
  });

  const ssoLogin = async (wpsso: string) => {
    // console.log("3. sso 로그인 시도");
    // console.log(location.pathname);
    setLoadingModal({
      isButton: false,
      isModal: true,
      type: "default",
    });
    await ssoLoginData.mutateAsync(wpsso);
  };

  const checkAuth = () => {
    // if (
    //   !token &&
    //   !ssoLoginCheck.ssoCheck &&
    //   // location.pathname.includes("/west") &&
    //   !ssoLoginCheck.logoutCheck &&
    //   WPSSO
    // ) {
    //   console.log("SSO 키 검증 시도");
    //   ssoLogin(WPSSO);
    //   return;
    // }

    if (
      location.pathname !== "/" &&
      !location.pathname.includes("/login") &&
      !location.pathname.includes("/join") &&
      !location.pathname.includes("/pass") &&
      !location.pathname.includes("/service-guide") &&
      !location.pathname.includes("/agreement/qr/") &&
      !location.pathname.includes("/brower-check") && 
      !location.pathname.includes("/waiting")
    ) {
      if (!token || !role || !userData) {
        logOut();
        // logout.mutate(
        //   {},
        //   {
        //     onSuccess() {
        //       logOut();
        //     },
        //   }
        // );
      }
    }

    if (token && role && role === "admin" && location.pathname === "/") {
      navigate("/west/system/dashboard", { replace: true });
    }

    if (location.pathname.includes("/login") || location.pathname.includes("/join")) {
      if (token && role === "admin") {
        navigate("/west/system/dashboard", { replace: true });
      }
      if ((token && !sessionUserData) || (sessionUserData && !token)) {
        logOut();
      }
    }
  };


  // const getRole = () => {
  //   if (!token) return true;
  //   const parsed = parseJwt(token);

  //   const type = parsed.master ? 'MASTER' : parsed.committer ? 'COMMITTER' : 'USER'
  //   return type;
  // }



  
  return { logOut, checkAuth };
};
