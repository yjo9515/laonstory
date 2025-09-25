import styled from "styled-components";
import theme from ".";

export const ViewDetailObjectBox = styled.div`
  width: 100%;
  min-height: 300px;
  background-color: ${(props) => props.theme.colors.blueGray2};
  border-radius: 10px;
  display: table;
  color: ${(props) => props.theme.colors.gray2};
  margin-top: 61px;
  label {
    display: block;
    font-size: ${(props) => props.theme.fontType.subTitle2.fontSize};
    font-weight: ${(props) => props.theme.fontType.subTitle2.bold};
    white-space: nowrap;
  }
  & .detailWrapper {
    width: 100%;
    height: 100%;
    display: flex;
    & > div {
      padding: 32px;
      width: 50%;
      height: 100%;
      display: flex;
      flex-direction: column;
    }
  }
`;

interface ViewObjectWrapperBoxTypes {
  textAlign?: string;
  isShadow?: boolean;
  detail?: boolean;
}

export const ViewObjectWrapperBox = styled.div<ViewObjectWrapperBoxTypes>`
  width: 100%;
  min-height: 680px;
  height: auto;
  position: relative;
  background-color: #fff;
  padding: ${(props) => (props.detail ? "40px" : "25px")};
  /* padding-top: 60px; */
  box-shadow: ${(props) => (!props.isShadow ? "0px 1px 47px 8px rgba(53, 88, 122, 0.1)" : "")};
  border-radius: 22px;
  /* overflow-y: auto; */
  /* margin-top: 50px; */
  .viewTitle {
    font-size: ${theme.fontType.title2.fontSize};
    font-weight: ${theme.fontType.title2.bold};
    color: ${theme.colors.body2};
    text-align: ${(props) => (props.textAlign ? props.textAlign : "left")};
    & > .subViewTitle {
    }
  }
  .dateWrap{
    display: flex;
    gap: 10px;
    align-items: center;
    font-size: 20px;
  }

  .selectWrap{
    margin-bottom: 15px;
    select{
      height: 30px;
      width: 120px;
      border-radius: 5px;
    }
  }

  & > .searchBox {
    width: 100%;
    height: 40px;
    margin-bottom: 20px;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 24px;
    & > .searchBoxInfo {
      flex: 1;
      padding-left: 10px;
      font-size: 12px;
      color: ${theme.colors.gray3};
    }
  }
  & > .listWrapper {
    width: 100%;
    height: 561px;
    background-color: ${theme.colors.gray2};
  }
  & > .pageNation {
    width: 100%;
    height: 30px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 30px;
    position: relative;
    & > .btnWrap {
      position: absolute;
      right: 0;
    }
    & > .main {
      margin-top: 61px;
      width: 100%;
    }
    & > .buttonContainer {
      display: flex;
      justify-content: center;
      margin-top: 40px;
    }
  }
  .mainContent {
    margin-top: 40px;

    .infoContainer {
      padding: 40px 0px;
      display: flex;
      flex-direction: column;
      gap: 16px;
      border-bottom: 1px solid ${theme.colors.blueGray2};

      &:first-child {
        padding-top: 0px;
      }
      & > h2 {
        color: ${theme.colors.body2};
        font-weight: 500;
        font-size: 16px;
        line-height: 23px;
        margin-bottom: 16px;
      }
    }
  }
  .buttonContainer {
    display: flex;
    justify-content: center;
    margin-top: 49px;
    gap: 24px;
  }
  .boardButtonContainer {
    display: flex;
    justify-content: center;
    margin-top: 70px;
    gap: 24px;
  }
`;

export const LandingContainer = styled.div`
  width: 100%;
  height: 100%;
  min-height: 600px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  & > h1 {
    margin-top: 28px;
    text-align: center;
    font-size: ${(props) => props.theme.fontType.headline.fontSize};
    font-weight: ${(props) => props.theme.fontType.headline.bold};
    color: ${(props) => props.theme.partnersColors.primary};
  }
  & > .subText {
    display: block;
    font-size: 18px;
    text-align: center;
    margin-top: 32px;
    line-height: 29.7px;
  }
  & > .main {
    margin-top: 72px;
    display: flex;
    justify-content: center;
  }
  & > .main > .authButtonContainer {
    display: flex;
    gap: 24px;
  }
  & > .buttonContainer {
    margin-top: 72px;
    display: flex;
    gap: 24px;
  }
`;

