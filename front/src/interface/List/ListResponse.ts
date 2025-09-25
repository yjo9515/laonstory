export interface meta {
  totalItems: number;
  itemCount: number;
  itemsPerPage: number;
  totalPages: number;
  currentPage: number;
}

// 평가위원 리스트
export interface ICommitterListRes {
  items: ICommitterListResItem[];
  meta: meta;
}
export interface ICommitterListResItem {
  id: string;
  name: string;
  email: string;
  phone: string | null;
  createdAt: string;
  status: string;
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

export interface ILogListDataRes {
  items: ILogListItem[];
  meta: meta;
}

export interface ILogListItem {
  id?: number;
  user: string;
  url: string;
  action: string;
  statusCode: number;
  ip: string;
  createdAt: string;
  param: string;
  body: string;
  response: string;
  query: string;
}
