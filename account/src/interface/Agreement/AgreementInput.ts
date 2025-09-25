export interface IAgreementInput {
  check1: boolean; //동의
  name: string; // 이름
  name1: string;
  registerNum1: string; //주민번호
  registerNum2: string; //주민번호
  companyBirthNum: string;
  corporateNumber: string; //법인등록번호
  corporateType: string; // 법인 종류
  businessType: string; // 업종
  businessConditions: string; // 업태
  birth: string;
  phone: string; //전화번호
  phoneCheck: boolean; // 본인인증
  email: string; //이메일
  postCode: string;
  postCode1: string;
  address: string; //주소
  fullAddress: string; // 풀 주소
  bank: string; //은행
  bankCode: string;
  account: string; //계좌번호
  accountName: string; // 예금주
  relation: string; //약정자와의 관계
  accountCheck: boolean; //계좌 검증
  IDFile: File[]; //신분증 사본
  bankBook: File[]; // 통장사본
  certificateFile: File[]; //인감증명서
  BusinessRegistration: File[]; //사업자등록증
  etcFile: File[]; // 기타파일
  IDFileName: string; //신분증 사본 목록
  bankBookName: string; //통장사본 목록
  companyNum: string; //사업자 등록번호
  companyName: string; // 상호
  mangerName: string; // 법인 담당자 이름
  accountId: string;
  admin: string; //담당자
  selectAdmin: string; // 선택한 담당자
  department: string; //부서명
}
