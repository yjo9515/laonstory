import React, { ReactNode } from "react";
import styled from "styled-components";
import theme from "../../../theme";

interface IInputSet1 {
  text?: string;
  label?: string;
  isButton?: boolean;
  buttonText?: string;
  isSelect?: boolean;
  selectOption?: ReactNode;
  disabled?: boolean;
  register?: any;
  type?: string;
  placeholder?: string;
  onClick?: () => void;
  value?: string;
  icon?: React.ReactNode;
  inputOnClick?: boolean;
  className?: string;
  readOnly?: boolean;
  autoComplete?: string;
}

interface LabelRadioBtnInterface extends IInputSet1 {
  component?: ReactNode;
  accept?: string;
}

export const LabelRadioBtn = (props: LabelRadioBtnInterface) => {
  return (
    <InputSet1Container
      disabled={props.disabled ?? false}
      inputOnClick={props.inputOnClick ?? false}
    >
      {/* <label>
        {props.icon}
        {props.label}
      </label> */}
      <div className="inputButtonWrap">
        <label htmlFor="accept1" className={`btn ${props.accept === "yes" && "yes"}`}>
          승인
          <input
            {...props.register}
            type={"radio"}
            id="accept1"
            value="yes"
            // style={{ display: "none" }}
          />
        </label>

        <label htmlFor="accept2" className={`btn ${props.accept === "no" && "no"}`}>
          반려
          <input
            {...props.register}
            type={"radio"}
            id="accept2"
            value="no"
            // style={{ display: "none" }}
          />
        </label>
      </div>
    </InputSet1Container>
  );
};

const InputSet1Container = styled.div<{
  disabled: boolean;
  inputOnClick: boolean;
}>`
  width: auto;
  height: 47px;
  display: flex;
  align-items: center;
  .inputButtonWrap {
    flex: 1;
    position: relative;
    width: 100%;
    height: 100%;
    display: flex;
    gap: 16px;
  }
  .btn {
    width: 104px;
    height: 47px;
    border: 1px solid #cbd3e5;
    color: #cbd3e5;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 25px;
    cursor: pointer;
    & > input {
      display: none;
    }
  }
  .yes {
    color: #fff;
    border: 1px solid #6fcf97;
    background-color: #6fcf97;
  }
  .no {
    color: #fff;
    border: 1px solid #da0043;
    background-color: #da0043;
  }
  .nonSelect {
    background-color: ${theme.colors.gray6} !important;
    cursor: default;
    &:focus {
      outline: none;
    }
  }
`;
