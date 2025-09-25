import { useLocation, useNavigate } from "react-router";
import styled from "styled-components";
import theme from "../../../theme";
import { getCookie } from "../../../utils/ReactCookie";
import LogoWhite from "./../../../assets/Logo/logoWhite.svg";
import BorderLineButton from "../../../components/Common/Button/BorderLineButton";
import FillButton from "../../../components/Common/Button/FillButton";
import { useAuth } from "../../../utils/AuthUtils";

interface ViewHeaderTypes {
  role?: string;
  authority?: string;
  username?: string;
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
  authority?: string;
};

function ViewHeader(props: ViewHeaderTypes) {
  const navigate = useNavigate();
  const location = useLocation().pathname;
  const { logOut } = useAuth();

  return (
    <HeaderBlock
      systemType={props.systemType}
      bgColor={props.bgColor}
      fullWidth={props.fullWidth}
      loginWidth={props.loginWidth}
      authority={props.authority}
      id="header"
    >
      <div className={`headerWrapper ${props.authority === "admin" ? "headerTop" : ""}`}>
        <div className="logo">
          {props.systemType === "partners" && props.authority !== "admin" && (
            <img src={LogoWhite} alt="로고" onClick={() => navigate("/")} />
          )}
        </div>
        <div className="info">
          {!props.notInfo && (
            <>
              <p>
                {getCookie("token") && sessionStorage.getItem("user") ? (
                  <>
                    <span className="username">{props.username}</span>님 환영합니다!
                  </>
                ) : (
                  <></>
                )}
              </p>
              {props.authority &&
                props.authority !== "admin" &&
                location !== "/user/partners/agreement" && (
                  <>
                    <FillButton
                      buttonName="계좌이체거래 약정서 발급"
                      onClick={() => navigate("/user/partners/agreement")}
                      margin={"7px"}
                      systemType={props.systemType}
                    />
                  </>
                )}
              {location !== "/user/partners/my-info" && (
                <FillButton
                  buttonName="내 정보"
                  onClick={
                    props.authority !== "admin"
                      ? () => navigate("/user/partners/my-info")
                      : () => navigate("/west/partners/my-info")
                  }
                  margin={"7px"}
                  systemType={props.systemType}
                />
              )}
              {process.env.REACT_APP_SOURCE_DISTRIBUTE === "OUTSIDE" && (
                <>
                  {getCookie("token") ? (
                    <BorderLineButton
                      buttonName="로그아웃"
                      onClick={() =>
                        logOut(undefined, props.authority === "admin" ? "admin" : "user")
                      }
                      systemType={props.systemType}
                    />
                  ) : (
                    !location.includes("/join") && (
                      <BorderLineButton
                        buttonName="로그인"
                        onClick={() => navigate("/")}
                        systemType={props.systemType}
                      />
                    )
                  )}
                </>
              )}
            </>
          )}
        </div>
      </div>
    </HeaderBlock>
  );
}

const HeaderBlock = styled.div<ViewHeaderBlockType>`
  width: ${(props) =>
    props.loginWidth
      ? theme.commonWidth.landingWidth
      : props.fullWidth && getCookie("token")
      ? "100%"
      : theme.commonWidth.landingWidth};
  padding: ${(props) => (props.authority === "admin" ? "12px" : "24px")} 0px;
  display: flex;
  justify-content: center;
  align-items: center;
  & > .headerWrapper {
    width: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    /* margin-top: 14px; */

    & > .logo {
      width: 300px;
      display: flex;
      justify-content: center;
      align-items: center;
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
        color: #fff;
        font-size: ${theme.fontType.body.fontSize};
        & > span {
          font-weight: ${theme.fontType.body.bold};
        }
      }
    }
  }
  & > .headerTop {
    margin-top: 12px;
  }
  &.downScroll {
    display: none;
  }
  & .username {
    font-size: 16px;
    font-weight: 600 !important;
  }
`;

export default ViewHeader;
