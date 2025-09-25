import React from "react";
import styled from "styled-components";
import theme from "../../../../theme";
import uploadIcon from "../../../../assets/Icon/upload.svg";
import deleteIcon from "../../../../assets/Icon/delete.svg";
import { DetailSection } from "../../../../components/Detail/DetailSection";
import { InfoList } from "../../../../components/Detail/DetailListTable";

export interface StepThreeTypes {
  onFiles: (files: any) => void;
  files: any[];
  resFiles: any[];
  onFilesException: (index: number, type: string) => void;
  onNoticeInput: (text: string, type: string) => void;
  notice: {
    committerNoticeContent: string;
    companyNoticeContent: string;
  };
}

export const StepThree: React.FC<StepThreeTypes> = (props) => {
  return (
    <>
      <DetailSection>
        <DetailSection.Title>
          4. 공지사항 입력
          <span>평가방 입장 시 평가위원, 제안업체에게 공지할 내용을 각각 입력해주세요.</span>
        </DetailSection.Title>
        <StepThreeBlock>
          <InfoList>
            <InfoList.Title>
              {`1) 평가위원 공지사항`}
              <span>평가에 참여하는 평가위원에게만 보여지는 공지사항입니다.</span>
            </InfoList.Title>
            <textarea
              placeholder="내용이 없습니다. 클릭 후 내용을 입력해주세요."
              onChange={(e) => props.onNoticeInput(e.target.value, "committerNoticeContent")}
              value={props.notice.committerNoticeContent}
            ></textarea>
            <InfoList.Title>
              {`2) 제안업체 공지사항`}
              <span>평가에 참여하는 제안업체에게만 보여지는 공지사항입니다.</span>
            </InfoList.Title>
            <textarea
              placeholder="내용이 없습니다. 클릭 후 내용을 입력해주세요."
              onChange={(e) => props.onNoticeInput(e.target.value, "companyNoticeContent")}
              value={props.notice.companyNoticeContent}
            ></textarea>
          </InfoList>
        </StepThreeBlock>
      </DetailSection>
      <FileContainer>
        <DetailSection.Title>
          5. 제안검토파일 업로드
          <span>
            제안 발표 전 평가위원에게 읽기전용으로 제공됩니다. (pdf 파일만 업로드하실 수 있습니다.)
          </span>
          <label htmlFor="file" className="fileUpload">
            파일 업로드
            <img src={uploadIcon} alt="업로드 아이콘" />
          </label>
        </DetailSection.Title>
        <DetailSection.Title>
          <span style={{color : "red", fontWeight : "bold"}}>암호화 해제 후 업로드</span>
        </DetailSection.Title>
        <div className="fileContainer">
          <div className="fileContainerHeader">
            <div>파일명</div>
            <div>삭제</div>
          </div>
          <div className="fileContainerBody">
            {/* 평가방에서 DB에 저장 된 파일 정보를 보여줄 때 */}
            {props.resFiles &&
              props.resFiles.length > 0 &&
              props.resFiles.map((data, index) => (
                <div className="fileRows" key={data.id}>
                  <div>{data.fileName}</div>
                  <div onClick={() => props.onFilesException(data.id, "modify")}>
                    <img src={deleteIcon} alt="" />
                  </div>
                </div>
              ))}
            {/* 평가방에서 새로 추가된 파일 정보를 보여줄 때 */}
            {props.files &&
              props.files.length > 0 &&
              Array.from(props.files).map((data, index) => (
                <div className="fileRows" key={index}>
                  <div>{data.name}</div>
                  <div onClick={() => props.onFilesException(index, "new")}>
                    <img src={deleteIcon} alt="" />
                  </div>
                </div>
              ))}
            {/* 파일관련 정보가 없을 경우 */}
            {props.files.length === 0 && props.resFiles.length === 0 && (
              <InfoList.NoContentMessage text="업로드한 파일이 없습니다. 파일업로드 버튼 클릭 후 파일을 추가해주세요." />
            )}
          </div>
        </div>
        <input
          type="file"
          id="file"
          onChange={(e: any) => {
            props.onFiles(e);
          }}
          accept={".pdf"}
          multiple
        />
      </FileContainer>
    </>
  );
};

const StepThreeBlock = styled.div``;

const FileContainer = styled.div`
  & > div {
    margin-top: 40px;
  }
  input {
    display: none;
  }
  .fileUpload {
    width: 130px;
    height: 40px;
    margin-left: auto;
    padding: 4px 16px;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 4px;
    background: ${theme.systemColors.systemPrimary};
    border-radius: 67px;
    color: white;
    font-weight: 500;
    font-size: 13px;
    cursor: pointer;
    white-space: nowrap;
  }
  .fileContainer {
    width: 100%;
    height: 246px;
    border: 1px solid ${theme.systemColors.blueDeep};
    border-radius: 5px;
    & > .fileContainerHeader {
      height: 67px;
      padding: 24px;
      display: flex;
      border-bottom: 1px solid ${theme.systemColors.blueDeep};
      font-size: ${theme.fontType.subTitle1.fontSize};
      font-weight: ${theme.fontType.subTitle1.bold};
      color: ${theme.colors.body2};
      > div {
        padding-left: 8px;
        border-left: 1px solid ${theme.colors.blueGray1};
        line-height: 18px;
        &:first-child {
          width: 998px;
        }
      }
    }
    & > .fileContainerBody {
      position: relative;
      height: 179px;
      overflow-y: scroll;
      -ms-overflow-style: none; /* IE and Edge */
      scrollbar-width: none; /* Firefox */
      &::-webkit-scrollbar {
        display: none !important;
      }
      & > .fileRows {
        width: 100%;
        height: 40px;
        display: flex;
        align-items: center;
        padding: 0px 24px;
        font-size: ${theme.fontType.subTitle1.fontSize};
        font-weight: ${theme.fontType.subTitle1.bold};
        color: ${theme.colors.body2};
        & > div {
          padding-left: 8px;
          &:first-child {
            width: 998px;
          }
          &:last-child {
            cursor: pointer;
          }
        }
      }
    }
  }
`;
