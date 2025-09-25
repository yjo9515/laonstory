import React, { useEffect, useState } from "react";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import styled from "styled-components";
import {
  getEvaluationTimeCatchApi,
  patchEvaluationTimeStartApi,
  patchEvaluationTimeStopApi,
} from "../../api/EvaluationRoomApi";
import { EvaluationRoomInfoTypes } from "../../interface/System/EvaluationRoomProceed/EvaluationRoomProceedTypes";
import {
  alertModalState,
  IAlertModalDefault,
  loadingModalState,
} from "../../modules/Client/Modal/Modal";
import { useData, useSendData } from "../../modules/Server/QueryHook";
import theme from "../../theme";
import EvaluationRoomInfoLayout from "./EvaluationRoomInfoLayout/EvaluationRoomInfoLayout";

interface EvaluationRoomTimeTypes {
  role: string;
  evaluationRoomInfo: EvaluationRoomInfoTypes | null;
  authority: string;
  evaluationRoomStatus: { announcement: string; inquiry: string };
  setAlertModal: (data: IAlertModalDefault) => void;
  resetAlertModal: () => void;
  infoText?: { start: string; reset: string };
  selectFocus: (type: string) => void;
  focusType: { start: string; reset: string };
  selectFocusType: string;
  direction?: string;
  stepReady?: boolean;
  onTime: () => void;
}

type TimeBoxBlockType = {
  startCheck: boolean;
  authority?: string;
};

