import React from "react";
import styled from "styled-components";

interface IInputButton {
  text: string;
  onClick?: () => void;
  children?: React.ReactNode;
  submit?: boolean;
  cancel?: boolean;
  round?: boolean;
}

export default function InputButton({
  text,
  onClick,
  children,
  submit = false,
  cancel,
  round,
}: IInputButton) {
  return (
    <InputButtonContainer
      className={`${cancel && "cancel"} ${round && "round"}`}
      type={submit ? "submit" : "button"}
      onClick={onClick}
    >
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
  background-color: #438cae;
  color: white;
  border-radius: 5px;
  font-size: 15px;
  line-height: 22px;
  &.cancel {
    border: 1px solid #438cae;
    background-color: #fff;
    color: #438cae;
  }
  &.round {
    border-radius: 25px;
  }
`;
