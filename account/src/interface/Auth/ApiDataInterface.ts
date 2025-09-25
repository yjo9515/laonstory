// 아이디 중복확인
export interface IDuplicateIdData {
  username: string;
}
// 이메일 중복확인
export interface IDuplicateEmailData {
  email: string;
}


// 유저 중복확인
export interface IDuplicateUserData {
  name: string;
  phone: string;
  type: string | undefined;
}


// Personal 회원가입
export interface IPersonalSignup {
  username: string;
  password: string;
  name: string;
  phone: string;
  email: string;
  emailUUID: string;
}
// company 회원가입
export interface ICompanySignup {
  username: string;
  password: string;
  name: string;
  phone: string;
  email: string;
  emailUUID: string;
  companyName: string;
}

// 이메일 인증코드 보내기
export interface IAuthSendEmail {
  email: string;
}

/** 이메일 인증코드 재전송 인터페이스*/
export interface IAuthReSendEmail {
  email: String;
  uuid: string;
}

//  이메일 인증
export interface IAuthEmail {
  uuid: string;
  email: string;
  code: string;
}

// user 로그인
export interface IUserLogin {
  id: string;
  password: string;
}

// user 로그인 2차
export interface IUserLoginSecound {
  // name: string;
  // phone: string;
  encData: string;
  accessCode: string;
  id: string;
}

// admin 로그인
export interface IAdminLogin {
  id: string;
  password?: string;
}

// 아이디 찾기
export interface IFindId {
  email: string;
}
// 비밀번호 찾기
export interface IFindPassword {
  id: string;
  password: string;
  // phone: string;
  encData: string;
}

export interface IDeleteId{
  id: string
}
