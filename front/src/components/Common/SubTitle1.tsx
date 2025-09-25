import styled from "styled-components";

// text와 margin-top을 받는 SubTitle1
export default function SubTitle({ text, top = 80 }: { text: string; top?: number }) {
  return <SubTitleContainer top={top}>{text}</SubTitleContainer>;
}

const SubTitleContainer = styled.h2<{ top: number }>`
  margin-top: ${(props) => props.top + "px"};
  text-align: start;
  font-size: ${(props) => props.theme.fontType.subTitle1.fontSize};
  font-weight: ${(props) => props.theme.fontType.subTitle1.bold};
  color: ${(props) => props.theme.colors.gray2};
`;
