import { useRecoilValue, useResetRecoilState } from "recoil";
import styled from "styled-components";
import { contentModalState } from "../../modules/Client/Modal/Modal";
import theme from "../../theme";
import InputButton from "../Common/Button/InputButton";
import Overlay from "./Overlay";

export default function ContentModal() {
  const contentModal = useRecoilValue(contentModalState);
  const resetModal = useResetRecoilState(contentModalState);
  return (
    <Overlay>
      <ContentModalContainer>
        {contentModal.title && <h1>{contentModal.title}</h1>}
        <div className="subText">{contentModal.subText}</div>
        <div className="content">{contentModal.content}</div>
        {contentModal.onClick && !contentModal.type && (
          <div className="buttonContainer">
            <InputButton text="취소" onClick={resetModal} />
            <InputButton text={contentModal.buttonText || ""} onClick={contentModal.onClick} />
          </div>
        )}
        {contentModal.onClick && contentModal.type && (
          <div className="buttonContainer">
            <InputButton text={contentModal.buttonText || ""} onClick={contentModal.onClick} />
          </div>
        )}
        {!contentModal.onClick && contentModal.type !== "cancel" && contentModal.type && (
          <div className="buttonContainer">
            <InputButton text="확인" onClick={resetModal} />
          </div>
        )}
        {!contentModal.onClick && contentModal.type === "cancel" && (
          <div className="buttonContainer">
            <InputButton text="취소" onClick={resetModal} />
          </div>
        )}
      </ContentModalContainer>
    </Overlay>
  );
}

const ContentModalContainer = styled.div`
  background-color: #fff;
  padding: 40px 40px 32px 40px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  border-radius: 10px;
  & > h1 {
    font-weight: 700;
    font-size: 20px;
    line-height: 29px;
    color: ${theme.colors.body2};
  }
  .buttonContainer {
    margin-top: 48px;
    display: flex;
    justify-content: center;
    gap: 16px;
  }
  .subText {
    margin-top: 16px;
    margin-bottom: 29px;
    color: ${theme.colors.body};
    font-weight: 500;
    font-size: 14px;
    white-space: pre-wrap;
  }
  .content {
    width: 100%;
    height: 100%;
  }
`;
