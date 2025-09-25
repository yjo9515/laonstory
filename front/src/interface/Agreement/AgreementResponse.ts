/**계좌이체거래약정서 발급 유무 Res */
export interface IAgreementCheckRes {
  code: string;
  message: string;
}

export interface IAgreementApplicationRes {
  accountName: string;
  accountBank: string;
  accountNumber: string;
  birthDay: string;
  identityFile: File[];
  passbookFile: File[];
  id: string;
}
