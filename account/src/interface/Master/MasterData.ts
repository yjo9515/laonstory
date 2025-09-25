// admin user 회원가입 승인 및 반려 api data interface
export interface IAdminApplyData {
  type: string;
  id: string;
  reason?: string;
}

// admin agreement 승인 및 반려 api data interface
export interface IAdminAgreement {
  uuid?: string;
  reason?: string;
  adjustmentAccount?: string;
  payment?: string;
  method?: string;
  wtCode?: string;
  certificateFile?: File | string;
  identityFile?: File | string;
}

// user detail data
export interface IUserDetailData {
  id: string;
}

// 이용자 초대
export interface IInvitePersonal {
  name: string;
  email: string;
}

// 약관 data
export interface ITerm {
  title: string;
  content: string;
  type: string;
}

// 약관 타입
export interface ITermType {
  type: "personal" | "company" | "personal_account";
}

// 파일 경로
export interface IFilePathData {
  path: string;
  type: string;
}
