export interface IAgreementInput {
  check1: boolean; //동의
  name: string; // 이름
  registerNum1: string; //주민번호
  registerNum2: string; //주민번호
  phone: string; //전화번호
  phoneCheck: boolean; // 본인인증
  email: string; //이메일
  address: string; //주소
  fullAddress: string; // 풀 주소
  bank: string; //은행
  account: string; //계좌번호
  accountName: string; // 예금주
  relation: string; //약정자와의 관계
  accountCheck: boolean; //계좌 검증
  IDFile: File[]; //신분증 사본
  bankBook: File[]; // 통장사본
  IDFileName: string; //신분증 사본 목록
  bankBookName: string; //통장사본 목록
}
