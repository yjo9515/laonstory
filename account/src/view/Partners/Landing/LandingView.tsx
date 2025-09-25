import { useEffect, useRef, useState } from "react";
import { UseFormRegister } from "react-hook-form";
import { useNavigate } from "react-router";
import { Link } from "react-router-dom";
import { useRecoilValue } from "recoil";
import styled from "styled-components";
import ArrowNext from "../../../assets/Icon/ArrowNext";
import Phone from "../../../assets/Icon/Phone";
import BorderLineButton from "../../../components/Common/Button/BorderLineButton";
import FillButton from "../../../components/Common/Button/FillButton";
import LandingList from "../../../components/List/ListComponent/LandingList/LandingList";
import { ILoginInput } from "../../../interface/Auth/FormInputInterface";
import { userState } from "../../../modules/Client/Auth/Auth";
import theme from "../../../theme";
import { useAuth } from "../../../utils/AuthUtils";
import { getCookie } from "../../../utils/ReactCookie";
import BackgroundImage from "../../../assets/background/landingBackgroundImage.png";
import LogoWhite from "../../../assets/Logo/logoWhite.svg";
import check from "../../../assets/Icon/check.svg";
import landingInfo from "../../../assets/Img/landingInfo.png";
import accountApplication from "../../../assets/Icon/accountApplication.svg";
import LogoSmallTitle from "../../../assets/Logo/logoSmallTitle.svg";
import personalServiceInfo from "../../../assets/Img/personalServiceInfo.png";
import companyServiceInfo from "../../../assets/Img/companyServiceInfo.png";
import InputButton from "../../../components/Common/Button/InputButton";
import SmartPhone from "../../../assets/Auth/SmartPhone";
import NicePhone from "../../../components/Modal/Nice/NicePhone";
import { HiChevronUp } from "react-icons/hi";
import { AiOutlineFileSearch } from "react-icons/ai";
import InputSet1 from "../../../components/Common/Input/InputSet1";

