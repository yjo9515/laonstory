//  평가위원 리스트 api data
export interface ICommitterListData {
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
  type: string;
}
