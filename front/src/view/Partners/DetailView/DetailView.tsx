import { UseFormRegister } from "react-hook-form";
import styled from "styled-components";
import BigButton from "../../../components/Common/Button/BigButton";
import Form from "../../../components/Common/Container/Form";
import Left from "../../../components/MyInfo/Left";
import { IAccept, IFile } from "../../../controllers/Partners/Detail/Detail";
import {
  AgreementDetailRes,
  IIdentityFile,
  IPassbookFile,
  UserDetailRes,
} from "../../../interface/Master/MasterRes";
import theme from "../../../theme";
import { ViewObjectWrapperBox } from "../../../theme/common";

export default function DetailView({
  isButton = true,
  infoData,
  type,
  register,
  onSubmit,
  accept,
  agreementData,
  onDeleteClick,
  clickFileList,
}: {
  isButton?: boolean;
  infoData: UserDetailRes;
  agreementData: AgreementDetailRes;
  type: string;
  register: UseFormRegister<IAccept>;
  onSubmit: any;
  accept?: string;
  onDeleteClick?: () => void;
  clickFileList?: (file: IFile) => void;
}) {
  return (
    <DetailViewWrapper>
      <ViewObjectWrapperBox detail>
        <h1 className="viewTitle">
          {(type === "committer" && "평가위원") ||
            (type === "company" && "제안업체") ||
            (type === "agreement" && "계좌이체거래약정서")}{" "}
          상세
        </h1>
        <div className="mainContent">
          <Form onSubmit={onSubmit}>
            <DetailWrapper>
              <Left
                accept={accept}
                detailData={infoData}
                agreementData={agreementData}
                isButton={isButton}
                type={type}
                isAdminDetail
                register={register || {}}
                agreementFileList={
                  [agreementData?.identityFile, agreementData?.passbookFile] as [
                    IIdentityFile,
                    IPassbookFile
                  ]
                }
                onDeleteClick={onDeleteClick}
                myInfoChangeInfoList={infoData?.userInfoChangeHistoryList}
                clickFileList={clickFileList}
              />
              {(agreementData?.status === "요청" || infoData?.adminVerify === "심사대기") && (
                <div className="buttonContainer">
                  <BigButton text="저장" submit />
                </div>
              )}
            </DetailWrapper>
          </Form>
        </div>
      </ViewObjectWrapperBox>
    </DetailViewWrapper>
  );
}

const DetailViewWrapper = styled.div`
  margin-bottom: 130px;
`;

export const DetailWrapper = styled.div`
  .buttonContainer {
    justify-content: flex-end;
  }
`;
