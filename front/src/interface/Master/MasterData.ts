// admin user 회원가입 승인 및 반려 api data interface
export interface IAdminApplyData {
  type: string;
  id: string;
  reason?: string;
}

// admin agreement 승인 및 반려 api data interface
export interface IAdminAgreement {
  uuid: string;
  reason?: string;
}

// user detail data
export interface IUserDetailData {
  type: string;
  id: string;
}

// 평가위원 초대
export interface IInviteCommitter {
  name: string;
  email?: string;
  birth: string;
  phone: string;
  createdAt?: string;
  id?: string;
}

// 평가위원 초대 코드사용
export interface IInviteCommitter2 {
  name: string;
  email?: string;
  birth: string;
  phone: string;
  createdAt?: string;
  code: string;
  id?: string;
}


// 제안업체 초대
export interface IInviteCompany {
  username?: string;
  password?: string;
  name?: string;
  phone?: string;
  email?: string;
  companyName: string;
}

// 약관 data
export interface ITerm {
  title: string;
  content: string;
  type: string;
}

// 약관 타입
export interface ITermType {
  type: "personal" | "consignment" | "security" | "committer";
}

// 파일 경로
export interface IFilePathData {
  path: string;
  type: string;
}

export interface ILogListData {
  page: number;
}

export interface ILogSearchData {
  page : number;
  search : string;
  startDate : string;
  endDate : string;
  type?: string;
}
