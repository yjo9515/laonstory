import { Link } from "react-router-dom";
import PersonalIcon from "../../../assets/Auth/PersonalIcon";
import CompanyIcon from "../../../assets/Auth/CompanyIcon";
import AuthButton from "../../../components/Common/Button/AuthButton";
import { LandingContainer, LoginContainer } from "../../../theme/common";
import logoBlue from "../../../assets/Logo/logoBlue.svg";
export default function JoinView() {
  return (
    <LoginContainer>
      <div className="header">
        <div className="headerContent">
          <Link to="/">
            <img src={logoBlue} alt="로고" />
          </Link>
        </div>
      </div>
      <LandingContainer>
        <h1>회원가입</h1>
        <p className="subText">
          한국서부발전 온라인 계좌등록 시스템에 오신걸 환영합니다!
          <br />
          이용자 및 법인일 경우 아래의 버튼을 눌러 가입을 진행해주세요.
        </p>
        <div className="main">
          <div className="authButtonContainer">
            <Link to="personal">
              <AuthButton
                title="개인"
                icon={<PersonalIcon />}
                text={<p>개인으로 가입하려면 클릭해주세요.</p>}
              ></AuthButton>
            </Link>
            <Link to="company">
              <AuthButton
                text={<p>사업자 및 법인으로 가입하려면 클릭해주세요.</p>}
                title="사업자 및 법인"
                icon={<CompanyIcon />}
              ></AuthButton>
            </Link>
          </div>
        </div>
      </LandingContainer>
    </LoginContainer>
  );
}
