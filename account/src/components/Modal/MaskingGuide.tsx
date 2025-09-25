import React from "react";
import styled from "styled-components";
import companyGif from "./../../assets/gif/company.gif";
import idCardGif from "./../../assets/gif/ID_card.gif";

function MaskingGuide({ type }: { type: "private" | "company" }) {
  return (
    <MaskingGuideBlock>
      <div>
        {type === "company" && <img src={companyGif} decoding="async" alt="" />}
        {type === "private" && <img src={idCardGif} decoding="async" alt="" />}
      </div>
      {type === "private" && (
        <p>
          마우스를 드래그하여 <span>[신분증 사본]</span>의 <span>'주민등록번호 뒷자리'</span>를
          칠해주신 후 <span>'완료'</span> 버튼을 클릭해주세요.
          <br />
          잘못 칠 하셨을 경우에는 <span>'초기화'</span> 버튼을 클릭하시면 다시 진행 하실 수
          있습니다.
        </p>
      )}
      {type === "company" && (
        <p>
          마우스를 드래그하여 <span>[인감증명서 사본]</span>의{" "}
          <span>'대표자 주민등록번호 뒷자리'</span>를 칠해주신 후 <span>'완료'</span> 버튼을
          클릭해주세요.
          <br />
          잘못 칠 하셨을 경우에는 <span>'초기화'</span> 버튼을 클릭하시면 다시 진행 하실 수
          있습니다.
        </p>
      )}
    </MaskingGuideBlock>
  );
}

const MaskingGuideBlock = styled.div`
  width: 800px;
  height: auto;
  & > div {
    width: 700px;
    height: 350px;
    margin: 0 auto;
    display: flex;
    justify-content: center;
    & > img {
      width: 465px;
      /* height: 100%; */
      object-fit: contain;
    }
  }
  & > p {
    text-align: center;
    margin-top: 20px;
    & > span {
      color: #425061;
      font-weight: bold;
    }
  }
`;

export default MaskingGuide;
