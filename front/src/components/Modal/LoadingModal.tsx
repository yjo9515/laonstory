import { useEffect } from "react";
import { useRecoilValue, useResetRecoilState } from "recoil";
import styled from "styled-components";
import { loadingModalState } from "../../modules/Client/Modal/Modal";
import BigButton from "../Common/Button/BigButton";
import { BlockChain, Loading } from "../Common/Loading/Loading";
import Overlay from "./Overlay";

export default function LoadingModal() {
  const loadingModal = useRecoilValue(loadingModalState);
  const resetModal = useResetRecoilState(loadingModalState);

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

  return (
    <Overlay>
      {!loadingModal.bg ? (
        <OnlyLoadingContainer>
          {loadingModal.type === "default" && <Loading />}
          {loadingModal.type === "block" && <BlockChain />}
          {loadingModal.subText && (
            <div className={`subText ${loadingModal.type === "default" ? "default" : ""}`}>
              {loadingModal.subText}
            </div>
          )}
          {!loadingModal.subText && (
            <p className={`rhombus ${loadingModal.type === "default" ? "default" : ""}`}>
              잠시만 기다려 주세요.
            </p>
          )}
          {/* {loadingModal.isButton && (
            <div className="buttonContainer">
              <BigButton text="취소" onClick={resetModal} white />
              <BigButton
                text={loadingModal.buttonText || "확인"}
                onClick={loadingModal.onClick || resetModal}
              />
            </div>
          )} */}
        </OnlyLoadingContainer>
      ) : (
        <LoadingContainer>
          {loadingModal.subText && <p className="subText">{loadingModal.subText}</p>}
          {loadingModal.isButton && (
            <div className="buttonContainer">
              <BigButton text="취소" onClick={resetModal} white />
              <BigButton
                text={loadingModal.buttonText || "확인"}
                onClick={loadingModal.onClick || resetModal}
              />
            </div>
          )}
        </LoadingContainer>
      )}
    </Overlay>
  );
}

const OnlyLoadingContainer = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  /* margin-top: -200px; */
  & .subText {
    color: white;
    text-align: center;
    white-space: pre-wrap;
    & > h1 {
      font-size: 30px;
      font-weight: 700;
      margin-bottom: 16px;
    }
  }
  .buttonContainer {
    margin: 0 auto;
    margin-top: 60px;
    display: flex;
    gap: 16px;
    > Button {
      width: 169px;
      height: 54px;
      color: white;
      border: 1px solid rgba(218, 221, 229, 0.2);
      box-shadow: 0px 4px 4px -2px rgba(0, 0, 0, 0.1);
      border-radius: 61px;
      &:first-child {
        background: #35629d;
      }
      &:last-child {
        background: #5fa4f2;
      }
    }
  }
  & > .rhombus {
    text-align: center;
    color: #fff;
  }
  & > .default {
    margin-top: -60px;
  }
`;

const LoadingContainer = styled.div`
  width: 496px;
  height: 524px;
  background-color: #fff;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: center;
  z-index: 00;
  border-radius: 10px;
  .svg {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 32px;
    width: 220px;
    height: 220px;
  }
  .subText {
    margin-top: 13px;
    height: 46px;
    display: block;
    text-align: center;
    white-space: pre-wrap;
    line-height: 23px;
    font-size: 16px;
  }
  .buttonContainer {
    margin-top: 114px;
    display: flex;
    gap: 16px;
    > Button {
      width: 169px;
      height: 54px;
      color: white;
      border: 1px solid rgba(218, 221, 229, 0.2);
      box-shadow: 0px 4px 4px -2px rgba(0, 0, 0, 0.1);
      border-radius: 61px;
      &:first-child {
        background: #35629d;
      }
      &:last-child {
        background: #5fa4f2;
      }
    }
  }
`;
