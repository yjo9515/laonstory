import { useRef } from "react";
import { UseFormRegister } from "react-hook-form";
import { useSetRecoilState } from "recoil";
import styled from "styled-components";
import BigInputButton from "../../../components/Common/Button/BigInputButton";
import Form from "../../../components/Common/Container/Form";
import Left from "../../../components/MyInfo/Left";
import AttachedFileViewer from "../../../components/Viewer/AttachedFileViewer";
import { IAccept, IFile } from "../../../controllers/Partners/Detail/Detail";
import {
  AgreementDetailRes,
  ICertificateFile,
  IEtcFile,
  IIdentityFile,
  IPassbookFile,
  UserDetailRes,
} from "../../../interface/Master/MasterRes";
import { ViewObjectWrapperBox } from "../../../theme/common";
import { DrawingImage } from "../../../utils/ImageDrawingUtil";

export default function DetailView({
  isButton = true,
  infoData,
  role,
  register,
  onSubmit,
  accept,
  agreementData,
  onDeleteClick,
  clickFileList,
  id,
  fileUrl,
  changeShow,
  show,
  file,
  onNextFlow,
  onSaveData,
  viewShow,
  explanationShow,
}: {
  isButton?: boolean;
  infoData: UserDetailRes;
  agreementData: AgreementDetailRes;
  role: string;
  register: UseFormRegister<IAccept>;
  onSubmit: any;
  accept?: string;
  onDeleteClick?: () => void;
  clickFileList?: (file: IFile) => void;
  id: string;
  fileUrl: string;
  changeShow: () => void;
  show: boolean;
  file: { name: string; path: string };
  onNextFlow: () => void;
  onSaveData: (file: any) => void;
  viewShow: boolean;
  explanationShow: boolean;
}) {
  return (
    <ViewObjectWrapperBox detail>
      <h1 className="viewTitle">
        {(role === "personal" && "이용자") ||
          (role === "company" && "법인") ||
          (role === "agreement" && "계좌이체거래약정서 상세")}
      </h1>
      <div className="mainContent">
        <Form onSubmit={onSubmit}>
          <DetailWrapper>
            <Left
              accept={accept}
              detailData={infoData}
              agreementData={agreementData}
              isButton={isButton}
              role={role}
              isAdminDetail
              register={register || {}}
              agreementFileList={
                [
                  agreementData?.identityFile,
                  agreementData?.passbookFile,
                  agreementData?.certificateFile,
                  agreementData?.etcFile,
                ] as [IIdentityFile, IPassbookFile, ICertificateFile, IEtcFile]
              }
              onDeleteClick={onDeleteClick}
              myInfoChangeInfoList={infoData?.userInfoChangeHistoryList}
              clickFileList={clickFileList}
              id={id}
              isDetail={true}
            />
            {(agreementData?.status === "요청중" || infoData?.adminVerify === "심사대기") && (
              <div className="buttonContainer">
                <BigInputButton
                  text={`${accept === "no" ? "저장" : "다음"}`}
                  type="button"
                  onClick={onNextFlow}
                />
              </div>
            )}
          </DetailWrapper>
        </Form>
      </div>

      {fileUrl && show && explanationShow && !viewShow && (
        <DrawingImage url={fileUrl} changeShow={changeShow} onSaveData={onSaveData} file={file} />
      )}
      {fileUrl && show && viewShow && !explanationShow && (
        <AttachedFileViewer url={fileUrl} file={file} changeShow={changeShow} />
      )}
    </ViewObjectWrapperBox>
  );
}

export const DetailWrapper = styled.div``;
