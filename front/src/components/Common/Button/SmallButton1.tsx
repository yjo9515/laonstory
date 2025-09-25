import styled from "styled-components";
import theme from "../../../theme";

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
  padding: 11.5px 24px;
  background-color: ${theme.systemColors.systemPrimary};
  color: white;
  text-align: center;
  border-radius: 67px;
  white-space: nowrap;
  cursor: pointer;
  font-size: ${theme.fontType.subTitle1.fontSize};
  font-weight: ${theme.fontType.subTitle1.bold};
`;
