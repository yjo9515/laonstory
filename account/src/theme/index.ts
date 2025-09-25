import "styled-components";
import { DefaultTheme } from "styled-components";

const colors = {
  // systemPrimary: "#415B7A",
  // systemSideBarBtn: "#2C496B",
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
  black30: "rgba(0, 0, 0, 0.3)",
  white: "#ffffff",
  green: "#6FCF97",
  red: "#AF0808",
  blue: "#2F80ED",
  body2: "#2A3748",
  body: "#425061",
  blueDeep: "#CBD3E5",
  peacok: "#0A4763",
};

const partnersColors = {
  primary: "#0058A2",
  primaryHover: "#0A63AE",
};

const systemColors = {
  systemPrimary: "#415B7A",
  systemSideBarBtn: "#2C496B",
};

const fontType = {
  headline: { fontSize: "28px", bold: 800 },
  subTitle1: { fontSize: "24px", bold: 800 },
  subTitle2: { fontSize: "15px", bold: 800 },
  subTitle3: { fontSize: "15px", bold: 500 },
  subTitle3LineHeight: { fontSize: "15px", bold: 500, lineHeight: "165%" },
  body: { fontSize: "14px", bold: 400 },
  bodyLineHeight: { fontSize: "13px", bold: 300, lineHeight: "165%" },
  button1: { fontSize: "15px", bold: 800 },
  button2: { fontSize: "13px", bold: 700 },
  pagenationBold: { fontSize: "14px", bold: 700 },
  pagenation: { fontSize: "14px", bold: 500 },
  time: { fontSize: "50px", bold: 600 },
  medium32: { fontSize: "32px", bold: 500 },
  medium30: { fontSize: "30px", bold: 500 },
  medium24: { fontSize: "24px", bold: 500 },
  medium16: { fontSize: "16px", bold: 500 },
  medium13: { fontSize: "13px", bold: 500 },
  medium12: { fontSize: "12px", bold: 500 },
  light20: { fontSize: "20px", bold: 300 },
  light18: { fontSize: "18px", bold: 300 },
  regular14: { fontSize: "14px", bold: 400 },
  regular13: { fontSize: "13px", bold: 400 },
  regular12: { fontSize: "12px", bold: 400 },
  bold30: { fontSize: "30px", bold: 700 },
  bold16: { fontSize: "16px", bold: 700 },
  bold13: { fontSize: "13px", bold: 700 },
};

const commonWidth = {
  wrapWidth: "1860px",
  landingWidth: "1175px",
};
const commonHeight = {
  headerHeight: "48px",
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

const theme: DefaultTheme = {
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
