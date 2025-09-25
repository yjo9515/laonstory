import { Link, useLocation, useNavigate } from "react-router-dom";
import styled from "styled-components";
import BigButton from "../../../components/Common/Button/BigButton";
import { LoginContainer } from "../../../theme/common";
import logoBlue from "../../../assets/Logo/logoBlue.svg";
import theme from "../../../theme";
import { BlockChain } from "../../../components/Common/Loading/Loading";
import { useEffect } from "react";

export default function JoinCompleteView() {
  const location = useLocation() as { state: { isComplete: boolean } };
  const navigate = useNavigate();

  useEffect(() => {
    if (location?.state?.isComplete) return;
    if (!location?.state?.isComplete) navigate("/");
  }, [location?.state?.isComplete]);

  return (
    <LoginContainer>
      <div className="header">
        <div className="headerContent">
          <Link to="/">
            <img src={logoBlue} alt="로고" />
          </Link>
        </div>
      </div>
      <JoinCompleteViewContainer>
        <div className="blockChin">
          <BlockChain />
        </div>
        <h1>회원가입 완료</h1>
        <div className="subText">
          <p>
            한국서부발전 계좌등록시스템에 성공적으로 가입되었습니다!
            <br /> 이제 <strong>블록체인을 이용하여 편리하고 안전하고 공정한</strong>
            <br /> 한국서부발전의 계좌등록시스템을 이용해보세요!
          </p>
        </div>
        <div className="buttonContainer">
          <Link to={`/`}>
            <BigButton text="로그인 페이지로" />
          </Link>
        </div>
      </JoinCompleteViewContainer>
    </LoginContainer>
  );
}

const JoinCompleteViewContainer = styled.div`
  margin-top: 83px;
  display: flex;
  flex-direction: column;
  align-items: center;
  & > .blockChin {
  }
  & > h1 {
    margin-top: 40px;
    margin-bottom: 16px;
    color: ${theme.partnersColors.primary};
    font-size: ${theme.fontType.bold30.fontSize};
    font-weight: ${theme.fontType.bold30.bold};
  }
  & > .subText {
    text-align: center;
    strong {
      color: ${theme.partnersColors.primary};
    }
  }
  & > .buttonContainer {
    margin-top: 139px;
  }
`;
