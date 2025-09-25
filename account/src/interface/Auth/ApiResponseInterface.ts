/** 이메일인증번호 전송 Response */
export interface IAuthSendEmailResponse {
  uuid: string;
}

/** 이메일인증번호 재전송 Response */
export interface IAuthReSendEmailResponse {
  uuid: string;
}

/**  user 로그인 Response  */
export interface IUserLoginResponse {
  access_token: string;
  access_code: string;
  info: IUserLoginInfoResponse;
  role: string;
  isChangePassword: boolean;

}

interface IUserLoginInfoResponse {
  id: string;
  name: string;
  phone: string;
}

/** admin 로그인 Response  */
export interface IAdminLoginResponse {
  empId: string;
  name: string;
  phone: string;
  createdAt: string;
  updatedAt: string;
  access_token: string;
}
// company 내정보  res
export interface ICompanyMyInfoRes {}
// company 내정보 변경 내역 res
export interface ICompanyMyHistoryRes {}
// personal 내정보 res
export interface IPersonalMyHistoryRes {}
// personal 내정보 변경 내역 res
export interface IPersonalMyHistoryRes {}
