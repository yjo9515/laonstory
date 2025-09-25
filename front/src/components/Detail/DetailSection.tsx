import { HTMLAttributes, ReactNode } from "react";
import styled from "styled-components";
import theme from "../../theme";

// html 속성 props들을 상속받아 사용할 수 있다
interface CommentProps extends HTMLAttributes<HTMLDivElement> {
  text: string;
  children: ReactNode;
}

/**상세페이지의 구역 설정 컴포넌트 */
export function DetailSectionWrapper({ children }: { children: ReactNode }) {
  return <DetailSectionContainer>{children}</DetailSectionContainer>;
}
const DetailSectionContainer = styled.div`
  padding-bottom: 56px;
  margin-bottom: 56px;
  border-bottom: 1px solid ${theme.colors.blueDeep};
  display: flex;
  flex-direction: column;
  & > div {
    padding-right: 55px;
    padding-left: 24px;
    margin-left: 55px;
    border-left: 1px solid ${theme.colors.blueGray2};
  }
  &:last-child {
    border-bottom: none;
    margin-bottom: 0;
    padding-bottom: 0;
  }
  &:first-child {
    padding-bottom: 56px;
    border-bottom: 1px solid ${theme.colors.blueGray2};
  }
`;
/** 정보 구역의 제목 */
function DetailSectionTitle({
  children,
  text,
  message,
}: {
  children?: ReactNode;
  text?: string;
  message?: string;
}) {
  return (
    <TitleContainer>
      {text ? text : children}{" "}
      {message && (
        <span>
          ( <span style={{ color: "#DA0043" }}>*</span> {message} )
        </span>
      )}
    </TitleContainer>
  );
}
const TitleContainer = styled.h2`
  margin-bottom: 56px;
  display: flex;
  align-items: center;
  gap: 16px;
  font-size: ${theme.fontType.title3.fontSize};
  font-weight: ${theme.fontType.title3.bold};
  color: ${theme.colors.body};
  & > span {
    font-weight: ${theme.fontType.content1.bold};
    font-size: ${theme.fontType.content1.fontSize};
    color: ${theme.systemColors.bodyLighter2};
  }
`;
/** 라벨과 텍스트로 이루어진 정보 세트 */
function DetailSectionInfoSet({ labelText, children }: { labelText: string; children: ReactNode }) {
  return (
    <InfoSetContainer>
      <label>{labelText}</label>
      {children}
    </InfoSetContainer>
  );
}
const InfoSetContainer = styled.div`
  display: flex;
  align-items: center;
  margin-bottom: 24px;
  & > label {
    width: 130px;
    color: ${theme.colors.body2};
    font-weight: ${theme.fontType.contentTitle1.bold};
    font-size: ${theme.fontType.contentTitle1.fontSize};
  }
  & > span {
    width: 100%;
    flex: 1;
    color: ${theme.colors.body};
    font-weight: ${theme.fontType.content1.bold};
    font-size: ${theme.fontType.content1.fontSize};
  }
  &:last-child {
    margin-bottom: 0px;
  }
`;
/** 회색 바탕의 정보 비활성화 처리된 정보 */
function DetailSectionInfoBlock({
  text,
  onClick,
  labelText,
  children,
}: {
  text?: string;
  onClick?: () => void;
  labelText?: string;
  children?: ReactNode;
}) {
  return (
    <InfoBlockContainer>
      {labelText && <label>{labelText}</label>}
      <span onClick={onClick}>{text || children}</span>
    </InfoBlockContainer>
  );
}
const InfoBlockContainer = styled.div`
  & > label {
    margin-bottom: 16px;
    display: block;
    font-size: ${theme.fontType.contentTitle1.fontSize};
    font-weight: ${theme.fontType.contentTitle1.bold};
    color: ${theme.systemColors.bodyLighter};
  }
  & > span {
    width: 100%;
    height: 47px;
    padding: 0px 24px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex: 1;
    font-size: ${theme.fontType.subTitle1.fontSize};
    font-weight: ${theme.fontType.subTitle1.bold};
    line-height: 47px;
    border-radius: 5px;
    outline: none;
    color: ${theme.colors.body};
    background-color: ${theme.colors.blueGray2};
    cursor: pointer;
    & > img {
      display: block;
      width: 24px;
      height: 24px;
    }
  }
`;

export const DetailSection = Object.assign(DetailSectionWrapper, {
  Title: DetailSectionTitle,
  InfoSet: DetailSectionInfoSet,
  InfoBlock: DetailSectionInfoBlock,
});
