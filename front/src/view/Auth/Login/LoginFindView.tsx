import { UseFormRegister } from "react-hook-form";
import { Link } from "react-router-dom";
import BigButton from "../../../components/Common/Button/BigButton";
import Form from "../../../components/Common/Container/Form";
import InputSet from "../../../components/Common/Input/InputSet";
import PhoneAuthSet from "../../../components/Common/Input/PhoneAuthSet";
import { ILoginFindInput } from "../../../interface/Auth/FormInputInterface";
import { LoginContainer } from "../../../theme/common";
import { Regex } from "../../../utils/RegularExpression";
import logoBlue from "../../../assets/Logo/logoBlue.svg";
import ArrowPrev from "../../../assets/Icon/ArrowPrev";
import NicePhone from "../../../components/Modal/Nice/NicePhone";
import styled from "styled-components";

interface ILoginFindView {
  findType: string;
  tabClick: (type: string) => void;
  register: UseFormRegister<ILoginFindInput>;
  onSubmit: any;
  phoneCheckClick: () => void;
  phoneCheck: boolean;
  passData: string;
  phoneNumber: string;
  onPassDataReset: () => void;
}

export default function LoginFindView({
  register,
  onSubmit,
  findType,
  tabClick,
  phoneCheckClick,
  phoneCheck,
  passData,
  phoneNumber,
  onPassDataReset,
}: ILoginFindView) {
  return (
    <>
      <LoginFindBlock>
        <LoginContainer>
          <div className="header">
            <div className="headerContent">
              <Link to="/">
                <img src={logoBlue} alt="로고" />
              </Link>
            </div>
          </div>
          <div className="content">
            <div>
              <Link to="/">
                <div className="backButton">
                  <ArrowPrev />
                  <span>뒤로</span>
                </div>
              </Link>
            </div>
            <h1>아이디/비밀번호 찾기</h1>
            <div className="main">
              <div className="tabBar">
                <button
                  type="button"
                  className={findType === "id" ? "currentTab" : ""}
                  onClick={() => {
                    tabClick("id");
                  }}
                >
                  아이디 찾기
                </button>
                <button
                  type="button"
                  className={findType === "password" ? "currentTab" : ""}
                  onClick={() => {
                    tabClick("password");
                  }}
                >
                  비밀번호 찾기
                </button>
                <div className={`currentTab ${findType === "password" ? "move" : ""}`}></div>
              </div>
              <div className="inputContainer">
                <Form onSubmit={onSubmit}>
                  {findType === "id" ? (
                    <>
                      <InputSet
                        placeholder="이메일 주소를 입력하세요."
                        type="text"
                        bold
                        register={register("email", {
                          required: "이메일 주소를 입력하세요.",
                          pattern: {
                            value: Regex.emailRegex,
                            message: "알맞은 형식의 이메일 주소를 입력하세요.",
                          },
                        })}
                        label="이메일"
                      />
                      <p className="infoText">
                        * 가입 시 등록한 이메일을 입력해주세요. 이메일로 아이디를 보내드립니다.
                      </p>
                    </>
                  ) : (
                    <>
                      <InputSet
                        placeholder="아이디를 입력하세요."
                        type="text"
                        bold
                        label="아이디"
                        register={register("id", { required: "아이디를 입력하세요." })}
                      />
                      <PhoneAuthSet
                        onClick={phoneCheckClick}
                        phoneCheck={phoneCheck}
                        phoneNumber={phoneNumber}
                      />
                      <InputSet
                        placeholder="변경할 비밀번호를 입력하세요."
                        type="password"
                        bold
                        label="변경할 비밀번호"
                        register={register("newPassword", {
                          required: "변경할 비밀번호를 입력하세요.",
                        })}
                      />
                      <InputSet
                        placeholder="변경할 비밀번호를 한번 더 입력하세요. 입력하세요."
                        type="password"
                        bold
                        label="변경할 비밀번호 확인"
                        register={register("confirmNewPassword", {
                          required: "변경할 비밀번호를 한번 더 입력하세요. 입력하세요.",
                        })}
                      />
                    </>
                  )}
                  <div className="buttonContainer">
                    <BigButton
                      w={354}
                      text={findType === "id" ? "이메일 전송" : "비밀번호 변경"}
                      submit
                    />
                  </div>
                </Form>
              </div>
            </div>
          </div>
        </LoginContainer>
      </LoginFindBlock>
      {passData && <NicePhone passData={passData} onClose={onPassDataReset} />}
    </>
  );
}

const LoginFindBlock = styled.div`
  margin-bottom: 100px;
`;
