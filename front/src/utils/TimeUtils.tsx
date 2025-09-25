import React, { ChangeEvent, useEffect, useState } from "react";
import styled from "styled-components";
import arrowDown from "../assets/Icon/arrowDown.svg";
import arrowUp from "../assets/Icon/arrowUp.svg";

interface counterProps {
  maxValue: number[];
}
interface timerStateDefaultType {
  [key: string]: string;
}
interface timerListType {
  [key: number]: string;
}
// 최대값 배열을 받는다 최대값 배열의 개수만큼 카운터를 만든다
// 이 값을 이용하는 input의 name과 value를 left+id, right+id 형식으로 사용해야 한다.
export const useSetCounter = (props: counterProps) => {
  let timerStateDefault: timerStateDefaultType = {};
  props.maxValue.forEach((el, i) => {
    timerStateDefault[`left${i + 1}`] = "00";
    timerStateDefault[`right${i + 1}`] = "00";
  });
  const [times, setTimes] = useState(timerStateDefault);
  // 타이머 시간 입력 함수
  const changeTimes = (e: ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    // 최대값 배열의 위치가 아이디
    const id = Number(name[name.length - 1]);
    let timeValue = Number(value);
    // 처음 00을 포함해 입력값이 3자리가 되면 기존값의 마지막 값과 입력 값을 합쳐줌
    if (value.length === 3) {
      timeValue = Number(`${times[name][times[name].length - 1]}${value[value.length - 1]}`);
      // console.log("timeValue", timeValue);
    }
    // 숫자가 아닌 값을 입력하면 리턴
    if (isNaN(Number(value))) return;
    // 왼쪽값이 최대값이 되면 초 0으로 고정
    if (name === `left${id}` && timeValue === props.maxValue[id - 1]) {
      setTimes((prev) => ({
        ...prev,
        [`left${id}`]: String(props.maxValue[id - 1]),
        [`right${id}`]: "00",
      }));
      return;
    }
    // 분 혹은 초가 최대값을 넘으면 최대값으로 고정
    if (name.includes("left")) {
      if (Number(value) < 0 || Number(value) > props.maxValue[id - 1]) {
        timeValue = props.maxValue[id - 1];
      }
    }
    if (name.includes("right")) {
      if (Number(value) < 0 || Number(value) > 59) {
        timeValue = 59;
      }
    }
    setTimes((prev) => ({
      ...prev,
      [name]: String(timeValue).length === 1 ? `0${String(timeValue)}` : String(timeValue),
    }));
  };
  // 타이머 증가 감소 버튼 클릭 함수
  const upAndDownTime = (name: string, type: "up" | "down") => {
    let timeValue = isNaN(Number(times[name])) ? 0 : Number(times[name]);
    const id = Number(name[name.length - 1]);
    if (type === "up") {
      timeValue++;
      if (name.includes("left") && timeValue === props.maxValue[id - 1]) {
        setTimes((prev) => ({
          ...prev,
          [`left${id}`]: String(props.maxValue[id - 1]),
          [`right${id}`]: "00",
        }));
        return;
      }
      if (Number(times[`left${id}`]) === props.maxValue[id - 1] && name === `right${id}`)
        timeValue = 0;
      if (name.includes("left") && Number(times[name]) + 1 > props.maxValue[id - 1]) timeValue = 0;
      if (name.includes("right") && Number(times[name]) + 1 > 59) timeValue = 0;
    }
    if (type === "down") {
      timeValue--;
      if (Number(times[name]) - 1 < 0) {
        if (name.includes("left")) {
          timeValue = props.maxValue[id - 1];
          setTimes((prev) => ({
            ...prev,
            [`left${id}`]: String(timeValue),
            [`right${id}`]: "00",
          }));
          return;
        }
        if (name.includes("right")) timeValue = 59;
      }
    }
    setTimes((prev) => ({
      ...prev,
      [name]: String(timeValue).length === 1 ? `0${String(timeValue)}` : String(timeValue),
    }));
  };
  //최종 형태의 시간
  let timers: timerListType = {};
  props.maxValue.forEach((el, i) => {
    const id = i + 1;
    const left = times[`left${id}`].length === 1 ? "0" + times[`left${id}`] : times[`left${id}`];
    const right =
      times[`right${id}`].length === 1 ? "0" + times[`right${id}`] : times[`right${id}`];
    timers[i] = `${left}:${right}`;
  });

  return { times, setTimes, timers, changeTimes, upAndDownTime };
};

