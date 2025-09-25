import React from "react";
import styled from "styled-components";
import theme from "../../../theme";

interface BorderLineButtonTypes {
  buttonName: string;
  systemType?: string;
  onClick: () => void;
}

type BorderLineButtonBlockType = {
  systemType?: string;
};

function BorderLineButton(props: BorderLineButtonTypes) {
  return (
    <BorderLineButtonBlock systemType={props.systemType} onClick={props.onClick}>
      {props.buttonName}
    </BorderLineButtonBlock>
  );
}

export default BorderLineButton;

const BorderLineButtonBlock = styled.div<BorderLineButtonBlockType>`
  width: 80px;
  height: 30px;
  display: inline-flex;
  justify-content: center;
  align-items: center;
  /* border: 1px solid ${(props) =>
    props.systemType === "system" ? theme.partnersColors.primary : "#fff"};
  color: ${(props) => (props.systemType === "system" ? theme.partnersColors.primary : "#fff")}; */
  border: 1px solid #fff;
  color: #fff;
  border-radius: 30px;
  font-size: 14px;
  cursor: pointer;
  transition: ease-in;
  transition-duration: 0.1s;
  &:hover {
    /* background-color: ${(props) =>
      props.systemType === "system" ? theme.partnersColors.primary : "#fff"};
    color: ${(props) => (props.systemType === "system" ? "#fff" : theme.partnersColors.primary)}; */
    background-color: #fff;
    border: 1px solid #fff;
    color: ${(props) =>
      props.systemType === "system"
        ? theme.systemColors.systemSideBarBtn
        : theme.partnersColors.primary};
    font-weight: 600;
  }
`;
