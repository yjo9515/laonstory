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
}

// committer 회원가입
export interface ICommitterSignup {
  username: string;
  password: string;
  name: string;
  phone: string;
  email: string;
  emailUUID: string;
}

// committer 초대
export interface ICommitterInvitation {
  email: string;
}


// committer 코드 확인 및 삭제
export interface ICommitterInvitationCode {
  code: string;
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
  manager: string;
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

// 제안업체 로그인
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

// 평가위원 로그인
export interface ICommitterLogin {
  // name: string;
  // phone: string;
  // birth: string;
  encData: string;
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
