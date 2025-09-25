import React from "react";
import styled from "styled-components";
import theme from "../../../theme";

interface IInputButton {
  text: string;
  onClick?: () => void;
  children?: React.ReactNode;
  submit?: boolean;
}

export default function InputButton({ text, onClick, children, submit }: IInputButton) {
  return (
    <InputButtonContainer type={submit ? "submit" : "button"} onClick={onClick}>
      {text}
      {children}
    </InputButtonContainer>
  );
}

const InputButtonContainer = styled.button`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 167px;
  height: 47px;
  background-color: ${theme.systemColors.systemPrimary};
  color: white;
  border-radius: 69px;
  font-size: 15px;
  line-height: 22px;
`;
