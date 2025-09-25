import { IAgreementListResItem } from "../List/ListResponse";

export interface UserDetailRes {
  userInfoChangeHistoryList: IUserInfoChangeHistoryList[];
  id: string;
  name: string;
  phone: string;
  email: string;
  password: string;
  adminVerify: string;
  rejectReason: null;
  companyName?: string;
  username?: string;
  userId?: string;
}

export interface LogDetailRes {
  id: string;
  user: string;
  master: string;
  action: string;
  url: string;
  statusCode: number;
  ip: string;
  param: string;
  query: string;
  body:string;
  response:string;
  createdAt:string;
  who:any;
  infoCount:string;
}

// export interface UserData {
//   id: string;
//   role: string;
//   name: string;
// }

export interface IUserInfoChangeHistoryList {
  after: string;
  before: string;
  changeAt: string;
  changeType: string;
}
export interface AgreementDetailRes {
  accountNumber: string;
  accountName: string;
  accountBank: string;
  birthDay?: string;
  rejectReason: string;
  id: string;
  updatedAt: string;
  name: string;
  phone: string;
  createdAt: string;
  email: string;
  deletedAt: null;
  identityFile: IIdentityFile;
  passbookFile: IPassbookFile;
  certificateFile?: ICertificateFile;
  etcFile?: IEtcFile;
  status: string;
  idNumber: string;
  address: string;
  contractor?: string;
  manager?: string;
  postCode: string;
  userId: string;
  businessType? : string | null;
  businessConditions? : string | null;
}

export interface IIdentityFile {
  id: string;
  createdAt: string;
  updatedAt: string;
  fileName: string;
  fileUrl: string;
}
export interface IPassbookFile {
  id: string;
  createdAt: string;
  updatedAt: string;
  fileName: string;
  fileUrl: string;
}

export interface ICertificateFile {
  id: string;
  createdAt: string;
  updatedAt: string;
  fileName: string;
  fileUrl: string;
}

export interface IEtcFile {
  id: string;
  createdAt: string;
  updatedAt: string;
  fileName: string;
  fileUrl: string;
}
