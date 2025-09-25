import React, { Fragment } from "react";
import styled from "styled-components";
import ArrowNext from "../../assets/Icon/ArrowNext";
import theme from "../../theme";

// {text:"본인인증" , component: <Icon>} 형식의 배열을 받아서 뿌려줌
export default function Process({
  contents,
  process,
}: {
  contents: { text: string; component: React.ReactNode }[];
  process: number;
}) {
  return (
    <SignupProcessContainer>
      {contents.map((el, i) => (
        <Fragment key={i}>
          <IconContainer currentProcess={process === i + 1}>
            <span>{`STEP 0${i + 1}`}</span>
            {el.component}
            <span>{el.text}</span>
          </IconContainer>
          {i !== contents.length - 1 && <ArrowNext />}
        </Fragment>
      ))}
    </SignupProcessContainer>
  );
}

const SignupProcessContainer = styled.div`
  max-width: 1200px;
  width: 100%;
  margin: 0 auto;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 64px;
`;
const IconContainer = styled.div<{ currentProcess: boolean }>`
  width: 116px;
  height: 116px;
  padding: 8px 0px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  border: ${(props) => !props.currentProcess && `1px solid ${props.theme.colors.blueDeep}`};
  background-color: ${(props) => props.currentProcess && props.theme.systemColors.systemPrimary};
  border-radius: 12.8889px;
  svg {
    width: 51px;
    height: 51px;
    path,
    rect,
    line {
      stroke: ${(props) => props.currentProcess && "white"};
    }
    circle {
      fill: ${(props) => props.currentProcess && "white"};
    }
  }
  & > span {
    color: ${(props) => (props.currentProcess ? "white" : props.theme.systemColors.systemPrimary)};
    font-size: ${theme.fontType.content2.fontSize};
    font-weight: ${theme.fontType.content2.bold};
  }
`;
