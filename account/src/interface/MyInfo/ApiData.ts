export interface IMyInfoChange {
  data: string;
  content: string;
  type: string;
}
// company 전화번호 변경
export interface ICompanyChangePhoneData {
  // phone: string;
  password: string;
  // originalPhone: string;
  // managerName: string;
  changeEncData: string;
  encData: string;
}
// company 이메일 변경
export interface ICompanyChangeEmailData {
  uuid: string;
  email: string;
}
// company 비밀번호 변경
export interface ICompanyChangePasswordData {
  // phone: string;
  encData: string;
  newPassword: string;
}

// =============================personal

// personal 전화번호 변경
export interface IPersonalChangePhoneData {
  // phone: string;
  encData: string;
  password: string;
}
// personal 이메일 변경
export interface IPersonalChangeEmailData {
  uuid: string;
  email: string;
}
// personal 비밀번호 변경
export interface IPersonalChangePasswordData {
  // phone: string;
  encData: string;
  newPassword: string;
}
