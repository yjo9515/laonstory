import React, { useEffect, useState } from "react";
import styled from "styled-components";
import { NavLink } from "react-router-dom";
import { useNavigate } from "react-router";
import theme from "../../../theme";

import { HiOutlineChevronRight, HiOutlineArrowRight } from "react-icons/hi";
import { useLocation } from "react-router";
import ManualDownloadButton from "../../../components/Common/Button/ManualDownloadButton";

interface SideBarViewTypes {
  role: string;
  systemType: string;
  authorityType: string;
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

  const goPage = (link: string) => {
    navigate(link);
  };

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

  return (
    <SideBarViewBlock selectMotion={selectMotion} systemType={props.systemType}>
      <section>
        <ul>
          {props.systemType && props.systemType === "system" && (
            <>
              {props.role === "admin" && (
                <>
                  <li>
                    <NavLink
                      to={`/west/system/dashboard`}
                      className={({ isActive }) => (isActive ? "active" : "")}
                      onClick={() => onSideMenuClick(`/west/system/dashboard`)}
                    >
                      <SelectMotion title="홈" />
                    </NavLink>
                  </li>
                  <li>
                    <NavLink
                      to={`/west/system/company`}
                      className={({ isActive }) => (isActive ? "active" : "")}
                    >
                      <SelectMotion title="제안업체" />
                    </NavLink>
                  </li>
                  <li>
                    <NavLink
                      to={`/west/system/committer`}
                      className={({ isActive }) => (isActive ? "active" : "")}
                    >
                      <SelectMotion title="평가위원" />
                    </NavLink>
                  </li>
                </>
              )}
              <li>
                <NavLink
                  to={`/${props.role === "admin" ? "west" : props.role}/system/evaluation-room`}
                  className={({ isActive }) => (isActive ? "active" : "")}
                  onClick={() => onSideMenuClick(`/${props.role}/system/evaluation-room`)}
                >
                  <SelectMotion title="평가방" />
                </NavLink>
              </li>
              {props.role === "admin" && (
                <>
                  <li>
                    <NavLink
                      to={`/west/system/evaluation-table`}
                      className={({ isActive }) => (isActive ? "active" : "")}
                    >
                      <SelectMotion title="평가항목표" />
                    </NavLink>
                  </li>
                  {props.role === "admin" && (
                    <li>
                      <NavLink
                        to={`/west/system/terms`}
                        className={({ isActive }) => (isActive ? "active" : "")}
                      >
                        <SelectMotion title="약관설정" />
                      </NavLink>
                    </li>
                  )}
                  {props.role === "admin" && (
                    <li>
                      <NavLink
                        to={`/west/system/log`}
                        className={({ isActive }) => (isActive ? "active" : "")}
                      >
                        <SelectMotion title="감사로그" />
                      </NavLink>
                    </li>
                  )}
                  {/* {(props.role === "admin" && props.empId === '11111111') && (
                    <li>
                      <NavLink
                        to={`/west/system/information-subject`}
                        className={({ isActive }) => (isActive ? "active" : "")}
                      >
                        <SelectMotion title="취급중인 정보주체" />
                      </NavLink>
                    </li>
                  )} */}
                </>
              )}
            </>
          )}
        </ul>
        <div className="manualBtn">
          <ManualDownloadButton />
        </div>
        {/* 시스템일 경우 파트너 서비스로 이동 */}
        {/* <div className="footerInfo">
          {props.systemType === "system" && (
            <>
              <section
                className="serviceChange"
                onClick={() => {
                  goPage("/west/system/webex/oauth");
                }}
              >
                <p>Webex 연동</p>
                <div>
                  <HiOutlineArrowRight />
                </div>
              </section>
            </>
          )}
        </div> */}
      </section>
    </SideBarViewBlock>
  );
};

export default SideBarView;

const SideBarViewBlock = styled.div<SelectMotionType>`
  width: 295px;
  height: 100%;
  position: relative;
  & > section {
    top: 95px;
    width: 220px;
    height: 700px;
    background-color: ${theme.colors.white};
    display: flex;
    flex-direction: column;
    justify-content: ${(props) => (props.systemType === "system" ? "space-between" : "flex-start")};
    box-shadow: 0px 1px 47px 8px rgba(53, 88, 122, 0.1);
    border-radius: 10px;
    position: fixed;
    left: 30px;
    z-index: 2;
    & > .logo {
      width: 100%;
      flex: 1;
      max-height: 130px;
      & > img {
        display: block;
        margin: 0 auto;
      }
    }
    & > ul {
      width: 100%;
      height: auto;
      padding: 16px 8px;
      flex: 1;
      & > li {
        height: 58px;
        margin-top: 10px;
        display: flex;
        flex-direction: column;
        align-items: center;
        &:first-child {
          margin-top: 0px;
        }
        & > a {
          width: 100%;
          height: 100%;
          padding: 16px;
          position: relative;
          font-weight: 500;
          font-size: 18px;
          display: flex;
          justify-content: space-between;
          align-items: center;
          transition: ease-in-out;
          transition-duration: 0.2s;
          color: #333;
          border-radius: 8px;
          & > span {
            width: 18px;
            height: 18px;
            opacity: 0;
            right: 50px;
            & > svg {
              width: 100%;
              height: 100%;
            }
          }
        }
        & > a:hover {
          width: ${(props) => (props.selectMotion ? "100%" : "90%")};
          font-weight: ${(props) => (props.selectMotion ? theme.fontType.subTitle3.bold : 500)};
          background-color: ${theme.systemColors.pointColor};
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
    }
    & > .footerInfo {
      padding: 0 24px;
      margin-top: ${theme.commonMargin.gap2};
      & > .serviceChange {
        width: 172px;
        height: 32px;
        color: ${theme.colors.body};
        background-color: #edeff4;
        border-radius: 30px;
        padding: 4px 16px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        font-weight: 500;
        font-size: 13px;
        margin-bottom: ${theme.commonMargin.gap3};
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
        font-size: ${theme.fontType.body.fontSize};
        margin-bottom: ${theme.commonMargin.gap3};
        & > p:first-child {
          color: ${theme.colors.gray1};
        }
        & > p {
          margin-bottom: ${theme.commonMargin.gap4};
        }
      }
    }
    .active {
      width: ${(props) => (props.selectMotion ? "100%" : "90%")};

      font-weight: ${(props) => (props.selectMotion ? theme.fontType.subTitle3.bold : 500)};
      background-color: ${theme.systemColors.pointColor};
      color: ${(props) => (props.selectMotion ? theme.colors.white : "#333")};
      border-radius: 10px;
      & > span {
        position: absolute;
        opacity: ${(props) => (props.selectMotion ? 1 : 0)};
        right: ${(props) => (props.selectMotion ? "10px" : "40px")};
      }
    }
    .manualBtn {
      width: 92%;
      height: 50px;
      margin-bottom: 10px;
      /* background-color: red; */
      display: flex;
      justify-content: center;
      align-items: center;
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