export const timesDefault = {
  hour1: "00",
  minute1: "00",
  hour2: "00",
  minute2: "00",
};
// 함수 props 타입
interface timeRangeProps {
  onChange: (times: timesType) => void;
  times?: timesType;
}
// state 기본값 타입
type timesDefault = typeof timesDefault;
export interface timesType extends timesDefault {
  [key: string]: string;
}
// 시간 범위 커스텀 훅
export const TimeRange = React.forwardRef((props: timeRangeProps, ref) => {
  // 시간 범위 state
  const [times, setTimes] = useState<timesType>(props.times || timesDefault);
  // 타이머 시간 입력 함수
  const changeTimes = (e: ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;

    let timeValue = Number(value);
    // 공통 조건
    // 처음 00을 포함해 입력값이 3자리가 되면 기존값의 마지막 값과 입력 값을 합쳐줌
    if (value.length === 3) {
      timeValue = Number(`${times[name][times[name].length - 1]}${value[value.length - 1]}`);
      // console.log("timeValue", timeValue);
    }
    // 숫자가 아닌값이 들어오면 리턴
    if (isNaN(Number(value))) return;
    // 시작 시간이 안정해졌는데 끝 시간을 입력하려 하면 리턴
    if ((times.hour1 === "" || times.minute1 === "") && name.includes("2")) return;

    // 시간 부분 조건
    if (name.includes("hour")) {
      if (timeValue > 24) return;
    }
    // 분 부분 조건
    if (name.includes("minute")) {
      if (timeValue > 59) return;
    }
    // 값이 없으면 초기화
    if (!value) {
      setTimes((prev) => ({
        ...prev,
        [name]: "00",
      }));
      return;
    }

    setTimes((prev) => ({
      ...prev,
      [name]: String(timeValue).length === 1 ? `0${String(timeValue)}` : String(timeValue),
    }));
  };

  // 타이머 증가 감소 버튼 클릭 함수
  const upAndDownTime = (name: string, type: "up" | "down") => {
    // 숫자가 아닌 값이 들어오면 리턴
    let timeValue = isNaN(Number(times[name])) ? 0 : Number(times[name]);

    if (type === "up") {
      timeValue++;
      if (name.includes("hour") && timeValue > 24) {
        timeValue = 1;
      }
      if (name.includes("minute") && timeValue > 59) {
        timeValue = 0;
      }
    }
    if (type === "down") {
      timeValue--;
      if (timeValue === 0 || timeValue === -1) {
        if (name.includes("hour")) {
          timeValue = 24;
        }
        if (name.includes("minute")) {
          timeValue = 59;
        }
      }
    }
    setTimes((prev) => ({
      ...prev,
      [name]: String(timeValue).length === 1 ? `0${String(timeValue)}` : String(timeValue),
    }));
  };

  useEffect(() => {
    props.onChange(times);
  }, [times]);

  return (
    <TimeRangeContainer ref={ref as any} className="timeRange">
      <div>
        <div>
          <img src={arrowUp} alt="" onClick={() => upAndDownTime("hour1", "up")} />
          <input
            type="text"
            name="hour1"
            onChange={changeTimes}
            value={times.hour1}
            onFocus={(e) => e.target.select()}
          />
          <img src={arrowDown} alt="" onClick={() => upAndDownTime("hour1", "down")} />
        </div>
        <span>:</span>
        <div>
          <img src={arrowUp} alt="" onClick={() => upAndDownTime("minute1", "up")} />
          <input
            type="text"
            name="minute1"
            onChange={changeTimes}
            value={times.minute1}
            onFocus={(e) => e.target.select()}
          />
          <img src={arrowDown} alt="" onClick={() => upAndDownTime("minute1", "down")} />
        </div>
      </div>
      <span className="timeRangeBetween">~</span>
      <div>
        <div>
          <img src={arrowUp} alt="" onClick={() => upAndDownTime("hour2", "up")} />
          <input
            type="text"
            name="hour2"
            onChange={changeTimes}
            value={times.hour2}
            onFocus={(e) => e.target.select()}
          />
          <img src={arrowDown} alt="" onClick={() => upAndDownTime("hour2", "down")} />
        </div>
        <span>:</span>
        <div>
          <img src={arrowUp} alt="" onClick={() => upAndDownTime("minute2", "up")} />
          <input
            type="text"
            name="minute2"
            onChange={changeTimes}
            value={times.minute2}
            onFocus={(e) => e.target.select()}
          />
          <img src={arrowDown} alt="" onClick={() => upAndDownTime("minute2", "down")} />
        </div>
      </div>
    </TimeRangeContainer>
  );
});

const TimeRangeContainer = styled.div`
  display: flex;
  align-items: center;
  gap: 20px;
  & > .timeRangeBetween {
    font-size: 50px;
  }
  & > div {
    display: flex;
    align-items: center;
    gap: 10px;
    & > div {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 5px;
      & > img {
        width: 30px;
        cursor: pointer;
      }
      & > span {
        font-size: 30px;
      }
      & > input {
        width: 70px;
        height: 70px;
        padding: 10px;
        font-size: 30px;
        text-align: center;
      }
    }
  }
`;
