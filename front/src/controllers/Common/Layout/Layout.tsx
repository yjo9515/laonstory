/* eslint-disable react-hooks/exhaustive-deps */
import { ReactElement, useEffect, useRef, useState } from "react";
import styled from "styled-components";
import theme from "../../../theme";
import SideBar from "../SideBar/SideBar";
import ViewHeader from "../../../view/Common/HeaderView/HeaderView";
import ViewFooter from "../../../view/Common/FooterView/FooterView";
import { getCookie } from "../../../utils/ReactCookie";
import { userState } from "../../../modules/Client/Auth/Auth";
import { useRecoilValue } from "recoil";
import RoleUtils from "../../../utils/RoleUtils";
import { currentProcess } from "../../Auth/Join/JoinProcess";
import { useAuth } from "../../../utils/AuthUtils";
import { sideBarCover, footerZIndexControl } from "../../../modules/Client/Modal/Modal";
import systemBanner from "../../../assets/Img/systemBanner.png";
import { useLocation } from "react-router";

interface LayoutTypes {
  notSideBar?: boolean;
  notInfo?: boolean;
  children: ReactElement;
  fullWidth?: boolean;
  fullHeight?: boolean;
  notHeader?: boolean;
  notFooter?: boolean;
  notHeadTitle?: boolean;
  notBackground?: boolean;
  notBackgroundSystem?: boolean;
  bgColor?: string;
  logoColor?: boolean;
  process?: currentProcess;
  loginWidth?: boolean;
  noBottom?: boolean;
}

type LayoutBlockTypes = {
  fullWidth?: boolean;
  fullHeight?: boolean;
  systemType?: string;
  notHeader?: boolean;
  notFooter?: boolean;
  notHeadTitle?: boolean;
  noBottom?: boolean;
  role?: string;
  notSideBar?: boolean;
  scrollBottomCheck?: boolean;
  footerZIndexControlState?: boolean;
};

function Layout({
  children,
  notSideBar,
  fullWidth,
  fullHeight,
  notInfo,
  notHeader,
  notFooter,
  notHeadTitle,
  notBackground,
  bgColor,
  logoColor,
  process,
  loginWidth,
  noBottom,
}: LayoutTypes) {
  // const auth = useRecoilValue(AuthSetQuery);
  const userData = useRecoilValue(userState);
  const role = RoleUtils.getClientRole(userData.role);
  const location = useLocation();
  const { logOut } = useAuth();
  const logout = () => {
    logOut(undefined);
  };
  const [pageMotion, setPageMotion] = useState<boolean>(false);
  const [wheelHeaderMotion, setWheelHeaderMotion] = useState<boolean>(false);
  const [type, setType] = useState<string>(getCookie("type"));
  const [cover, setCover] = useState(false);
  const [scrollBottomCheck, setScrollBottomCheck] = useState<boolean>(false);
  const setSideBarCover = useRecoilValue(sideBarCover);
  const footerZIndexControlState = useRecoilValue(footerZIndexControl);

  useEffect(() => {
    if (setSideBarCover) setCover(true);
    else setCover(false);
  }, [setSideBarCover]);

  useEffect(() => {
    setTimeout(() => {
      setPageMotion(true);
    }, 100);
  }, []);

  useEffect(() => {
    const children = document.getElementById("children");
    if (children) {
      children.scrollTo(0, 0);
    }
  }, [process]);

  useEffect(() => {
    setType(getCookie("type"));
  }, [getCookie("type")]);

  /** 스크롤 되는 영역 ref */
  const wrapRef = useRef<HTMLDivElement | null>(null);
  /** 스크롤 되는 영역 높이 체크 ref */
  const inDivRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    let t = wrapRef.current?.offsetHeight; // 해당 div 영역 높이
    const a = Number(wrapRef.current?.scrollHeight);
    let b = Number(wrapRef.current?.scrollTop) + Number(t);

    if (a === b) {
      setScrollBottomCheck(true);
    }

    const wheelFooterHandler = (e: Event) => {
      let refHeight = wrapRef.current?.offsetHeight; // 해당 div 영역 높이

      const scrollFullHeight = Number(wrapRef.current?.scrollHeight);
      let scrollTopPosition = Number(wrapRef.current?.scrollTop) + Number(refHeight);

      // console.log(refHeight);
      let check = false;
      if (scrollTopPosition + 10 >= Number(scrollFullHeight)) {
        check = true;
      } else {
        check = false;
      }
      setScrollBottomCheck(check);
    };

    wrapRef.current?.addEventListener("scroll", wheelFooterHandler);
    return () => wrapRef.current?.removeEventListener("scroll", wheelFooterHandler);
  }, [location.pathname]);

  return (
    <LayoutBlock
      ref={inDivRef}
      fullWidth={fullWidth}
      fullHeight={fullHeight}
      systemType={type}
      notHeadTitle={notHeadTitle}
      noBottom={noBottom}
      notHeader={notHeader}
      notFooter={notFooter}
      role={role}
      scrollBottomCheck={scrollBottomCheck}
      footerZIndexControlState={footerZIndexControlState}
    >
      <div>
        {!notSideBar && <SideBar role={RoleUtils.getRole(userData.role)} />}
        {!notHeader && !cover && (
          <ViewHeader
            username={
              RoleUtils.getClientRole(userData.role) === "company"
                ? userData.companyName
                : userData.name
            }
            authority={RoleUtils.getClientRole(userData.role)}
            onLogout={logout}
            role={userData.role}
            notInfo={notInfo}
            notSideBar={notSideBar}
            systemType={type}
            bgColor={bgColor}
            logoColor={logoColor}
            fullWidth={fullWidth}
            loginWidth={loginWidth}
            wheelHeaderMotion={wheelHeaderMotion}
          />
        )}
        <div className="wrapper" ref={wrapRef}>
          <div className={`viewWrapper`}>
            <div className={`children`} id="children">
              {!notHeadTitle && <div className="header"></div>}
              <div className={`inChildren ${pageMotion && "view"}`}>{children}</div>
            </div>
          </div>
        </div>
      </div>
      {scrollBottomCheck && !notFooter && (
        <div className={`footerWrapper ${scrollBottomCheck ? "viewFooter" : ""}`}>
          <ViewFooter />
        </div>
      )}
      {/* <div className={`footerWrapper viewFooter`}>
        <ViewFooter />
      </div> */}
      {!notBackground && <div className="backgroundColor"></div>}
    </LayoutBlock>
  );
}

