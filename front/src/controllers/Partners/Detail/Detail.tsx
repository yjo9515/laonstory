import { AxiosResponse } from "axios";
import { useState } from "react";
import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
import { useQuery } from "react-query";
import { useNavigate, useParams } from "react-router";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import {
  agreementApprovalApi,
  agreementDetailApi,
  agreementRejectApi,
  applyApi,
  filePathApi,
  rejectApi,
  userDetailApi,
} from "../../../api/MasterApi";
import { IFilePathData, IUserDetailData } from "../../../interface/Master/MasterData";
import { AgreementDetailRes, UserDetailRes } from "../../../interface/Master/MasterRes";
import { alertModalState } from "../../../modules/Client/Modal/Modal";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import DetailView from "../../../view/Partners/DetailView/DetailView";
import Layout from "../../Common/Layout/Layout";

export interface IAccept {
  accept: string;
  reason: string;
}

export interface IFile {
  path: string;
  name: string;
}

export default function Detail({ type }: { type: string }) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const param = useParams();
  const navigate = useNavigate();

  // 파일 경로 용 state
  const [file, setFile] = useState<IFile>({
    path: "",
    name: "",
  });
  const clickFileList = (file: IFile) => {
    if (getFilePath.isLoading) {
      return;
    }

    setFile((prev) => ({ ...prev, name: file.name, path: file.path }));
  };

  // ============================================API 연결
  // detail 유저정보 data
  const userDetailData = { id: param.id as string, type };
  // user detail api
  const { data: userData } = useData<UserDetailRes, IUserDetailData>(
    ["userData", userDetailData],
    userDetailApi,
    {
      enabled: type === "committer" || type === "company",
    }
  );
  // agreement detail api
  const uuid = param?.id as string;

  const { data: agreementData } = useData<AgreementDetailRes, string | null>(
    ["userData", uuid],
    agreementDetailApi,
    {
      enabled: type === "agreement",
    }
  );
  // 회원가입 승인 api
  const userApply = useSendData(applyApi);
  const userReject = useSendData(rejectApi);
  // 계좌이체거래약정서 승인 api
  const agreementApproval = useSendData(agreementApprovalApi);
  const agreementReject = useSendData(agreementRejectApi);

  // 계좌이체거래약정서 첨부파일 다운로드 api

  const getFilePath = useQuery<AxiosResponse<Blob>, IFilePathData>(
    ["getFilePath", { type: "ACCOUNT", path: file?.path }],
    () => filePathApi({ type: "ACCOUNT", path: file?.path }),
    {
      enabled: !!file?.path,
      onSuccess(data) {
        const link = document.createElement("a");
        link.href = window.URL.createObjectURL(data.data);
        link.setAttribute("download", file.name);
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        setFile({
          path: "",
          name: "",
        });
      },
      retry: false,
    }
  );
  // 계좌이체거래약정서 첨부파일 삭제 api

  // ====================================== Form 관련
  const { register, handleSubmit, watch } = useForm<IAccept>({});

  const accept = watch("accept");

  const onValid: SubmitHandler<IAccept> = (formData) => {
    if (
      userApply.isLoading ||
      userReject.isLoading ||
      agreementApproval.isLoading ||
      agreementReject.isLoading
    )
      return;
    const { accept, reason } = formData;

    // 계좌이체거래약정서 승인 반려
    if (type === "agreement") {
      const data = { reason, uuid };
      if (accept === "yes") {
        agreementApproval.mutate(data, {
          onSuccess() {
            setAlertModal({
              isModal: true,
              content: "승인 되었습니다.",
              type: "check",
              onClick() {
                navigate("/west/system/agreement");
              },
            });
          },
        });
      }
      if (accept === "no") {
        agreementReject.mutate(data, {
          onSuccess() {
            setAlertModal({
              isModal: true,
              content: "반려 되었습니다.",
              type: "check",
              onClick() {
                navigate("/west/system/agreement");
              },
            });
          },
        });
      }
    }
    if (type === "company") {
      if (accept === "yes") {
        userApply.mutate(
          { type: "company", id: param.id as string },
          {
            onSuccess() {
              setAlertModal({
                isModal: true,
                content: "승인 되었습니다.",
                type: "check",
                onClick() {
                  navigate("/west/system/company");
                },
              });
            },
          }
        );
      }
      if (accept === "no") {
        userReject.mutate(
          { type: "company", id: param.id as string, reason },
          {
            onSuccess() {
              setAlertModal({
                isModal: true,
                content: "반려 되었습니다.",
                type: "check",
                onClick() {
                  navigate("/west/system/company");
                },
              });
            },
          }
        );
      }
    }
  };
  const inValid: SubmitErrorHandler<IAccept> = (errors) => {
    setAlertModal({
      isModal: true,
      content: errors.reason?.message,
    });
  };

  // 삭제 버튼 클릭 이벤트
  const onDeleteClick = () => {
    setAlertModal({
      isModal: true,
      content: "파일을 삭제하시겠습니까?",
      onClick() {
        resetAlertModal();
      },
    });
  };

  return (
    <Layout>
      <DetailView
        infoData={userData?.data as UserDetailRes}
        agreementData={agreementData?.data as AgreementDetailRes}
        isButton={false}
        type={type}
        register={register}
        onSubmit={handleSubmit(onValid, inValid)}
        accept={accept}
        onDeleteClick={onDeleteClick}
        clickFileList={clickFileList}
      />
    </Layout>
  );
}
