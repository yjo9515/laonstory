import React from "react";
import styled from "styled-components";
import { isIE } from "react-device-detect";

function NotUseBrower() {
  if (!isIE) return <></>;
  return (
    <NotUseBrowerBlock>
      <div className="wrapper">
        <h1>
          죄송합니다.
          <br />
          한국서부발전 제안서 평가시스템은
          <br />
          internet explorer에서 이용하실 수 없습니다.
        </h1>
        <ul>
          <li>저희 서비스는 Google Chrome에 최적화 되어있습니다.</li>
          <li>Chrome 또는 Edge에서 다시 이용해주세요.</li>
        </ul>
      </div>
    </NotUseBrowerBlock>
  );
}

export default NotUseBrower;

const NotUseBrowerBlock = styled.div`
  width: 100vw;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  & > .wrapper {
    & > h1 {
      color: #5c87e8;
      font-size: 40px;
    }
    & > ul {
      margin-top: 60px;
      padding-left: 20px;
      & > li {
        list-style: inside;
      }
    }
  }
`;