export const LoginContainer = styled.div`
  width: 100%;
  padding-bottom: 67px;
  & > .header {
    width: 100%;
    padding: 16px 0px;
    /* margin-top: -30px; */
    & > .headerContent {
      width: 1152px;
      margin: 0 auto;
    }
    & > img {
      display: block;
      height: 32px;
    }
  }
  & > .content {
    width: 738px;
    margin: 0 auto;
    margin-top: 48px;
    padding: 32px 32px 72px 32px;
    background: #ffffff;
    border: 1px solid #dadde5;
    border-radius: 34px;
    .backButton {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: ${theme.fontType.subTitle1.fontSize};
      font-weight: ${theme.fontType.subTitle1.bold};
      cursor: pointer;
      & img {
        display: block;
      }
      & span {
        font-weight: 400;
        font-size: 13px;
        line-height: 19px;
      }
    }
    & > h1 {
      text-align: center;
      color: ${theme.colors.body};
      font-weight: ${theme.fontType.title1.bold};
      font-size: ${theme.fontType.title1.fontSize};
      line-height: 35px;
    }
    .main {
      display: flex;
      align-items: center;
      flex-direction: column;
      padding: 0px 48px;
      & .infoText {
        font-weight: ${theme.fontType.content2.bold};
        font-size: ${theme.fontType.content2.fontSize};
        color: ${theme.colors.body};
        line-height: 17px;
        margin-top: -8px;
      }
      & > .tabBar {
        width: 100%;
        height: 55px;
        margin-top: 40px;
        margin-bottom: 40px;
        position: relative;
        display: flex;
        background: #edeff4;
        border: 1px solid #dadde5;
        box-shadow: 0px -2px 13px -1px rgba(0, 0, 0, 0.07);
        border-radius: 79px;
        font-size: ${theme.fontType.button1.fontSize};
        font-weight: ${theme.fontType.button1.bold};
        color: ${theme.colors.blueGrayDeeper2};
        button {
          display: block;
          width: 50%;
          height: 100%;
          font-size: 16px;
          line-height: 23px;
          text-align: center;
          z-index: 3;
          transition: all 0.2s;
          font-weight: 500;
          &.currentTab {
            color: #425061;
            font-weight: 700;
          }
        }
        > div.currentTab {
          width: 50%;
          height: 100%;
          position: absolute;
          left: 0px;
          background-color: #fff;
          border: 1px solid #dadde5;
          box-shadow: 0px -2px 13px -1px rgba(0, 0, 0, 0.07);
          border-radius: 79px;
          z-index: 1;
          transition: all 0.2s;
          &.move {
            left: 50%;
          }
        }
      }
      & > .subText {
        margin-top: 16px;
        text-align: center;
        font-size: ${theme.fontType.contentTitle1.fontSize};
        font-weight: ${theme.fontType.contentTitle1.bold};
        margin-bottom: 40px;
      }
      & > .inputContainer {
        width: 100%;
        > form {
          display: flex;
          flex-direction: column;
          gap: 24px;
        }
      }
      & .buttonContainer {
        margin-top: 87px;
        width: 100%;
        display: flex;
        justify-content: center;
      }
    }
  }
`;

export const JoinContainer = styled.div`
  margin-top: 45px;
  & > h1 {
    /* margin-top: 109px; */
    text-align: center;
    font-size: ${theme.fontType.title1.fontSize};
    font-weight: ${theme.fontType.title1.bold};
    color: ${(props) => props.theme.colors.body};
  }
  & > .process {
    margin-top: 32px;
  }
  & > .main {
    width: 1152px;
    margin: 0 auto;
    margin-top: 48px;
    margin-bottom: 60px;
  }
`;

export const MyInfoModalContainer = styled.div`
  .main {
    width: 100%;

    display: flex;
    align-items: center;
    justify-content: center;

    gap: 40px;
    & > div {
      width: 50%;
      display: flex;
      align-items: center;
      flex-direction: column;
      gap: 24px;
    }
    & > .centerLine {
      height: 100%;
      width: 1px;
      background-color: ${theme.colors.blueGray1};
    }
    & > span {
      display: block;
      width: 100%;
      /* background-color: pink; */
      margin-top: -35px;
      & > span {
        width: 350px;
        margin: 0 auto;
        display: flex;
        justify-content: flex-end;
        & > p {
          text-decoration: underline;
          color: ${theme.colors.blueGrayDeeper2};
          font-size: 14px;
          margin-top: 4px;
          cursor: pointer;
        }
      }
    }
  }
  .buttonContainer {
    display: flex;
    justify-content: center;
  }
`;
