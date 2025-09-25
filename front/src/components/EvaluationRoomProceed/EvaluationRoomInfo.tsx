import React from "react";
import styled from "styled-components";
import { EvaluationRoomInfoTypes } from "../../interface/System/EvaluationRoomProceed/EvaluationRoomProceedTypes";
import GradeCheckUtils from "../../utils/GradeCheckUtils";
import theme from "./../../theme/index";
import EvaluationRoomInfoLayout from "./EvaluationRoomInfoLayout/EvaluationRoomInfoLayout";
import LogoSmallWhite from "./../../assets/Logo/logoSmallWhite.svg";

interface EvaluationRoomInfoType {
  evaluationRoomInfo: EvaluationRoomInfoTypes | null;
  infoText: string;
  selectFocus: (type: string) => void;
  focusType: string;
  selectFocusType: string;
  direction?: string;
  stepReady?: boolean;
  categoryNum?: number;
}

function EvaluationRoomInfo(props: EvaluationRoomInfoType) {
  /** 시간 - 초 제거 */
  const onDateSplit = (data: string) => {
    if (!data) return "";
    let date = data.split(":");

    return `${date[0]}:${date[1]}`;
  };

  return (
    <EvaluationRoomInfoLayout
      title="평가 정보"
      infoText={props.infoText}
      focusType={props.focusType}
      selectFocus={props.selectFocus}
      selectFocusType={props.selectFocusType}
      direction={props.direction}
      categoryNum={props.categoryNum}
      stepReady={props.stepReady}
    >
      <>
        <EvaluationRoomInfoBlock>
          <>
            <div>
              <span>사업명</span>
              <div>{props.evaluationRoomInfo?.proposedProject}</div>
            </div>

            <div>
              <span>평가담당자</span>
              <div>
                <span>{props.evaluationRoomInfo?.masterName}</span>
                {/* <span>({props.evaluationRoomInfo?.masterPhone})</span> */}
              </div>
            </div>

            <div>
              <span>평가진행시간</span>
              <div>
                <span>{props.evaluationRoomInfo?.evaluationAt}</span>{" "}
                <span>
                  {onDateSplit(props.evaluationRoomInfo?.startAt ?? "")} ~{" "}
                  {onDateSplit(props.evaluationRoomInfo?.endAt ?? "")}
                </span>
              </div>
            </div>
          </>
        </EvaluationRoomInfoBlock>
        {/* <BackgroundBlock>
          <img src={LogoSmallWhite} alt="" />
        </BackgroundBlock> */}
      </>
    </EvaluationRoomInfoLayout>
  );
}

export default EvaluationRoomInfo;

const EvaluationRoomInfoBlock = styled.div`
  width: 100%;
  height: auto;
  font-size: ${theme.fontType.body.fontSize};

  position: relative;
  overflow: hidden;

  & > div {
    margin-bottom: ${theme.commonMargin.gap4};
    & > span {
      font-size: ${theme.fontType.body.fontSize};
      color: ${theme.colors.gray3};
      display: inline-block;
      /* margin-bottom: ${theme.commonMargin.gap4}; */
    }
  }
`;

const BackgroundBlock = styled.div`
  position: absolute;
  top: 50%;
  right: -15%;
  transform: translateY(-50%);
  z-index: -1;
  opacity: 1;
  & > img {
    height: 150px;
  }
`;
