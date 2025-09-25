import React, { useEffect, useState } from "react";
import { HiOutlineChevronRight } from "react-icons/hi";
import { useLocation, useNavigate } from "react-router";
import { Link, NavLink } from "react-router-dom";
import { useRecoilValue } from "recoil";
import styled from "styled-components";
import ManualDownloadButton from "../../../components/Common/Button/ManualDownloadButton";
import { sideBarCover } from "../../../modules/Client/Modal/Modal";
import theme from "../../../theme";
import LogoTwoLine from "./../../../assets/Logo/logoTwoLine.svg";

interface SideBarViewTypes {
  role: string;
  systemType: string;
  authorityType: string;
  isAccountant: boolean;
  empId: string;
}

type SelectMotionType = {
  selectMotion: boolean;
  systemType: string;
};

const SelectMotion = (props: any) => {
  return (
    <>
      {props.title}
      <span>
        <HiOutlineChevronRight />
      </span>
    </>
  );
};

const SideBarView: React.FC<any> = (props: SideBarViewTypes) => {
  const navigate = useNavigate();
  const location = useLocation();

  const [selectMotion, setSelectMotion] = useState<boolean>(true);
  const [selectLink, setSelectLink] = useState<string>("");
  
  const [check, setCheck] = useState<boolean>(false);

  const goPage = (link: string) => {
    navigate(link);
  };
  const clickPrivacy = () => {
    if (process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL") {
      window.open("http://intra.iwest.co.kr:6200/prvc.html", "_blank");
    }
  }

  useEffect(() => {
    if (!selectMotion) {
      setTimeout(() => {
        setSelectMotion(true);
      }, 100);
    }
  }, [selectMotion]);

  useEffect(() => {
    setSelectLink(location.pathname);
  }, []);


  const onSideMenuClick = (link: string) => {
    if (link !== selectLink) {
      setSelectMotion(false);
      setSelectLink(link);
    }
  };

  const setSideBarCover = useRecoilValue(sideBarCover);

  useEffect(() => {
    if (setSideBarCover) setCheck(true);
    if (!setSideBarCover) setCheck(false);
  }, [setSideBarCover]);

  // const logPageMove = (e : any) => {
  //   e.preventDefault();
  //   console.log(process.env.REACT_APP_LOG_PASSWORD)
  //   setPassCheck(true);
  // }

  

  return (
    <SideBarViewBlock selectMotion={selectMotion} systemType={props.systemType}>
      <section>
        <div className="logo">
          <Link to="/west/partners/dashboard">
            <img src={LogoTwoLine} alt="" />
          </Link>
        </div>
        <ul>
          {props.role === "admin" && (
            <>
              <li>
                <NavLink
                  to={`/west/partners/dashboard`}
                  className={({ isActive }) => (isActive ? "active" : "")}
                >
                  <SelectMotion title="홈" />
                </NavLink>
              </li>
              <li>
                <NavLink
                  to={`/west/partners/agreement?page=0?search=`}
                  className={({ isActive }) => (isActive ? "active" : "")}
                >
                  <SelectMotion title="신청현황" />
                </NavLink>
              </li>
              <li>
                <NavLink
                  to={`/west/partners/issuance?page=0?search=`}
                  className={({ isActive }) => (isActive ? "active" : "")}
                >
                  <SelectMotion title="발급완료" />
                </NavLink>
              </li>
              {!props.isAccountant && props.empId === '04160266' &&(
                <li>
                  <NavLink
                    to={`/west/partners/user`}
                    className={({ isActive }) => (isActive ? "active" : "")}
                  >
                    <SelectMotion title="회원 리스트" />
                  </NavLink>
                </li>
              )}
            </>
          )}
          {props.role === "admin" && !props.isAccountant && (
            <li>
              <NavLink
                to={`/west/partners/terms`}
                className={({ isActive }) => (isActive ? "active" : "")}
              >
                <SelectMotion title="약관설정" />
              </NavLink>
            </li>
          )}
          {props.role === "admin" && !props.isAccountant && (
            <li>
              <NavLink
                // onClick={e => logPageMove(e)}
                to={`/west/partners/log`}
                className={({ isActive }) => (isActive ? "active" : "")}
              >
                <SelectMotion title="감사로그" />
              </NavLink>
            </li>
          )}
        </ul>
        <div className="footerInfo">
          <div className="manualBtn">
            <ManualDownloadButton type="admin" />
          </div>
          {props.role === "admin" && (
            <div>
              <p>문의</p>
              <p>
                상생협력처/디지털총괄실 담당
                <br />
                041-400-1944
              </p>
            </div>
          )}
          {props.role !== "admin" && (
            <>
              <div>
                <p>고객센터</p>
                <p>041-400-1944</p>
              </div>
              <div>
                <p>주소</p>
                <p>(32140) 충청남도 태안군 태안읍 중앙로 285</p>
              </div>
            </>
          )}
          {(process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL") && <div className="cousor" style={{fontWeight : "bold", fontSize : "15px",cursor:"pointer"}} onClick={clickPrivacy}>개인정보처리방침</div>}
          <div className="copyright">
            copyright(c)2022 Korea Western Power co.,Ltd.All Rights Reserved.
          </div>
        </div>
      </section>
    </SideBarViewBlock>
  );
};

export default SideBarView;

const SideBarViewBlock = styled.div<SelectMotionType>`
  flex: 1;
  min-width: 220px;
  height: 100vh;
  position: relative;
  & > section {
    overflow-y: auto;
    padding: 50px 0px;
    width: 220px;
    height: 100%;
    background-color: ${theme.colors.white};
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    box-shadow: ${(props) =>
      props.systemType === "system"
        ? "-11px -11px 32px 1px rgba(35, 110, 198, 0.1), 0px 4px 30px -11px rgba(33, 44, 46, 0.3)"
        : "0px 4px 22px -1px rgba(0, 0, 0, 0.15)"};
    position: absolute;
    z-index: 50;
    &::-webkit-scrollbar {
      width: 0px;
    }
    & > .logo {
      width: 100%;
      padding: 24px;
      & img {
        width: 100%;
        display: block;
        margin: 0 auto;
      }
      margin-bottom: 80px;
    }
    & > ul {
      width: 100%;
      height: auto;
      padding: 10px;
      margin-bottom: 50px;
      & > li {
        height: 60px;
        display: flex;
        flex-direction: column;
        align-items: center;
        & > a {
          padding: 0 20px;
          display: flex;
          justify-content: space-between;
          align-items: center;
          width: 100%;
          height: 100%;
          transition: ease-in-out;
          transition-duration: 0.2s;
          color: #333;
          position: relative;
          border-radius: 10px;
          font-size: 15px;
          & > span {
            position: absolute;
            width: 18px;
            height: 18px;
            opacity: 0;

            right: 50px;
            /* z-index: 10; */
            & > svg {
              width: 100%;
              height: 100%;
            }
          }
        }
        & > a:hover {
          width: ${(props) => (props.selectMotion ? "100%" : "90%")};
          font-weight: ${(props) => (props.selectMotion ? theme.fontType.subTitle3.bold : 500)};
          background-color: ${(props) =>
            props.selectMotion
              ? props.systemType === "system"
                ? theme.systemColors.systemSideBarBtn
                : theme.partnersColors.primary
              : "transparent"};
          color: ${(props) => (props.selectMotion ? theme.colors.white : "#333")};

          & > span {
            transition: ease-in-out;
            transition-duration: 0.35s;
            position: absolute;
            opacity: 1;
            right: 10px;
          }
        }
      }
      & > li::before {
        content: "";
        padding-top: 7px;
        box-sizing: border-box;
      }
      & > li::after {
        content: "";
        border-bottom: 1px solid ${theme.colors.gray5};
        width: 80%;
        padding-bottom: 7px;
        box-sizing: border-box;
      }
      & > li:last-child::after {
        border-bottom: 0;
      }
    }
    & > .footerInfo {
      padding: 0 24px;
      margin-top: auto;
      & > .serviceChange {
        color: #fff;
        background-color: #438cae;
        border-radius: 30px;
        padding: 8px 10px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        font-size: 12px;
        margin-bottom: ${theme.commonMargin.gap2};
        transition: ease-in-out;
        transition-duration: 0.2s;
        cursor: pointer;
        & > div {
          width: 16px;
          height: 16px;
          margin-left: 10px;
          & > svg {
            width: 100%;
            height: 100%;
          }
        }
      }
      & > .serviceChange:hover {
        background-color: ${theme.colors.gray4};
      }
      & > div {
        color: ${theme.colors.gray3};
        font-weight: 300;
        /* font-size: ${theme.fontType.body.fontSize}; */
        font-size: 12px;
        margin-bottom: ${theme.commonMargin.gap3};
        & > p:first-child {
          color: ${theme.colors.gray1};
        }
        & > p {
          margin-bottom: ${theme.commonMargin.gap4};
        }
      }
      & > .copyright {
        margin-top: 50px;
        margin-bottom: 0;
      }
      & > .manualBtn {
        margin-bottom: 20px;
        display: flex;
        justify-content: flex-start;
        align-items: center;
      }
    }

    .active {
      width: ${(props) => (props.selectMotion ? "100%" : "100%")};
      font-size: ${(props) => (props.selectMotion ? theme.fontType.subTitle2.fontSize : "16px")};
      font-weight: ${(props) => (props.selectMotion ? theme.fontType.subTitle3.bold : 500)};
      background-color: ${(props) =>
        props.selectMotion
          ? props.systemType === "system"
            ? theme.systemColors.systemSideBarBtn
            : theme.partnersColors.primary
          : "transparent"};
      color: ${(props) => (props.selectMotion ? theme.colors.white : "#333")};
      border-radius: 10px;
      & > span {
        position: absolute;
        opacity: ${(props) => (props.selectMotion ? 1 : 0)};
        right: ${(props) => (props.selectMotion ? "10px" : "40px")};
      }
    }
  }
  .test {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
    background-color: rgb(0, 0, 0); /* Fallback color */
    background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
    border-radius: 22px;
    z-index: 100;
  }
`;