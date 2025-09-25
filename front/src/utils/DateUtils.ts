import dayjs from "dayjs";

class DateUtils {
  dateToFormat(date: dayjs.ConfigType, type: string) {
    if (!date) return "";
    return dayjs(date).format(type);
  }

  dateFormat = (date: dayjs.ConfigType) => {
    if (date === null || date === undefined || date === "") {
      return "";
    }
    let time: number;
    time = Number(dayjs(date).format("H"));
    if (time < 12) {
      date = dayjs(date).format("YYYY.MM.DD 오전 h:mm");
    } else {
      date = dayjs(date).format("YYYY.MM.DD 오후 h:mm");
    }
    return date;
  };

  // 게시판 날짜 형식
  boardDateFormat(date: string | Date | number) {
    return dayjs(date).format("YYYY-MM-DD");
  }
  // 시간 날짜 형식
  listDateFormat(date: string | Date | number) {    
    return dayjs(date).format("YYYY-MM-DD hh:mm");
  }

  getMilleSecond(date: dayjs.ConfigType) {
    return dayjs(date);
  }
}

export default new DateUtils();
