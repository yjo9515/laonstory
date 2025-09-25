import React, { useEffect, useState } from "react";
import styled from "styled-components";
import theme from "../../theme";
import BigButton from "../Common/Button/BigButton";
import Overlay from "../Modal/Overlay";
import parse from "html-react-parser";
import ReactPlayer from "react-player";

import step1 from "../../assets/WebexStep/step1.svg";
import step2 from "../../assets/WebexStep/step2.svg";
import step3 from "../../assets/WebexStep/step3.svg";

import adminStep1 from "../../assets/WebexStep/adminStep1.svg";
import adminStep2 from "../../assets/WebexStep/adminStep2.svg";
import webexArrowIcon from "./../../assets/Icon/webexArrowIcon.svg";
import webexGif from "./../../assets/WebexStep/Block_tuto_02.gif";
import blockTuto720p from "./../../assets/WebexStep/Block_tuto_720p.mp4";

interface EvaluationWebexStepModalInterface {
  role: string;
  url: string;
  onClose: () => void;
}

function EvaluationWebexStepModal(props: EvaluationWebexStepModalInterface) {
  const [step, setStep] = useState<number>(1);

  const [videoReady, setVideoReady] = useState<boolean>(false);

  const [internalCheck, setInternalCheck] = useState<"OUTSIDE" | "INTERNAL">("OUTSIDE");

  useEffect(() => {
    if (blockTuto720p) {
      setVideoReady(true);
    }
  }, [blockTuto720p]);

  useEffect(() => {
    if (process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL")
      setInternalCheck(process.env.REACT_APP_SOURCE_DISTRIBUTE);
  }, []);

  const onNextStep = () => {
    let next = step + 1;

    if (props.role !== "admin") {
      window.open(props.url, "_blank", "noopener,noreferrer");
      return;
    }

    if (props.role === "admin") {
      window.open(props.url, "_blank", "noopener,noreferrer");
      return;
    }

    // setStep(next);
  };

  const onPrevStep = () => {
    let prev = step - 1;

    if (prev < 1) {
      return;
    }

    setStep(prev);
  };

  return (
    <Overlay>
      <EvaluationWebexStepModalBlock>
        <h1>화상평가 이용 안내</h1>
        <div className="subText">
          {props.role === "admin" ? (
            <>
              <span>
                아래의 <span className="point">'화상평가 시작'</span> 버튼을 클릭하면 webex
                프로그램이 실행됩니다.
              </span>
              <span className="pointRed">
                * 프로그램이 설치되어 있지 않은 경우 설치 안내 페이지로 이동합니다.
              </span>
            </>
          ) : (
            <>
              <span>
                아래의 <span className="point">'화상평가 시작'</span> 버튼을 클릭하면 새 창 또는 새
                탭에서 webex 페이지가 열립니다.
              </span>
              <span className="pointRed">
                * 익명 이용을 위해 브라우저에서 사용해 주세요. (설치된 프로그램 사용 금지)
              </span>
            </>
          )}
        </div>
        {props.role !== "admin" && (
          <>
            <div className="contentAdmin" style={{ marginBottom: 0 }}>
              <PlayerWrapper>
                {!videoReady && (
                  <div className="notLoadVideo">
                    <p>
                      영상을 불러오는데 실패하였습니다.
                      <br />
                      화면을 닫은 후 다시 열어주세요.
                    </p>
                  </div>
                )}
                {videoReady && (
                  <ReactPlayer
                    className="react-player"
                    url={blockTuto720p}
                    width="100%"
                    height="100%"
                    muted={true} //chrome정책으로 인해 자동 재생을 위해 mute 옵션을 true로 해주었다.
                    playing={true}
                    controls={true}
                    loop={false}
                    config={{
                      file: {
                        attributes: {
                          controlsList: "nodownload",
                          onContextMenu: (e: any) => e.preventDefault(),
                        },
                      },
                    }}
                  />
                )}
              </PlayerWrapper>
              {/* <div className="webexGif">
                <img src={webexGif} alt="" />
              </div>
              <div className="webexGifGuide">
                <div style={{ textAlign: "left" }}>
                  1. 페이지 하단에서{" "}
                  <span className="point pointUnderLine">'브라우저에서 참여하십시오'</span>를 클릭해
                  주세요.
                </div>
                <div style={{ textAlign: "left" }}>
                  2. <span className="point pointUnderLine">'내 이름'</span>과{" "}
                  <span className="point pointUnderLine">'미팅비밀번호'</span>를 입력해 주세요.
                </div>
                <div>
                  <span>
                    3. 카메라와 마이크를 사용할 수 있도록 권한 요청을 <span>'허용'</span>해 주세요.
                  </span>
                </div>
                <div>
                  <span>
                    4. 오디오와 비디오 설정 후 <span>'미팅 참여'</span>버튼을 누르세요.
                  </span>
                  <br />
                  <span className="pointRed">
                    * 평가담당자의 입장 수락 후 화상평가를 이용하실 수 있습니다.
                  </span>
                </div>
              </div> */}
              {/* <div className="contentBox" style={{ width: "450px" }}>
                <div className="imgBox">
                  <img src={step1} alt="" />
                </div>
                <div className="textBox" style={{ height: "100px" }}>
                  <div style={{ textAlign: "left" }}>
                    1. 페이지 하단에서{" "}
                    <span className="point pointUnderLine">'브라우저에서 참여하십시오'</span>를
                    클릭해 주세요.
                  </div>
                  <span className="pointRed" style={{ fontSize: "14px", fontWeight: 900 }}>
                    * 프로그램 설치 및 설치된 프로그램을 사용하면 안됩니다.
                  </span>
                </div>
              </div>
              <div className="centerArrow">
                <img src={webexArrowIcon} alt="" />
              </div>
              <div className="contentBox" style={{ width: "555px" }}>
                <div className="imgBox">
                  <img src={step2} alt="" />
                </div>
                <div className="textBox" style={{ height: "100px" }}>
                  <div style={{ textAlign: "left" }}>
                    2. 평가방/화상평가 정보의{" "}
                    <span className="point pointUnderLine">'내 이름'</span>과{" "}
                    <span className="point pointUnderLine">'미팅비밀번호'</span>를 입력해 주세요.
                  </div>
                  <span className="pointRed" style={{ fontSize: "14px" }}>
                    * 프로그램 설치 및 설치된 프로그램을 사용하면 안됩니다.
                  </span>
                </div>
              </div> */}
            </div>
            {/* <div className="contentBottom">
              <div>
                <img src={step3} alt="" />
              </div>
              <div>
                <div>
                  <span>
                    3. 카메라와 마이크를 사용할 수 있도록 권한 요청을 <span>'허용'</span>해 주세요.
                  </span>
                </div>
                <div>
                  <span>
                    4. 오디오와 비디오 설정 후 <span>'미팅 참여'</span>버튼을 누르세요.
                  </span>
                  <span className="pointRed">
                    * 평가담당자의 입장 수락 후 화상평가를 이용하실 수 있습니다.
                  </span>
                </div>
              </div>
            </div> */}
            <div className="buttonContainer">
              <BigButton text="닫기" onClick={props.onClose} white />
              <BigButton text={"화상평가 시작"} onClick={onNextStep} />
            </div>
            <div className="adminSubGuide">* webex 완료 후 닫기 버튼을 눌러주세요.</div>
          </>
        )}
        {props.role === "admin" && (
          <>
            <div className="contentAdmin">
              <div className="contentBox">
                <div className="imgBox">
                  <img src={adminStep1} alt="" />
                </div>
                <div className="textBox">
                  <div className="severalLines emphasis">
                    <span style={{ marginBottom: "10px" }}>
                      webex 프로그램이 실행되면 로그인을 진행해 주세요.
                    </span>
                    <span className="strong">이메일 주소 : webex01@iwest.co.kr</span>
                    <span className="strong">비밀번호 : TJQNghktkd1!</span>
                  </div>
                  <span>* 이미 로그인이 되어 있는 경우 미팅 대기화면에서 시작됩니다.</span>
                </div>
              </div>
              <div className="centerArrow">
                <img src={webexArrowIcon} alt="" />
              </div>
              <div className="contentBox">
                <div className="imgBox">
                  <img src={adminStep2} alt="" />
                </div>
                <div className="textBox center">
                  <div>
                    오디오와 비디오 설정 후 <span className="strong">'미팅시작'</span>버튼을
                    누르세요.
                    <br />
                    평가 참여자의 입장 요청 시 수락하여 화상평가를 진행해 주세요.
                  </div>
                </div>
              </div>
            </div>
            <div className="buttonContainer">
              {step === 2 && <BigButton text="이전" onClick={onPrevStep} white />}
              <BigButton text="닫기" onClick={props.onClose} white />
              <BigButton text={"화상평가 시작"} onClick={onNextStep} />
            </div>
            <div className="adminSubGuide">
              * webex 프로그램 실행 완료 후 닫기 버튼을 눌러주세요.
            </div>
          </>
        )}
      </EvaluationWebexStepModalBlock>
    </Overlay>
  );
}

export default EvaluationWebexStepModal;

const EvaluationWebexStepModalBlock = styled.div`
  background-color: #fff;
  padding: 40px;
  /* padding-top: 40px; */
  display: flex;
  flex-direction: column;
  align-items: center;
  z-index: 00;
  /* border-radius: 22px; */
  min-width: 1250px;
  max-height: 90%;
  height: auto;
  /* overflow-y: scroll; */
  h1 {
    font-weight: 700;
    font-size: 20px;
    color: ${theme.colors.body2};
  }
  .buttonContainer {
    display: flex;
    gap: 24px;
    /* margin-top: 36px; */
  }
  .subText {
    font-weight: 500;
    font-size: 16px;
    margin-top: 16px;
    white-space: pre-wrap;
    color: ${theme.colors.body};
    text-align: center;
    display: flex;
    flex-direction: column;
  }
  .guideInfo {
    height: 100px;
  }
  .isAdmin {
    width: 100%;
    height: auto;
    display: flex;
    justify-content: space-between;
    & > div {
      width: calc(100% / 2);
      height: 100px;
    }
  }
  .content {
    height: 340px;
    padding-top: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;

    & > img {
      height: 320px;
      object-fit: contain;
    }
    .buttonContainer {
      /* margin-top: 50px; */
    }
  }
  .contentAdmin {
    display: flex;
    justify-content: center;
    align-items: center;
    /* gap: 40px; */
    margin-top: 24px;
    margin-bottom: 24px;
    & > .webexGif {
      width: 100%;
      border: 1px solid black;
      min-width: 640px;
      min-height: 360px;
      margin-bottom: 30px;
      /* width: 500px; */
      & > img {
        width: 100%;
        object-fit: contain;
      }
    }
    & > .webexGifGuide {
      margin-left: 30px;
      width: 700px;
      /* background-color: pink; */
      & > div {
        margin-bottom: 14px;
      }
    }
    & > .contentBox {
      width: 500px;
      min-height: 300px;
      & > .imgBox {
        min-height: 270px;
        & > img {
          width: 100%;
          object-fit: contain;
        }
      }
      & > .textBox {
        height: 130px;
        margin-top: 10px;
        font-weight: 200;
        color: #425061;
        & > div {
          text-align: center;

          & > .strong {
            color: #2a3748;
            font-weight: 900;
            font-size: 17px;
          }
        }
        & > .severalLines {
          display: flex;
          flex-direction: column;
          text-align: left;
        }
        & > .emphasis {
          border: 4px solid #ff0000;
          padding: 6px;
          margin-bottom: 6px;
        }

        & > span {
          font-size: 12px;
        }
      }
      & > .center {
        display: flex;
        justify-content: center;
        align-items: center;
      }
    }
    & > .centerArrow {
      width: 100px;
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
    }
  }
  .contentBottom {
    width: 1100px;
    display: flex;
    justify-content: space-between;
    margin-bottom: 30px;
    & > div:nth-child(1) {
      width: 550px;
      & > img {
        width: 100%;
        object-fit: contain;
      }
    }
    & > div:nth-child(2) {
      width: 500px;
      /* background-color: pink; */
      & > div {
        margin-top: 30px;

        & > span {
          display: block;
          & > span {
            font-weight: 900;
          }
        }
        & > span:nth-child(1) {
          font-size: 16px;
        }
        & > span:nth-child(2) {
          font-size: 14px;
        }
      }
    }
  }
  .adminSubGuide {
    width: 100%;
    font-size: 14px;
    text-align: center;
    padding-top: 10px;
    font-weight: 900;
  }
  .point {
    font-weight: 900 !important;
    font-size: 16px;
  }

  .pointRed {
    color: #ff0000;
  }

  .pointUnderLine {
    text-decoration: underline;
  }
`;

const PlayerWrapper = styled.div`
  width: 817px;
  height: 460px;
  margin-bottom: 20px;
  border: 1px solid black;
  & > .notLoadVideo {
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 20px;
    color: ${theme.systemColors.bodyLighter2};
  }
`;
