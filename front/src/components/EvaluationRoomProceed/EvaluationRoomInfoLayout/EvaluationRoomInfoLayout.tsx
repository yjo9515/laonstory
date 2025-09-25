import React, { ReactElement, useEffect, useState } from "react";
import styled from "styled-components";
import theme from "../../../theme";

import Parser from "html-react-parser";
import { CategoryInfoData } from "./EvaluationRoomCategoryInfoData";
import { useRecoilValue } from "recoil";
import { userState } from "../../../modules/Client/Auth/Auth";
import RoleUtils from "../../../utils/RoleUtils";

interface EvaluationRoomInfoTitleTypes {
  title: string;
  children: ReactElement;
  infoText?: string;
  focusType?: string;
  selectFocus?: (type: string) => void;
  selectFocusType?: string;
  direction?: string;
  categoryNum?: number;
  stepReady?: boolean;
  onTime?: () => void;
}

type EvaluationRoomInfoTitleBlockType = {
  isFoucs?: boolean;
  openCheck?: boolean;
  isRight?: boolean;
};

export type CategoryInfoType = {
  categoryTitle: string;
  categoryContent: string;
  companyNum?: string;
  committerNum?: string;
  adminNum?: string;
  userContent?: string;
};

function EvaluationRoomInfoLayout(props: EvaluationRoomInfoTitleTypes) {
  const [openCheck, setOpenCheck] = useState<boolean>(true);
  const [mouseOverCheck, setMouseOverCheck] = useState<boolean>(false);
  const [categoryInfo, setCategoryInfo] = useState<CategoryInfoType>({
    categoryTitle: "",
    categoryContent: "",
  });
  const userData = useRecoilValue(userState);
  const type = RoleUtils.getClientRole(userData.role);
  // 해당 항목의 툴팁 컨턴츠 찾기
  useEffect(() => {
    const data = CategoryInfoData[props.categoryNum as number];
    setCategoryInfo(data);
  }, [props.categoryNum]);

  const [isFoucs, setIsFoucs] = useState<boolean>(false);

  const onOpen = () => {
    setOpenCheck(!openCheck);
  };

  const onFoucs = (e: any) => {
    e.stopPropagation();
    if (!openCheck) return;
    if (props.selectFocus) {
      if (props.selectFocusType === props.focusType) {
        props.selectFocus("");
      } else {
        props.selectFocus(props.focusType ?? "");
      }
    }
  };

  useEffect(() => {
    if (!openCheck) {
      setIsFoucs(false);
      if (props.selectFocus) props.selectFocus("");
    }
  }, [openCheck]);

  useEffect(() => {
    if (!props.selectFocusType) return setIsFoucs(false);
    if (props.selectFocusType && props.selectFocusType === props.focusType) return setIsFoucs(true);
    setIsFoucs(false);
  }, [props.selectFocusType]);

  return (
    <EvaluationRoomInfoTitleBlock
      isFoucs={isFoucs}
      openCheck={openCheck}
      onMouseOver={() => props.stepReady && setMouseOverCheck(true)}
      onMouseOut={() => setMouseOverCheck(false)}
      isRight={props.direction === "right"}
    >
      <div
        className="title"
        // onClick={onOpen}
      >
        <div
        // onClick={(e) => onFoucs(e)}
        >
          {props.title}
          {props.onTime && type === "admin" && <span onClick={props.onTime}>시간설정</span>}
        </div>
        {/* <span>
          {openCheck && <img src={arrowUp} alt="열기 아이콘" />}
          {!openCheck && <img src={arrowDown} alt="열기 아이콘" />}
        </span> */}
      </div>
      {openCheck && <section>{props.children}</section>}
      <div className={`${isFoucs && "backgroudColor"}`}></div>
      <div
        className={`infoObject ${
          props.direction === "left" ? "infoObjectLeft" : "infoObjectRight"
        } ${
          mouseOverCheck
            ? props.direction === "left"
              ? "infoObjectLeftOver"
              : "infoObjectRightOver"
            : ""
        }`}
      >
        <div>
          <span></span>
        </div>
        <div>
          <h5>
            {(type === "admin" && categoryInfo?.adminNum) ||
              (type === "committer" && categoryInfo?.committerNum) ||
              (type === "company" && categoryInfo?.companyNum) ||
              (props.categoryNum as number) + 1}
            . {categoryInfo.categoryTitle}
          </h5>
          <p>
            {type === "admin" && Parser(categoryInfo.categoryContent)}
            {(type === "committer" || type === "company") &&
              Parser(categoryInfo?.userContent || "")}
          </p>
        </div>
      </div>
      <div
        className={`focusPoint ${
          props.direction === "left" ? "infoObjectLeft" : "infoObjectRight"
        } ${mouseOverCheck ? "focusPointOver" : ""}`}
      ></div>
    </EvaluationRoomInfoTitleBlock>
  );
}

