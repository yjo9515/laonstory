import styled from "styled-components";
import theme from "../../../theme";
import { UseFormRegister } from "react-hook-form";
import { ILoginInput } from "../../../interface/Auth/FormInputInterface";
import { Link, useNavigate } from "react-router-dom";
import { IUser } from "../../../interface/Auth/AuthInterface";
import systemImg from "../../../assets/Img/system.png";
import systemBanner from "../../../assets/Img/systemBanner.png";
import LogoWhite from "./../../../assets/Logo/logoWhite.svg";
import { useRef, useState } from "react";
import LandingList from "../../../components/List/LandingList/LandingList";
import RoleUtils from "../../../utils/RoleUtils";
import FillButton from "../../../components/Common/Button/FillButton";
import SmartPhone from "../../../assets/Auth/SmartPhone";
import info1 from "../../../assets/Img/info_1.jpg";
import info2 from "../../../assets/Img/info_2.jpg";
import info3 from "../../../assets/Img/info_3.jpg";
import info4 from "../../../assets/Img/info_4.jpg";
import BigInputButton from "../../../components/Common/Button/BigInputButton";
import SmallButton1 from "../../../components/Common/Button/SmallButton1";
import NicePhone from "../../../components/Modal/Nice/NicePhone";

interface ILogin {
  register: UseFormRegister<ILoginInput>;
  onSubmit: any;
  isAdmin: boolean;
  changeAdmin: (val: boolean) => void;
  loginType: string;
  changeLoginType: (type: string) => void;
  userData: IUser;
  isLogined: boolean;
  onLogout: () => void;
  goPage: (linkType: string) => void;
  onCommitterLoginClick: () => void;
  loginPassCheck: boolean;
  passData?: string;
  onLoginPhoneCheck: () => void;
  onCancelLoginPhone: () => void;
  passDataReset: () => void;
}

type LandingContainerType = {
  isAdmin?: boolean;
  isAnimationed?: boolean;
};

