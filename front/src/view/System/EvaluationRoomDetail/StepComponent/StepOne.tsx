import React, { useEffect, useState } from "react";
import { UseFormRegister, UseFormSetValue, UseFormWatch } from "react-hook-form";
import { StepOneState } from "../../../../interface/System/EvaluationRoomDetail/EvaluationRoomDetailTypes";
import { TimeRange, timesType } from "../../../../utils/TimeUtils";
import { useOutSideClick } from "../../../../utils/outSideClick";
import DateUtils from "../../../../utils/DateUtils";
import { useDatePicker } from "../../../../utils/DatePicker";
import { Inputs } from "../../../../components/Common/Input/Input";
import styled from "styled-components";
import theme from "../../../../theme";
import { DetailSection } from "../../../../components/Detail/DetailSection";

interface StepOneTypes {
  register: UseFormRegister<StepOneState>;
  setValue: UseFormSetValue<StepOneState>;
  watch: UseFormWatch<StepOneState>;
}

export const StepOne: React.FC<StepOneTypes> = (props) => {
  const [times, setTimes] = useState<timesType>({
    hour1: "00",
    hour2: "00",
    minute1: "00",
    minute2: "00",
  });
  const [startDate, setStartDate] = useState(
    props.watch("date") ? new Date(props.watch("date")) : new Date()
  );
  useEffect(() => {
    if (props.watch("date")) {
      setStartDate(new Date(props.watch("date")));
    }
  }, [props.watch("date")]);

  useEffect(() => {
    const startTime = props.watch("startTime")?.split(":");
    const endTime = props.watch("endTime")?.split(":");
    if (startTime && endTime) {
      const hour1 = startTime[0];
      const minute1 = startTime[1];
      const hour2 = endTime[0];
      const minute2 = endTime[1];
      setTimes({
        hour1,
        hour2,
        minute1,
        minute2,
      });
    }
  }, [props.watch("startTime"), props.watch("endTime")]);
  const onChange = (times: timesType) => {
    props.setValue("startTime", `${times.hour1}:${times.minute1}`);
    props.setValue("endTime", `${times.hour2}:${times.minute2}`);
  };
  const onDateChange = (date: Date) => {
    const now = new Date();
    if (
      date.getFullYear() === now.getFullYear() &&
      (date.getMonth() < now.getMonth() ||
        (date.getMonth() <= now.getMonth() && date.getDate() < now.getDate()))
    )
      return;
    setStartDate(date as Date);
    props.setValue("date", DateUtils.boardDateFormat(date as Date));
  };
  const DatePicker = useDatePicker(startDate, onDateChange);
  const [show, setShow] = useState(false);
  const changeShow = () => {
    setShow(false);
  };
  const { ref } = useOutSideClick(changeShow);

  return (
    <DetailSection>
      <DetailSection.Title>
        1. 기본정보 입력
        <span style={{ color: "#DA0043", marginLeft: "-12px" }}>*</span>
        <span>
          기본정보 입력만 입력 후 평가방을 개설할 수 있습니다. 평가방 수정을 통해 참석자 등록,
          평가항목표 등록, 공지사항, 제안발표자료 업로드 등을 추가하실 수 있습니다.
        </span>
      </DetailSection.Title>
      <Inputs>
        <Inputs.InputSet
          labelText="사업명"
          type="text"
          placeholder="사업명을 입력하세요"
          register={props.register("businessName", {})}
          w={94}
        />
        <StepOneBlock>
          <Inputs.Label labelText="평가일시" w={94} />
          <div className="dateAndTime">
            {DatePicker}
            <div>
              <Inputs.ClickInput
                onClick={() => setShow(true)}
                text={`${times?.hour1}:${times?.minute1} ~ ${times?.hour2}:${times?.minute2}`}
              />
              {show && <TimeRange times={times} onChange={onChange} ref={ref} />}
            </div>
          </div>
        </StepOneBlock>
        <div className="meetingUrl">
          <Inputs.Label labelText="화상회의정보" w={94} />
          <p>
            평가방 개설 완료 시 자동으로 생성되며, 평가방에 입장 시 ‘화상평가시작’ 버튼에 링크가
            적용됩니다.
          </p>
        </div>
      </Inputs>
    </DetailSection>
  );
};

const StepOneBlock = styled.div`
  width: 100%;
  & .dateAndTime {
    width: 100%;
    position: relative;
    display: flex;
    flex: 1;
    gap: 16px;
    & > div {
      width: 100%;
      & > div {
        width: 100%;
        & > span {
          display: block;
          width: 100%;
          line-height: 47px;
          cursor: pointer;
        }
        &.timeRange {
          width: 50%;
          position: absolute;
          padding: 10px;
          bottom: -160px;
          right: 0px;
          background-color: #fff;
          box-shadow: 0px 2px 13px -1px rgba(0, 0, 0, 0.15);
          border-radius: 5px;
        }
      }
      & > .datePicker {
      }
    }
  }
`;
