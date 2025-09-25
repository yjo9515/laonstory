import React from "react";
import styled from "styled-components";
import theme from "../../../theme";

interface AddModalWrapTypes {
  nexAddCategoryType?: string;
  onAddCategory?: () => void;
  onAddContent?: () => void;
  subCheck?: boolean;
  contentCheck?: boolean;
}

type AddModalWrapBlockTypes = {
  subCheck?: boolean;
  contentCheck?: boolean;
};

function CategoryAddModal(props: AddModalWrapTypes) {
  return (
    <AddModalWrapBlock subCheck={props.subCheck} contentCheck={props.contentCheck}>
      {!props.contentCheck && (
        <div onClick={props.onAddCategory}>{props.nexAddCategoryType ?? ""} 추가</div>
      )}
      {!props.subCheck && <div onClick={props.onAddContent}>평가 내용 추가</div>}
    </AddModalWrapBlock>
  );
}

export default CategoryAddModal;

const AddModalWrapBlock = styled.figure<AddModalWrapBlockTypes>`
  width: 110px;
  height: auto;
  background-color: #fff;
  position: absolute;
  top: 0;
  right: 32px;
  z-index: 3;
  padding: 0 10px;
  box-shadow: 0px 1px 10px 1px rgba(53, 88, 122, 0.15);
  & > div {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    padding: 8px 0;
    cursor: pointer;
  }
  & > div:nth-child(1) {
    border-bottom: ${(props) =>
      props.subCheck || props.contentCheck ? "0" : `1px solid ${theme.colors.blueDeep}`};
  }
  & > div:hover {
    color: ${theme.systemColors.systemPrimary};
    font-weight: bold;
  }
`;
