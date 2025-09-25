// 회원가입
export interface IJoinInput {
  personalAgree: boolean;
  secretAgree: boolean;
  infoAgree: boolean;
  id: string;
  password: string;
  confirmPassword: string;
  adminName: string;
  name: string;
  companyName: string;
  phone: string;
  email: string;
  emailCheck: boolean;
  idCheck: boolean;
  emailUUID: string;
  phoneCheck: boolean;
  [key: string]: string | boolean;
}

// 로그인
export interface ILoginInput {
  id: string;
  password: string;
  [key: string]: string;
}

export interface ILoginFindInput {
  email: string;
  id: string;
  phoneCheck: boolean;
  newPassword: string;
  confirmNewPassword: string;
  encData: string;
  [key: string]: string | boolean;
}

export interface ILoginPhoneInput {
  id: string;
  password: string;
  phoneCheck: boolean;
  [key: string]: string | boolean;
}

// 정보변경
export interface IChangePhone {
  password: string;
  phoneCheck: boolean;
  // phone: string;
  encData: string;
  [key: string]: string | boolean;
}

export interface IChangeEmail {
  newEmail: string;
  authNumber: string;
  emailCheck: boolean;
  emailSend: boolean;
  password: string;
  uuid: string;
  [key: string]: string | boolean;
}

export interface IChangePassword {
  password: string;
  newPassword: string;
  confirmNewPassword: string;
  phoneCheck: boolean;
  phone: string;
  encData: string;
  [key: string]: string | boolean;
}

export interface IChangeAdmin {
  phoneCheck: boolean;
  currentPhoneCheck: boolean;
  password: string;
  managerName: string;
  originalPhone: string;
  phone: string;
  changeEncData: string;
  encData: string;
}
