import { useEffect } from "react";
import { useRecoilValue, useResetRecoilState } from "recoil";
import styled from "styled-components";
import { alertModalState } from "../../modules/Client/Modal/Modal";
import theme from "../../theme";
import InputButton from "../Common/Button/InputButton";
import { Confirm, Loading } from "../Common/Loading/Loading";
import Overlay from "./Overlay";

// 전역으로 사용되는 Alert Modal
// Alert Modal Atom에 값이 들어가면 보여주고 아니면 null 반환
// 버튼은 기본적으로 Atom의 값을 비우는 onClick 함수를 가지고 있음
export default function AlertModal() {
  const alertModal = useRecoilValue(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);

  // 키보드 동작 막기
  useEffect(() => {
    const a = (e: Event) => {
      e.preventDefault();
    };
    window.addEventListener("keydown", a);
    return () => {
      window.removeEventListener("keydown", a);
    };
  }, []);

  const onCheckFn = () => {
    if (alertModal.onClick) alertModal.onClick();
    resetAlertModal();
  };

  return (
    <>
      {alertModal.isModal ? (
        <Overlay>
          <AlertModalContainer>
            <h1>{alertModal.title || "안내"} </h1>
            {alertModal.isBlock && (
              <div className="confirm">
                <Loading />
              </div>
            )}
            {alertModal.isLoading && (
              <div className="confirm">
                <Confirm />
              </div>
            )}
            <div className="content">{alertModal.content}</div>
            {alertModal.buttonText && alertModal.onClick && (
              <div className="buttonContainer">
                <InputButton cancel text={alertModal.buttonText} onClick={alertModal.onClick} />
                <InputButton onClick={resetAlertModal} text="확인" />
              </div>
            )}
            {alertModal.type === "check" && alertModal.onClick && (
              <InputButton onClick={onCheckFn} text="확인" />
            )}
            {alertModal.onClick && !alertModal.type && !alertModal.buttonText && (
              <div className="buttonContainer">
                <InputButton cancel text="취소" onClick={resetAlertModal} />
                <InputButton onClick={alertModal.onClick} text="확인" />
              </div>
            )}
            {!alertModal.onClick && <InputButton onClick={resetAlertModal} text="확인" />}
          </AlertModalContainer>
        </Overlay>
      ) : null}
    </>
  );
}
const AlertModalContainer = styled.div`
  width: 610px;
  background-color: #fff;
  padding: 40px 40px 32px 40px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  gap: 40px;
  border-radius: 22px;  
  h1 {
    color: ${theme.colors.body2};
    font-weight: 700;
    font-size: 20px;
  }
  .content {
    white-space: pre-wrap;
    text-align: center;
    color: ${theme.colors.body};
    font-weight: 500;
    font-size: 15px;    
    overflow: auto;
    width: 100%;
    word-wrap: break-word;
  }
  .confirm {
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .buttonContainer {
    display: flex;
    gap: 24px;
  }
`;
