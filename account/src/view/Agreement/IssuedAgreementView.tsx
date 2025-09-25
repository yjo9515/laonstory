import styled from "styled-components";
import theme from "../../theme";
import { ViewObjectWrapperBox } from "../../theme/common";
import FileViewer from "../../components/Viewer/FileViewer";
import InputButton from "../../components/Common/Button/InputButton";
import { Link, useNavigate } from "react-router-dom";
import { useState } from "react";
import { Inputs } from "../../components/Common/Input/InputSet1";
import bag from "../../assets/Icon/bag.svg";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import { alertModalState } from "../../modules/Client/Modal/Modal";
import FileDeleteGuideText from "../../components/Modal/Agreement/FileDeleteGuideText";
import AttachedFileViewer from "../../components/Viewer/AttachedFileViewer";
import {
  AttachedFileContentType,
  AttachedFileType,
} from "../../controllers/Agreement/AgreementView";

export default function IssuedAgreementView({
  type,
  url,
  isApplication = false,
  clickMainApplicationButton,
  isPin,
  goBack,
  isAccountant,
  attachedFileData,
  onComplete,
}: {
  type?: string;
  url: string;
  isApplication: boolean;
  clickMainApplicationButton: () => void;
  isPin: boolean;
  goBack?: () => void;
  isAccountant: boolean;
  attachedFileData: AttachedFileType | null;
  onComplete: () => void;
}) {
  const navigate = useNavigate();
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);

  const [viewFile, setViewFile] = useState({
    name: "",
    path: "",
    url: "",
  });

  const [isPrint, setPrint] = useState(false);
  const clickPrint = (val: boolean) => {
    setPrint(val);
  };

  const fileConfirm = () => {
    setAlertModal({
      isModal: true,
      content: <FileDeleteGuideText />,
      onClick() {
        onComplete();
        setAlertModal({
          isModal: true,
          content: (
            <div
              style={{
                height: "100px",
                display: "flex",
                flexDirection: "column",
                justifyContent: "center",
                alignItems: "center",
              }}
            >
              <p style={{ marginBottom: "10px" }}>
                첨부파일을 삭제 및 고객의 개인정보가 폐기되었습니다.
              </p>
              <p>
                * 발급완료된 계좌이체 거래약정서는 전사적관리시스템(SAP)에서 확인할 수 있습니다.
              </p>
            </div>
          ),
          onClick() {
            navigate(-1);
          },
          type: "check",
        });
      },
    });
  };

  const fileCheck = false;

  const onViewFileClick = (file: AttachedFileContentType) => {
    if (!attachedFileData) return;

    const { fileName, fileUrl } = file;

    let data = {
      name: fileName,
      path: "",
      url: fileUrl,
    };
    setViewFile(data);
  };

  const onClose = () => {
    setViewFile({
      name: "",
      path: "",
      url: "",
    });
  };

  return (
    <>
      {" "}
      <ViewObjectWrapperBox>
        <h1 className="title">
          계좌이체거래 약정서
          {/* {type !== "admin" && (
            <button onClick={clickMainApplicationButton} className="mainAgreement">
              + 주거래계좌로 등록
            </button>
          )} */}
        </h1>
        <div className="mainContent">
          <ViewerContainer>
            {url && <FileViewer big isPrint={isPrint} url={url} clickPrint={clickPrint} />}
          </ViewerContainer>
          {/* <ViewerContainer>
       {<FileViewer big isPrint={isPrint} url={url} clickPrint={clickPrint} />}
     </ViewerContainer> */}
        </div>
        {/* <div className="buttonContainer">
     <div className="between">
       <InputButton text="출력" round onClick={() => clickPrint(true)} />
       <div>
         <a href={url} download="계좌거래이체약정서">
           <InputButton text="다운로드" round />
         </a>
       </div>
     </div>
   </div> */}
        {url && (
          <>
            {(type === "admin" || isAccountant) && (
              <div className="buttonContainer">
                <div className="between">
                  <div>
                    {!isAccountant && <InputButton round text="돌아가기" onClick={goBack} />}
                  </div>
                  <div>
                    <a href={url} download="계좌거래이체약정서">
                      <InputButton text="다운로드" round />
                    </a>
                  </div>
                </div>
              </div>
            )}
            {type !== "admin" && (
              <div className="buttonContainer">
                <div className="between">
                  <div>
                    <InputButton text="돌아가기" round onClick={goBack} />
                  </div>
                  <div>
                    <a href={url} download="계좌거래이체약정서">
                      <InputButton text="다운로드" round />
                    </a>
                  </div>
                </div>
              </div>
            )}
          </>
        )}
        {/* {!isAccountant && type === "admin" && !isPin && (
          <p
            style={{
              textAlign: "center",
              marginTop: "40px",
              marginBottom: "40px",
              fontSize: "14px",
            }}
          >
            * 주 거래 계좌로 설정한 계좌이체거래약정서만 출력 및 저장이 가능합니다.
          </p>
        )} */}
        {isAccountant && type === "admin" && (
          <>
            <AttachedFileBlock>
              {attachedFileData && (
                <div>
                  <Inputs.Label
                    w={120}
                    labelText="첨부파일"
                    labelIcon={<img src={bag} alt="아이콘" />}
                  />
                  <div className="fileList">
                    <div>
                      <div className="fileTitle">파일종류</div>
                    </div>
                    {attachedFileData?.certificateFile && (
                      <div>
                        <div className="fileTitle">사업자등록증 사본</div>
                        <div
                          className="fileName"
                          onClick={() => onViewFileClick(attachedFileData.certificateFile)}
                        >
                          {attachedFileData.certificateFile.fileName}
                        </div>
                      </div>
                    )}
                    {attachedFileData?.identityFile && (
                      <div>
                        <div className="fileTitle">인감증명서 사본</div>
                        <div
                          className="fileName"
                          onClick={() => onViewFileClick(attachedFileData.identityFile)}
                        >
                          {attachedFileData.identityFile.fileName}
                        </div>
                      </div>
                    )}
                    {attachedFileData?.passbookFile && (
                      <div>
                        <div className="fileTitle">통장 사본</div>
                        <div
                          className="fileName"
                          onClick={() => onViewFileClick(attachedFileData.passbookFile)}
                        >
                          {attachedFileData.passbookFile.fileName}
                        </div>
                      </div>
                    )}
                    {attachedFileData?.etcFile && (
                      <div>
                        <div className="fileTitle">기타</div>
                        <div
                          className="fileName"
                          onClick={() => onViewFileClick(attachedFileData.etcFile)}
                        >
                          {attachedFileData.etcFile.fileName}
                        </div>
                      </div>
                    )}
                  </div>
                </div>
              )}
              <div>
                <Inputs.Label
                  w={120}
                  labelText={`첨부파일\n확인여부`}
                  labelIcon={<img src={bag} alt="아이콘" />}
                />
                <div className="fileGuide">
                  {attachedFileData && (
                    <>
                      <p>
                        * 위의 첨부파일은 이용자가 계좌이체거래약정서 발급 신청 시 업로드한
                        파일입니다.
                      </p>
                      <p>* 첨부 파일을 확인 후 오른쪽의 ‘확인 완료’ 버튼을 눌러주세요.</p>
                      <p>
                        * 개인정보처리방침에 따라 ‘확인 완료’ 버튼 클릭 시 파일을 삭제하고
                        개인정보를 폐기합니다.
                      </p>
                    </>
                  )}
                  {!attachedFileData && <p>* 확인 완료 되었습니다.</p>}
                </div>
                {attachedFileData && (
                  <InputButton text="확인 완료" cancel round onClick={fileConfirm} />
                )}
              </div>
            </AttachedFileBlock>
          </>
        )}
        {isAccountant && type === "admin" && (
          <div>
            <InputButton text="돌아가기" round onClick={goBack} />
          </div>
        )}
      </ViewObjectWrapperBox>
      {viewFile.url && viewFile.name && (
        <AttachedFileViewer url={viewFile.url} file={viewFile} changeShow={onClose} />
      )}
    </>
  );
}