export default function LandingView({
  loginType,
  changeLoginType,
  changeAdmin,
  register,
  onSubmit,
  isAdmin,
  isLogined,
  userData,
  onLogout,
  onCommitterLoginClick,
  loginPassCheck,
  passData,
  onLoginPhoneCheck,
  onCancelLoginPhone,
  passDataReset,
}: ILogin) {
  const [isAnimationed, setIsAnimaitoned] = useState(false);
  const [showInfo, setShowInfo] = useState(false);
  const [type, setType] = useState<"committer" | "company" | "admin" | "">("");
  const navigate = useNavigate();
  const role = RoleUtils.getClientRole(userData.role);
  const headerRef = useRef<HTMLImageElement>(null);
  const committerRef = useRef<HTMLImageElement>(null);
  const companyRef = useRef<HTMLImageElement>(null);
  const adminRef = useRef<HTMLImageElement>(null);
  const clickButton = (type: "committer" | "company" | "admin" | "top") => {
    if (type === "committer")
      committerRef?.current?.scrollIntoView({ behavior: "smooth", block: "start" });
    if (type === "company")
      companyRef?.current?.scrollIntoView({ behavior: "smooth", block: "start" });
    if (type === "admin") adminRef?.current?.scrollIntoView({ behavior: "smooth", block: "start" });
    if (type === "top") headerRef?.current?.scrollIntoView({ behavior: "smooth", block: "start" });
  };

  return (
    <>
      <HeadInfoBlock>
        <div className={`banner ${isLogined && "remove"} ${isLogined && isAnimationed && "show"}`}>
          {isAnimationed && isLogined && loginPassCheck && (
            <div className="bannerNav">
              <div className="bannerNavTab">
                <h2>
                  서비스 안내 <span>제안서 평가서비스 안내</span>
                </h2>
                <button type="button" onClick={() => setShowInfo(true)}>
                  바로가기
                </button>
              </div>
              <div className="border"></div>
              <div className="bannerNavTab">
                <h2>
                  고객센터 <span>문의사항이 있으신가요?</span>
                </h2>
                <button type="button">041-400-1944</button>
              </div>
            </div>
          )}
          {!isAnimationed && (
            <>
              <h1>
                한국서부발전 <span>제안서 평가시스템</span>에 오신 여러분 환영합니다!
              </h1>
              <p>
                편리하고 간편하지만 공정하고 안전한 <span>블록체인 기반</span> 평가시스템을
                이용해보세요!
              </p>
            </>
          )}
        </div>
        <div className="headerWrap">
          <div>
            <a href="/">
              <img src={LogoWhite} alt="로고" />
            </a>
            {isLogined && loginPassCheck && (
              <div className="headerNav">
                <p>
                  <span className="username">
                    {RoleUtils.isAuthorityTypeCheck(role ?? "")}{" "}
                    {role === "company" ? userData.companyName : userData.name}
                  </span>{" "}
                  님 환영합니다!
                </p>
                <div>
                  {role === "company" && (
                    <FillButton
                      buttonName="내정보"
                      onClick={() => navigate("/user/system/my-info")}
                    />
                  )}
                  <FillButton buttonName="로그아웃" onClick={onLogout} />
                </div>
              </div>
            )}
          </div>
        </div>
      </HeadInfoBlock>
      <LandingAllWrapBlock>
        {!showInfo && (
          <LandingContainer isAdmin={isAdmin}>
            <div className={`content ${isAnimationed && isLogined && "show"}`}>
              {!isAnimationed && (
                <div
                  className={`firstBox ${isLogined && loginPassCheck && "none"}`}
                  onAnimationEnd={() => setIsAnimaitoned(true)}
                >
                  <div className="left">
                    <>
                      {process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL" && (
                        <div className="internalUserTab">서부 평가담당자</div>
                      )}
                      {process.env.REACT_APP_SOURCE_DISTRIBUTE === "OUTSIDE" && (
                        <div className="userTab">
                          <button
                            className={!isAdmin ? "currentTab" : ""}
                            type="button"
                            onClick={() => changeAdmin(false)}
                          >
                            평가위원/제안업체
                          </button>
                          <button
                            type="button"
                            className={isAdmin ? "currentTab" : ""}
                            onClick={() => changeAdmin(true)}
                          >
                            서부 평가담당자
                          </button>
                          <div className={`currentTab ${isAdmin ? "move" : ""}`}></div>
                        </div>
                      )}
                      {isAdmin || process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL" ? (
                        <>
                          <div className="adminLoginInfo">
                            <p>* 아래의 두가지 중 이용을 원하시는 로그인 방식을 선택해주세요.</p>
                            <p>
                              * 모바일 OTP를 선택하신 경우 생성된 일회용 비밀번호를 입력해주세요.
                            </p>
                          </div>
                          <div className="tabSelectBox">
                            <div className="tabBar">
                              <span
                                className={loginType === "loginTypeLeft" ? "color" : ""}
                                onClick={() => {
                                  changeLoginType("loginTypeLeft");
                                }}
                              >
                                모바일 OTP
                              </span>
                              <span
                                className={loginType === "loginTypeRight" ? "color" : ""}
                                onClick={() => {
                                  changeLoginType("loginTypeRight");
                                }}
                              >
                                지문인증
                              </span>
                            </div>
                          </div>
                          <form onSubmit={onSubmit}>
                            <div className="inputSet">
                              <div className="inputWrap">
                                {loginType === "loginTypeLeft" ? (
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
                                      placeholder="생성된 비밀번호를 입력하세요."
                                      type="text"
                                      {...register("password", {
                                        required: "생성된 비밀번호를 입력하세요.",
                                      })}
                                    />
                                  </>
                                ) : (
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
                              <button className="bigButton">로그인</button>
                            </div>
                          </form>
                        </>
                      ) : (
                        <>
                          <div className="adminLoginInfo">
                            <p>아래의 두가지 중 이용을 원하시는 로그인을 선택해주세요.</p>
                          </div>
                          <div className="tabSelectBox">
                            <div className="tabBar">
                              <span
                                className={loginType === "loginTypeLeft" ? "color" : ""}
                                onClick={() => {
                                  changeLoginType("loginTypeLeft");
                                }}
                              >
                                평가위원 로그인
                              </span>
                              <span
                                className={loginType === "loginTypeRight" ? "color" : ""}
                                onClick={() => {
                                  changeLoginType("loginTypeRight");
                                }}
                              >
                                제안업체 로그인
                              </span>
                            </div>
                          </div>
                          <form onSubmit={onSubmit}>
                            {loginType === "loginTypeLeft" ? (
                              <button
                                className="committerAuth"
                                type="button"
                                onClick={onLoginPhoneCheck}
                              >
                                <SmartPhone />
                                <h3>본인인증</h3>
                                <p>본인인증을 진행하시려면 클릭하세요</p>
                              </button>
                            ) : (
                              <>
                                {!isLogined ? (
                                  <div className="inputSet">
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
                                    <button className="bigButton">로그인</button>
                                  </div>
                                ) : (
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
                              </>
                            )}
                            {loginType === "loginTypeLeft" ? (
                              <p className="loginInfoCommitter">
                                * 서부 평가담당자가 등록한 정보가 없을 경우 로그인이 제한될 수
                                있습니다.
                              </p>
                            ) : (
                              <>
                                {" "}
                                <div className="buttonContainer">
                                  <ul>
                                    {!isLogined ? (
                                      <>
                                        <li>
                                          <Link to={"/login/find/id"}>아이디 찾기</Link>
                                        </li>
                                        <li>
                                          <Link to={"/login/find/password"}>비밀번호 찾기</Link>
                                        </li>
                                      </>
                                    ) : (
                                      <li className="cursor" onClick={onCancelLoginPhone}>
                                        뒤로가기
                                      </li>
                                    )}
                                    <li>
                                      <Link to={"/join"}>회원가입</Link>
                                    </li>
                                  </ul>
                                </div>
                                {isLogined && !loginPassCheck && (
                                  <p className="loginInfoCompany">
                                    * 등록한 담당자 정보와 다를 경우 로그인이 제한됩니다.
                                  </p>
                                )}
                              </>
                            )}
                          </form>
                        </>
                      )}
                    </>
                  </div>
                  <div className="right">
                    <h2>
                      <span>제안서 평가시스템</span>이란 무엇일까요?
                    </h2>
                    <img src={systemImg} alt="시스템 이미지" />
                    <p>
                      제안서 평가시스템은 한국서부발전의 사업 공고에 신청한 제안업체들의 사업
                      제안서와 제안 발표를 기반으로, 평가위원들이 사업에 적합한 기업을 선정하는
                      온라인 평가시스템입니다. 제안서 평가시스템의 모든 과정은{" "}
                      <span className="point">블록체인을 기반으로</span> 공정하고 안전하게
                      이루어집니다.
                    </p>
                  </div>
                </div>
              )}
              {isAnimationed && isLogined && loginPassCheck && <LandingList />}
            </div>
          </LandingContainer>
        )}
        {showInfo && (
          <>
            {/* <div className="buttons">
              <SmallButton1 text="평가위원" onClick={() => clickButton("committer")} />
              <SmallButton1 text="제안업체" onClick={() => clickButton("company")} />
              <SmallButton1 text="서부 담당자" onClick={() => clickButton("admin")} />
              <SmallButton1 text="맨 위로" onClick={() => clickButton("top")} />
            </div> */}
            <div className="info">
              <img src={info1} alt="" ref={headerRef} />
              {/* <img src={info2} alt="" ref={committerRef} />
              <img src={info3} alt="" ref={companyRef} />
              <img src={info4} alt="" ref={adminRef} /> */}
            </div>
          </>
        )}
      </LandingAllWrapBlock>
      {passData && <NicePhone passData={passData} onClose={passDataReset} />}
    </>
  );
}

const LandingAllWrapBlock = styled.div`
  width: 100%;
  height: 100%;
  .buttons {
    position: fixed;
    gap: 8px;
    right: 20px;
    bottom: 20px;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }
  .info {
    display: flex;
    flex-direction: column;
    gap: 208px;
    & > img {
      margin: 0 auto;
      display: block;
      width: 50%;
    }
  }
`;
const HeadInfoBlock = styled.div`
  width: 100%;
  height: 250px;
  margin: 0 auto;
  background-color: ${theme.partnersColors.primary};
  display: flex;
  justify-content: center;
  align-items: center;
  background: url(${systemBanner});
  background-size: cover;
  position: relative;
  & > .banner {
    width: ${theme.commonWidth.landingWidth};
    margin-top: 60px;
    height: 202px;
    font-size: 13px;
    color: ${theme.colors.white};
    @keyframes show {
      from {
        opacity: 0;
      }
      to {
        opacity: 1;
      }
    }
    &.show {
      animation: show 0.6s linear forwards;
    }
    @keyframes remove {
      from {
        opacity: 1;
      }
      to {
        opacity: 0;
      }
    }
    &.none {
      animation: remove 0.3s linear forwards;
    }
    & > h1 {
      margin-top: 32px;
      font-size: 30px;
      font-weight: 500;
      & > span {
        color: #f2b04c;
        font-size: 46px;
        font-weight: 700;
      }
    }
    & > p {
      font-size: 20px;
      margin-top: 16px;
      & > span {
        color: #66a7ff;
        font-size: 30px;
        font-weight: 700;
      }
    }
    & > .bannerNav {
      width: 736px;
      margin-top: 40px;
      display: flex;
      align-items: center;
      & > .bannerNavTab {
        width: 50%;
        height: 125px;
        &:last-child {
          padding-left: 24px;
        }
        & > h2 {
          font-size: 30px;
          font-weight: 500;
          margin-bottom: 27px;
          display: flex;
          align-items: flex-end;
          gap: 16px;
          & > span {
            font-size: 18px;
            font-weight: 300;
          }
        }
        & > button {
          width: 252px;
          height: 55px;
          background-color: ${theme.systemColors.landingButtonColor};
          box-shadow: 0px -2px 13px -3px rgba(0, 0, 0, 0.27);
          border-radius: 11px;
          font-weight: 500;
          font-size: 18px;
          text-align: center;
          transition: 0.2s all;
          &:hover {
            background-color: ${theme.systemColors.pointColor};
          }
        }
      }
      & > .border {
        width: 1px;
        height: 105px;
        background-color: ${theme.colors.blueGray2};
      }
    }
  }
  & > .headerWrap {
    width: 100%;
    height: 64px;
    position: absolute;
    top: 0;
    left: 0;
    background-color: rgba(0, 0, 0, 0);
    & > div {
      width: ${theme.commonWidth.landingWidth};
      height: 100%;
      margin: 0 auto;
      padding: 6px 0;
      display: flex;
      align-items: center;
      justify-content: space-between;
      & > img {
        height: 32px;
        object-fit: contain;
      }
      & > .headerNav {
        font-size: 13px;
        color: white;
        display: flex;
        align-items: center;
        gap: 24px;
        & .username {
          font-size: 16px;
        }
        & > div {
          display: flex;
          gap: 10px;
          & > button {
            padding: 8px;
            font-weight: 500;
            color: ${theme.systemColors.systemPrimary};
            background-color: #fff;
            border-radius: 6px;
            text-align: center;
            transition: all 0.2s;
            &:hover {
              background-color: ${theme.systemColors.systemPrimary};
              color: white;
            }
          }
        }
      }
    }
  }
`;
const LandingContainer = styled.div<LandingContainerType>`
  width: ${theme.commonWidth.landingWidth};
  height: 100%;
  margin: 0 auto;
  .content {
    width: 100%;
    margin-top: ${(props) => (props.isAnimationed ? "72px" : "40px")};
    padding-bottom: 40px;
    /* 위에 탭 변경 */
    @keyframes show {
      from {
        opacity: 0;
      }
      to {
        opacity: 1;
      }
    }
    &.show {
      animation: show 0.6s linear forwards;
    }
    .userTab {
      width: 100%;
      height: 55px;
      position: relative;
      display: flex;
      background: ${theme.colors.blueGray2};
      box-shadow: 0px -2px 13px -1px rgba(0, 0, 0, 0.07);
      border-radius: 11px;
      color: ${theme.colors.gray};
      border: 1px solid ${theme.colors.blueGray1};
      font-size: ${theme.fontType.button1.fontSize};
      font-weight: ${theme.fontType.button1.bold};
      > button {
        width: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 3;
        transition: all 0.2s;
        &.currentTab {
          color: white;
        }
      }
      > div.currentTab {
        width: 50%;
        height: 100%;
        position: absolute;
        left: 0px;
        background: ${theme.systemColors.systemPrimary};
        box-shadow: 0px -2px 13px -1px rgba(0, 0, 0, 0.07);
        border-radius: 11px;
        z-index: 1;
        transition: all 0.2s;
        &.move {
          left: 50%;
        }
      }
    }

    .internalUserTab {
      width: 100%;
      height: 55px;
      position: relative;
      display: flex;
      justify-content: center;
      align-items: center;
      box-shadow: 0px -2px 13px -1px rgba(0, 0, 0, 0.07);
      border-radius: 11px;
      background-color: ${theme.systemColors.systemPrimary};
    }
    color: white;
  }
  /* input, button 묶음 */
  .inputSet {
    margin-top: 56px;
    display: flex;
    justify-content: space-between;
    gap: 16px;
    width: 100%;
    & .inputWrap {
      width: 100%;
      display: flex;
      flex-direction: column;
      gap: 8px;
      flex: 1;
      & input {
        width: 100%;
        height: 52px;
        padding-left: 24px;
        border: 1px solid ${theme.colors.gray5};
        border-radius: 7px;
        outline: none;
      }
    }
    & > button {
      width: 127px;
      height: inherit;
      background: ${theme.systemColors.systemPrimary};
      border: 1px solid rgba(218, 221, 229, 0.2);
      box-shadow: 0px 4px 4px -2px rgba(0, 0, 0, 0.1);
      border-radius: 11px;
      text-align: center;
      color: white;
    }
  }
  .firstBox {
    /* 하위 컨테이너 공통 적용 */
    width: 100%;
    height: 100%;
    height: 570px;
    display: flex;
    gap: 40px;
    @keyframes remove {
      from {
        opacity: 1;
      }
      to {
        opacity: 0;
      }
    }
    &.none {
      animation: remove 0.3s linear forwards;
    }
    /* firstBox 하위 컨테이너 공통 적용 */
    & > div {
      width: 50%;
      height: 100%;
      padding: 32px;
    }
    /* 왼쪽 박스 */
    .left {
      border: 1px solid ${theme.colors.blueGray1};
      border-radius: 15px;
      padding: 32px 24px;
      .loginInfoCommitter {
        margin-top: 60px;
        font-size: ${theme.fontType.content1.fontSize};
        font-weight: ${theme.fontType.content1.bold};
        text-align: center;
        color: ${theme.colors.blueGrayDeeper2};
      }
      .loginInfoCompany {
        margin-top: 20px;
        font-size: ${theme.fontType.content1.fontSize};
        font-weight: ${theme.fontType.content1.bold};
        text-align: center;
        color: ${theme.colors.blueGrayDeeper2};
      }
      .buttonContainer {
        margin-top: 24px;
        display: flex;
        justify-content: center;
        ul {
          display: flex;
          justify-content: flex-start;
          gap: 16px;
          li {
            font-size: ${theme.fontType.content2.fontSize};
            font-weight: ${theme.fontType.content2.bold};
            padding-right: 16px;
            border-right: 1px solid #848484;
            &:last-child {
              border-right: none;
              padding-right: 0px;
            }
            a {
              color: #848484;
            }
          }
          .cursor {
            cursor: pointer;
          }
        }
      }
      & .adminLoginInfo {
        margin-top: 24px;
        margin-bottom: 16px;
        & > p {
          font-size: ${theme.fontType.content1.fontSize};
          font-weight: ${theme.fontType.content1.bold};
          line-height: 19px;
          color: ${theme.colors.blueGrayDeeper2};
        }
      }
      & .tabSelectBox {
        .tabBar {
          font-size: ${theme.fontType.contentTitle1.fontSize};
          font-weight: ${theme.fontType.contentTitle1.bold};
          line-height: 20px;
          color: ${theme.colors.blueGrayDeeper2};
          > span {
            padding-left: 7px;
            cursor: pointer;
            font-weight: 500;
            &:first-child {
              padding-right: 7px;
              padding-left: 0px;
              border-right: 1px solid ${theme.colors.blueGray2};
            }
            &.color {
              text-decoration: underline;
              color: ${theme.partnersColors.primary};
            }
          }
        }
      }

      & .committerAuth {
        width: 223px;
        height: 223px;
        display: flex;
        flex-direction: column;
        align-items: center;
        margin: 0 auto;
        margin-top: 70px;
        border: 0.465px solid ${theme.colors.blueGray1};
        box-shadow: 0px 4px 17px -4px rgba(0, 0, 0, 0.25);
        border-radius: 15.81px;
        & > svg {
          margin-top: 24px;
          height: 112px;
          & rect {
            stroke: ${theme.systemColors.systemFont};
          }
          & circle {
            fill: ${theme.systemColors.systemFont};
          }
        }
        & > h3 {
          margin-top: 16px;
          margin-bottom: 12px;
          font-weight: ${theme.fontType.title3.bold};
          font-size: ${theme.fontType.title3.fontSize};
          color: ${theme.systemColors.systemFont};
        }
        & > p {
          font-size: ${theme.fontType.content2.fontSize};
          font-weight: ${theme.fontType.content2.bold};
          color: ${theme.colors.blueGrayDeeper2};
        }
      }
    }
    .right {
      /* padding: 32px; */
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: space-between;
      border: 1px solid ${theme.colors.blueGray1};
      border-radius: 20px;
      & > h2 {
        width: 100%;
        font-weight: 500;
        font-size: 20px;
        color: ${theme.systemColors.systemFont};
        & > span {
          position: relative;
          font-weight: 700;
          font-size: 26px;
          color: #f2b04c;
          /* &::after {
              content: "";
              position: absolute;
              top: 12px;
              right: 3px;
              width: 180px;
              height: 22px;
              z-index: -1;
              background-color: #ffda7b;
            } */
        }
      }
      & > img {
        display: block;
        width: 100%;

        /* margin-top: 48px;
          margin-bottom: 40px; */
      }
      & > p {
        font-size: 13px;
        line-height: 180%;
        color: ${theme.systemColors.systemFont};
        & > .point {
          font-weight: 500;
          position: relative;
          color: #66a7ff;
          font-size: 20px;
          /* &::after {
              content: "";
              position: absolute;
              bottom: -2px;
              left: 0px;
              width: 110px;
              height: 12px;
              background-color: #80ffe1;
              z-index: -1;
            } */
        }
      }
    }
  }
`;
