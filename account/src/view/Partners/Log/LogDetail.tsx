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
  LogDetailRes,
  UserDetailRes,
} from "../../../interface/Master/MasterRes";
import { ViewObjectWrapperBox } from "../../../theme/common";
import { DrawingImage } from "../../../utils/ImageDrawingUtil";

export default function DetailView({
  role,
  logData
}: {
    role: string;
    logData?: LogDetailRes;
}) {
  return (
    <ViewObjectWrapperBox detail>
              <h1 className="viewTitle">감사로그 상세</h1>
              <div className="mainContent">
                <Left
                  role="log"
                  logData={logData}
                />
              </div>                
            </ViewObjectWrapperBox>
  );
}

export const DetailWrapper = styled.div``;
