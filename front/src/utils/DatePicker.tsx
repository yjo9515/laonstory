import ReactDatePicker, {
  ReactDatePickerCustomHeaderProps,
  registerLocale,
} from "react-datepicker";
import styled from "styled-components";
import ArrowNext from "../assets/Icon/ArrowNext";
import ArrowPrev from "../assets/Icon/ArrowPrev";
import theme from "../theme";
import ko from "date-fns/locale/ko";

/**
 *
 * @param startDate date input value state
 * @param setStartDate date change event - 선택한 date 값을 받아서 처리할 함수 (state 설정 해줘야 함)
 */
export const useDatePicker = (startDate: Date, setStartDate: (date: Date) => void) => {
  registerLocale("ko", ko);
  const now = new Date();
  // 달력 커스텀 헤더
  const renderCustomHeader = (params: ReactDatePickerCustomHeaderProps) => {
    const { decreaseMonth, increaseMonth, date } = params;
    const nowYear = now.getFullYear();
    const dateYear = date.getFullYear();
    const nowMonth = now.getMonth();
    const dateMonth = date.getMonth();
    return (
      <div className="date-picker-header">
        {nowYear === dateYear && dateMonth <= nowMonth ? null : (
          <button onClick={decreaseMonth}>
            <ArrowPrev />
          </button>
        )}
        <span>
          {date.getFullYear()}.{date.getMonth() + 1}
        </span>
        <button onClick={increaseMonth}>
          <ArrowNext />
        </button>
      </div>
    );
  };
  const dayClassName = (date: Date) => {
    if (
      date.getFullYear() === now.getFullYear() &&
      (date.getMonth() < now.getMonth() ||
        (date.getMonth() <= now.getMonth() && date.getDate() < now.getDate()))
    ) {
      return "block";
    }
    if (
      date.getFullYear() === startDate.getFullYear() &&
      date.getMonth() === startDate.getMonth() &&
      date.getDate() === startDate.getDate()
    ) {
      return "choose";
    }
    return null;
  };

  return (
    <DatePickerContainer className="datePicker">
      <ReactDatePicker
        renderCustomHeader={renderCustomHeader}
        selected={startDate}
        dayClassName={dayClassName}
        onChange={setStartDate}
        locale="ko"
        dateFormat="yyyy-MM-dd"
      />
    </DatePickerContainer>
  );
};

const DatePickerContainer = styled.div`
  width: 100%;
  & input {
    width: 100%;
    height: 47px;
    padding-left: 24px;
    flex: 1;
    font-size: ${theme.fontType.content2.fontSize};
    font-weight: ${theme.fontType.content2.bold};
    border-radius: 5px;
    line-height: 47px;
    border: 1px solid ${theme.colors.blueDeep};
    cursor: pointer;
  }
  & .react-datepicker-wrapper {
    width: 100%;
    & .react-datepicker__input-container {
    }
  }
  & .react-datepicker__tab-loop {
    position: absolute;
  }
  & .react-datepicker-popper {
    width: 300px;
    background-color: #fff;
    box-shadow: 0px 2px 13px -1px rgba(0, 0, 0, 0.15);
    border-radius: 10px;
    & .react-datepicker__navigation {
      display: none;
    }
    & .react-datepicker__header {
      width: 100%;
      display: flex;
      flex-direction: column;
      & .react-datepicker__day-names {
        display: flex;
        color: ${theme.colors.gray};
        padding: 2px 0px;
        border-bottom: 1px solid ${theme.colors.gray4};
        margin-bottom: 5px;
      }
      & .date-picker-header {
        padding: 10px 25px;
        font-size: 21px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        border-top-right-radius: 5px;
        border-top-left-radius: 5px;
        background-color: ${theme.partnersColors.primary};
        color: white;
        & > button {
          font-size: 25px;
          cursor: pointer;
          & svg {
            width: 20px;
            height: 20px;
            & path {
              stroke: white;
            }
          }
        }
        & > span {
          font-size: 20px;
          margin: 0 auto;
        }
      }
    }
    & .react-datepicker__week {
      display: flex;
    }
    & .react-datepicker__day {
      cursor: pointer;
      border-radius: 5px;
      &.block {
        cursor: default;
        color: ${theme.colors.gray4};
      }

      &:not(.block):hover,
      &.choose {
        background-color: ${theme.partnersColors.primary};
        color: white;
      }
    }
    & .react-datepicker__day,
    .react-datepicker__day-name {
      width: calc(100% / 7);
      padding: 7px 0px;
      text-align: center;
      font-size: 18px;
    }
  }
`;
