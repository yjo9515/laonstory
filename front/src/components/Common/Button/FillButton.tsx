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
  padding: 8px 16px;
  display: inline-flex;
  justify-content: center;
  align-items: center;
  background-color: white;
  color: ${theme.systemColors.systemFont};
  border-radius: 30px;
  font-weight: 500;
  font-size: 13px;
  cursor: pointer;
  transition: ease-in;
  transition-duration: 0.1s;
  margin-right: ${(props) => (props.margin ? props.margin : 0)};
  box-sizing: border-box;
  &:hover {
    background-color: ${theme.systemColors.systemFont};
    color: white;
    font-weight: 600;
  }
`;
