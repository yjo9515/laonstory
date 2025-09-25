import styled from "styled-components";
import theme from "../../theme";
import { useEffect, useState, useCallback, useRef } from "react";
// pdf viewer
import {
  Viewer,
  Worker,
  DocumentLoadEvent,
  LocalizationMap,
  PdfJs,
  RenderPage,
} from "@react-pdf-viewer/core";
import "@react-pdf-viewer/core/lib/styles/index.css";
// ========================== pdf viewer 플러그인
//rotate
import { rotatePlugin } from "@react-pdf-viewer/rotate";
import "@react-pdf-viewer/thumbnail/lib/styles/index.css";
// page 넘기기
import { pageNavigationPlugin } from "@react-pdf-viewer/page-navigation";
import "@react-pdf-viewer/page-navigation/lib/styles/index.css";
// zoom 기능
import { zoomPlugin } from "@react-pdf-viewer/zoom";
import "@react-pdf-viewer/zoom/lib/styles/index.css";
import ko_KR from "@react-pdf-viewer/locales/lib/ko_KR.json";
import { printPlugin } from "@react-pdf-viewer/print";
import "@react-pdf-viewer/print/lib/styles/index.css";

const FileViewer = ({
  url,
  selectFile,
  setWidthOrHeight,
  isPrint,
  clickPrint,
  noHeader = false,
  noBottom = false,
  outputCheck = false,
  full = false,
  renderPage,
  big = false,
}: {
  url?: string;
  selectFile?: string;
  setWidthOrHeight?: (type: string) => void;
  isPrint?: boolean;
  clickPrint?: (val: boolean) => void;
  ref?: React.MutableRefObject<undefined>;
  noHeader?: boolean;
  noBottom?: boolean;
  outputCheck?: boolean;
  full?: boolean;
  renderPage?: RenderPage;
  big?: boolean;
}) => {
  const [pages, setPages] = useState(0);
  const [thumbnail, setThumbnail] = useState(false);
  const printExecutedRef = useRef(false); // 프린트 실행 여부 추적

  // 플러그인 인스턴스들을 useCallback으로 메모화
  const rotatePluginInstance = rotatePlugin();
  const pageNavigationPluginInstance = pageNavigationPlugin({
    enableShortcuts: true,
  });
  const zoomPluginInstance = zoomPlugin();
  const printPluginInstance = printPlugin();

  // 각 플러그인의 기능들 추출
  const { RotateBackwardButton, RotateForwardButton } = rotatePluginInstance;
  const {
    GoToFirstPage,
    GoToLastPage,
    GoToNextPage,
    GoToPreviousPage,
    CurrentPageInput,
    NumberOfPages,
    jumpToPage,
  } = pageNavigationPluginInstance;
  const { ZoomPopover, ZoomIn, ZoomOut, zoomTo } = zoomPluginInstance;
  const { print } = printPluginInstance;

  // PDF 로드 완료시 콜백
  const onLoad = useCallback((e: DocumentLoadEvent) => {
    const page = e.doc.numPages;
    setPages(page);
    
    // big 옵션이 true일 때만 확대
    if (big) {
      setTimeout(() => {
        zoomTo(1.7);
      }, 100); // 약간의 지연을 주어 PDF 로딩 완료 후 실행
    }
  }, [big, zoomTo]);

  // 회전 처리
  const onWidthOrHeight = useCallback((rotate: number) => {
    if (!setWidthOrHeight) return;
    
    const num = Math.abs(rotate);
    if (num === 0 || num === 180 || num === 360) {
      setWidthOrHeight("width");
    } else if (num === 90 || num === 270) {
      setWidthOrHeight("height");
    }
  }, [setWidthOrHeight]);

  // 인쇄 처리 - 무한 루프 방지
  useEffect(() => {
    if (isPrint && !printExecutedRef.current) {
      printExecutedRef.current = true;
      print();
      
      // clickPrint 콜백이 있으면 실행
      if (clickPrint) {
        clickPrint(false);
      }
    }
    
    // isPrint가 false가 되면 다시 실행 가능하도록 리셋
    if (!isPrint) {
      printExecutedRef.current = false;
    }
  }, [isPrint, print, clickPrint]);

  // 파일 URL 생성
  const fileUrl = useCallback(() => {
    if (url) return url;
    if (selectFile) {
      return `${process.env.REACT_APP_RESOURCE_URL}?path=${selectFile}&type=ACCOUNT`;
    }
    return "";
  }, [url, selectFile]);

  // transformGetDocumentParams 메모화
  const transformParams = useCallback((option: PdfJs.GetDocumentParams) => {
    if (selectFile) {
      return Object.assign(option, {
        url: `${process.env.REACT_APP_RESOURCE_URL}?path=${selectFile}&type=ACCOUNT`,
      });
    }
    return option;
  }, [selectFile]);

  return (
    <Worker workerUrl={`${window.location.origin}/pdf.worker.js`}>
      <ViewerContainer className={`${full && "full"}`} outputCheck={outputCheck}>
        {!noHeader && (
          <TopBar>
            {pages !== 1 && (
              <div className="left">
                <button
                  onClick={() => {
                    setThumbnail((prev) => !prev);
                  }}
                >
                  <svg
                    aria-hidden="true"
                    focusable="false"
                    height="16px"
                    viewBox="0 0 24 24"
                    width="16px"
                  >
                    <path
                      d="M10.5,9.5c0,0.552-0.448,1-1,1h-8c-0.552,0-1-0.448-1-1v-8c0-0.552,0.448-1,1-1h8c0.552,0,1,0.448,1,1V9.5z
            M23.5,9.5c0,0.552-0.448,1-1,1h-8c-0.552,0-1-0.448-1-1v-8c0-0.552,0.448-1,1-1h8c0.552,0,1,0.448,1,1V9.5z
            M10.5,22.5 c0,0.552-0.448,1-1,1h-8c-0.552,0-1-0.448-1-1v-8c0-0.552,0.448-1,1-1h8c0.552,0,1,0.448,1,1V22.5z
            M23.5,22.5c0,0.552-0.448,1-1,1 h-8c-0.552,0-1-0.448-1-1v-8c0-0.552,0.448-1,1-1h8c0.552,0,1,0.448,1,1V22.5z"
                    ></path>
                  </svg>
                </button>
              </div>
            )}
            <div className="center">
              <ZoomOut />
              <ZoomPopover />
              <ZoomIn />
            </div>
            {pages !== 1 && (
              <div className="right">
                <RotateBackwardButton />
                <RotateForwardButton />
              </div>
            )}
          </TopBar>
        )}
        <div className="content">
          {pages !== 1 && (
            <LeftBar thumbnail={thumbnail}>
              {[...Array(pages)].map((el, i) => (
                <button type="button" key={i} onClick={() => jumpToPage(i)}>
                  {"Page " + (i + 1)}
                </button>
              ))}
            </LeftBar>
          )}
          {(selectFile || url) && (
            <>
              <Viewer
                renderPage={renderPage}
                withCredentials={false}
                transformGetDocumentParams={selectFile ? transformParams : undefined}
                fileUrl={fileUrl()}
                plugins={[
                  printPluginInstance,
                  rotatePluginInstance,
                  pageNavigationPluginInstance,
                  zoomPluginInstance,
                ]}
                onDocumentLoad={onLoad}
                localization={ko_KR as unknown as LocalizationMap}
                onRotate={(e) => onWidthOrHeight(e.rotation)}
                defaultScale={1.2}
              />
            </>
          )}
        </div>
        {pages !== 1 && !noBottom && (
          <BottomBar>
            <div className="buttons">
              <GoToFirstPage />
              <GoToPreviousPage />
              <div>
                <CurrentPageInput />/ <NumberOfPages />
              </div>
              <GoToNextPage />
              <GoToLastPage />
            </div>
          </BottomBar>
        )}
      </ViewerContainer>
    </Worker>
  );
};

