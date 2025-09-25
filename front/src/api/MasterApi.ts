import {
  IAdminAgreement,
  IAdminApplyData,
  IFilePathData,
  IInviteCommitter,
  IInviteCompany,
  ITerm,
  IUserDetailData,
  ILogListData,
  ILogSearchData
} from "../interface/Master/MasterData";
import axios from "./DefaultClient";

/** Master  User 가입 요청 승인 api*/
export const applyApi = (data: IAdminApplyData) => {
  const { type, id } = data;
  return axios.post(`master/user/${type}/apply/${id}`);
};

/** Master User 가입 요청 반려 api*/
export const rejectApi = (data: IAdminApplyData) => {
  const { type, id, reason } = data;
  return axios.post(`master/user/${type}/reject/${id}?reason=${reason}`);
};

/** Master 사용자 상세 api*/
export const userDetailApi = (data: IUserDetailData | null) => {
  let type, id;
  if (data) {
    type = data.type;
    id = data.id;
  }
  return axios.get(`master/user/${type}/${id}`);
};

/** 계좌거래이체약성서 상세 api */
export const agreementDetailApi = (uuid: string | null) => {
  return axios.get(`master/account/${uuid}`);
};

/** 계좌이체거래약정서 승인 api */
export const agreementApprovalApi = (data: IAdminAgreement) => {
  const { uuid } = data;
  return axios.patch(`master/account/${uuid}/approval`);
};
/** 계좌이체거래약정서 반려 api */
export const agreementRejectApi = (data: IAdminAgreement) => {
  const { uuid, reason } = data;
  return axios.patch(`master/account/${uuid}/reject`, { reason });
};
/** 평가위원 초대 api*/
export const inviteCommitterApi = (data: IInviteCommitter) => {
  return axios.post(`master/committer`, data);
};
/** 평가위원 수정 */
export const modifyCommitterApi = (data: IInviteCommitter) => {
  const { id, ...apiData } = data;
  return axios.patch(`master/committer/${id}`, apiData);
};
/** 평가위원 삭제 */
export const deleteCommitterApi = (id: string) => {
  return axios.delete(`master/committer/${id}`);
};

/** 제안업체 등록 */
export const inviteCompanyApi = (data: IInviteCompany) => {
  return axios.post(`master/company`, data);
};

/** 약관 수정 api*/
export const termApi = (data: ITerm) => {
  return axios.patch(`term`, data);
};

/** 약관 모두 보기 api*/
export const getAllTermApi = () => {
  return axios.get(`term`);
};

/** 약관 모두 보기 api*/
export const getTermApi = (type: "personal" | "consignment" | "security" | "agreement"  | "committer" |null) => {
  return axios.get(`term/${type}`);
};

/** 파일 경로 api */
export const filePathApi = (data: IFilePathData) => {
  return axios.get(`resource?path=${data?.path}&type=${data?.type}`, {
    responseType: "blob",
  });
};

/** 계좌이체거래약정서 PDF 데이터 */
export const getAccountQRDocsApi = (id: string) => {
  let data = {
    evaluationRoomId: id,
  };
  return axios.post(`final-score/qr/docs`, data, {
    responseType: "blob",
  });
};

/** 블록체인 데이터 */
export const getAccountQRBlockApi = (id: string) => {
  let data = {
    evaluationRoomId: id,
  };
  return axios.post(`final-score/qr/block`, data);
};

/** 평가위원 평가표 블록체인 데이터 */
export const getCommitterQrDocsApi = (data: { evaluationRoomId: number; committerId: number }) => {
  return axios.post(`final-score/qr/committer/docs`, data, { responseType: "blob" });
};

export const getCommitterQrBlockApi = (data: { evaluationRoomId: number; committerId: number }) => {
  return axios.post(`final-score/qr/committer/block`, data);
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
    params: {
      page: pageState?.page  ? pageState.page + 1 : 1,
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
