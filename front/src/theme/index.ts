import "styled-components";
import { DefaultTheme } from "styled-components";

const colors = {
  gray: "#8F8F8F",
  gray1: "#333333",
  gray2: "#4F4F4F",
  gray3: "#828282",
  gray4: "#BDBDBD",
  gray5: "#E0E0E0",
  gray6: "#F2F2F2",
  blueGray1: "#DADDE5",
  blueGray2: "#EDEFF4",
  blueGrayDeeper2: "#AAB1C1",
  bluepurpleLight: "#F8FAFF",
  black30: "rgba(0, 0, 0, 0.3)",
  white: "#ffffff",
  green: "#6FCF97",
  red: "#AF0808",
  blue: "#2F80ED",
  body2: "#2A3748",
  body: "#425061",
  blueDeep: "#CBD3E5",
};

const partnersColors = {
  primary: "#0058A2",
  primaryHover: "#0A63AE",
};

const systemColors = {
  systemPrimary: "#03096F",
  systemSideBarBtn: "#2C496B",
  systemFont: "#1E416B",
  landingButtonColor: "#292e8b",
  pointColor: "#e4651d",
  pointColor2: "#FF9F46",
  bodyLighter: "#566576",
  bodyLighter2: "#798593",
  blueDeep: "#CBD3E5",
  startTimer: "#3C0B54",
  closeTimer: "#DA0043",
};

const fontType = {
  headline: { fontSize: "28px", bold: 800 },
  // subTitle1: { fontSize: "24px", bold: 800 },
  subTitle2: { fontSize: "15px", bold: 800 },
  subTitle3: { fontSize: "15px", bold: 500 },
  subTitle3LineHeight: { fontSize: "15px", bold: 500, lineHeight: "165%" },
  body: { fontSize: "14px", bold: 400 },
  bodyLineHeight: { fontSize: "13px", bold: 300, lineHeight: "165%" },
  // button1: { fontSize: "15px", bold: 800 },
  button2: { fontSize: "13px", bold: 700 },
  pagenationBold: { fontSize: "14px", bold: 700 },
  pagenation: { fontSize: "14px", bold: 500 },
  time: { fontSize: "38px", bold: 700 },
  title1: { fontSize: "24px", bold: 700 },
  title2: { fontSize: "20px", bold: 600 },
  title3: { fontSize: "16px", bold: 700, color: "#425061" },
  content1: { fontSize: "13px", color: "#798593", bold: 400 },
  content2: { fontSize: "12px", bold: 400 },
  subTitle1: { fontSize: "13px", bold: 500 },
  body1: { fontSize: "13px", color: "#2A3748" },
  contentTitle1: { fontSize: "14px", bold: 500 },
  button1: { fontSize: "15px", bold: 500 },
  input1: { fontSize: "13px", bold: 400 },
};

const commonWidth = {
  wrapWidth: "1860px",
  landingWidth: "1175px",
};
const commonHeight = {
  headerHeight: "64px",
  footerHeight: "80px",
};

const commonInput = {
  height: "40px",
  placeholderColor: colors.gray4,
  radius: "5px",
  border: `1px solid ${colors.gray5}`,
  paddingLeft: "14px",
};

const commonMargin = {
  gap1: "70px",
  gap2: "40px",
  gap3: "20px",
  gap4: "10px",
  totalPageGradeGap: "40px", // 최종평가표 페이지 여백용
};

const commonRadius = {
  radius1: "8px",
};

const theme = {
  colors,
  partnersColors,
  systemColors,
  fontType,
  commonWidth,
  commonInput,
  commonMargin,
  commonRadius,
  commonHeight,
};

export default theme;
