import "styled-components";

declare module "styled-components" {
  export interface DefaultTheme {
    colors: {
      gray: string;
      gray1: string;
      gray2: string;
      gray3: string;
      gray4: string;
      gray5: string;
      gray6: string;
      blueGray1: string;
      blueGray2: string;
      blueGrayDeeper2: string;
      green: string;
      red: string;
      blue: string;
      black30: string;
      white: string;
      body2: string;
      body: string;
      blueDeep: string;
      peacok: string;
    };

    // 계좌등록시스템
    partnersColors: {
      primary: string;
      primaryHover: string;
    };

    // 제안서 평가시스템
    systemColors: {
      systemPrimary: string;
      systemSideBarBtn: string;
    };

    fontType: {
      medium32: fontSize;
      medium30: fontSize;
      medium24: fontSize;
      medium16: fontSize;
      medium13: fontSize;
      medium12: fontSize;
      light20: fontSize;
      light18: fontSize;
      regular12: fontSize;
      regular13: fontSize;
      regular14: fontSize;
      bold30: fontSize;
      bold16: fontSize;
      bold13: fontSize;
      headline: fontSize;
      subTitle1: fontSize;
      subTitle2: fontSize;
      subTitle3: fontSize;
      subTitle3LineHeight: fontSize;
      body: fontSize;
      bodyLineHeight: fontSize;
      button1: fontSize;
      button2: fontSize;
      pagenationBold: fontSize;
      pagenation: fontSize;
      time: fontSize;
    };

    commonWidth: {
      wrapWidth: string;
      landingWidth: string;
    };

    commonHeight: {
      headerHeight: string;
    };

    commonInput: {
      height: string;
      placeholderColor: string;
      radius: string;
      border: string;
      paddingLeft: string;
    };

    commonMargin: {
      gap1: string;
      gap2: string;
      gap3: string;
      gap4: string;
      totalPageGradeGap: string;
    };

    commonRadius: {
      radius1: string;
    };
  }
}

interface fontSize {
  fontSize: string;
  bold: number;
  lineHeight?: string;
}
