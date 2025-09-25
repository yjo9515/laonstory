import { passType } from "../components/Modal/Nice/NiceComplete";
import {
  IAdminLogin,
  IAuthEmail,
  IAuthReSendEmail,
  IAuthSendEmail,
  ICommitterInvitation,
  ICommitterInvitationCode,
  ICommitterLogin,
  ICommitterSignup,
  ICompanySignup,
  IDuplicateEmailData,
  IDuplicateUserData,
  IFindId,
  IFindPassword,
  IUserLogin,
  IUserLoginSecound,
} from "../interface/Auth/ApiDataInterface";
import { IInviteCommitter, IInviteCommitter2 } from "../interface/Master/MasterData";
import axios from "./DefaultClient";

/** 평가의원 회원가입 */
export const committerSignupApi = (data: ICommitterSignup | {}) => {
  return axios.post("auth/committer/signup", data);
};
// 제안업체 회원가입
export const companySignupApi = (data: ICompanySignup | {}) => {
  return axios.post("auth/company/signup", data);
};
// 아이디 중복체크
export const duplicateIdCheck = (data: { username: string } | null) => {
  return axios.get(`auth/username?username=${data?.username}`);
};
// 이메일 중복체크
export const duplicateEmail = (data: IDuplicateEmailData | null) => {
  return axios.get(`auth/email?email=${data?.email}`);
};

// 유저 중복체크
export const duplicateUserCheck = (data: IDuplicateUserData | null) => {
  return axios.post(`auth/duplicate`, data);
};


// 평가위원 초대
export const committerInvitation = (data: ICommitterInvitation) => {
  return axios.get(`auth/committer/invitation?email=${data.email}`);
};

// 평가위원 초대코드 확인
export const checkInvitationCodeApi = (data: ICommitterInvitationCode) => {
  return axios.get(`auth/committer/code?code=${data.code}`,);
};

// 초대 코드로 평가위원  등록 완료
export const invitationCommitterApi = (data: IInviteCommitter2) => {
  return axios.post(`/committer/invitation`, data);
};

// 이메일 인증코드 보내기
export const authSendEmailApi = (data: IAuthSendEmail) => {
  return axios.post("auth/email/code", data);
};

/**이메일 재전송 api*/
export const authReSendEmailApi = (data: IAuthReSendEmail) => {
  return axios.post("auth/email/code/resend", data);
};

/** 이메일 인증 api */
export const authEmailApi = (data: IAuthEmail) => {
  const { uuid, email, code } = data;
  const query = `uuid=${uuid}&email=${email}&code=${code}`;
  return axios.get(`auth/email/verify?${query}`);
};

/** 제안업체 로그인 api */
export const userLoginApi = (data: IUserLogin) => {
  return axios.post("auth/login", data);
};

/** 제안업체 로그인 2차 api */
export const userLoginSecoundApi = (data: IUserLoginSecound) => {
  return axios.post("auth/login/2", data);
};

/** 평가위원 로그인 api */
export const committerLoginApi = (data: ICommitterLogin) => {
  return axios.post("auth/committer-login", data);
};

/** Admin otp 로그인 api */
export const adminOTPLoginApi = (data: IAdminLogin) => {
  return axios.post("auth/login/otp", data);
};

/** Admin otp 로그인 api */
export const adminHandLoginApi = (data: IAdminLogin) => {
  return axios.post("auth/login/fido", data);
};

/** 로그아웃 api */
export const logoutApi = () => {
  return axios.post("auth/logout");
};


/** jwt refresh api */
export const committerRefreshTokenApi = () => {
  return axios.post("auth/committer/refresh");
};
/** jwt refresh api */
export const companyRefreshTokenApi = () => {
  return axios.post("auth/company/refresh");
};
/** jwt refresh api */
export const masterRefreshTokenApi = () => {
  return axios.post("auth/master/refresh");
};






/** 아이디 찾기 api */
export const findIdApi = (data: IFindId) => {
  return axios.post("auth/find", data);
};

/** 비밀번호 찾기 api */
export const findPasswordApi = (data: IFindPassword) => {
  return axios.post("auth/find/pw", data);
};

/** 나이스 본인인증 신청 api */
export const passRequestApi = (url: string) => {
  return axios.post(`auth/pass`, { redirectUrl: url });
};

/** 나이스 본인인증 요청 api */
export const passDecRequestApi = (data: passType) => {
  return axios.post(`auth/pass/dec`, data);
};

/** 로그인 2차 전화번호 인증 */
export const loginPhoneCheckApi = (data: { name: string; phone: string }) => {
  return axios.post(`auth/login/2`, data);
};

/** SSO 로그인 */
export const ssoLoginApi = (sso: string) => {
  const data = {
    value: sso,
  };
  return axios.post(`auth/login/sso`, data);
};

/** 매뉴얼 다운로드 */
export const downloadManual = () => {
  return axios.get(`manual`, {
    responseType: "blob",
  });
};

/** 담당자 이름 찾기 */
export const getEmpApi = (data: { name: string; type: string }) => {
  return axios.get(`auth/emp`, { params: { name: data.name } });
};

/** 회원탈퇴 api */
export const deleteUserApi = async (id: number) => {
  const data = {
    id: id
  }  
  return axios.post('auth/out', data);
};