import { useEffect, useRef, useState } from "react";
import styled from "styled-components";
import FileViewer from "../components/Viewer/FileViewer";
import theme from "../theme";
import html2canvas from "html2canvas"; // domToImage 대신 html2canvas 사용
import { alertModalState, loadingModalState } from "../modules/Client/Modal/Modal";
import { useResetRecoilState, useSetRecoilState } from "recoil";

interface DrawingImageProps {
  url: string;
  changeShow: () => void;
  file: { name: string; path: string };
  onSaveData: (file: any) => void;
}

export const DrawingImage = (props: DrawingImageProps) => {
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const setLoadingModal = useSetRecoilState(loadingModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const [imageData, setImageData] = useState<any>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const printRef = useRef<HTMLDivElement>(null);
  const inRef = useRef<HTMLDivElement>(null);
  const imgRef = useRef<HTMLImageElement>(null); // 이미지용 별도 ref 추가
  const [isDrawing, setIsDrawing] = useState(false);

  const fileTypeCheck = (fileName: string): string => {
    const lowerName = fileName.toLowerCase();
    if (lowerName.includes(".png")) return "png";
    if (lowerName.includes(".jpg")) return "jpg";
    if (lowerName.includes(".jpeg")) return "jpeg";
    if (lowerName.includes(".pdf")) return "pdf";
    return "";
  };

  const fileType: string = fileTypeCheck(props.file.name);

  // 개선된 이미지 캡처 함수
  const clickPrint = async () => {
    try {
      const printContent = printRef.current;
      if (!printContent) {
        console.error("캡처할 요소를 찾을 수 없습니다.");
        return;
      }

      setLoadingModal({
        isButton: false,
        isModal: true,
      });

      // 테두리 숨기기
      if (inRef.current) {
        inRef.current.classList.add('no-border');
      }
      if (imgRef.current) {
        imgRef.current.classList.add('no-border');
      }

      // html2canvas를 사용한 캡처
      const canvas = await html2canvas(printContent, {
        scale: 2,
        useCORS: true,
        allowTaint: false,
        backgroundColor: '#ffffff',
        ignoreElements: (element) => {
          // iframe이나 외부 위젯 제외
          return element instanceof HTMLIFrameElement || 
                 element.classList?.contains("external-widget");
        },
        onclone: (clonedDoc) => {
          // 클론된 문서에서 스타일 정리
          const style = clonedDoc.createElement('style');
          style.textContent = `
            .no-border { border: 0 !important; }
            .no-capture { display: none !important; }
          `;
          clonedDoc.head.appendChild(style);
          return clonedDoc;
        }
      });

      // Canvas를 Blob으로 변환 (더 효율적)
      const blob = await new Promise<Blob | null>((resolve) => {
        canvas.toBlob(resolve, 'image/jpeg', 0.95);
      });

      if (blob) {
        const file = new File([blob], "file.jpeg", { type: "image/jpeg" });
        props.onSaveData(file);
      }

      // 테두리 복원
      if (inRef.current) {
        inRef.current.classList.remove('no-border');
      }
      if (imgRef.current) {
        imgRef.current.classList.remove('no-border');
      }

      resetLoadingModal();

    } catch (error) {
      console.error("이미지 생성 실패:", error);
      
      // 에러 발생 시에도 스타일 복원
      if (inRef.current) {
        inRef.current.classList.remove('no-border');
      }
      if (imgRef.current) {
        imgRef.current.classList.remove('no-border');
      }
      
      resetLoadingModal();
      
      // 사용자에게 에러 알림
      setAlertModal({
        isModal: true,
        content: "이미지 생성에 실패했습니다. 다시 시도해주세요.",
      });
    }
  };

  // Canvas 초기화 및 이벤트 리스너 개선
  useEffect(() => {
    setIsDrawing(false);
    const canvas = canvasRef.current;
    if (!canvas) return;

    const ctx = canvas.getContext("2d");
    if (!ctx) return;

    const CANVAS_WIDTH = 790;
    const CANVAS_HEIGHT = 1109;

    canvas.width = CANVAS_WIDTH;
    canvas.height = CANVAS_HEIGHT;
    ctx.lineWidth = 10;
    ctx.lineCap = "round";
    ctx.strokeStyle = "#000000"; // 기본 색상 설정
    
    let isPainting = false;
    let isFilling = false;

    // 마우스 이벤트 핸들러들
    const onMove = (event: MouseEvent) => {
      if (isPainting) {
        ctx.lineTo(event.offsetX, event.offsetY);
        ctx.stroke();
        setIsDrawing(true);
        return;
      }
      ctx.moveTo(event.offsetX, event.offsetY);
    };

    const startPainting = (event: MouseEvent) => {
      isPainting = true;
      ctx.beginPath();
      ctx.moveTo(event.offsetX, event.offsetY);
    };

    const cancelPainting = () => {
      isPainting = false;
      ctx.beginPath();
    };

    const onCanvasClick = () => {
      if (isFilling) {
        ctx.fillRect(0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);
      }
    };

    const resetPainting = () => {
      ctx.clearRect(0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);
      canvas.width = CANVAS_WIDTH;
      canvas.height = CANVAS_HEIGHT;
      ctx.lineWidth = 10;
      ctx.lineCap = "round";
      ctx.strokeStyle = "#000000";
      isPainting = false;
      isFilling = false;
      setIsDrawing(false);
    };

    // 이벤트 리스너 등록
    canvas.addEventListener("mousemove", onMove);
    canvas.addEventListener("mousedown", startPainting);
    canvas.addEventListener("mouseup", cancelPainting);
    canvas.addEventListener("mouseleave", cancelPainting);
    canvas.addEventListener("click", onCanvasClick);

    // 초기화 버튼 이벤트
    const eraseBtn = document.getElementById("erase");
    if (eraseBtn) {
      eraseBtn.addEventListener("click", resetPainting);
    }

    // 정리 함수
    return () => {
      canvas.removeEventListener("mousemove", onMove);
      canvas.removeEventListener("mousedown", startPainting);
      canvas.removeEventListener("mouseup", cancelPainting);
      canvas.removeEventListener("mouseleave", cancelPainting);
      canvas.removeEventListener("click", onCanvasClick);
      
      if (eraseBtn) {
        eraseBtn.removeEventListener("click", resetPainting);
      }
    };
  }, []);

  const onSaveCheck = () => {
    if (isDrawing) {
      setAlertModal({
        isModal: true,
        content: `계좌이체거래약정서의 발급이 완료 됩니다.\n계좌이체거래약정서, 첨부파일 (개인정보 보완 진행 파일 포함)은 서버로 전송 됩니다.\n진행하시겠습니까?`,
        onClick: () => {
          clickPrint();
          resetAlertModal();
        },
      });
    } else {
      setAlertModal({
        isModal: true,
        content: `첨부파일의 개인정보 보완이 완료되지 않았습니다.\n개인정보 가림 처리 완료 후 다음으로 진행하실 수 있습니다.`,
      });
    }
  };

  // 파일 URL 생성 함수
  const getFileUrl = () => {
    if (props.url.includes("blob:")) {
      return props.url;
    }
    return `${process.env.REACT_APP_RESOURCE_URL}?path=${props.url}&type=ACCOUNT`;
  };

  return (
    <>
      <CanvasContainer>
        <section>
          <div className="title">
            <h2>첨부파일 마스킹 진행 안내</h2>
            <span>
              * 민감한 개인정보가 포함된 첨부파일의 마스킹 처리가 필요합니다.
              <br />
              마우스를 드래그하여 일부 정보를 마스킹 처리 후 완료 버튼을 눌러주세요.
            </span>
          </div>
          <div className="viewBox">
            <div
              className="viewer"
              style={{ width: "790px", height: "1109px", position: "relative" }}
              ref={printRef}
            >
              {fileType === "pdf" && (
                <div
                  style={{
                    width: "790px",
                    height: "1109px",
                    border: "1px solid #ddd",
                  }}
                  ref={inRef}
                >
                  <FileViewer
                    url={getFileUrl()}
                    noHeader={true}
                    noBottom={true}
                    outputCheck={true}
                    full
                  />
                </div>
              )}
              {(fileType === "jpg" || fileType === "png" || fileType === "jpeg") && (
                <img
                  crossOrigin="anonymous"
                  style={{
                    display: "block",
                    maxWidth: "100%",
                    maxHeight: "calc(790px * 1.4)",
                    margin: "0 auto",
                    border: "1px solid #ddd",
                  }}
                  src={getFileUrl()}
                  alt="파일 사진"
                  ref={imgRef}
                />
              )}
              <canvas
                style={{
                  position: "absolute",
                  left: "50%",
                  top: "50%",
                  transform: "translate(-50%, -50%)",
                  zIndex: 99,
                  cursor: "crosshair",
                }}
                ref={canvasRef}
              />
            </div>
          </div>
          <div className="toolbar">
            <button type="button" onClick={props.changeShow}>
              닫기
            </button>
            <div>
              <button id="erase" type="button">
                초기화
              </button>
              <button
                type="button"
                className={!isDrawing ? "drawingPass" : ""}
                onClick={onSaveCheck}
              >
                저장
              </button>
            </div>
          </div>
        </section>
      </CanvasContainer>
    </>
  );
};

const CanvasContainer = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.4);
  z-index: 90;
  overflow: auto;
  display: flex;
  justify-content: center;
  padding: 50px;

  /* 캡처 시 테두리 숨기기 */
  .no-border {
    border: 0 !important;
  }

  & > section {
    width: auto;
    height: 1400px;
    padding: 40px;
    background-color: #fff;
    border-radius: 20px;

    & > .title {
      width: 100%;
      height: auto;
      text-align: center;
      display: flex;
      flex-direction: column;
      margin-bottom: 20px;
      & > h2 {
        color: #da0043;
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 14px;
      }
      & > span {
        font-size: 18px;
        color: ${theme.colors.gray3};
      }
    }

    & > .viewBox {
      background-color: #fff;
      position: relative;
      color: black;
      & > .viewer {
        width: 790px;
        height: 1109px;
        position: relative;
      }
    }

    .toolbar {
      width: 100%;
      height: 100px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      z-index: 91;
      
      & > div {
        & > button:last-child {
          margin-left: 10px;
        }
      }
      
      button {
        width: 167px;
        height: 47px;
        background-color: #438cae;
        color: #fff;
        text-align: center;
        border-radius: 25px;
        border: none;
        cursor: pointer;
        font-size: 14px;
        
        &:hover {
          background-color: #357a9b;
        }
        
        &:disabled {
          background-color: ${theme.colors.gray4};
          cursor: not-allowed;
        }
      }
    }
  }

  .drawingPass {
    background-color: ${theme.colors.gray4} !important;
    
    &:hover {
      background-color: ${theme.colors.gray4} !important;
    }
  }
`;