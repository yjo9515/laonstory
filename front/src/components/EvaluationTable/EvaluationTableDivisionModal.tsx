import React, { useEffect } from "react";
import styled from "styled-components";
import { useSetRecoilState } from "recoil";
import theme from "../../theme";
import { TableDivisionEnumType } from "./EvaluationTableComponentType";
import { footerZIndexControl } from "../../modules/Client/Modal/Modal";

interface EvaluationTableDivisionModalTypes {
  onDivisionSelect: (type: TableDivisionEnumType) => void;
  onClose: () => void;
}

function EvaluationTableDivisionModal(props: EvaluationTableDivisionModalTypes) {
  const setFooterZIndexControl = useSetRecoilState(footerZIndexControl);

  useEffect(() => {
    // 모달이 열릴 때 footer z-index를 0으로 설정
    setFooterZIndexControl(true);

    // 컴포넌트가 언마운트될 때 footer z-index를 원래대로 복원
    return () => {
      setFooterZIndexControl(false);
    };
  }, [setFooterZIndexControl]);

  return (
    <EvaluationTableDivisionModalBlock>
      <h2>평가를 선택해주세요.</h2>
      <section>
        <div onClick={() => props.onDivisionSelect(TableDivisionEnumType.DIVISION_SCORE)}>
          정량평가
        </div>
        <div onClick={() => props.onDivisionSelect(TableDivisionEnumType.DIVISION_SUITABLE)}>
          적합 / 부적합
        </div>
      </section>
      <div className="close" onClick={props.onClose}>
        닫기
      </div>
    </EvaluationTableDivisionModalBlock>
  );
}

export default EvaluationTableDivisionModal;

const EvaluationTableDivisionModalBlock = styled.div`
  width: 100%;
  height: 600px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  & > h2 {
    margin-top: 40px;
    font-size: 20px;
    color: ${theme.systemColors.systemFont};
  }
  & > section {
    display: flex;
    justify-content: space-between;
    width: 50%;
    padding: 24px;
    & > div {
      width: calc(100% / 2 - 20px);
      height: 200px;
      background-color: ${theme.systemColors.systemPrimary};
      color: #fff;
      border-radius: 20px;
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 24px;
      cursor: pointer;
    }
    & > div:hover {
      background-color: ${theme.systemColors.pointColor};
    }
  }
  .close {
    margin-top: 20px;
    padding: 10px 60px;
    background-color: ${theme.colors.gray4};
    color: #fff;
    font-size: 16px;
    cursor: pointer;
    border-radius: 8px;
  }
`;