export default EvaluationRoomInfoLayout;

const EvaluationRoomInfoTitleBlock = styled.div<EvaluationRoomInfoTitleBlockType>`
  width: 100%;
  height: auto;
  position: relative;
  & > .title {
    width: 100%;
    position: relative;
    z-index: 10;
    height: 42px;
    background-color: ${theme.colors.blueGray2};
    padding: ${theme.commonMargin.gap3};
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: ${theme.fontType.body.fontSize};
    /* cursor: pointer; */
    & > span {
      font-size: 16px;
    }
    & > div {
      width: 100%;
      display: flex;
      align-items: center;
      justify-content: space-between;

      & > span {
        padding: 3px 7px;
        margin-left: ${theme.commonMargin.gap4};
        background-color: ${theme.systemColors.systemPrimary};
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 11px;
        font-weight: 300;
        border-radius: 10px;
        cursor: pointer;
        color: #fff;
        transition: ease-in-out;
        transition-duration: 0.1s;
        &:hover {
          background-color: #545e6b;
        }
      }
    }
  }
  & > section {
    padding: ${theme.commonMargin.gap3};
    width: 100%;
    height: auto;
    position: relative;
    /* overflow-x: hidden; */

    z-index: 2;
    border: ${(props) => (props.isFoucs ? `2.5px dashed #ebd400` : "2.5px solid transparent")};
    border-radius: ${(props) => (props.isFoucs ? "10px" : "0")};
    transition: ease-in;
    transition-duration: 0.1s;
    background-color: #fff;
  }
  & > .backgroudColor {
    transition: ease-in;
    transition-duration: 0.1s;
    width: 100%;
    height: 100%;
    background-color: #ffffcc;
    opacity: 0.6;
    position: absolute;
    top: 0;
    left: 0;
  }
  & button {
    width: 100%;
    height: 46px;
    background-color: ${theme.partnersColors.primary};
    color: white;
    border-radius: 8px;
    text-align: center;
  }

  .infoObject {
    position: absolute;
    top: 0;
    width: 280px;
    height: auto;
    opacity: 1;
    z-index: 1;
    transition: ease-in;
    transition-duration: 0.25s;
    & > div:nth-child(2) {
      width: 100%;
      height: auto;
      overflow: hidden;
      border-radius: ${theme.commonRadius.radius1};
      padding: ${theme.commonMargin.gap3};
      background-color: #fff;
      white-space: pre-line;
      opacity: 0;
      transition: ease-in;
      transition-duration: 0.15s;
      transition-delay: 0.1s;
      & > h5 {
        margin-bottom: 16px;
      }
      & > p {
        font-weight: 100 !important;
        font-size: 13px;
      }
    }
  }

  .infoObjectLeft {
    right: 0;
  }
  .infoObjectRight {
    left: 0px;
  }

  .infoObjectLeftOver {
    right: -340px;
    width: 340px;
    opacity: 1;
    display: flex;
    align-items: center;
    justify-content: space-between;
    & > div:nth-child(1) {
      height: 100%;
      & > span {
        display: block;
        width: 20px;
        height: 3px;
        background-color: ${theme.systemColors.pointColor2};
      }
    }
    & > div:nth-child(2) {
      width: 320px;
      opacity: 1;
      border: 3px solid ${theme.systemColors.pointColor2};
    }
  }

  .infoObjectRightOver {
    left: -340px;
    width: 340px;
    opacity: 1;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-direction: row-reverse;
    & > div:nth-child(1) {
      height: 100%;
      & > span {
        display: block;
        width: 20px;
        height: 3px;
        background-color: ${theme.systemColors.pointColor2};
      }
    }
    & > div:nth-child(2) {
      width: 320px;
      opacity: 1;
      border: 3px solid ${theme.systemColors.pointColor2};
    }
  }
  .focusPoint {
    width: 0;
    height: 100%;
    background-color: ${theme.systemColors.pointColor2};
    position: absolute;
    opacity: 0;
    top: 0;
    right: 0;
    left: ${(props) => (props.isRight ? 0 : "auto")};
    z-index: 10;
    transition: ease-in;
    transition-duration: 0.15s;
  }

  .focusPointOver {
    width: 10px;
    opacity: 1;
  }

  .notSubmit {
  }
  .firstSubmit {
    color: #6fcf97;
  }
  .requestModify {
    color: #da0043;
  }
  .submitComplete {
    color: #0058a2;
  }
  .fontBold {
    font-weight: bold !important;
  }
`;
