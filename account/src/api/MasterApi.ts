import {
  IAdminAgreement,
  IAdminApplyData,
  IFilePathData,
  IInvitePersonal,
  ITerm,
  IUserDetailData,
} from "../interface/Master/MasterData";
import { ILogListData, ILogSearchData } from "../interface/List/ListData";
import axios from "./DefaultClient";

/** Master  User 가입 요청 승인 api*/
export const applyApi = (data: IAdminApplyData) => {
  const { type, id } = data;
  return axios.post(`master/user/apply/${id}`);
};

/** Master User 가입 요청 반려 api*/
export const rejectApi = (data: IAdminApplyData) => {
  const { type, id, reason } = data;
  return axios.post(`master/user/reject/${id}?reason=${reason}`);
};

/** Master 사용자 상세 api*/
export const userDetailApi = (data: IUserDetailData | null) => {
  return axios.get(`master/user/${data?.id}`);
};
/** 계좌거래이체약성서 상세 api */
export const agreementDetailApi = (uuid: string | null) => {
  return axios.get(`master/account/${uuid}`);
};

/** 계좌이체거래약정서 승인 api */
export const agreementApprovalApi = (data: FormData) => {
  const uuid = data.get("uuid");
  return axios.patch(`master/account/${uuid}/approval`, data);
};
/** 계좌이체거래약정서 반려 api */
export const agreementRejectApi = (data: IAdminAgreement) => {
  const { uuid, reason } = data;
  return axios.patch(`master/account/${uuid}/reject`, { reason });
};
/** 이용자 초대 api*/
export const invitePersonalApi = (data: IInvitePersonal) => {
  return axios.post(`master/invite`, data);
};
/** 약관 수정 api*/
export const termApi = (data: ITerm) => {
  return axios.patch(`term`, data);
};
/** 약관 모두 보기 api*/
export const getAllTermApi = () => {
  return axios.get(`term`);
};
/** 약관 개별 보기 api*/
export const getTermApi = (type: "personal" | "company" | "personal_account" | null) => {
  return axios.get(`term/${type}`);
};
/** 파일 경로 api */
export const filePathApi = (data: IFilePathData) => {
  return axios.get(`resource?path=${data?.path}&type=${data?.type}`, {
    responseType: "blob",
  });
};

/** 회계담당자 계좌이체거래약정서 파일 가져오기 */
export const getAccountCheckFilesApi = (uuid: string) => {
  return axios.get(`master/accounts/check/${uuid}/files`);
};

/** 회계담당자 계좌이체거래약정서 파일 확인 */
export const getAccountCheckApi = (uuid: string) => {
  return axios.get(`master/accounts/check/${uuid}`);
};

/** 계좌이체거래약정서 PDF 데이터 */
export const getAccountQRDocsApi = (uuid: string) => {
  let data = {
    uuid,
  };
  return axios.post(`account/qr/docs`, data, {
    responseType: "blob",
  });
};

/** 블록체인 데이터 */
export const getAccountQRBlockApi = (uuid: string) => {
  let data = {
    uuid,
  };
  return axios.post(`account/qr/block`, data);
};

// 로그 리스트 패스워드체크
export const postLogPasswordApi = (pw:string) => {
  const data = {
    pass : pw
  }
  return axios.post(`master/log/check`, data);
}

// 로그 리스트 패스워드 변경
export const postLogPasswordChangeApi = (data: { password: string; newPassword: string }) => {      
  return axios.post(`master/log/pass`, data);
}

// 로그 리스트
export const getLogApi = (pageState: ILogSearchData | null) => {
  return axios.get(`master/log`, {
    params : {
      page: pageState?.page ? pageState.page + 1 : 1,
      query: pageState?.search,
      startDate: pageState?.startDate,
      endDate: pageState?.endDate,
      type: pageState?.type
    }
  })
}

// 로그 상세
export const getLogDetailApi = (id: string | null) => {
  return axios.get(`master/log/${id}`,   
)
}
