import React from "react";
import styled from "styled-components";

// 파일 업로드 용도 많이 쓰일 label button
// text - 안에 들어갈 글자 , children - label안에 들어갈 input 등 혹시 모를 대비용
// htmlFor 주로 display none 된 input과 연결 용으로 쓰일 속성
export default function LabelButton({
  text,
  children,
  onClick,
  submit = false,
  fullHeight = false,
}: {
  text?: string;
  children?: React.ReactNode;
  onClick?: () => void;
  submit?: boolean;
  fullHeight?: boolean;
}) {
  return (
    <LabelButtonContainer
      fullHeight={fullHeight}
      onClick={onClick}
      type={submit ? "submit" : "button"}
    >
      {text && text}
      {children && children}
    </LabelButtonContainer>
  );
}

const LabelButtonContainer = styled.button<{ fullHeight: boolean }>`
  width: 120px;
  height: ${(props) => (props.fullHeight ? "inherit" : "32px")};
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: ${(props) => props.theme.systemColors.systemPrimary};
  font-size: ${(props) => props.theme.fontType.body.fontSize};
  line-height: ${(props) => props.theme.fontType.bodyLineHeight.lineHeight};
  color: white;
  border-radius: 3px;
  white-space: nowrap;
  cursor: pointer;
  > label {
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: ${(props) => props.theme.fontType.body.fontSize};
    color: white;
    cursor: pointer;
    > input {
      display: none;
    }
  }
`;