interface ILogin {
  register: UseFormRegister<ILoginInput>;
  onSubmit: any;
  loginType: string;
  changeLoginType: (type: string) => void;
  // authClick: () => void;
  isLogined: boolean;
  type: "admin" | "user";
  routeType?: string;
  loginPassCheck: boolean;
  passData?: string;
  passProgress: boolean;
  onLoginPhoneCheck: () => void;
  onCancelLoginPhone: () => void;
  passDataReset: () => void;
}
type LandingContainerType = {
  image?: string;
};
export default function LandingView({
  loginType,
  changeLoginType,
  register,
  onSubmit,
  isLogined,
  type,
  routeType,
  loginPassCheck,
  passData,
  passProgress,
  onLoginPhoneCheck,
  onCancelLoginPhone,
  passDataReset,
}: ILogin) {
  const navigate = useNavigate();
  const userInfo = useRecoilValue(userState);
  // 로그아웃 Hook
  const { logOut } = useAuth();
  // 애니메이션
  const [animationed, setAnimationed] = useState(false);
  const changeAnimationed = (val: boolean) => {
    setAnimationed(val);
  };
  // 서비스 안내 state
  const [service, setService] = useState(false);
  const pRef = useRef<HTMLImageElement>(null);
  const cRef = useRef<HTMLImageElement>(null);
  const uRef = useRef<HTMLDivElement>(null);
  const clickButton = (type: "personal" | "company" | "top" | "") => {
    if (type === "personal") pRef?.current?.scrollIntoView({ behavior: "smooth", block: "start" });
    if (type === "company") cRef?.current?.scrollIntoView({ behavior: "smooth", block: "start" });
    if (type === "top") uRef?.current?.scrollIntoView({ behavior: "smooth", block: "start" });
  };

  useEffect(() => {
    if (routeType === "service") {
      setService(true);
    } else {
      setService(false);
    }
  }, [routeType]);
  // =====================================================================

  return (
    <>
      <LandingContainer image={BackgroundImage}>
        <div className="header" ref={uRef}>
          <div className="headLogo">
            <div className="logo" onClick={() => window.location.reload()}>
              <img src={LogoWhite} alt="로고" />
            </div>
            <div className="header__userInfo">
              {getCookie("token") && userInfo && loginPassCheck ? (
                <>
                  <p>
                    <span className="username">{userInfo?.companyName || userInfo?.name}</span> 님
                    환영합니다!
                  </p>
                </>
              ) : (
                <></>
              )}
              {isLogined && loginPassCheck && (
                <>
                  <FillButton
                    buttonName="내 정보"
                    onClick={() => navigate("/user/partners/my-info")}
                    margin={"7px"}
                    systemType="partners"
                  />
                  <BorderLineButton
                    buttonName="로그아웃"
                    onClick={async () => {
                      logOut(() => changeAnimationed(false));
                    }}
                    systemType="partners"
                  />
                </>
              )}
            </div>
          </div>
          {type === "user" && (
            <div className="headNav">
              <div className="navBox">
                {isLogined ? (
                  <>
                    <h2>발급하기</h2>
                    <div>
                      <p>계좌이체거래약정서 발급</p>
                      <Link to={"/user/partners/agreement"} state={{ type: "partners" }}>
                        <SmallButton type="button">
                          발급하기 <ArrowNext />
                        </SmallButton>
                      </Link>
                    </div>
                  </>
                ) : (
                  <>
                    <h2>회원가입</h2>
                    <div>
                      <p>계좌등록이 필요하세요?</p>
                      <Link to={"/join"} state={{ type: "partners" }}>
                        <SmallButton type="button">
                          회원가입 <ArrowNext />
                        </SmallButton>
                      </Link>
                    </div>
                  </>
                )}
              </div>
              <div className="hr" />
              <div className="navBox">
                <h2>서비스 안내</h2>
                <div>
                  <p>계좌등록시스템 이용안내</p>
                  <SmallButton
                    type="button"
                    className="service"
                    onClick={() => {
                      navigate("/service-guide");
                      // setService(true);
                    }}
                  >
                    바로가기 <ArrowNext />
                  </SmallButton>
                </div>
              </div>
              <div className="hr" />
              <div className="navBox">
                <h2>고객센터</h2>
                <div>
                  <p>문의사항이 있으신가요?</p>
                  <a href="tel:041-400-1944">
                    <SmallButton type="button" className="service">
                      <Phone />
                      041-400-1944
                    </SmallButton>
                  </a>
                </div>
              </div>
            </div>
          )}
          {type === "admin" && (
            <div className="headNav">
              <div className="adminNav">
                <h1>한국서부발전의 계좌등록시스템에 오신 서부 담당자님, 반갑습니다. </h1>
                <p>블록체인을 이용하여 안전하고 편리하게 계좌등록시스템을 이용해보세요.</p>
              </div>
              <div className="hr" />
              <div className="navBox">
                <h2>서비스 안내</h2>
                <div>
                  <p>계좌등록시스템 이용안내</p>
                  <SmallButton
                    type="button"
                    className="service"
                    onClick={() => {
                      setService(true);
                    }}
                  >
                    바로가기 <ArrowNext />
                  </SmallButton>
                </div>
              </div>
            </div>
          )}
        </div>
        <div className="content">
          {!service && (
            <>
              {!animationed && (
                <div
                  className={`left ${isLogined && loginPassCheck ? "none" : ""}`}
                  onAnimationEnd={() => setAnimationed(true)}
                >
                  <div className="top">
                    <h3>
                      <img src={check} alt="체크 아이콘" />
                      계좌등록시스템이란?
                    </h3>
                    <img src={landingInfo} className="landingInfo" alt="정보 이미지" />
                  </div>
                  <div className="bottom">
                    <h3>
                      <img src={accountApplication} alt="계좌이체 아이콘" />
                      계좌이체거래약정서 발급절차
                    </h3>
                    <div className="process">
                      {process.env.REACT_APP_SOURCE_DISTRIBUTE === "OUTSIDE" && (
                        <ul>
                          <li>1.회원가입 및 로그인</li>
                          <li>2.계좌이체거래약정서 발급 페이지로 이동</li>
                          <li>3.약관동의 후 계좌 유효성 및 사용자 검증</li>
                          <li>4.첨부 문서 업로드</li>
                          <li>5.발급 신청 진행</li>
                          <li>6.서부 담당자의 승인 및 발급 완료</li>
                        </ul>
                      )}
                      {process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL" && (
                        <ul>
                          <li>1.담당자 로그인(OTP, 지문인증, SSO)</li>
                          <li>2.계좌이체거래약정서 {">"} 신청현황 페이지로 이동</li>
                          <li>3.발급요청된 내역 확인 및 검토</li>
                          <li>4.첨부 문서 확인 및 보완 필요 문서 가림처리</li>
                          <li>5.발급 완료</li>
                        </ul>
                      )}
                    </div>
                  </div>
                </div>
              )}
              {!animationed && (
                <div className={`right ${isLogined && loginPassCheck ? "none" : ""}`}>
                  <form onSubmit={onSubmit}>
                    {type === "admin" && (
                      <div className="adminLogin">
                        <div className="tabBar">
                          <span
                            className={loginType === "otp" ? "color" : ""}
                            onClick={() => {
                              changeLoginType("otp");
                            }}
                          >
                            모바일 OTP
                          </span>
                          <span
                            className={loginType === "hand" ? "color" : ""}
                            onClick={() => {
                              changeLoginType("hand");
                            }}
                          >
                            지문인증
                          </span>
                        </div>
                        <div className={`inputWrap`}>
                          {loginType === "otp" && (
                            <>
                              <div className="otp">
                                <input
                                  placeholder="사번을 입력하세요."
                                  type="text"
                                  {...register("id", {
                                    required: "사번을 입력하세요.",
                                  })}
                                />
                              </div>
                              <input
                                placeholder="생성된 일회용 비밀번호를 입력하세요."
                                type="text"
                                {...register("password", {
                                  required: "생성된 일회용 비밀번호를 입력하세요.",
                                })}
                              />
                            </>
                          )}
                          {loginType === "hand" && (
                            <>
                              <input
                                className="singleInput"
                                placeholder="사번을 입력하세요."
                                type="text"
                                {...register("id", {
                                  required: "사번을 입력하세요.",
                                })}
                              />
                            </>
                          )}
                        </div>
                        <div className="buttonContainer">
                          <button className="bigButton">로그인</button>
                        </div>
                        <p className="info">
                          * 위의 방식 중 이용을 원하시는 로그인 방식을 선택해주세요.
                        </p>
                        <p>* 모바일 OTP를 선택하신 경우 생성된 일회용 비밀번호를 입력해주세요.</p>
                      </div>
                    )}
                    {type === "user" && (
                      <div className="userLogin">
                        {!passProgress && (
                          <div className="inputWrap">
                            <input
                              placeholder="아이디를 입력하세요."
                              type="text"
                              {...register("id", {
                                required: "아이디를 입력하세요.",
                              })}
                            />
                            <input
                              placeholder="비밀번호를 입력하세요."
                              type="password"
                              {...register("password", {
                                required: "비밀번호를 입력하세요.",
                              })}
                            />
                          </div>
                        )}
                        {passProgress && (
                          <button
                            className="committerAuth"
                            type="button"
                            onClick={onLoginPhoneCheck}
                          >
                            <SmartPhone />
                            <h3>본인인증</h3>
                            <p>다시 진행하시려면 클릭하세요</p>
                          </button>
                        )}
                        <div className="buttonContainer">
                          {!passProgress && (
                            <button className="bigButton" type="submit">
                              로그인
                            </button>
                          )}
                          <ul>
                            {!passProgress ? (
                              <>
                                <li>
                                  <Link to={"/login/find/id"}>아이디 찾기</Link>
                                </li>
                                <li>
                                  <Link to={"/login/find/password"}>비밀번호 찾기</Link>
                                </li>
                                <li>
                                  <Link to={"/login/change-phone"}>전화번호 변경</Link>
                                </li>
                              </>
                            ) : (
                              <li onClick={onCancelLoginPhone}>뒤로가기</li>
                            )}
                            <li>
                              <Link to={"/join"}>회원가입</Link>
                            </li>
                          </ul>
                        </div>
                        <p className="info">* 아이디 비밀번호 입력 후 로그인 버튼을 눌러주세요.</p>
                        <p>* 로그인이 완료되면 본인인증을 진행합니다.</p>
                      </div>
                    )}
                  </form>
                  <div className="logoBox">
                    <img src={LogoSmallTitle} alt="" />
                  </div>
                </div>
              )}
              {isLogined && animationed && loginPassCheck && (
                <LandingList animationed={animationed} />
              )}
            </>
          )}
          {service && (
            <div className="service">
              <h1>서비스 안내</h1>
              <div>
                <p>필요한 서비스 안내를 선택해주세요 !</p>
                <div className="serviceButtons">
                  <InputButton onClick={() => clickButton("personal")} text="개인" />
                  <InputButton onClick={() => clickButton("company")} text="법인" />
                </div>
              </div>
              <img src={personalServiceInfo} alt="" ref={pRef} />
              <img src={companyServiceInfo} alt="" ref={cRef} />
              <button className="up" onClick={() => clickButton("top")}>
                <HiChevronUp />
              </button>
            </div>
          )}
        </div>
      </LandingContainer>
      {passData && <NicePhone passData={passData} onClose={passDataReset} />}
    </>
  );
}

