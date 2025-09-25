import styled from "styled-components";
import theme from "../../theme";
import { ScrollContainer } from "./Container/ScrollContainer";
import { CheckBox } from "./Input/CheckBox";

// scroll set 컨테이너
export default function ScrollSet({
  title, //제목
  text, // 스크롤 해야할 텍스트 (약관 같은)
  agreeText, //체크 박스 옆에 문구
  register, // 체크 여부 확인 위한 input controller
}: {
  title: string;
  text: string;
  register?: any;
  agreeText?: string;
}) {
  return (
    <ScrollSetContainer>
      <h2>{title}</h2>
      <div className="textContainer">
        <ScrollContainer text={text} />
      </div>
      {(register || agreeText) && (
        <div className="agreeContainer">
          {agreeText && <p>{agreeText}</p>}
          {register && <CheckBox register={register} />}
        </div>
      )}
    </ScrollSetContainer>
  );
}
const ScrollSetContainer = styled.div`
  .textContainer {
    padding: 16px 8px 0px 24px;
    height: 240px;
    border: 1px solid #cbd3e5;
    border-radius: 5px;
    font-size: ${theme.fontType.body1.fontSize};
    color: ${theme.fontType.body1.color};
  }
  h2 {
    margin-bottom: 32px;
    line-height: 23px;
    font-size: ${theme.fontType.title3.fontSize};
    font-weight: ${theme.fontType.title3.bold};
    color: ${theme.fontType.title3.color};
  }
  .agreeContainer {
    margin-top: 19px;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 16px;
    font-size: ${theme.fontType.body1.fontSize};
    color: ${theme.fontType.body1.color};
  }
`;
