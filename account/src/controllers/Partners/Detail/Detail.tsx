import { AxiosResponse } from "axios";
import { useEffect, useState } from "react";
import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
import { useQuery } from "react-query";
import { useLocation, useNavigate } from "react-router";
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
import MaskingGuide from "../../../components/Modal/MaskingGuide";
import {
  IAdminAgreement,
  IFilePathData,
  IUserDetailData,
} from "../../../interface/Master/MasterData";
import { AgreementDetailRes, UserDetailRes } from "../../../interface/Master/MasterRes";
import {
  alertModalState,
  contentModalState,
  loadingModalState,
} from "../../../modules/Client/Modal/Modal";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import RoleUtils from "../../../utils/RoleUtils";
import DetailView from "../../../view/Partners/DetailView/DetailView";
import Layout from "../../Common/Layout/Layout";

export interface IAccept {
  accept: string;
  reason: string;
  adjustmentAccount: string;
  payment: string;
  method: string;
  wtCode: string;
  fileData: File;
  residentRegistrationNumber: string;
}

export interface IFile {
  path: string;
  name: string;
}

export default function Detail({ type }: { type: string }) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const setContentModal = useSetRecoilState(contentModalState);
  const resetContentModal = useResetRecoilState(contentModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const setLoadingModal = useSetRecoilState(loadingModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const navigate = useNavigate();
  const state = useLocation().state as { id: string; role: string };
  const id = state?.id;
  const role = RoleUtils.getClientRole(state?.role);

  // 첨부파일 목록 가림처리 뷰어 state
  const [show, setShow] = useState(false);

  // 첨부파일 확인 뷰어 state
  const [viewShow, setViewShow] = useState(false);

  // 첨부파일 목록 가림처리 설명 알림 state
  const [explanationShow, setExplanationShow] = useState(false);

  const changeShow = () => {
    setFileUrl("");
    setShow(false);
    setViewShow(false);
    setExplanationShow(false);
    setFile({
      path: "",
      name: "",
    });
  };

  useEffect(() => {
    if (!state?.id || !state?.role) navigate("/");
  }, [state?.id, state?.role]);

  // 서버에서 가져온  파일 주소
  const [fileUrl, setFileUrl] = useState("");

  // 파일 경로 용 state
  const [file, setFile] = useState<IFile>({
    path: "",
    name: "",
  });
  const clickFileList = (file: IFile) => {
    if (getFilePath.isLoading) {
      return;
    }
    setViewShow(true);
    setTimeout(() => {
      setFile((prev) => ({ name: file.name, path: file.path }));
    }, 10);
  };

  // ============================================API 연결

  // detail 유저정보 data
  const userDetailData = { id };
  // user detail api
  const { data: userData } = useData<UserDetailRes, IUserDetailData>(
    ["userData", userDetailData],
    userDetailApi,
    {
      enabled: type === "user" || role === "userAgreement",
    }
  );
  // agreement detail api
  const { data: agreementData } = useData<AgreementDetailRes, string | null>(
    ["userData", id],
    agreementDetailApi,
    {
      enabled: role !== "userAgreement" && type === "agreement",
    }
  );

  // 회원가입 승인 api
  const userApply = useSendData(applyApi);
  const userReject = useSendData(rejectApi);
  // 계좌이체거래약정서 승인 api
  const agreementApproval = useSendData(agreementApprovalApi, {
    onError(errors: any) {
      setAlertModal({
        isModal: true,
        content: errors.response.data.message,
      });
      resetLoadingModal();
      changeShow();
      // 
    },
  });
  const agreementReject = useSendData(agreementRejectApi);

  // 계좌이체거래약정서 첨부파일 다운로드 api
  const getFilePath = useQuery<AxiosResponse<Blob>, IFilePathData>(
    ["getFilePath", { type: "ACCOUNT", path: file?.path }],
    () => filePathApi({ type: "ACCOUNT", path: file?.path }),
    {
      enabled: !!file?.path,
      onSuccess(data) {
        setFileUrl(window.URL.createObjectURL(data.data));
        setShow(true);
      },
      retry: false,
    }
  );
  // 계좌이체거래약정서 첨부파일 삭제 api
  // ====================================== Form 관련
  const { register, handleSubmit, watch, setValue } = useForm<IAccept>({});

  const accept = watch("accept");

  const onValid: SubmitHandler<IAccept> = (formData) => {
    if (
      userApply.isLoading ||
      userReject.isLoading ||
      agreementApproval.isLoading ||
      agreementReject.isLoading
    )
      return;
    const {
      accept,
      reason,
      adjustmentAccount,
      payment,
      method,
      wtCode,
      fileData,
      residentRegistrationNumber,
    } = formData;

    if (!accept) {
      setAlertModal({
        isModal: true,
        content: "승인 여부를 선택해주세요.",
      });
      return;
    }

    changeShow();

    // 계좌이체거래약정서 승인 반려
    if (type === "agreement") {
      if (accept === "yes") {
        // if (!adjustmentAccount || !payment || method || wtCode || fileData) return;

        let formData = new FormData();

        formData.append("adjustmentAccount", adjustmentAccount);
        formData.append("payment", payment);
        formData.append("method", method);
        formData.append("uuid", id);

        if (agreementData?.data.manager) {
          // 사업자일 경우
          formData.append("certificateFile", fileData);
        } else {
          // 개인일 경우
          formData.append("identityFile", fileData);
          formData.append("wtCode", wtCode);
          formData.append("residentRegistrationNumber", residentRegistrationNumber.replace(/-/g,""));
        }

        agreementApproval.mutate(formData, {
          onSuccess() {
            setAlertModal({
              isModal: true,
              content:
                "승인 되었습니다. SAP 구매처 생성/변경 승인요청에서 3단 결재를 올려주시기 바랍니다.",
              type: "check",
              buttonText: "확인/ SAP 바로가기",
              onClick() {
                // navigate("/west/partners/agreement");
                window.location.replace(
                  "http://winers.iwest.co.kr/irj/servlet/prt/portal/prtroot/com.sap.portal.appintegrator.sap.Transaction/tx.sapssd?TCode=ZFIAPR0010&ApplicationParameter=&AutoStart=false&GuiType=WinGui&System=SAP_ECC&WinGui_Type=StructuredDocument&%24Roundtrip=true&%24DebugAction=null"
                );
              },
            });
          },
        });
      } else {
        const data = { reason, uuid: id };
        agreementReject.mutate(data, {
          onSuccess() {
            setAlertModal({
              isModal: true,
              content: "반려 되었습니다.",
              type: "check",
              onClick() {
                navigate("/west/partners/agreement");
              },
            });
          },
        });
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

  // 담당자 추가정보 입력 후 다음 진행
  const onNextFlow = () => {
    const { accept, adjustmentAccount, payment, method, wtCode, residentRegistrationNumber } =
      watch();    

    if (accept === "no") return onValid(watch());    

    if (!agreementData?.data.manager && !residentRegistrationNumber)
      return setAlertModal({ isModal: true, content: "신청인 주민등록번호를 입력해주세요." });

    if(!agreementData?.data.manager){
      // 주민번호 자릿수 및 유효성 검사
      
      if(!/^\d{13}$/.test(residentRegistrationNumber.replace(/-/g,""))){
        return setAlertModal({ isModal: true, content: "주민등록번호는 13자리여야 합니다. 다시 확인해 주세요."});
      }else{
        const data = residentRegistrationNumber.replace(/-/g,"");
        const multipleList = [2,3,4,5,6,7,8,9,2,3,4,5];
        let sum = 0;

        for(var i =0; i< 12; i++){
          sum += parseInt(data[i], 10) * multipleList[i];
        }

        const remain = (11 -(sum % 11)) % 10;
        const check = parseInt(data[12], 10);
        if(remain !== check){
          return setAlertModal({ isModal: true, content: "유효하지 않은 주민등록번호 입니다. 다시 확인해 주세요"});
        }      
      }
    }

    if (!adjustmentAccount)
      return setAlertModal({ isModal: true, content: "조정계정을 선택해주세요." });

    if (!payment) return setAlertModal({ isModal: true, content: "지급조건을 선택해주세요." });

    if (!method) return setAlertModal({ isModal: true, content: "지급방법을 선택해주세요." });

    if (!agreementData?.data.manager && !wtCode)
      return setAlertModal({ isModal: true, content: "원천세 코드를 선택해주세요." });

    if (!accept) return setAlertModal({ isModal: true, content: "승인여부를 선택해주세요." });

    const fileData = agreementData?.data.certificateFile
      ? agreementData?.data.certificateFile
      : agreementData?.data.identityFile;

    if (fileData) {
      setFile({ name: fileData.fileName, path: fileData.fileUrl });
    }

    setContentModal({
      isModal: true,
      content: <MaskingGuide type={!agreementData?.data.manager ? "private" : "company"} />,
      subText: "마스킹 방법을 숙지 하신 후 아래의 '다음' 버튼을 눌러주세요.",
      title: "첨부파일 마스킹 안내",
      buttonText: "확인",
      type: "button",
      onClick: () => {
        setExplanationShow(true);
        resetContentModal();
      },
    });
  };

  // 최종 저장
  const onSaveData = (file: File) => {
    setValue("fileData", file);
    setShow(false);

    setTimeout(() => {
      onValid(watch());
    }, 10);
  };

  return (
    <Layout>
      <DetailView
        infoData={userData?.data as UserDetailRes}
        agreementData={agreementData?.data as AgreementDetailRes}
        isButton={false}
        role={role}
        register={register}
        onSubmit={handleSubmit(onValid, inValid)}
        accept={accept}
        onDeleteClick={onDeleteClick}
        clickFileList={clickFileList}
        id={id}
        fileUrl={fileUrl}
        show={show}
        changeShow={changeShow}
        file={file}
        onNextFlow={onNextFlow}
        onSaveData={onSaveData}
        viewShow={viewShow}
        explanationShow={explanationShow}
      />
    </Layout>
  );
}
