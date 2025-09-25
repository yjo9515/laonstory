import React from "react";
import styled from "styled-components";
import theme from "../../../theme";
import { useLocation } from "react-router";

interface ViewFooterTypes {}

function ViewFooter(props: ViewFooterTypes) {  
const location = useLocation();
const clickPrivacy = () => {
  if (process.env.REACT_APP_SOURCE_DISTRIBUTE === "OUTSIDE") {
    window.open("https://www.iwest.co.kr/iwest/563/subview.do", "_blank");
  }
}

  return (
    <FooterBlock>
      <div className="footerWrap">
        <div className="leftBox">
         {
          (process.env.REACT_APP_SOURCE_DISTRIBUTE === "OUTSIDE") &&
          <ul>
            <li className="cousor" style={{fontWeight : "bold", fontSize : "15px", cursor:"pointer"}} onClick={clickPrivacy}>개인정보처리방침</li>
            {/* <li className="cousor">약관수정페이지</li> */}
          </ul>
          }
          <ul>
            <li>
              <span>고객센터</span>
              <span>041-400-1944</span>
            </li>
            <li>
              <span>주소</span>
              <span>(32140) 충청남도 태안군 태안읍 중앙로 285</span>
            </li>
          </ul>
          <ul>
            <li>copyright(c)2022 Korea Western Power co.,Ltd.All Rights Reserved.</li>
          </ul>
        </div>
        <div className="rightBox">
          {/* <select>
            <option value="">관련사이트로 이동</option>
          </select> */}
        </div>
      </div>
    </FooterBlock>
  );
}

const ScrollAlert = styled.div`
  max-height: 500px;
  overflow-y: auto;
  padding: 16px;
`;

const FooterBlock = styled.div`
  width: 100%; 
  background-color: ${theme.colors.white};
  display: flex;
  justify-content: center;
  align-items: center;
  border-top: 1px solid ${theme.colors.gray5};
  color: ${theme.colors.gray4};
  font-size: ${theme.fontType.pagenation.fontSize};
  margin-top: auto;
  & > .footerWrap {
    width: ${theme.commonWidth.landingWidth};
    height: 100%;
    display: flex;
    justify-content: space-between;
    & > div {
      width: calc(100% / 2);
      height: 100%;
      padding: 24px 0;
    }
    & > .leftBox {
      display: flex;
      justify-content: center;
      flex-direction: column;
      align-items: flex-start;
      & > ul {
        content: "";
        display: flex;
        justify-content: flex-start;
        align-items: center;
        margin-bottom: ${theme.commonMargin.gap4};
        & > li {
          margin-right: ${theme.commonMargin.gap3};
          cursor: default;
          & > span:first-child {
            margin-right: ${theme.commonMargin.gap4};
            font-weight: ${theme.fontType.subTitle2.bold};
          }
        }
        & > .cousor {
          cursor: pointer;
        }
      }
    }
    & > .rightBox {
      display: flex;
      justify-content: flex-end;
      align-items: center;
      & > select {
        width: 300px;
        height: 34px;
        padding-left: 12px;
        border: 1px solid ${theme.colors.gray5};
        border-radius: 5px;
        color: ${theme.colors.gray3};
      }
    }
  }
`;

export default ViewFooter;
