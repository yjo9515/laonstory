import styled from "styled-components";

export default function Label({ bold = false, text }: { bold?: boolean; text: string }) {
  return <LabelContainer bold={bold}>{text}</LabelContainer>;
}

const LabelContainer = styled.label<{ bold: boolean }>`
  color: ${(props) => props.theme.colors.gray1};
  font-size: ${(props) =>
    props.bold ? props.theme.fontType.subTitle2.fontSize : props.theme.fontType.body.fontSize};
  font-weight: ${(props) =>
    props.bold ? props.theme.fontType.subTitle2.bold : props.theme.fontType.body.bold};
`;
