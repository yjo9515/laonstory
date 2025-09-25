import { useEffect } from "react";
import { useLocation } from "react-router";
import { useRecoilValue, useResetRecoilState } from "recoil";
import styled from "styled-components";
import { loadingModalState } from "../../modules/Client/Modal/Modal";
import theme from "../../theme";
import InputButton from "../Common/Button/InputButton";
import { BlockChain, Finger, Loading } from "../Common/Loading/Loading";
import Overlay from "./Overlay";

export default function LoadingModal() {
  const loadingModal = useRecoilValue(loadingModalState);
  const resetModal = useResetRecoilState(loadingModalState);
  const path = useLocation().pathname;

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
      {loadingModal.isFinger && (
        <LoadingContainer>
          <h1>지문인증 중...</h1>
          <div className="icon">
            <Finger />
          </div>
          {loadingModal.subText && <p className="subText">{loadingModal.subText}</p>}
          <div className="buttonContainer">
            <InputButton text="취소" onClick={resetModal} />
          </div>
        </LoadingContainer>
      )}
      {loadingModal.isBlockChain && (
        <LoadingBoxContainer>
          <BlockChain />
          <p>
            잠시만 기다려주세요.
            <br />곧 결과를 안내해드리겠습니다.
          </p>
        </LoadingBoxContainer>
      )}
      {!loadingModal.isFinger && !loadingModal.isBlockChain && (
        <LoadingBoxContainer>
          <Loading />
          <p className="rhombus">잠시만 기다려 주세요.</p>
        </LoadingBoxContainer>
      )}
    </Overlay>
  );
}

const LoadingContainer = styled.div`
  width: 610px;
  padding: 40px 40px 32px 40px;
  background-color: #fff;
  display: flex;
  flex-direction: column;
  align-items: center;
  z-index: 00;
  border-radius: 10px;
  h1 {
    font-weight: 700;
    font-size: 20px;
    line-height: 29px;
    color: ${theme.colors.body2};
  }

  .subText {
    margin-top: 13px;
    height: 46px;
    display: block;
    text-align: center;
    white-space: pre-wrap;
    line-height: 23px;
    font-size: 16px;
    color: ${theme.colors.body};
  }
  .buttonContainer {
    margin-top: 70px;
    display: flex;
  }
`;

const LoadingBoxContainer = styled.div`
  width: auto;
  height: auto;
  text-align: center;
  & > p {
    color: #fff;
  }
  & > .rhombus {
    margin-top: -60px;
  }
`;