function EvaluationRoomTime(props: EvaluationRoomTimeTypes) {
  const t =
    Number(process.env.REACT_APP_PROCEED_TIMER) > 0
      ? Number(process.env.REACT_APP_PROCEED_TIMER)
      : false;

  let refetchTime: number | boolean = t;

  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const setLoadingModal = useSetRecoilState(loadingModalState);
  const setAlertModal = useSetRecoilState(alertModalState);
  const [timeStart, setTimeStart] = useState<boolean>(false);
  /** 발표시간 */
  const [announcementTimer, setAnnouncementTimer] = useState<boolean>(false);
  const [announcementMinutes, setAnnouncementMinutes] = useState<number>(0);
  const [announcementSeconds, setAnnouncementSeconds] = useState<number>(0);
  /** 질의응답시간 */
  const [inquiryTimer, setInquiryTimer] = useState<boolean>(false);
  const [inquiryMinutes, setInquiryMinutes] = useState<number>(0);
  const [inquirySeconds, setInquirySeconds] = useState<number>(0);

  useEffect(() => {
    if (!timeStart && !announcementTimer && !inquiryTimer) {
      announcementTimeSetting();
      inquiryTimeSetting();
    }
  }, [props.evaluationRoomStatus]);

  /** 발표시간 세팅 */
  const announcementTimeSetting = () => {
    let announcement = props.evaluationRoomStatus.announcement.split(":");
    setAnnouncementMinutes(parseInt(announcement[0]));
    setAnnouncementSeconds(parseInt(announcement[1]));
  };

  /** 질의 응답시간 세팅 */
  const inquiryTimeSetting = () => {
    let inquiry = props.evaluationRoomStatus.inquiry.split(":");
    setInquiryMinutes(parseInt(inquiry[0]));
    setInquirySeconds(parseInt(inquiry[1]));
  };

  // 평가방 평가시간 시작 요청
  const patchEvaluationTimeStart = useSendData<any, { id: number; type: string }>(
    patchEvaluationTimeStartApi,
    {
      onSuccess: () => {
        resetLoadingModal();
        setTimeout(() => {
          setTimeStart(true);
        }, 1000);
      },
      onError() {
        resetLoadingModal();
        setAlertModal({
          isModal: true,
          content: "이용자간 시간설정을 동기화 중입니다.\n시작버튼을 다시 눌러주세요.",
        });
        onReset();
      },
    }
  );

  const onReset = () => {
    setTimeStart(false);
    setAnnouncementTimer(false);
    setInquiryTimer(false);
    announcementTimeSetting();
    inquiryTimeSetting();
  };

  // 평가방 평가시간 종료 요청
  const patchEvaluationTimeStop = useSendData<any, number>(patchEvaluationTimeStopApi, {
    onSuccess: () => {
      setTimeout(() => {
        resetLoadingModal();
      }, 1000);
      onReset();
    },
    onError() {
      resetLoadingModal();
    },
  });

  // 서버에서 진행되는 시간 가져오기
  const { data: getEvaluationTimeCatch, refetch: getEvaluationTimeCatchRefetch } = useData<
    any,
    null
  >(
    ["getEvaluationTimeCatch", null],
    () => getEvaluationTimeCatchApi(Number(props.evaluationRoomInfo?.evaluationRoomId)),
    {
      refetchInterval:
        props.authority === "admin" ? (timeStart ? refetchTime : false) : refetchTime,
      onSuccess: (item) => {
        const time = item.data;

        if (!time) {
          onReset();
          return;
        }
        if (time[0] === 0) {
          setTimeout(() => {
            onTimeReset();
            onReset();
          }, 500);
          return;
        }

        const { min, sec } = timeCheck(time[0]);

        if (time[1] === "PRESENTATION") {
          setAnnouncementTimer(true);
          setAnnouncementMinutes(min);
          setAnnouncementSeconds(sec);
        }
        if (time[1] === "QUESTION") {
          setInquiryTimer(true);
          setInquiryMinutes(min);
          setInquirySeconds(sec);
        }
      },
    }
  );

  const timeCheck = (time: number) => {
    const seconds: number = time;

    // const hour = seconds / 3600 < 10 ? "0" + seconds / 3600 : seconds / 3600;
    const min = (seconds % 3600) / 60 < 10 ? "0" + (seconds % 3600) / 60 : (seconds % 3600) / 60;
    const sec = seconds % 60 < 10 ? "0" + (seconds % 60) : seconds % 60;

    return {
      min: parseInt(String(min), 10),
      sec: parseInt(String(sec), 10),
    };
  };

  /** 시간 진행 */
  const onTimeStart = (type: string) => {
    let t = "";

    if (type === "announcement") {
      if (inquiryTimer)
        return setAlertModal({
          isModal: true,
          content: "질의 응답 시간이 끝나거나 리셋을 시킨 후 사용해주세요.",
        });
      t = "PRESENTATION";
      setAnnouncementTimer(true);
    }
    if (type === "inquiry") {
      if (announcementTimer)
        return setAlertModal({
          isModal: true,
          content: "발표 시간이 끝나거나 리셋을 시킨 후 사용해주세요.",
        });
      t = "QUESTION";
      setInquiryTimer(true);
    }

    let data = {
      id: Number(props.evaluationRoomInfo?.evaluationRoomId),
      type: t,
    };

    patchEvaluationTimeStart.mutate(data);
  };

  /** 타이머 리셋 컨펌 모달 */
  const onTimeResetModal = (type: string) => {
    props.setAlertModal({
      isModal: true,
      content: `${type === "announcement" ? "발표시간" : "질의응답시간"}을 초기화 하시겠습니까?`,
      onClick: () => onTimeReset(),
    });
  };

  /** 타이머 리셋 컨펌 확인 */
  const onTimeReset = () => {
    patchEvaluationTimeStop.mutate(Number(props.evaluationRoomInfo?.evaluationRoomId));
    props.resetAlertModal();
    setLoadingModal({ isButton: false, isModal: true, type: "default" });
  };

  return (
    <EvaluationRoomTimeBlock>
      <EvaluationRoomInfoLayout
        title="발표시간"
        infoText={props.infoText?.start}
        selectFocus={props.selectFocus}
        focusType={props.focusType.start}
        selectFocusType={props.selectFocusType}
        direction={props.direction}
        stepReady={props.stepReady}
        onTime={props.onTime}
        categoryNum={4}
      >
        <TimeBoxBlock
          className={
            (announcementTimer &&
              (announcementMinutes >= 1 ||
                (announcementMinutes < 1 && announcementSeconds >= 15)) &&
              "start") ||
            (announcementSeconds < 15 && announcementMinutes < 1 && announcementTimer && "close") ||
            ""
          }
          startCheck={announcementTimer}
          authority={props.authority}
        >
          <div
            className={
              (announcementTimer &&
                (announcementMinutes >= 1 ||
                  (announcementMinutes < 1 && announcementSeconds >= 15)) &&
                "start") ||
              (announcementTimer &&
                announcementMinutes < 1 &&
                announcementSeconds < 15 &&
                "close") ||
              ""
            }
          >
            {announcementMinutes < 10 ? `0${announcementMinutes}` : announcementMinutes}:
            {announcementSeconds! < 10 ? `0${announcementSeconds}` : announcementSeconds}
          </div>

          {props.authority === "admin" && (
            <div>
              {!announcementTimer ? (
                <div
                  className={`start `}
                  onClick={() => {
                    if (Number(announcementMinutes + announcementSeconds) <= 0) return;
                    onTimeStart("announcement");
                  }}
                >
                  시작
                </div>
              ) : (
                <div
                  className={`reset ${
                    announcementSeconds < 15 && announcementMinutes < 1 && "close"
                  }`}
                  onClick={() => {
                    onTimeResetModal("announcement");
                  }}
                >
                  리셋
                </div>
              )}
            </div>
          )}
        </TimeBoxBlock>
      </EvaluationRoomInfoLayout>
      <EvaluationRoomInfoLayout
        title="질의 응답 시간"
        infoText={props.infoText?.reset}
        selectFocus={props.selectFocus}
        focusType={props.focusType.reset}
        selectFocusType={props.selectFocusType}
        direction={props.direction}
        stepReady={props.stepReady}
        onTime={props.onTime}
        categoryNum={5}
      >
        <TimeBoxBlock
          className={
            (inquiryTimer &&
              (inquiryMinutes >= 1 || (inquiryMinutes < 1 && inquirySeconds >= 15)) &&
              "start") ||
            (inquirySeconds < 15 && inquiryMinutes < 1 && inquiryTimer && "close") ||
            ""
          }
          startCheck={inquiryTimer}
          authority={props.authority}
        >
          <div
            className={
              (inquiryTimer &&
                (inquiryMinutes >= 1 || (inquiryMinutes < 1 && inquirySeconds >= 15)) &&
                "start") ||
              (inquirySeconds < 15 && inquiryMinutes < 1 && inquiryTimer && "close") ||
              ""
            }
          >
            {inquiryMinutes < 10 ? `0${inquiryMinutes}` : inquiryMinutes}:
            {inquirySeconds! < 10 ? `0${inquirySeconds}` : inquirySeconds}
          </div>

          {/* <p>질의 응답 시간</p> */}
          {props.authority === "admin" && (
            <div>
              {!inquiryTimer ? (
                <div
                  className="start"
                  onClick={() => {
                    if (Number(inquiryMinutes + inquirySeconds) <= 0) return;
                    onTimeStart("inquiry");
                  }}
                >
                  시작
                </div>
              ) : (
                <div
                  className={`reset ${inquirySeconds < 15 && inquiryMinutes < 1 && "close"}`}
                  onClick={() => {
                    onTimeResetModal("inquiry");
                  }}
                >
                  리셋
                </div>
              )}
            </div>
          )}
        </TimeBoxBlock>
      </EvaluationRoomInfoLayout>
    </EvaluationRoomTimeBlock>
  );
}

