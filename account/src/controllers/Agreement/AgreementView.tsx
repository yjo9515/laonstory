import { useEffect, useState } from "react";
import { useMutation } from "react-query";
import { useLocation, useNavigate, useParams } from "react-router";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import {
  companyMainApplicationApi,
  getAccountApplicationPDFApi,
  personalMainApplicationApi,
} from "../../api/AgreementApi";
import { getAccountCheckApi, getAccountCheckFilesApi } from "../../api/MasterApi";
import { userState } from "../../modules/Client/Auth/Auth";
import { alertModalState, loadingModalState } from "../../modules/Client/Modal/Modal";
import { useData, useSendData } from "../../modules/Server/QueryHook";
import RoleUtils from "../../utils/RoleUtils";
import IssuedAgreementView from "../../view/Agreement/IssuedAgreementView";
import Layout from "../Common/Layout/Layout";

export interface AttachedFileType {
  identityFile: AttachedFileContentType;
  passbookFile: AttachedFileContentType;
  certificateFile: AttachedFileContentType;
  coverIdentityFile: AttachedFileContentType;
  etcFile: AttachedFileContentType;
  coverCertificateFile: AttachedFileContentType;
}

export type AttachedFileContentType = {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  fileName: string;
  fileUrl: string;
};

function AgreementView({ type }: { type?: string }) {
  const params = useParams();
  const navigate = useNavigate();
  const state = useLocation()?.state as { id: string; isPin: boolean };
  const uuid = params.uuid ?? state.id;
  const userData = useRecoilValue(userState);
  const role = RoleUtils.getClientRole(userData.role);
  const alertModal = useSetRecoilState(alertModalState);
  const loadingModal = useSetRecoilState(loadingModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);

  const isAccountant: boolean = RoleUtils.isAccountant(userData.isAccountant);

  const [attachedFileData, setAttachedFileData] = useState<AttachedFileType | null>(null);

  const goBack = () => {
    navigate(-1);
  };

  // 계좌이체거래약정서 pdf 가져오기 api
  const getAccountApplicationPDF = useMutation(getAccountApplicationPDFApi, {
    onMutate() {
      loadingModal({
        isButton: false,
        isModal: true,
        isBlockChain: true,
      });
    },
  });
  // 주 계좌거래약정서 신청 api
  // 개인
  const personalMainApplication = useSendData(personalMainApplicationApi);
  // 법인
  const companyMainApplication = useSendData(companyMainApplicationApi);

  // 회계담당자 계좌이체거래약정서 파일 가져오기
  const getAccountCheckFiles = useData<AttachedFileType, string>(
    ["getAccountCheckFiles", null],
    () => getAccountCheckFilesApi(uuid),
    {
      enabled: isAccountant ? true : false,
      onSuccess(item) {
        if (!item.data.identityFile && !item.data.certificateFile && !item.data.passbookFile) {
          setAttachedFileData(null);
        } else {
          setAttachedFileData(item.data);
        }
      },
    }
  );

  // 회계담당자 계좌이체거래약정서 파일 확인
  const getAccountCheck = useData<string, any>(
    ["getAccountCheck", null],
    () => getAccountCheckApi(uuid),
    { enabled: false }
  );

  useEffect(() => {
    if (uuid) {
      getAccountApplicationPDF.mutate(
        { uuid },
        {
          onSuccess(data) {
            // pdf 파일 띄워주기 위한 작업
            const file = new Blob([data.data], {
              type: "application/pdf",
            });
            const fileURL = URL.createObjectURL(file);
            setTimeout(() => {
              resetLoadingModal();
              setUrl(fileURL);
            }, 2000);
          },
          onError(data: any) {
            resetLoadingModal();
            alertModal({
              isModal: true,
              content: data.response.statusText,
              onClick() {
                navigate(-1);
              },
              type: "check",
            });
          },
        }
      );
    } else {
      navigate("/");
    }
  }, []);

  const [url, setUrl] = useState("");

  const clickMainApplicationButton = () => {
    alertModal({
      isModal: true,
      content: "주거래계좌로 등록하시겠습니까?",
      onClick() {
        if (role === "company") {
          companyMainApplication.mutate(
            { uuid },
            {
              onSuccess() {
                alertModal({
                  isModal: true,
                  content: "주 계좌이체거래약정서가 설정되었습니다.",
                });
              },
            }
          );
        }
        if (role === "personal") {
          personalMainApplication.mutate(
            { uuid },
            {
              onSuccess() {
                alertModal({
                  isModal: true,
                  content: "주 계좌이체거래약정서가 설정되었습니다.",
                });
              },
            }
          );
        }
      },
    });
  };

  const onComplete = () => {
    getAccountCheck.refetch();
  };

  return (
    <Layout
      notSideBar={type !== "admin"}
      notHeadTitle={type !== "admin"}
      useFooter={type !== "admin"}
    >
      <IssuedAgreementView
        clickMainApplicationButton={clickMainApplicationButton}
        type={type}
        isApplication
        url={url}
        isPin={state?.isPin}
        goBack={goBack}
        isAccountant={isAccountant}
        attachedFileData={attachedFileData}
        onComplete={onComplete}
      />
    </Layout>
  );
}

export default AgreementView;
