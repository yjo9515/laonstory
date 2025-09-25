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
    height: 210px;
  }
  h2 {
    color: ${theme.colors.body2};
    margin-bottom: 32px;
    font-weight: 500;
    font-size: 16px;
    line-height: 23px;
  }
  .agreeContainer {
    margin-top: 19px;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 16px;
    font-size: 13px;
  }
`;