export default EvaluationRoomTime;

const EvaluationRoomTimeBlock = styled.div`
  width: 100%;
  /* & > div {
    margin-bottom: ${theme.commonMargin.gap4};
  } */
  & > .timeSetting {
    width: 100%;
    height: 48px;
    border: 1px solid ${theme.partnersColors.primary};
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: ${theme.fontType.subTitle3.fontSize};
    font-weight: ${theme.fontType.subTitle3.bold};
    color: ${theme.partnersColors.primary};
  }
  /* & > .timeBox {
    width: 100%;
    border: 1px solid ${theme.partnersColors.primary};
    padding: ${theme.commonMargin.gap4};
    & > div:nth-child(1) {
      height: 32px;
      width: 100%;
      display: flex;
      justify-content: space-between;
      align-items: center;

      font-size: ${theme.fontType.subTitle3.fontSize};
      font-weight: ${theme.fontType.subTitle3.bold};
      color: ${theme.partnersColors.primary};
      margin-bottom: ${theme.commonMargin.gap4};
      & > div {
        & > .reset {
          font-size: ${theme.fontType.body.fontSize};
          font-weight: ${theme.fontType.body.bold};
          color: ${theme.colors.gray4};
          cursor: pointer;
        }
      }
    }
    & > div:nth-child(2) {
      text-align: end;
      font-size: ${theme.fontType.time.fontSize};
      font-weight: ${theme.fontType.time.bold};
    }
  } */
`;

const TimeBoxBlock = styled.div<TimeBoxBlockType>`
  width: 100%;
  height: 100px;
  position: relative;
  border: 1px solid ${(props) => theme.colors.blueGray1};
  display: flex;
  justify-content: ${(props) => (props.authority === "admin" ? "space-between" : "center")};
  border-radius: ${theme.commonRadius.radius1};
  color: ${theme.colors.gray4};
  &.start {
    border: 3px solid ${theme.systemColors.startTimer};
  }
  &.close {
    border: 3px solid ${theme.systemColors.closeTimer};
  }
  & > div:nth-child(1) {
    width: 100%;
    flex: 1;
    font-size: ${theme.fontType.time.fontSize};
    font-weight: ${theme.fontType.time.bold};
    display: flex;
    align-items: center;
    justify-content: center;
    &.start {
      color: black;
    }
    &.close {
      color: ${theme.systemColors.closeTimer};
    }
  }
  & > div:nth-child(2) {
    width: 70px;
    height: 100%;

    font-size: ${theme.fontType.subTitle3.fontSize};
    font-weight: ${theme.fontType.subTitle3.bold};
    color: ${theme.partnersColors.primary};
    & > .start {
      width: 100%;
      height: 100%;
    }
    & > .start,
    & > .reset {
      font-size: ${theme.fontType.subTitle1.fontSize};
      font-weight: ${theme.fontType.subTitle1.bold};
      color: ${theme.colors.white};
      cursor: pointer;
      display: flex;
      justify-content: center;
      align-items: center;
      background-color: ${theme.partnersColors.primary};
      border-top-right-radius: ${theme.commonRadius.radius1};
      border-bottom-right-radius: ${theme.commonRadius.radius1};
    }
    & > .reset {
      width: 70px;
      height: calc(100% + 4px);
      position: absolute;
      right: -2px;
      top: -2px;
      background-color: ${theme.systemColors.startTimer};
      &.close {
        background-color: ${theme.systemColors.closeTimer};
      }
    }
  }
`;
