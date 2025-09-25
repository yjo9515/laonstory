import styled from "styled-components";

// Text를 중심으로 일정한 비율을 가지는 버튼 - 현재 로그인, 로그아웃 버튼
export default function SmallButton2({
  text,
  onClick,
  blue = true, // blue true면 파랑색 바탕 false 면 하얀색 비팅
}: {
  text: string;
  onClick: () => void;
  blue?: boolean;
}) {
  return (
    <SmallButtonContainer type="button" onClick={onClick} blue={blue}>
      {text}
    </SmallButtonContainer>
  );
}

const SmallButtonContainer = styled.button<{ blue: boolean }>`
  padding: 4px 16px 4px 16px;
  background-color: ${(props) => (props.blue ? props.theme.partnersColors.primary : "white")};
  color: ${(props) => (props.blue ? "white" : props.theme.partnersColors.primary)};
  border-radius: 5px;
  line-height: 165%;
  white-space: nowrap;
  cursor: pointer;
`;
