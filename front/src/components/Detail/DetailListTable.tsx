import React, { ReactNode } from "react";
import styled from "styled-components";
import theme from "../../theme";

/** 헤더와 제목을 가진 리스트 & 테이블 컨테이너 */
export function InfoList({ children }: { children: ReactNode }) {
  return <InfoListContainer>{children && children}</InfoListContainer>;
}
const InfoListContainer = styled.div`
  margin-bottom: 40px;
  &:last-child {
    margin-bottom: 0px;
  }
  & table {
    & th,
    td {
      font-size: ${theme.fontType.subTitle1.fontSize};
      font-weight: ${theme.fontType.subTitle1.bold};
    }
  }
  & textarea {
    width: 100%;
    height: 246px;
    margin-bottom: 48px;
    padding: 16px;
    position: relative;
    resize: none;
    outline: none;
    border: 1px solid ${theme.colors.blueDeep};
    border-radius: 5px;
    font-size: ${theme.fontType.content1.fontSize};
    font-weight: ${theme.fontType.content1.bold};
    &::placeholder {
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%, -50%);
      color: ${theme.systemColors.bodyLighter};
      font-size: ${theme.fontType.content1.fontSize};
      font-weight: ${theme.fontType.content1.bold};
    }
  }
`;
// 제목
function ListTitle({ children }: { children: ReactNode }) {
  return <ListTitleContainer>{children}</ListTitleContainer>;
}
const ListTitleContainer = styled.h3`
  margin-bottom: 40px;
  display: flex;
  align-items: center;
  justify-content: flex-start;
  gap: 16px;
  font-size: ${theme.fontType.contentTitle1.fontSize};
  font-weight: ${theme.fontType.contentTitle1.bold};
  color: ${theme.colors.body2};
  & > span {
    font-size: ${theme.fontType.content1.fontSize};
    font-weight: ${theme.fontType.content1.bold};
    color: ${theme.systemColors.bodyLighter};
  }
  & > button {
    padding: 4px 16px;
    margin-left: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 4px;
    background: ${theme.systemColors.systemPrimary};
    color: white;
    border-radius: 67px;
    font-size: ${theme.fontType.subTitle1.fontSize};
    font-weight: ${theme.fontType.subTitle1.bold};
    & > svg {
      & > path {
        fill: white;
      }
    }
  }
`;
// 리스트들 ul
function InfoListContents({ children }: { children: ReactNode }) {
  return <InfoListContentsContainer>{children}</InfoListContentsContainer>;
}
const InfoListContentsContainer = styled.ul`
  width: 100%;
  height: 200px;
  padding: 16px;
  margin-top: 16px;
  position: relative;
  display: flex;
  flex-direction: column;
  gap: 8px;
  border: 1px solid ${theme.systemColors.blueDeep};
  border-radius: 5px;
  background-color: #fff;
  overflow-y: scroll;
  /* -ms-overflow-style: none; 
  scrollbar-width: none; 
  &::-webkit-scrollbar {
    display: none !important;
  } */
`;
/** 리스트 하나의 내용 li */
function InfoListContent({ children }: { children: ReactNode }) {
  return <InfoListContentContainer>{children}</InfoListContentContainer>;
}
const InfoListContentContainer = styled.div`
  width: 100%;
  height: 40px;
  display: flex;
  align-items: center;
  gap: 8px;
  color: ${theme.colors.body};
  border-radius: 5px;
  outline: none;
  font-weight: 400;
  background-color: ${theme.colors.blueGray2};
  & button {
    margin-top: 4px;
  }
`;
// 리스트 헤더
function Headers({ children }: { children: ReactNode }) {
  return <HeadersContainer>{children}</HeadersContainer>;
}
const HeadersContainer = styled.div`
  width: 100%;
  height: 100%;
  margin-bottom: 16px;
  display: flex;
  align-items: center;
  gap: 8px;
`;
// 리스트 헤더 속 내용
function Header({
  children,
  w,
  center = false,
  text,
}: {
  children?: ReactNode;
  w?: number;
  center?: boolean;
  text?: string;
}) {
  return (
    <HeaderContainer center={center} w={w}>
      {text && text}
      {children && children}
    </HeaderContainer>
  );
}
const HeaderContainer = styled.div<{ w?: number; center?: boolean }>`
  width: ${(props) => (props.w ? `${props.w}px` : "100%")};
  display: flex;
  height: 40px;
  align-items: center;
  ${(props) => props.center && "justify-content:center;"};
  ${(props) => !props.w && "flex:1;"};
  font-size: ${theme.fontType.subTitle1.fontSize};
  font-weight: ${theme.fontType.subTitle1.bold};
  color: ${theme.colors.body2};
`;
// 내용 없을 때 메시지
function NoContentMessage({ text }: { text: string }) {
  return <NoContentMessageContainer>{text}</NoContentMessageContainer>;
}
const NoContentMessageContainer = styled.p`
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  font-size: ${theme.fontType.content1.fontSize};
  font-weight: ${theme.fontType.content1.bold};
  color: ${theme.systemColors.bodyLighter2};
`;

InfoList.Title = ListTitle;
InfoList.Contents = InfoListContents;
InfoList.Content = InfoListContent;
InfoList.Headers = Headers;
InfoList.Header = Header;
InfoList.NoContentMessage = NoContentMessage;
