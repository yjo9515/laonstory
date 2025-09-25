import styled from "styled-components";
import theme from "../../../theme";

interface ISignupButtonProps {
  icon: JSX.Element; // jsx 형식의 컴포넌트를 받습니다 (아이콘)
  title: string; // 제목
  text: JSX.Element | JSX.Element[]; // 설명 문구
  onClick?: () => void; // 클릭 이벤트가 필요 시 설정
}

export default function AuthButton({ icon, title, text, onClick }: ISignupButtonProps) {
  return (
    <button onClick={onClick || (() => {})} type="button">
      <SignupButtonContainer>
        <SignupButtonImage>{icon}</SignupButtonImage>
        <h3>{title}</h3>
        {text}
      </SignupButtonContainer>
    </button>
  );
}

const SignupButtonContainer = styled.div`
  width: 400px;
  height: 400px;
  padding-top: 72px;
  border-radius: 30px;
  border: 1px solid ${(props) => props.theme.colors.blueGray1};
  display: flex;
  flex-direction: column;
  align-items: center;
  cursor: pointer;
  & > h3 {
    margin-top: 34px;
    color: ${theme.colors.peacok};
    font-size: ${theme.fontType.bold30.fontSize};
    font-weight: ${theme.fontType.bold30.bold};
  }
  &:hover {
    border: 3px solid #0a4763;
    & > div {
      margin-top: -2px;
    }
  }
  &:active {
    background-color: ${theme.colors.peacok};
    border: 3px solid ${theme.colors.peacok};
    & > p,
    h3 {
      color: white;
    }
    & path,
    rect,
    circle {
      stroke: white;
    }
    circle {
      fill: white;
    }
  }
  & > p {
    margin-top: 16px;
    text-align: center;
    color: ${(props) => props.theme.colors.body};
    font-size: ${theme.fontType.medium16.fontSize};
    font-weight: ${theme.fontType.medium16.bold};
  }
`;

const SignupButtonImage = styled.div`
  > svg {
    width: 190px;
    height: 171px;
  }
`;
