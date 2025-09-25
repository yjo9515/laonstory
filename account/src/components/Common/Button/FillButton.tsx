import React from "react";
import styled from "styled-components";
import theme from "../../../theme";

interface FillButtonTypes {
  buttonName: string;
  systemType?: string;
  onClick: () => void;
  margin?: string;
}

type FillButtonBlockType = {
  systemType?: string;
  margin?: string;
};

function FillButton(props: FillButtonTypes) {
  return (
    <FillButtonBlock systemType={props.systemType} onClick={props.onClick} margin={props.margin}>
      {props.buttonName}
    </FillButtonBlock>
  );
}

export default FillButton;

const FillButtonBlock = styled.div<FillButtonBlockType>`
  min-width: 80px;
  height: 30px;
  padding: 0px 15px;
  display: inline-flex;
  justify-content: center;
  align-items: center;
  background-color: #fff;
  color: ${theme.systemColors.systemPrimary};
  border-radius: 30px;
  font-size: 14px;
  cursor: pointer;
  transition: ease-in;
  transition-duration: 0.1s;
  margin-right: ${(props) => (props.margin ? props.margin : 0)};
  box-sizing: border-box;
  border: 1px solid #fff;
  &:hover {
    background-color: ${theme.partnersColors.primary};
    color: #fff;
    font-weight: 600;
    border: 1px solid ${theme.partnersColors.primary} !important;
  }
`;
