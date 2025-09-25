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
}

export interface IUserInfoChangeHistoryList {
  after: string;
  before: string;
  changeAt: string;
  changeType: string;
}

export interface ResponseDataRes{
  id: number;
  user: string;
  master: string;
  url: string;
  action: string;
  param: string; 
  body: string;  
  response: string; 
  query: string; 
  statusCode: number;
  ip: string;
  createdAt: string;
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

export interface AgreementDetailRes {
  id: string;
  accountNumber: string;
  accountName: string;
  accountBank: string;
  birthDay: string;
  fileUrl: null;
  rejectReason: string;
  committer: {
    id: string;
    createdAt: string;
    updatedAt: string;
    name: string;
    phone: string;
    auth: {
      id: string;
      createdAt: string;
      updatedAt: string;
      username: string;
      email: string;
      rejectReason: null;
      deletedAt: null;
    };
  };
  identityFile: IIdentityFile;
  passbookFile: IPassbookFile;
  createdAt: string;
  updatedAt: string;
  status: string;
  idNumber: string;
  address: string;
  relations: string;
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
