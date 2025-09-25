import React from "react";
import styled from "styled-components";

function FileDeleteGuideText() {
  return (
    <FileDeleteGuideTextBlock>
      <span>
        첨부파일을 삭제하고 고객의 개인정보를 폐기합니다.
        <br />
        진행하시겠습니까?
      </span>
      <span>(* 개인정보 보완 첨부파일(개인정보 가림처리 파일)은 삭제되지 않습니다.)</span>
    </FileDeleteGuideTextBlock>
  );
}

export default FileDeleteGuideText;

const FileDeleteGuideTextBlock = styled.div`
  display: flex;
  flex-direction: column;
  & > span {
    font-size: 12px;
    line-height: 24px;
    &:first-child {
      margin-bottom: 24px;
    }
  }
`;
