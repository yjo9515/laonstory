import { Link } from "react-router-dom";
import BigButton from "../../../components/Common/Button/BigButton";
import { LoginContainer } from "../../../theme/common";
import logoBlue from "../../../assets/Logo/logoBlue.svg";
import styled from "styled-components";
import theme from "../../../theme";
import { BlockChain } from "../../../components/Common/Loading/Loading";

export default function JoinCompleteView() {
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
            <br /> 한국서부발전의 제안서평가시스템을 이용해보세요!
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
  margin-top: 88px;
  display: flex;
  flex-direction: column;
  align-items: center;
  & > .blockChin {
  }
  & > h1 {
    margin-top: 40px;
    margin-bottom: 40px;
    color: ${theme.partnersColors.primary};
    font-size: ${theme.fontType.title1.fontSize};
    font-weight: ${theme.fontType.title1.bold};
  }
  & > .subText {
    text-align: center;
    line-height: 22px;
    font-size: ${theme.fontType.contentTitle1.fontSize};
    font-weight: ${theme.fontType.contentTitle1.bold};
    strong {
      color: ${theme.partnersColors.primary};
    }
  }
  & > .buttonContainer {
    margin-top: 118px;
  }
`;
