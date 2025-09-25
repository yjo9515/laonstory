import { useNavigate } from "react-router";
import styled from "styled-components";
import theme from "../../../theme";
import { getCookie } from "../../../utils/ReactCookie";
import RoleUtils from "../../../utils/RoleUtils";
import LogoWhite from "./../../../assets/Logo/logoWhite.svg";
import FillButton from "../../../components/Common/Button/FillButton";

interface ViewHeaderTypes {
  wheelHeaderMotion: boolean;
  role?: string;
  authority?: string;
  username?: string;
  onLogout: () => void;
  notInfo?: boolean;
  notSideBar?: boolean;
  bgColor?: string;
  logoColor?: boolean;
  systemType: string;
  fullWidth?: boolean;
  loginWidth?: boolean;
}

type ViewHeaderBlockType = {
  systemType: string;
  bgColor?: string;
  fullWidth?: boolean;
  loginWidth?: boolean;
  wheelHeaderMotion?: boolean;
  role: string;
};

function ViewHeader(props: ViewHeaderTypes) {
  const navigate = useNavigate();
  const role = RoleUtils.getClientRole(props.role || "");
  const type = RoleUtils.getRole(props.role || "");

  // const sessionUserData = sessionStorage.getItem("user");

  // console.log(sessionUserData);

  return (
    <HeaderBlock
      systemType={props.systemType}
      bgColor={props.bgColor}
      fullWidth={props.fullWidth}
      loginWidth={props.loginWidth}
      wheelHeaderMotion={props.wheelHeaderMotion}
      role={role}
    >
      <div className="headerWrapper">
        <div className="logo">
          <img
            src={LogoWhite}
            alt="로고"
            onClick={() => {
              if (role === "admin") {
                navigate("/west/system/dashboard");
              } else {
                navigate("/");
              }
            }}
          />
        </div>
        <div className="info">
          {!props.notInfo && (
            <>
              <p>
                {getCookie("token") ? (
                  <>
                    <span className="username">
                      <>
                        {RoleUtils.isAuthorityTypeCheck(props.authority ?? "")} {props.username}
                      </>
                    </span>{" "}
                    님 환영합니다!
                  </>
                ) : (
                  <></>
                )}
              </p>
              <>
                {role !== "admin" && (
                  <FillButton
                    buttonName="평가방"
                    onClick={() => navigate("/")}
                    margin={"7px"}
                    systemType={props.systemType}
                  />
                )}
                <FillButton
                  buttonName="내 정보"
                  onClick={() => navigate(`/${type === "admin" ? "west" : type}/system/my-info`)}
                  margin={"7px"}
                  systemType={props.systemType}
                />
              </>
              {getCookie("token") ? (
                <FillButton
                  buttonName="로그아웃"
                  onClick={props.onLogout}
                  systemType={props.systemType}
                />
              ) : (
                <FillButton
                  buttonName="로그인"
                  onClick={props.onLogout}
                  systemType={props.systemType}
                />
              )}
            </>
          )}
        </div>
      </div>
    </HeaderBlock>
  );
}

const HeaderBlock = styled.div<ViewHeaderBlockType>`
  width: 100%;
  height: ${theme.commonHeight.headerHeight};
  background: transparent;
  position: fixed;
  z-index: 40;
  top: ${(props) => (props.wheelHeaderMotion ? `-${theme.commonHeight.headerHeight}` : 0)};
  transition: ease-in-out;
  transition-duration: 0.3s;
  & > .headerWrapper {
    width: 100%;
    height: 100%;
    padding: 0px 50px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    & > .logo {
      width: 200px;
      height: 32px;
      display: flex;
      justify-content: center;
      align-items: center;
      margin-left: -10px;
      & > img {
        cursor: pointer;
        width: 100%;
        height: 100%;
        object-fit: contain;
      }
    }
    & > .info {
      width: auto;
      & > p {
        display: inline-block;
        margin-right: 20px;
        /* color: ${(props) =>
          props.systemType === "system" ? theme.partnersColors.primary : theme.colors.white}; */
        color: #fff;
        font-size: ${theme.fontType.body.fontSize};
        & > span {
          font-weight: ${theme.fontType.body.bold};
        }
      }
      & .username {
        font-size: 16px;
      }
    }
  }
`;

export default ViewHeader;
