import { UseFormRegister } from "react-hook-form";
import { Link } from "react-router-dom";
import BigButton from "../../../components/Common/Button/BigButton";
import Form from "../../../components/Common/Container/Form";
import InputSet from "../../../components/Common/Input/InputSet";
import PhoneAuthSet from "../../../components/Common/Input/PhoneAuthSet";
import { ILoginPhoneInput } from "../../../interface/Auth/FormInputInterface";
import { LoginContainer } from "../../../theme/common";
import logoBlue from "../../../assets/Logo/logoBlue.svg";
import arrowPrev from "../../../assets/Icon/arrowPrev.svg";
import NicePhone from "../../../components/Modal/Nice/NicePhone";

interface ILoginPhoneView {
  register: UseFormRegister<ILoginPhoneInput>;
  onSubmit: any;
  phoneCheckClick: () => void;
  phoneCheck: boolean;
  passData: string;
  phoneNumber: string;
  onPassDataReset: () => void;
}

export default function LoginPhoneView({
  register,
  onSubmit,
  phoneCheckClick,
  phoneCheck,
  passData,
  phoneNumber,
  onPassDataReset,
}: ILoginPhoneView) {
  return (
    <>
      {" "}
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
                <img src={arrowPrev} alt="뒤로가기 버튼" />
                <span>뒤로</span>
              </div>
            </Link>
          </div>
          <h1>전화번호 변경</h1>
          <div className="main">
            <div className="subText">
              아이디, 비밀번호 입력 후 변경할 전화번호로 본인인증을 진행해주세요.
            </div>
            <div className="inputContainer">
              <Form onSubmit={onSubmit}>
                <InputSet
                  placeholder="아이디를 입력하세요."
                  type="text"
                  bold
                  label="아이디"
                  register={register("id", { required: "아이디를 입력해주세요." })}
                />
                <InputSet
                  placeholder="비밀번호를 입력하세요."
                  type="password"
                  bold
                  label="비밀번호"
                  register={register("password", {
                    required: "비밀번호를 입력해주세요.",
                  })}
                />
                <PhoneAuthSet
                  onClick={phoneCheckClick}
                  phoneChange
                  phoneCheck={phoneCheck}
                  phoneNumber={phoneNumber}
                />
                {/* <InputSet
                  placeholder="변경할 전화번호를 입력하세요."
                  type="text"
                  bold
                  label="변경할 전화번호"
                  register={register("changePhone", {
                    required: "변경할 전화번호를 입력하세요.",
                  })}
                /> */}
                <div className="buttonContainer">
                  <BigButton text="전화번호 변경" submit />
                </div>
              </Form>
            </div>
          </div>
        </div>
      </LoginContainer>
      {passData && <NicePhone passData={passData} onClose={onPassDataReset} />}
    </>
  );
}
