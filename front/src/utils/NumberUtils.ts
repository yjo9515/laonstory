/* eslint-disable array-callback-return */
class NumberOnlyUtils {
  firstNotZero(data: string) {
    if (data === "") return null;

    let re = 0;

    if (data === "0" || data === "") {
      re = 0;
    } else {
      re = parseInt(String(data).replace(/(^0+)/, ""), 10);
    }

    if (isNaN(Number(re))) return 0;

    return re;
  }
  numberOnlyToString(data: string) {
    const regExp = /[^0-9]/g;
    return data.replace(regExp, "");
  }
  dountchartContrastBoolean(data: number) {
    const type = data
      .toString()
      .split("")
      .some((symbol) => symbol === "-");
    if (data === 0) return "normal";
    if (type) return "minus";
    if (!type) return "plus";
  }
  dountchartContrastIcon(data: number) {
    const type = data
      .toString()
      .split("")
      .some((symbol) => symbol === "-");
    if (data === 0) return "-";
    if (type) return "▼";
    if (!type) return "▲";
  }
  onlyNumber(data: number) {
    if (data === 0) return "";
    const number = data.toString().replace("-", "");
    return Number(number);
  }
  numberToComma(data: number) {
    if (!data) return 0;
    const comma = data.toLocaleString("en-US");
    return comma;
  }
  numberToList(page: number, count: number, size?: number) {
    if (!size) size = 10;
    if (page <= 0) page = 1;
    const currentPage = page - 1;
    const totalCount = count;
    const listNumber = [];
    for (let i = 0; i < totalCount; i++) {
      listNumber.push(i + 1);
    }
    listNumber.reverse();
    return listNumber.slice(currentPage * size, currentPage * size + size);
  }

  // 앞에 0 붙여서 숫자 표기
  numberOfDigits(num: number) {
    const digitLength = 6;
    const number = String(num);

    let returnData = number;

    const repetitionsCount = digitLength - String(num).length;

    [...Array(Number(repetitionsCount))].map((item) => {
      returnData = "0" + String(returnData);
    });

    return returnData;
  }
  // 전화번호 '-' 추가
  phoneFormat(phone: string) {
    return phone.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
  }
}

export default new NumberOnlyUtils();
