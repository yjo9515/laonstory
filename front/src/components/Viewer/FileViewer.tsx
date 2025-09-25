import styled from "styled-components";
import theme from "../../theme";
import { useEffect, useState } from "react";
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

export default function FileViewer({
  url,
  selectFile,
  selectFileName,
  setWidthOrHeight,
  isApplication = false,
  renderPage,
  full = false,
  noHeader,
}: {
  url?: string;
  selectFile?: string;
  selectFileName?: string;
  setWidthOrHeight?: (type: string) => void;
  isApplication?: boolean;
  renderPage?: RenderPage;
  noHeader?: boolean;
  full?: boolean;
}) {
  const [pages, setPages] = useState(0);

  console.log(selectFileName);

  const onLoad = (e: DocumentLoadEvent) => {
    const page = e.doc.numPages;
    setPages(page);
  };
  // ========================pdf viewer 플러그인
  // 회전 버튼
  const rotatePluginInstance = rotatePlugin();
  const { RotateBackwardButton, RotateForwardButton } = rotatePluginInstance;
  // 페이지 네비게이션
  const pageNavigationPluginInstance = pageNavigationPlugin({
    enableShortcuts: true,
  });
  const {
    GoToFirstPage,
    GoToLastPage,
    GoToNextPage,
    GoToPreviousPage,
    CurrentPageInput,
    NumberOfPages,
    jumpToPage,
  } = pageNavigationPluginInstance;
  // zoom 기능
  const zoomPluginInstance = zoomPlugin();
  const { ZoomPopover, ZoomIn, ZoomOut } = zoomPluginInstance;
  // 썸네일 유무
  const [thumbnail, setThumbnail] = useState(false);

  const onWidthOrHeight = (rotate: number) => {
    let num = Math.abs(rotate);
    if (!setWidthOrHeight) return;
    if (num === 0 || num === 180 || num === 360) setWidthOrHeight("width");
    if (num === 90 || num === 270) setWidthOrHeight("height");
  };

  return (
    <Worker workerUrl={`${window.location.origin}/pdf.worker.js`}>
      <ViewerContainer className={`${full && "full"}`}>
        {selectFileName && <div className="fileName">{selectFileName}</div>}
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
                transformGetDocumentParams={
                  selectFile
                    ? (option: PdfJs.GetDocumentParams) =>
                        Object.assign(option, {
                          url: selectFile
                            ? `${process.env.REACT_APP_RESOURCE_URL}?path=${selectFile}&type=EVALUATION`
                            : "",
                        })
                    : undefined
                }
                fileUrl={
                  url
                    ? url
                    : `${process.env.REACT_APP_RESOURCE_URL}?path=${selectFile}&type=EVALUATION`
                }
                plugins={[rotatePluginInstance, pageNavigationPluginInstance, zoomPluginInstance]}
                onDocumentLoad={onLoad}
                localization={ko_KR as unknown as LocalizationMap}
                onRotate={(e) => onWidthOrHeight(e.rotation)}
                defaultScale={1}
              />
            </>
          )}
        </div>
        {pages !== 1 && (
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
}

const ViewerContainer = styled.div`
  width: 100%;
  height: 100%;
  position: relative;
  &.full {
    .rpv-core__page-layer {
      /* width: 100% !important; */
      /* height: 100% !important; */
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
      /* height: 100% !important; */
    }
    .rpv-core__canvas-layer {
      width: 100% !important;
      height: 100% !important;
    }
    .rpv-core__canvas-layer > canvas {
      width: 100% !important;
      height: 100% !important;
    }
  }
  .content {
    flex: 1;
    display: flex;
    width: 100%;
    height: calc(100% - 92px);
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
  .rpv-core__page-layer {
    width: 100%;
  }
  .rpv-core__tooltip-body {
    display: none !important;
  }
  .fileName {
    position: absolute;
    top: 13px;
    left: 70px;
    font-size: 12px;
  }
`;

const TopBar = styled.div`
  width: 100%;
  height: 42px;
  background-color: ${theme.colors.gray6};
  display: flex;
  justify-content: space-between;
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
    padding: 7px 0px;
    border-bottom: 1px solid ${theme.colors.blueGray2};
    color: ${theme.systemColors.systemSideBarBtn};
    font-weight: 300;
    &:hover {
      color: #fff;
      background-color: ${theme.systemColors.systemSideBarBtn};
      font-weight: 600;
    }
  }

  & {
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
  }
`;

const BottomBar = styled.div`
  width: 100%;
  height: 50px;
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
