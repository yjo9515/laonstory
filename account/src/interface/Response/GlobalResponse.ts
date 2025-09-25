// Front Response interface data 형식만 따로 지정해서 사용 (data 부분만)
export interface GlobalResponse<T> {
  data: T;
  pageInfo?: pageInfo;
  message?: string;
  statusCode?: number;
}
export interface pageInfo {
  //현재 페이지 번호
  page: number;
  //페이지 당 데이터 수
  size: number;
  //전체 페이지 수
  totalPage: number;
  //전체 데이터 수
  totalCount: number;
  //첫 페이지 여부
  isFirst: boolean;
  //마지막 페이지 여부
  isLast: boolean;
  //이전 페이지 유무 여부
  hasPrevious: Boolean;
  //다음 페이지 유무 여부
  hasNext: Boolean;
}

// global Response Test 객체
const test: GlobalResponse<IData> = {
  data: {
    name: "Asdasd",
    password: "asdasd",
  },
  pageInfo: {
    page: 1,
    size: 2,
    totalPage: 3,
    totalCount: 4,
    isFirst: true,
    isLast: true,
    hasPrevious: true,
    hasNext: true,
  },
  message: "dasdasd",
  statusCode: 200,
};

interface IData {
  name: string;
  password: string;
}
