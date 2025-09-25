import styled from "styled-components";

// Text를 중심으로 일정한 비율을 가지는 버튼 - 검색, 유효성 검증
export default function SmallButton1({
  text,
  onClick,
  submit = false,
  white = false, // white가 true면 하얀색 바탕 false 면 파랑색 바탕
}: {
  text: string;
  onClick: any;
  white?: boolean;
  submit?: boolean;
}) {
  return (
    <SmallButtonContainer type={submit ? "submit" : "button"} onClick={onClick} white={white}>
      {text}
    </SmallButtonContainer>
  );
}

const SmallButtonContainer = styled.button<{ white: boolean }>`
  padding: 7px 16px 7px 16px;
  background-color: ${(props) => (props.white ? "white" : "#438cae")};
  color: ${(props) => (props.white ? props.theme.partnersColors.primary : "white")};
  border: ${(props) => (props.white ? `1px solid ${props.theme.colors.gray4}` : "")};
  border-radius: 5px;
  line-height: 165%;
  white-space: nowrap;
  font-size: 14px;
  cursor: pointer;
`;
