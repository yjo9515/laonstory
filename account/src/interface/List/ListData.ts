//  이용자 리스트 api data
export interface IPersonalListData {
  page: number;
  search: string;
}

// 평가방 리스트 api data
export interface IEvaluationListData {
  page: number;
  search: string;
}

// 계좌이체거래약정서 리스트 api data
export interface IAgreementListData {
  page: number;
  search: string;
}

// 유저가 발급한 계좌이체거래약정서 리스트 api data
export interface IUserAgreementListData {
  id: string;
  page: number;
}

export interface ILogListData {
  page : number;
}

export interface ILogSearchData {
  page : number;
  search : string;
  startDate : string;
  endDate : string;
  type?: string;
}