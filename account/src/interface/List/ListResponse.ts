export interface meta {
  totalItems: number;
  itemCount: number;
  itemsPerPage: number;
  totalPages: number;
  currentPage: number;
}

// 이용자 리스트
export interface IPersonalListRes {
  items: IPersonalListResItem[];
  meta: meta;
}
export interface IPersonalListResItem {
  id: string;
  name: string;
  email: string;
  phone: string | null;
  createdAt: string;
  status: string;
  userId: string;
  role: string;
}

// company 리스트
export interface ICompanyListRes {
  items: ICompanyListResItem[];
  meta: meta;
}
export interface ICompanyListResItem {
  id: string;
  companyName: string;
  email: string;
  phone: string | null;
  createdAt: string;
  status: string;
  responsibility?: string;
}

// 평가방 리스트
export interface IAdminListRes {
  items: ICompanyListResItem[];
  meta: meta;
}
export interface IAdminListResItem {
  id: string;
  meetingUrl: string; // 화상 url
  proposedProject: string; // 프로젝트 이름
  evaluationAt: string; // 평가일자
  startAt: string; // 시작시간
  endAt: string; // 종료시간
  enable: boolean; // 입장여부
  status: string;
  noticeContent: string;
  company: string;
  companyCount: number;
}

//계죄이체거래약정서 리스트
export interface IAgreementListRes {
  items: IAgreementListResItem[];
  meta: meta;
}
export interface IAgreementListResItem {
  createdAt: string;
  id: string;
  personalName: string;
  company: {
    id: string;
    createdAt: string;
    updatedAt: string;
    name: string;
    phone: string;
  };
  personal: {
    id: string;
    createdAt: string;
    updatedAt: string;
    name: string;
    phone: string;
  };
  uuid: string;
  status: string;
}

//
export interface IPersonalAgreementListRes {
  items: IPersonalAgreementListData[];
  meta: meta;
}

export interface IPersonalAgreementListData {
  createdAt: string;
  uuid: string;
  bank: string;
  accountNumber: string;
  status: string;
  id?: string;
}

export interface ILogListDataRes {
  items: ILogListItem[];
  meta: meta;
}

export interface ILogListItem {
  id? : number;
  user : string;
  url : string;
  action : string;
  statusCode : number;
  ip : string;
  createdAt : string;
  param : string;
  body : string;
  response : string;
  query : string;
}