const LayoutBlock = styled.div<LayoutBlockTypes>`
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  background-color: ${theme.colors.white};
  /* flex: 1; */
  /* overflow-y: scroll; */

  & > div {
    display: inline-flexbox;
  }
  & .wrapper {
    margin: 0 auto;
    width: ${(props) => (props.fullWidth ? "100%" : "calc(100% - 295px)")};
    /* height: ${(props) => (props.notHeader ? "calc(100vh - 80px)" : "calc(100vh - 140px)")}; */
    height: 100vh;
    /* padding-bottom: 60px; */
    margin-top: ${(props) => (props.notHeader ? 0 : "60px")};
    padding-bottom: ${(props) => (props.notHeader ? 0 : "60px")};
    padding-top: ${(props) => (props.notHeader ? 0 : "30px")};
    display: flex;
    flex-direction: column;
    z-index: 2;
    position: relative;
    overflow-y: scroll;
    &::-webkit-scrollbar {
      display: none;
    }
    .viewWrapper {
      width: 100%;
      z-index: 2;
      /* padding-bottom: 90px; */
      /* margin-bottom: 50px; */
      /* min-height: 500px; */
      height: calc(100% - 130px);
      overflow: auto;
      /* position: relative; */
      & > .children {
        width: ${(props) => (props.fullWidth ? "100%" : theme.commonWidth.landingWidth)};
        margin: 0 auto;
        position: relative;
        & > div {
          max-width: ${(props) => (props.fullWidth ? "100%" : "100%")};
        }
        & > .inChildren {
          width: 100%;
          transition: ease-in-out;
          transition-duration: 0.2s;
          opacity: 0;
          position: relative;
          /* top: 20px; */
        }
        & > .view {
          opacity: 1 !important;
          /* top: 0 !important; */
        }
        & > .header {
          height: auto;
          h2 {
            color: white;
            font-size: 20px;
            font-weight: 600;
          }
          > p {
            margin-top: 8px;
            font-size: 13px;
            font-weight: 400;
            color: white;
          }
        }
      }
    }
    .viewWrapper::-webkit-scrollbar {
      display: none;
    }
  }
  .backgroundColor {
    position: fixed;
    top: 0;
    width: 100%;
    height: 268px;
    background: url(${systemBanner}) no-repeat;
    background-size: cover;
    z-index: 0;
  }
  .footerWrapper {
    width: 100%;
    margin-top: 100px;
     /* height: ${(props) => (!props.scrollBottomCheck ? 0 : "80px")}; 
     height: 80px;  
    /* transition: ease-in-out;
    transition-duration: 0.3s; */
    background-color: #fff;
    overflow: hidden;
    position: fixed;
    bottom: 0;
    left: 0;
     z-index: ${(props) => (props.footerZIndexControlState ? 0 : 3)}; 
    display: flex;
    justify-content: center;
    border-top: 1px solid ${theme.colors.gray5};
  }
`;

export default Layout;
