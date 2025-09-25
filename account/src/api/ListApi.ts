import {
  IAgreementListData,
  IPersonalListData,
  IUserAgreementListData,
} from "../interface/List/ListData";
import axios from "./DefaultClient";

/** 이용자 api */
export const personalListApi = (data: IPersonalListData | null) => {
  const { search, page } = data as IPersonalListData;
  return axios.get(`master/users?page=${page + 1}&query=${search}`);
};
/** 계죄이체거래약정서 api */
export const accountListApi = (data: IAgreementListData | null) => {
  const { search, page } = data as IAgreementListData;
  return axios.get(`master/accounts?page=${page + 1}${search && "&query=" + search}`);
};
/**  계좌이체거래약정서를 발급한 회원 리스트 */
export const appliedAgreementList = (data: IPersonalListData | null) => {
  const { search, page } = data as IPersonalListData;
  return axios.get(`master/accounts/success/user?page=${page + 1}${search && "&query=" + search}`);
};
/** user의 발급된 모든 계좌이체거래약정서 api */
export const userAccountListApi = (data: IUserAgreementListData | null) => {
  const { id, page } = data as IUserAgreementListData;
  return axios.get(`master/accounts/user/${id}?page=${page + 1}`);
};

/** 개인 계좌이체거래약정서 리스트 가져오기 */
export const getPersonalAccountApplicationListApi = (data: { page: number } | null) => {
  const { search, page } = data as IAgreementListData;
  return axios.get(`personal/account/list?page=${page + 1}${search && "&query=" + search}`);
};

/** 법인 계좌이체거래약정서 리스트 가져오기 */
export const getCompanyApplicationListApi = (data: { page: number } | null) => {
  const { search, page } = data as IAgreementListData;
  return axios.get(`Company/account/list?page=${page + 1}${search && "&query=" + search}`);
};
