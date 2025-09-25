import styled from "styled-components";
import React, { useEffect, useRef, useState } from "react";
import FileViewer from "../../components/Viewer/FileViewer";
import { LoginContainer } from "../../theme/common";
import { Link } from "react-router-dom";
import logoBlue from "../../assets/Logo/logoBlue.svg";
import theme from "../../theme";
import { BlockDataType, CommitterInfo, Datum } from "../../controllers/Agreement/AgreementQR";
import DateUtils from "../../utils/DateUtils";
import { isMobile } from "react-device-detect";

interface DrawingImageProps {
  url: string;
  file?: { name: string; path: string };
  block: BlockDataType;
  committers: CommitterInfo | null;
  qrScoreType?: boolean;
}

type CommitterType = {
  empId?: string;
  name: string;
  phone: string;
  hash: string;
  birth?: string;
};

function AgreementQRView(props: DrawingImageProps) {
  // const fileTypeCheck = (fileName: string): string => {
  //   if (fileName.includes(".png")) return "png";
  //   if (fileName.includes(".jpg")) return "jpg";
  //   if (fileName.includes(".jpeg")) return "jpeg";
  //   if (fileName.includes(".pdf")) return "pdf";
  //   return "";
  // };

  // const fileType: string = fileTypeCheck(props.file.name);

  const [committerMaster, setCommitterMaster] = useState<CommitterType>();
  const [committerList, setCommitterList] = useState<CommitterType[]>([]);

  useEffect(() => {
    if (props.committers?.data && props.committers?.data.length > 0) {
      let data: CommitterType = {
        empId: "",
        name: "",
        phone: "",
        hash: "",
      };

      let committer: CommitterType[] = [];

      props.committers.data.map((item, index) => {
        const parse = JSON.parse(item.evdata);
        if (parse.empId) {
          data = parse;
        } else {
          committer.push(parse);
        }
      });

      setCommitterList(committer);
      setCommitterMaster(data);
    }
  }, [props.committers?.data]);

  return (
    <AgreementQRViewBlock>
      <div className="header">
        <div className="headerContent">
          <img src={logoBlue} alt="로고" />
        </div>
      </div>
      <section>
        <div className="viewBox">
          <div
            className="viewer"
            style={{
              width: "100%",
              height: `${isMobile ? "calc(100vw * 1.5)" : "1300px"}`,
              position: "relative",
              margin: "0 auto",
            }}
          >
            {/* {fileType === "pdf" && <FileViewer url={props.url} noHeader={true} full />}
            {(fileType === "jpg" || fileType === "png" || fileType === "jpeg") && (
              <img style={{ display: "block", maxWidth: "100%" }} src={props.url} alt="파일 사진" />
            )} */}
            {props.url && (
              <>
                <FileViewer
                  url={
                    props.url.includes("blob:")
                      ? props.url
                      : `${process.env.REACT_APP_RESOURCE_URL}?path=${props.url}&type=ACCOUNT`
                  }
                  noHeader={true}
                  full
                />
              </>
            )}
            {/* <canvas
              style={{
                position: "absolute",
                left: "50%",
                top: "50%",
                transform: "translate(-50%, -50%)",
                zIndex: 99,
              }}
              ref={canvasRef}
            ></canvas> */}
          </div>
        </div>

        {!props.qrScoreType && (
          <>
            <div className="fileInfoWrap">
              <h3>참석자 서명 정보</h3>
              <div className="fileInfo">
                <span>서부 평가담당자</span>
                <span>
                  {committerMaster?.name}: {committerMaster?.hash}
                </span>
              </div>
              <div className="fileInfo">
                <span>평가위원</span>
                {committerList.map((item, index) => (
                  <>
                    <span key={index}>
                      {item.name}: {item.hash}
                    </span>
                  </>
                ))}
              </div>
            </div>
          </>
        )}

        <div className="fileInfoWrap">
          <h3>블록체인 업로드 정보</h3>
          <div className="fileInfo">
            <span>생성일</span>
            <span>{DateUtils.listDateFormat(props.block.createdAt)}</span>
          </div>
          <div className="fileInfo">
            <span>Transaction ID</span>
            <span>{props.block.transactionId}</span>
          </div>
          <div className="fileInfo">
            <span>Block Number</span>
            <span>{props.block.blockNumber}</span>
          </div>
        </div>
      </section>
    </AgreementQRViewBlock>
  );
}

export default AgreementQRView;

const AgreementQRViewBlock = styled.div`
  width: 100vw;
  height: 100vh;
  max-width: 900px;
  margin: 0 auto;
  overflow-y: scroll;
  &::-webkit-scrollbar {
    width: 0px;
  }
  & > .header {
    width: 100%;
    /* height: 101px; */
    padding: 10px 20px;
    padding-top: 20px;

    & > .headerContent {
      & > img {
        height: 30px;
      }
    }
  }
  & > section {
    width: 100%;
    height: auto;
    padding: 20px;
    /* background-color: deeppink; */
    & > .viewBox {
      background-color: #fff;

      position: relative;
      color: black;
      & > .viewer {
        width: 100%;
        min-height: 400px;
        /* max-width: 790px; */
        /* height: 1109px; */
        position: relative;
      }
    }
    & > .fileInfoWrap {
      border: 1px solid ${theme.colors.blueDeep};
      border-radius: 20px;
      padding: 20px;
      margin-bottom: 20px;
      & > h3 {
        margin-bottom: 14px;
      }
      & > div {
        display: flex;
        flex-direction: column;
        margin-bottom: 10px;
        & > span {
          font-size: 0.8rem;
          word-wrap: break-word;
          &:first-child {
            font-weight: bold;
            color: ${theme.colors.gray4};
          }
        }
      }
      &:last-child {
        margin-bottom: 150px;
      }
    }
  }
`;