export default FileViewer;

const ViewerContainer = styled.div<{ outputCheck: boolean }>`
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  margin: 0 auto;
  
  &.full {
    .rpv-core__page-layer {
      width: 100% !important;
      height: 100% !important;
    }
    .rpv-core__tooltip-body {
      display: none !important;
    }
    .rpv-core__inner-pages > div {
      width: inherit !important;
      height: inherit !important;
    }
    .rpv-core__inner-page {
      width: 100% !important;
      height: 100% !important;
    }
    .rpv-core__canvas-layer {
      width: 100% !important;
      height: 100% !important;
      display: flex;
      justify-content: center;
    }
    .rpv-core__page-layer::after {
      box-shadow: ${(props) =>
        props.outputCheck ? "none" : "var(--rpv-core__page-layer-box-shadow)"};
    }
    .rpv-core__canvas-layer > canvas {
      width: 100% !important;
      object-fit: contain !important;
    }
  }
  
  .content {
    display: flex;
    width: 100%;
    overflow: auto;
    height: 100%;
  }
  
  .rpv-core__inner-pages--vertical {
    &::-webkit-scrollbar {
      width: 8px;
      height: 12px;
      background-color: ${(props) => props.theme.colors.gray6};
      border-radius: 55px;
      left: 8px;
    }
    &::-webkit-scrollbar-thumb {
      width: 8px;
      height: 12px;
      background-color: ${(props) => props.theme.colors.gray4};
      border-radius: 55px;
    }
  }
`;

const TopBar = styled.div`
  width: 100%;
  background-color: ${theme.colors.gray6};
  display: flex;
  justify-content: center;
  padding: 5px 20px;
  
  > div {
    width: 33%;
    display: flex;
    gap: 10px;
  }
  
  .left {
    justify-content: flex-start;
  }
  .right {
    justify-content: flex-end;
  }
  .center {
    justify-content: center;
  }
  
  button {
    > svg {
      width: 25px;
      height: 25px;
    }
  }
`;

const LeftBar = styled.div<{ thumbnail: boolean }>`
  width: 120px;
  display: ${(props) => (props.thumbnail ? "flex" : "none")};
  justify-content: flex-start;
  flex-direction: column;
  align-items: center;
  font-size: 16px;
  color: black;
  
  > button {
    width: 100%;
    text-align: center;
    padding: 10px 0px;
    border-bottom: 1px solid black;
  }
  
  overflow-y: auto;
  &::-webkit-scrollbar {
    width: 8px;
    background-color: ${(props) => props.theme.colors.gray6};
    border-radius: 55px;
    left: 8px;
  }
  &::-webkit-scrollbar-thumb {
    width: 8px;
    background-color: ${(props) => props.theme.colors.gray4};
    border-radius: 55px;
  }
`;

const BottomBar = styled.div`
  width: 100%;
  padding: 5px 20px;
  display: flex;
  justify-content: center;
  background-color: ${theme.colors.gray6};
  
  > div {
    display: flex;
    gap: 20px;
    color: black !important;
    
    button {
      > svg {
        width: 25px;
        height: 25px;
        rotate: -90deg;
      }
    }
  }
  
  .buttons {
    > div {
      display: flex;
      align-items: center;
      gap: 10px;
    }
  }
`;