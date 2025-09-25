import { useRecoilValue, useResetRecoilState } from "recoil";
import styled from "styled-components";
import { contentModalState } from "../../modules/Client/Modal/Modal";
import theme from "../../theme";
import BigButton from "../Common/Button/BigButton";
import Overlay from "./Overlay";

export default function ContentModal() {
  const contentModal = useRecoilValue(contentModalState);
  const resetModal = useResetRecoilState(contentModalState);

  const onReset = () => {
    if (contentModal.onClose) contentModal.onClose();
    resetModal();
  };

  return (
    <Overlay>
      <ContentModalContainer>
        <h1>{contentModal?.title}</h1>
        <div className="subText">{contentModal.subText}</div>
        <div className="content">{contentModal.content}</div>
        {contentModal.onClick && !contentModal.type && (
          <div className="buttonContainer">
            <BigButton text="취소" onClick={onReset} white />
            <BigButton text={contentModal.buttonText || ""} onClick={contentModal.onClick} />
          </div>
        )}
        {contentModal.type !== "cancel" && contentModal.type && (
          <div className="buttonContainer">
            <BigButton text="확인" onClick={onReset} />
          </div>
        )}
        {contentModal.type === "cancel" && (
          <div className="buttonContainer">
            <BigButton text="취소" onClick={onReset} />
          </div>
        )}
      </ContentModalContainer>
    </Overlay>
  );
}

const ContentModalContainer = styled.div`
  background-color: #fff;
  padding: 40px;
  padding-top: 56px;
  display: flex;
  flex-direction: column;
  align-items: center;
  z-index: 00;
  border-radius: 22px;
  h1 {
    font-size: ${theme.fontType.title2.fontSize};
    font-weight: ${theme.fontType.title2.bold};
    color: ${theme.colors.body2};
  }
  .subText {
    font-weight: ${theme.fontType.contentTitle1.bold};
    font-size: ${theme.fontType.contentTitle1.fontSize};
    margin-top: 16px;
    white-space: pre-wrap;
    color: ${theme.colors.body};
  }
  .content {
    align-self: center;
  }
  .buttonContainer {
    display: flex;
    gap: 24px;
    margin-top: 50px;
  }
`;
