import { useEffect } from "react";
import { useLocation } from "react-router";
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

import styled from 'styled-components';

import axios from "axios";
import masking from "./utils/masking";

const storage = window.localStorage;

function App() {
  const alertModal = useRecoilValue(alertModalState);
  const contentModal = useRecoilValue(contentModalState);
  const loadingModal = useRecoilValue(loadingModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const sessionUserData = window.sessionStorage.getItem("user");
  const token = getCookie("token");
  const location = useLocation();
  const { checkAuth, logOut } = useAuth();

  const { browerType } = useBrower();

  useEffect(() => {
    setTimeout(() => {
      checkAuth();
    }, 500);
    browerType();
    resetLoadingModal();
  }, [location.pathname]);

  useEffect(() => {
    // if(process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL"){            
      masking.fetchConfig().then((val)=>{        
        storage.setItem('masking', JSON.stringify(val));
      });                        
    // }
  },[])

  // console.log(window.navigator.onLine ? "인터넷 연결됨" : "인터넷 연결 안됨");

  return (
    <div className="App">
      {/* 전역 ALert Modal atom으로 관리됨 */}
      {contentModal.isModal && <ContentModal />}
      {loadingModal.isModal && <LoadingModal />}
      {alertModal.isModal && <AlertModal />}
      {/* <Modal>
        <div className="alignWrap">
          <h2>알림</h2>
          <p>
            현재 제안서 평가시스템이 점검 중입니다. <br />
            점검 완료 후 이용 부탁드리겠습니다.
          </p>
        </div>
      </Modal> */}
      <GlobalRoute />
    </div>
  );
}

const Modal = styled.div`
  width : 100%;
  height: 100%;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  margin : auto;
  background-color: rgba(0,0,0,0.3);
  z-index: 9999999999;
  & > .alignWrap {
    position: absolute;
    top: 0;left: 0;right: 0;bottom: 0;
    margin : auto;
    width: 360px;
    height: 240px;
    background-color: #fff;
    border-radius: 15px;
    padding: 16px;
    & > h2 {
      font-size: 20px;
      line-height: 80px;
      text-align: center;
    }
    & > p {
      font-size: 16px;
      line-height: 40px;
      text-align: center;
    }
  }
`;

export default App;
