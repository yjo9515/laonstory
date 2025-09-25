/* eslint-disable react-hooks/exhaustive-deps */
import { ReactElement, useEffect, useState } from "react";
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

interface LayoutTypes {
  notSideBar?: boolean;
  notInfo?: boolean;
  children: ReactElement;
  fullWidth?: boolean;
  fullHeight?: boolean;
  notHeader?: boolean;
  notHeadTitle?: boolean;
  notBackground?: boolean;
  useFooter?: boolean;
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
  notHeadTitle?: boolean;
  noBottom?: boolean;
};

function Layout({
  children,
  notSideBar,
  fullWidth,
  fullHeight,
  notInfo,
  notHeader,
  notHeadTitle,
  notBackground,
  useFooter,
  notBackgroundSystem,
  bgColor,
  logoColor,
  process,
  loginWidth,
  noBottom,
}: LayoutTypes) {
  const userData = useRecoilValue(userState);
  const role = RoleUtils.getClientRole(userData.role);
  const [pageMotion, setPageMotion] = useState<boolean>(false);
  const [type, setType] = useState<string>(getCookie("type"));

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

  // useEffect(() => {
  //   let lastScrollTop = 0;
  //   const target = document.getElementById("viewWrapper");
  //   const header = document.getElementById("header");
  //   const scrollEvent = () => {
  //     if (target && header) {
  //       const st = target?.scrollTop;
  //       if (st) {
  //         if (st - lastScrollTop >= 5) {
  //           header.classList.add("downScroll");
  //         } else {
  //           if (st < lastScrollTop) {
  //             header.classList.remove("downScroll");
  //           }
  //         }
  //         lastScrollTop = st;
  //       }
  //     }
  //   };
  //   if (role !== "admin") {
  //     target?.addEventListener("scroll", scrollEvent);
  //   }
  //   return () => {
  //     target?.removeEventListener("scroll", scrollEvent);
  //   };
  // }, []);

  return (
    <>
      <LayoutPartnersBlock
        fullWidth={fullWidth}
        fullHeight={fullHeight}
        notHeadTitle={notHeadTitle}
        noBottom={noBottom}
      >
        {!notSideBar && <SideBar role={role} />}
        <div className="wrapper">
          {!notHeader && (
            <ViewHeader
              username={role === "company" ? userData.companyName : userData.name}
              authority={role}
              role={userData.role}
              notInfo={notInfo}
              notSideBar={notSideBar}
              systemType={type}
              bgColor={bgColor}
              logoColor={logoColor}
              fullWidth={fullWidth}
              loginWidth={loginWidth}
            />
          )}
          <div className={`viewWrapper`} id="viewWrapper">
            <div className={`children`} id="children">
              {!notHeadTitle && (
                <div className="header">
                  {/* <h2>한국서부발전 계좌등록시스템에 오신 여러분 환영합니다!</h2> */}
                  {/* <p>편리하고 간편하지만 공정하고 안전한 계좌등록시스템을 이용해보세요!</p> */}
                  <h2>
                    안전하고 편리한 <span>블록체인 기반</span> 계좌등록시스템
                  </h2>
                  {/* <p>&nbsp;</p> */}
                </div>
              )}
              <div className={`inChildren ${pageMotion && "view"}`}>{children}</div>
            </div>
            {useFooter && <ViewFooter />}
          </div>
        </div>
        {!notBackground && <div className="backgroundColor"></div>}
      </LayoutPartnersBlock>
    </>
  );
}

const LayoutGlobalBlock = styled.div<LayoutBlockTypes>`
  width: 100vw;
  height: 100vh;
  min-width: 1500px;
  overflow: hidden;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: ${theme.colors.white};
  position: relative;
  & > .wrapper {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
    z-index: 90;
    position: relative;
    .viewWrapper {
      position: relative;
      width: 100%;
      height: 100%;
      display: flex;
      flex-direction: column;
      overflow-y: auto;
      -ms-overflow-style: none; /* IE and Edge */
      scrollbar-width: none; /* Firefox */
      & > .children {
        margin: 0 auto;
        width: ${(props) => (props.fullWidth ? "100%" : theme.commonWidth.landingWidth)};
        padding-bottom: ${(props) => (props.noBottom ? "0px" : "40px")};
        z-index: 90;
        & > div {
          margin: 0 auto;
          max-width: ${(props) => (props.fullWidth ? "100%" : "100%")};
        }
        & > .inChildren {
          width: 100%;
          height: 100%;
          transition: ease-in-out;
          transition-duration: 0.2s;
          opacity: 0;
          padding-top: 20px;
        }
        & > .view {
          opacity: 1 !important;
          padding-top: 0 !important;
        }
        & > .header {
          padding-top: 30px;
          padding-bottom: 30px;
          height: auto;
          h2 {
            color: white;
            font-size: 18px;
            font-weight: 500;
            & > span {
              font-weight: 700;
              font-size: 24px;
            }
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
`;

const LayoutPartnersBlock = styled(LayoutGlobalBlock)<LayoutBlockTypes>`
  .backgroundColor {
    position: absolute;
    top: 0;
    width: 100%;
    height: ${(props) => (props.systemType === "system" ? "200px" : "250px")};
    /* z-index: -1; */
    background: ${(props) =>
      props.systemType === "system"
        ? theme.systemColors.systemPrimary
        : `linear-gradient(
      93.69deg,
      #468fe6 3.22%,
      #4c9af0 24.27%,
      #4489d4 69.78%,
      #3662a5 99.03%
    );`};
  }
`;

export default Layout;
