// 내정보 interface
export interface MyInfoRes {
  id: string;
  name: string;
  phone: string;
  email: string;
  password: string;
  companyName?: string;
  username?: string;
  companyId?: number;
}
// 정보 변경 내역
export interface IMyInfoChangeRes {
  before: string;
  after: string;
  changeAt: string;
  changeType: string;
}
