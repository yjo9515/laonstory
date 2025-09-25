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
  top?: boolean;
}

export const ViewObjectWrapperBox = styled.div<ViewObjectWrapperBoxTypes>`
  width: 100%;
  min-height: 600px;
  height: auto;
  margin-top: ${(props) => (props.top ? "32px" : "0px")};
  padding: ${(props) => (props.detail ? "40px" : "30px")};
  position: relative;
  background-color: #fff;
  box-shadow: ${(props) => (!props.isShadow ? "0px 1px 47px 8px rgba(53, 88, 122, 0.1)" : "")};
  border-radius: 22px;
  .title {
    font-size: 20px;
    font-weight: 700;
    color: ${theme.colors.body2};
    display: flex;
    justify-content: space-between;
    .mainAgreement {
      width: 134px;
      height: 29px;
      padding: 4px 8px;
      background-color: #cc5600;
      color: white;
      display: flex;
      justify-content: center;
      align-items: center;
      border-radius: 67px;
      font-weight: 500;
      font-size: 13px;
      line-height: 19px;
    }
  }
  .viewTitle {
    font-size: 20px;
    font-weight: 700;
    color: ${theme.colors.body2};
    text-align: ${(props) => (props.textAlign ? props.textAlign : "left")};
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
  }
  & > .listWrapper {
    width: 100%;
    height: 570px;
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
    & > .between {
      width: 100%;
      display: flex;
      justify-content: space-between;
      gap: 16px;
      & > div {
        display: flex;
        & > button:first-child {
          margin-right: 10px;
        }
      }
    }
  }
  .boardButtonContainer {
    display: flex;
    justify-content: center;
    margin-top: 70px;
    gap: 24px;
  }
`;

export const LandingContainer = styled.div`
  display: flex;
  flex-direction: column;
  & > h1 {
    margin-top: 72px;
    text-align: center;
    font-size: ${(props) => props.theme.fontType.medium24.fontSize};
    font-weight: ${(props) => props.theme.fontType.medium24.bold};
    color: ${(props) => props.theme.colors.body};
  }
  & > .subText {
    display: block;
    font-size: ${(props) => props.theme.fontType.regular14.fontSize};
    font-weight: ${(props) => props.theme.fontType.regular14.bold};
    text-align: center;
    margin-top: 16px;
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

export const JoinContainer = styled.div`
  & > h1 {
    text-align: center;
    font-size: ${(props) => props.theme.fontType.medium24.fontSize};
    font-weight: ${(props) => props.theme.fontType.medium24.bold};
    color: ${(props) => props.theme.colors.body};
  }
  & > .process {
    margin-top: 32px;
  }
  & > .main {
    width: 1152px;
    margin: 0 auto;
    margin-top: 48px;
  }
`;

export const LoginContainer = styled.div`
  width: 100%;
  & > .header {
    width: 100%;
    height: 101px;
    padding: 24px 0px;
    & > .headerContent {
      width: 1152px;
      margin: 0 auto;
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
      font-weight: 500;
      font-size: 24px;
      line-height: 35px;
    }
    .main {
      display: flex;
      align-items: center;
      flex-direction: column;
      padding: 0px 48px;
      & .infoText {
        font-weight: 400;
        font-size: 12px;
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
        color: ${theme.colors.blueGrayDeeper2};
        button {
          display: block;
          width: 50%;
          height: 100%;
          font-weight: 700;
          font-size: 16px;
          line-height: 23px;
          text-align: center;
          z-index: 3;
          transition: all 0.2s;
          &.currentTab {
            color: #425061;
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
        margin-top: 22px;
        text-align: center;
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
        margin-top: 120px;
        width: 100%;
        display: flex;
        justify-content: center;
      }
    }
  }
`;

export const MyInfoModalContainer = styled.div`
  width: 700px;
  .main {
    width: 100%;
    min-height: 235px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
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
      min-height: 235px;
      background-color: ${theme.colors.blueGray1};
    }
    & > span {
      display: block;
      width: 100%;
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
`;
