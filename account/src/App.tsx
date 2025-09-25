import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router";
import { useRecoilValue, useResetRecoilState } from "recoil";
import AlertModal from "./components/Modal/AlertModal";
import ContentModal from "./components/Modal/ContentModal";
import LoadingModal from "./components/Modal/LoadingModal";
import {
  alertModalState,
  contentModalState,
  loadingModalState,
} from "./modules/Client/Modal/Modal";
import GlobalRoute from "./routers/GlobalRoute";
import { useAuth } from "./utils/AuthUtils";
import { useBrower } from "./utils/BrowerCheckUtils";
import { getCookie } from "./utils/ReactCookie";
import { useIdleTimer } from "react-idle-timer";
import { useSetRecoilState } from "recoil";
import axios from "axios";
import masking from "./utils/masking";

const storage = window.localStorage;

function App() {
  const alertModal = useRecoilValue(alertModalState);
  const contentModal = useRecoilValue(contentModalState);
  const loadingModal = useRecoilValue(loadingModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const location = useLocation();
  const navigate = useNavigate();

  const sessionUserData = window.sessionStorage.getItem("user");
  const token = getCookie("token");

  const { checkAuth, logOut } = useAuth();

  const { browerType } = useBrower();    
  const setAlertModal = useSetRecoilState(alertModalState);  

  useEffect(() => {
    // if(process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL"){            
      masking.fetchConfig().then((val)=>{        
        storage.setItem('masking', JSON.stringify(val));
      });                        
    // }
  },[])
  

  useEffect(() => {
    // if (
    //   process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL" &&
    //   location.pathname.split("/")[1] !== "west"
    // ) {
    //   // console.log("도메인에 admin 이 없을 경우");
    //   navigate("/west", { replace: true });
    // } else if (
    //   process.env.REACT_APP_SOURCE_DISTRIBUTE === "OUTSIDE" &&
    //   location.pathname.split("/")[1] === "west"
    // ) {
    //   navigate("/", { replace: true });
    // } else {
    //   // console.log("1. 0.5초 후 sso 검증 및 로그인 시도");
    //   setTimeout(() => {
    //     // console.log("2. sso 검증 및 로그인 진행");
    //     checkAuth();
    //   }, 500);
    // }
    console.log("app")    
    if (process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL" && location.pathname === "/") {
      navigate("/west", { replace: true });                
    } else {
      setTimeout(() => {
        checkAuth();
      }, 500);
      browerType();
      resetLoadingModal();
    }
  }, [location.pathname]);

  return (
    <div className="App">
      {/* 전역 ALert Modal atom으로 관리됨 */}
      {contentModal.isModal && <ContentModal />}
      {loadingModal.isModal && <LoadingModal />}
      {alertModal.isModal && <AlertModal />}
      <GlobalRoute />
    </div>
  );
}

export default App;
