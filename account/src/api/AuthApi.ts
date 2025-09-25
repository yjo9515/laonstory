import { passType } from "../components/Modal/Nice/NiceComplete";
import {
  IAdminLogin,
  IAuthEmail,
  IAuthReSendEmail,
  IAuthSendEmail,
  IPersonalSignup,
  ICompanySignup,
  IDuplicateEmailData,
  IFindId,
  IFindPassword,
  IUserLogin,
  IUserLoginSecound,
  IDuplicateUserData,
  IDeleteId,
} from "../interface/Auth/ApiDataInterface";
import axios from "./DefaultClient";

/** 개인 회원가입 */
export const personalSignupApi = (data: IPersonalSignup | {}) => {
  return axios.post("auth/personal/signup", data);
};
// 법인 회원가입
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


// 유저 중복체크
export const duplicateUserCheck = (data: IDuplicateUserData | null) => {
  return axios.post(`auth/duplicate`, data);
};

/** User 로그인 api */
export const userLoginApi = (data: IUserLogin) => {
  return axios.post("auth/login", data);
};

/** User 로그인 2차 api */
export const userLoginSecoundApi = (data: IUserLoginSecound) => {
  return axios.post("auth/login/2", data);
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
export const refreshTokenApi = () => {
  return axios.post("auth/user/refresh");
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

/** SSO 로그인 */
export const ssoLoginApi = (sso: string) => {
  const data = {
    value: sso,
  };
  return axios.post(`auth/login/sso`, data);
};

/** 로그인 2차 전화번호 인증 */
export const loginPhoneCheckApi = (data: { name: string; phone: string }) => {
  return axios.post(`auth/login/2`, data);
};

/** 로그인 전 전화번호 변경 본인 확인 전화번호 인증 */
export const changePhoneCheckApi = (data: {
  id: string;
  password: string;
  name: string;
  phone: string;
}) => {
  return axios.post(`auth/change/phone`, data);
};

/** personal 계정 탈퇴  */
export const personalDeleteUserApi = async () => {  
  return axios.post(`auth/out`);
};
