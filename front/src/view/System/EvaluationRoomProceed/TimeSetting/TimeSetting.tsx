import { useEffect } from "react";
import styled from "styled-components";
import theme from "../../../../theme";
import arrowDownBtn from "../../../../assets/Icon/arrowDownBtn.svg";
import arrowUpBtn from "../../../../assets/Icon/arrowUpBtn.svg";
import { useSetCounter } from "../../../../utils/TimeUtils";

interface TimeSettingTypes {
  onSetTime: (e: any) => void;
  timeSettingModalStatus: { announcement: string; inquiry: string };
}

function TimeSetting(props: TimeSettingTypes) {
  const { times, setTimes, timers, changeTimes, upAndDownTime } = useSetCounter({
    maxValue: [60, 60],
  });

  useEffect(() => {
    props.onSetTime({
      announcement: timers[0],
      inquiry: timers[1],
    });
  }, [times]);

  // 컨트롤러에 기존이 입력한 시간 가져오기
  useEffect(() => {
    const announcement = props.timeSettingModalStatus.announcement.split(":");
    const inquiry = props.timeSettingModalStatus.inquiry.split(":");
    setTimes((prev) => ({
      left1: announcement[0],
      left2: inquiry[0],
      right1: announcement[1],
      right2: inquiry[1],
    }));
  }, [props.timeSettingModalStatus]);

  return (
    <TimeSettingBlock>
      <div>
        <p>발표 시간</p>
        <div>
          <label>
            <img src={arrowUpBtn} alt="" onClick={() => upAndDownTime("left1", "up")} />
            <div>
              <input
                type="text"
                max={60}
                min={0}
                value={times.left1}
                name="left1"
                onChange={changeTimes}
              />
              <span>분</span>
            </div>
            <img src={arrowDownBtn} alt="" onClick={() => upAndDownTime("left1", "down")} />
          </label>
          <span>:</span>
          <label>
            <img src={arrowUpBtn} alt="" onClick={() => upAndDownTime("right1", "up")} />
            <div>
              <input
                type="text"
                max={60}
                min={0}
                value={times.right1}
                name="right1"
                onChange={changeTimes}
              />
              <span>초</span>
            </div>
            <img src={arrowDownBtn} alt="" onClick={() => upAndDownTime("right1", "down")} />
          </label>
        </div>
      </div>
      <div className="line"></div>
      <div>
        <p>질의 응답 시간</p>
        <div>
          <label>
            <img src={arrowUpBtn} alt="" onClick={() => upAndDownTime("left2", "up")} />
            <div>
              <input
                type="text"
                max={60}
                min={0}
                value={times.left2}
                name="left2"
                onChange={changeTimes}
              />
              <span>분</span>
            </div>
            <img src={arrowDownBtn} alt="" onClick={() => upAndDownTime("left2", "down")} />
          </label>
          <span>:</span>
          <label>
            <img src={arrowUpBtn} alt="" onClick={() => upAndDownTime("right2", "up")} />
            <div>
              <input
                type="text"
                max={60}
                min={0}
                value={times.right2}
                name="right2"
                onChange={changeTimes}
              />
              <span>초</span>
            </div>
            <img src={arrowDownBtn} alt="" onClick={() => upAndDownTime("right2", "down")} />
          </label>
        </div>
      </div>
    </TimeSettingBlock>
  );
}

export default TimeSetting;

const TimeSettingBlock = styled.div`
  padding: 0px 40px;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 102px;
  & > .line {
    height: 289px;
    width: 1px;
    background-color: ${theme.colors.blueGray2};
  }
  & > div {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    & > p {
      width: 100%;
      margin-bottom: 56px;
      text-align: center;
      color: ${theme.colors.body};
      font-size: 16px;
      font-weight: 500;
    }
    & > div {
      flex: 1;
      width: 100%;
      display: flex;
      align-items: center;
      gap: 43px;
      & > label {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        gap: 8px;
        & > img {
          cursor: pointer;
        }
        & > div {
          position: relative;
        }
        & span {
          position: absolute;
          top: 15px;
          right: -22px;
          color: ${theme.colors.blueGrayDeeper2};
          font-size: 15px;
          font-weight: 5;
        }
      }
    }
  }

  input[type="text"] {
    width: 72px;
    height: 48px;
    text-align: center;
    font-size: 24px;
    border-radius: 10px;
    border: 1px solid ${theme.colors.blueGray1};
  }
`;
