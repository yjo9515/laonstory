export interface IUser {
  id?: string;
  // 공통 회원 정보
  username?: string; // 아이디 (admin 제와)
  name?: string; // 이름 or // 담당자 이름
  email?: string; // 이메일
  phone?: string; // 전화번호 or //담당자 전화번호
  role: string; //권한
  emailUUID?: string;
  // company
  companyName?: string; // 업체명
  // committer
  bank?: string;
  accountName?: string;
  accountNumber?: string;
  // admin
  empId?: string;
  birth?: string;
}

export interface ISSOLogin {
  ssoCheck: boolean;
  logoutCheck: boolean;
}