const LandingContainer = styled.div<LandingContainerType>`
  width: 100%;
  margin: 0 auto;

  .header {
    width: 100%;
    height: 237px;
    /* background: linear-gradient(
      93.64deg,
      #4188de 3.21%,
      #4f9ff6 39.55%,
      rgba(69, 143, 229, 0.6) 84%,
      rgba(54, 117, 191, 0.41) 95.42%
    ); */
    background-image: url(${(props) => (props.image ? props.image : "")});
    background-size: cover;
    & > div {
      width: ${theme.commonWidth.landingWidth};
      margin: 0 auto;
    }
    & > .headLogo {
      padding: 24px 0px;
      margin-bottom: 16px;
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      & > .logo {
        width: 300px;
        display: flex;
        justify-content: center;
        align-items: center;
        cursor: pointer;
        & > img {
          width: 100%;
          height: 100%;
          object-fit: contain;
        }
      }
      & > .header__userInfo {
        display: flex;
        align-items: center;
        & > p {
          margin-right: 12px;
          color: white;
          font-size: 14px;
        }
        & .username {
          font-size: 16px;
          font-weight: 600;
        }
        & > span {
          margin-right: 24px;
          color: white;
        }
      }
    }

    & > .headNav {
      display: flex;
      height: auto;
      & > .adminNav {
        width: calc(100% - 410px);
        display: flex;
        flex-direction: column;
        justify-content: center;
        gap: 7px;
        color: white;
        & > h1 {
          font-size: 20px;
          font-weight: 500;
        }
      }
      & > .navBox {
        width: 33.33%;
        color: white;
        padding: 0px 24px;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        & > h2 {
          font-size: ${theme.fontType.medium30.fontSize};
          font-weight: 400;
        }
        & > div {
          width: 100%;
          display: flex;
          justify-content: space-between;
          align-items: flex-end;
          p {
            font-size: ${theme.fontType.light18.fontSize};
            /* font-weight: ${theme.fontType.light18.bold}; */
            font-weight: 300;
            margin-bottom: 1px;
          }
        }
        &:first-child {
          padding-left: 0px;
        }
      }
      .hr {
        width: 1px;
        height: 93px;
        background-color: ${theme.colors.gray5};
        margin-top: 16px;
        opacity: 0.5;
      }
    }
  }
  .content {
    width: ${theme.commonWidth.landingWidth};
    margin: 0 auto;
    display: flex;
    justify-content: flex-start;
    gap: 40px;
    .left {
      padding-top: 72px;
      padding-bottom: 40px;
      width: 100%;
      flex: 1;
      &.none {
        animation: leftFadeout 0.7s;
        animation-fill-mode: forwards;
      }
      @keyframes leftFadeout {
        from {
          opacity: 1;
        }
        to {
          opacity: 0;
          transform: translateX(-736px);
        }
      }
      h3 {
        display: flex;
        align-items: center;
        gap: 16px;
        font-weight: ${theme.fontType.medium24.bold};
        font-size: ${theme.fontType.medium24.fontSize};
        img {
          width: 32px;
          height: 32px;
        }
      }
      p {
        display: block;
        width: 736px;
        font-weight: ${theme.fontType.regular13.bold};
        font-size: ${theme.fontType.regular13.fontSize};
        > strong {
          font-weight: ${theme.fontType.bold13.bold};
          font-size: ${theme.fontType.bold13.fontSize};
        }
      }
      .landingInfo {
        display: block;
        width: 100%;
      }
      .process {
        width: 100%;
        height: 232px;
        padding: 32px 24px;
        border: 1px solid ${theme.colors.gray5};
        border-radius: 15px;
        ul {
          display: flex;
          flex-direction: column;
          gap: 4px;
          font-weight: ${theme.fontType.regular13.bold};
          font-size: ${theme.fontType.regular13.fontSize};
        }
      }
    }
    .right {
      width: 410px;
      padding: 24px;
      border-left: 1px solid ${theme.colors.gray5};
      border-right: 1px solid ${theme.colors.gray5};
      position: relative;
      &.none {
        animation: RightFadeout 0.7s;
        animation-fill-mode: forwards;
      }
      @keyframes RightFadeout {
        from {
          opacity: 1;
        }
        to {
          opacity: 0;
          transform: translateX(500px);
        }
      }
      input {
        width: 100%;
        height: 52px;
        display: block;
        border: none;
        outline: none;
        border-radius: 5px;
        padding-left: 24px;
        &::placeholder {
          font-weight: ${theme.fontType.regular14.bold};
          font-size: ${theme.fontType.regular14.fontSize};
        }
      }
      p {
        font-weight: ${theme.fontType.regular12.bold};
        font-size: ${theme.fontType.regular12.fontSize};
      }
      .inputWrap {
        width: 100%;
        margin-top: 10px;
        border: 1px solid ${theme.colors.gray4};
        border-radius: 5px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        input:first-child {
          border-bottom: 1px solid ${theme.colors.gray4};
          border-bottom-left-radius: 0px;
          border-bottom-right-radius: 0px;
          &.singleInput {
            border-bottom: none;
            border-bottom-left-radius: 5px;
            border-bottom-right-radius: 5px;
          }
        }

        .otp {
          width: 100%;
          position: relative;
          button {
            position: absolute;
            right: 8px;
            top: 8px;
            width: 91px;
            height: 36px;
            color: white;
            background-color: #5fa4f2;
            text-align: center;
            border: 1px solid rgba(218, 221, 229, 0.2);
            box-shadow: 0px 4px 4px -2px rgba(0, 0, 0, 0.1);
            border-radius: 61px;
          }
        }
      }

      .sso {
        border: 0;
        padding: 20px 0px;
        .ssoText {
          color: red;
          font-size: 1rem;
          font-weight: bold;
          color: #425061;
        }
      }
      .buttonContainer {
        margin-top: 16px;

        ul {
          margin-top: 16px;
          display: flex;
          justify-content: center;
          gap: 16px;
          li {
            font-weight: 400;
            font-size: 12px;
            line-height: 17px;
            padding-right: 16px;
            font-weight: ${theme.fontType.regular12.bold};
            font-size: ${theme.fontType.regular12.fontSize};
            border-right: 1px solid ${theme.colors.blueGrayDeeper2};
            cursor: pointer;
            &:last-child {
              border-right: none;
              padding-right: 0px;
            }
          }
        }
      }
      .bigButton {
        width: 100%;
        height: 54px;
        text-align: center;
        background: #35629d;
        border: 1px solid rgba(218, 221, 229, 0.2);
        box-shadow: 0px 4px 4px -2px rgba(0, 0, 0, 0.1);
        border-radius: 61px;
        color: white;
        font-size: ${theme.fontType.bold16.fontSize};
        font-weight: ${theme.fontType.bold16.bold};
      }
      .passCheck {
        background: ${theme.colors.gray5};
      }
      .userTab {
        width: 100%;
        height: 54.81px;
        margin-bottom: 15.94px;
        display: flex;
        background-color: ${theme.colors.blueGray2};
        border: 1px solid #dadde5;
        box-shadow: 0px -2px 13px -1px rgba(0, 0, 0, 0.07);
        border-radius: 5px;
        color: ${theme.colors.blueGrayDeeper2};
        font-size: ${theme.fontType.bold16.fontSize};
        font-weight: ${theme.fontType.bold16.bold};
        width: 100%;
        height: 100%;
        display: block;
        text-align: center;
        line-height: 55px;
        z-index: 3;
        transition: all 0.2s;
      }
      .userLogin {
        .inputWrap {
          margin-top: 10px;
        }
        & > .info {
          margin-top: 50px;
        }
        & .committerAuth {
          width: 223px;
          height: 223px;
          display: flex;
          flex-direction: column;
          align-items: center;
          margin: 0 auto;
          margin-top: 40px;
          /* margin-bottom: 40px; */
          border: 0.465px solid ${theme.colors.blueGray1};
          box-shadow: 0px 4px 17px -4px rgba(0, 0, 0, 0.25);
          border-radius: 15.81px;
          & > svg {
            margin-top: 24px;
            height: 112px;
            & rect {
              stroke: ${theme.colors.peacok};
            }
            & circle {
              fill: ${theme.colors.peacok};
            }
          }
          & > h3 {
            margin-top: 16px;
            margin-bottom: 12px;
            font-weight: ${theme.fontType.medium16.bold};
            font-size: ${theme.fontType.medium16.fontSize};
            color: ${theme.colors.peacok};
          }
          & > p {
            font-size: ${theme.fontType.medium12.fontSize};
            font-weight: ${theme.fontType.medium12.bold};
            color: ${theme.colors.blueGrayDeeper2};
          }
        }
      }
      .adminLogin {
        .tabBar {
          margin-top: 16px;
          margin-bottom: 16px;
          font-weight: 400;
          font-size: 14px;
          line-height: 20px;
          > span {
            padding-left: 7px;
            cursor: pointer;
            font-weight: 300;
            color: ${theme.colors.blueGrayDeeper2};
            padding-right: 7px;
            /* padding-left: 0px; */
            border-right: 1px solid #848484;
            &:hover {
              text-decoration: underline;
            }
            /* &:first-child {
              padding-right: 7px;
              padding-left: 0px;
              border-right: 1px solid #848484;
            } */
            &:last-child {
              border-right: 0;
            }
            &.color {
              font-weight: 700;
              text-decoration: underline;
              color: #35629d;
            }
          }
        }
        & > .info {
          margin-top: 32px;
        }
      }
      & > .logoBox {
        width: 160px;
        height: 100px;
        margin: 0 auto;
        margin-top: 37px;
        & > img {
          width: 100%;
          object-fit: contain;
        }
      }
    }
    .service {
      width: 100%;
      color: ${theme.colors.body2};
      & > h1 {
        margin-top: 72px;
        font-weight: 500;
        font-size: 24px;
      }
      & > img {
        margin: 0 auto;
        display: block;
        width: 80%;
      }
      & > div {
        margin-bottom: 200px;
        & > p {
          margin-top: 62px;
          font-weight: 300;
          font-size: 18px;
          text-align: center;
        }
        & > .serviceButtons {
          margin-top: 61px;
          display: flex;
          justify-content: center;
          gap: 16px;
        }
      }
      & .up {
        position: fixed;
        width: 70px;
        height: 70px;
        right: 40px;
        bottom: 40px;
        display: flex;
        justify-content: center;
        align-items: center;
        border-radius: 50%;
        background-color: rgba(0, 0, 0, 0.4);
        color: white;
        cursor: pointer;
        &:hover {
          background-color: rgba(0, 0, 0, 07);
        }
        & > svg {
          width: 40px;
          height: auto;
        }
      }
    }
    .bottom {
      h3 {
        margin-bottom: 24px;
      }
    }
  }
`;

const SmallButton = styled.button`
  padding: 9.5px 24px;
  display: flex;
  align-items: center;
  gap: 8px;
  justify-content: space-between;
  font-size: ${theme.fontType.medium13.fontSize};
  font-weight: ${theme.fontType.medium13.bold};
  line-height: 19px;
  border: 1px solid rgba(218, 221, 229, 0.2);
  background-color: #5fa4f2;
  border-radius: 19px;
  box-shadow: 0px 4px 4px -2px rgba(0, 0, 0, 0.1);
  transition: all 0.1s;
  color: white;
  > svg {
    width: 16px;
    height: 16px;
  }
  &:hover {
    background-color: #fff;
    color: #4289df;
    path {
      stroke: #4289df;
    }
  }
`;
