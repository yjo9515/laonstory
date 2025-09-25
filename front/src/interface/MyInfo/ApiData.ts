export interface IMyInfoChange {
  data: string;
  content: string;
  type: string;
}
// company 전화번호 변경
export interface ICompanyChangePhoneData {
  // phone: string;
  password: string;
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
  password: string;
  newPassword: string;
}

// =============================committer

// committer 전화번호 변경
export interface ICommitterChangePhoneData {
  phone: string;
  password: string;
}
// committer 이메일 변경
export interface ICommitterChangeEmailData {
  uuid: string;
  email: string;
}
// committer 비밀번호 변경
export interface ICommitterChangePasswordData {
  password: string;
  newPassword: string;
}