export const CenterInfo = styled.div`
  width: 100%;
  font-size: 40px;
  color: ${theme.partnersColors.primary};
  font-weight: 700;
  display: flex;
  line-height: 60px;
`;

export const ViewerContainer = styled.div`
  margin: 0 auto;
`;

const AttachedFileBlock = styled.div`
  border-top: 1px solid ${theme.colors.blueDeep};
  padding: 30px 0;
  margin-top: 30px;
  & > div {
    display: flex;
    justify-content: flex-start;
    & > label {
      align-items: flex-start;
    }
    & > div {
      width: 100%;
      min-height: 100px;
      flex: 1;
    }
    & > .fileList {
      padding: 0 20px;
      border: 1px solid ${theme.colors.blueDeep};
      border-radius: 10px;
      margin-bottom: 30px;
      & > div {
        border-bottom: 1px solid ${theme.colors.blueDeep};
        padding: 10px;
        display: flex;
        & > div {
          height: 100%;
          font-size: 14px;
          &.fileName {
            cursor: pointer;
          }
        }
        & > .fileTitle {
          margin-right: 20px;
          width: 150px;
        }

        &:first-child {
          & > div {
            text-align: center;
          }
        }
        &:last-child {
          border-bottom: 0;
        }
      }
    }
    & > .fileGuide {
      & > p {
        font-size: 12px;
        font-weight: 300;
        /* color: ${theme.colors.gray4}; */
        &:last-child {
          color: #333;
          font-weight: 900;
        }
      }
    }
  }
`;
