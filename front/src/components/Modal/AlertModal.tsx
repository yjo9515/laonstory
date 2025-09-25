import { useEffect, useState } from "react";
import {useNavigate } from "react-router";
import { useRecoilValue, useResetRecoilState } from "recoil";
import styled from "styled-components";
import { alertModalState } from "../../modules/Client/Modal/Modal";
import theme from "../../theme";
import AlertIcon from "./../../assets/Icon/alert.svg";

import BigButton from "../Common/Button/BigButton";
import { MainTitle } from "../Common/MainTitle";
import Overlay from "./Overlay";
import { debounce } from "lodash";

// 전역으로 사용되는 Alert Modal
// Alert Modal Atom에 값이 들어가면 보여주고 아니면 null 반환
// 버튼은 기본적으로 Atom의 값을 비우는 onClick 함수를 가지고 있음
export default function AlertModal() {
  const alertModal = useRecoilValue(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const navigate = useNavigate();

  // 키보드 동작 막기
  useEffect(() => {
    if(alertModal.type !== "logCheck"){
      const a = (e: Event) => {
        e.preventDefault();
      };
      window.addEventListener("keydown", a);
      return () => {
        window.removeEventListener("keydown", a);
      };
    }    
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
            <div className="title">
              {(alertModal.type === "error" || alertModal.type === "nextFlow") && (
                <img src={AlertIcon} alt="" />
              )}
              <h1>{alertModal.title || "안내"}</h1>
            </div>
            
            <div>{alertModal.content}</div>

            {alertModal.type === "check" && alertModal.onClick && (
              <BigButton
                onClick={debounce(() => {
                  onCheckFn();
                }, 500)}
                text="확인"
              />
            )}

            {alertModal.onClick && !alertModal.type && (
              <div className="buttonContainer">
                <BigButton text="취소" onClick={resetAlertModal} white />
                <BigButton
                  onClick={debounce(() => {
                    if (alertModal.onClick) alertModal.onClick();
                  }, 500)}
                  text="확인"
                />
              </div>
            )}

            {(alertModal.type === "error" || alertModal.type === "nextFlow") && (
              <>
                {alertModal.type === "error" && (
                  <>
                    {alertModal.onClick && (
                      <div className="buttonContainer">
                        <BigButton text="취소" onClick={resetAlertModal} white />
                        <BigButton
                          onClick={debounce(() => {
                            if (alertModal.onClick) alertModal.onClick();
                          }, 500)}
                          text="확인"
                        />
                      </div>
                    )}
                  </>
                )}
                {alertModal.type === "nextFlow" && (
                  <>
                    <BigButton
                      onClick={debounce(() => {
                        onCheckFn();
                      }, 500)}
                      bgColor={theme.systemColors.closeTimer}
                      text={alertModal.buttonText ? alertModal.buttonText : "다음"}
                    />
                  </>
                )}
              </>
            )}

            {alertModal.onClick && alertModal.type === "logCheck" && (
              <div className="buttonContainer">
                <BigButton text="취소" onClick={()=>{
                  resetAlertModal();
                  navigate(`/west/system/dashboard`, { replace: true });
                }} white />
                <BigButton
                  onClick={debounce(() => {
                    if (alertModal.onClick) alertModal.onClick();
                  }, 500)}
                  text="확인"
                />
              </div>
            )}
            {!alertModal.onClick && (
              <BigButton
                onClick={debounce(() => {
                  resetAlertModal();
                }, 500)}
                bgColor={alertModal.type === "error" ? theme.systemColors.closeTimer : ""}
                text="확인"
              />
            )}
          </AlertModalContainer>
        </Overlay>
      ) : null}
    </>
  );
}
const AlertModalContainer = styled.div`
  width: 610px;
  height: 361px;
  background-color: #fff;
  padding: 40px 0px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  border-radius: 10px;
  .title {
    display: flex;
    justify-content: center;
    & > img {
      margin-right: 10px;
    }
  }
  h1 {
    font-size: ${theme.fontType.title2.fontSize};
    font-weight: ${theme.fontType.title2.bold};
    color: ${theme.colors.body2};
  }
  p {
    white-space: pre-wrap;
    text-align: center;
    /* font-size: ${theme.fontType.contentTitle1.fontSize}; */
    /* font-weight: ${theme.fontType.contentTitle1.bold}; */
    font-size: 16px;
    color: ${theme.colors.body};
  }
  .buttonContainer {
    display: flex;
    gap: 24px;
  }
`;
