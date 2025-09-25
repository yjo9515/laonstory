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
        <span>{title}</span>
        {text}
      </SignupButtonContainer>
    </button>
  );
}

const SignupButtonContainer = styled.div`
  width: 400px;
  height: 400px;
  padding: 44px;
  border-radius: 30px;
  border: 1px solid ${(props) => props.theme.colors.blueGray1};
  display: flex;
  flex-direction: column;
  align-items: center;
  cursor: pointer;
  & > span {
    margin-top: 64px;
    color: ${theme.systemColors.systemPrimary};
    font-size: ${theme.fontType.title2.fontSize};
    font-weight: ${theme.fontType.title2.bold};
  }
  &:hover {
    border: 3px solid ${theme.systemColors.systemPrimary};
    & > div {
      margin-top: 48px;
    }
  }
  &:active {
    background-color: ${theme.systemColors.systemPrimary};
    border: 3px solid ${theme.systemColors.systemPrimary};
    & > p,
    span {
      color: white;
    }
    & path,
    rect {
      stroke: white;
    }
    & circle {
      fill: white;
    }
  }
  & > p {
    margin-top: 22px;
    text-align: center;
    color: ${(props) => props.theme.colors.body};
    font-size: ${theme.fontType.subTitle1.fontSize};
    font-weight: ${theme.fontType.subTitle1.bold};
  }
`;

const SignupButtonImage = styled.div`
  margin-top: 50px;
  height: 126px;
  > svg {
    width: 74px;
    height: 126px;
  }
`;
