import { string } from "prop-types";
import React, { useRef } from "react";
import styled from "styled-components";
import theme from "../../theme";
import FileViewer from "./FileViewer";

interface DrawingImageProps {
  url: string;
  file: { name: string; path: string };
  changeShow: () => void;
}

function AttachedFileViewer(props: DrawingImageProps) {
  const fileTypeCheck = (fileName: string): string => {
    if (fileName.includes(".png")) return "png";
    if (fileName.includes(".jpg")) return "jpg";
    if (fileName.includes(".jpeg")) return "jpeg";
    if (fileName.includes(".pdf")) return "pdf";
    return "";
  };

  const fileType: string = fileTypeCheck(props.file.name.toLowerCase());

  return (
    <CanvasContainer>
      <section>
        <div className="title">
          <h2>첨부파일 확인</h2>
          {/* <span>
            민감한 개인정보가 포함된 첨부파일의 보완 처리가 필요합니다.
            <br />
            마우스를 드래그하여 일부 정보를 가림처리 후 완료 버튼을 눌러주세요.
          </span> */}
        </div>
        <div className="viewBox">
          <div
            className="viewer"
            style={{ width: "790px", height: "1109px", position: "relative" }}
          >
            {fileType === "pdf" && (
              <FileViewer
                url={
                  props.url.includes("blob:")
                    ? props.url
                    : `${process.env.REACT_APP_RESOURCE_URL}?path=${props.url}&type=ACCOUNT`
                }
                noHeader={true}
                full
              />
            )}
            {(fileType === "jpg" || fileType === "jpeg" || fileType === "png") && (
              <>
                <img
                  crossOrigin="anonymous"
                  style={{
                    display: "block",
                    maxWidth: "100%",
                    maxHeight: "calc(790px * 1.4)",
                    margin: "0 auto",
                  }}
                  src={
                    props.url.includes("blob:")
                      ? props.url
                      : `${process.env.REACT_APP_RESOURCE_URL}?path=${props.url}&type=ACCOUNT`
                  }
                  alt="파일 사진"
                />
              </>
            )}
          </div>
        </div>
        <div className="toolbar">
          <button type="button" onClick={props.changeShow}>
            닫기
          </button>
        </div>
      </section>
    </CanvasContainer>
  );
}

export default AttachedFileViewer;

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
        font-size: 16px;
        font-weight: bold;
        margin-bottom: 14px;
      }
      & > span {
        font-size: 12px;
        color: ${theme.colors.gray3};
      }
    }

    & > .viewBox {
      background-color: #fff;

      position: relative;
      color: black;
      border-bottom: 1px solid #8c8c8c;
      padding-bottom: 26px;

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
      align-items: center;
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
      }
    }
  }
`;
