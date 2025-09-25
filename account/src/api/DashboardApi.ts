import axios from "./DefaultClient";

/** 대시보드 이용자 가입현황 */
export const dashboardUserApi = () => {
  return axios.get(`dashboard/partner`);
};
/** 대시보드 약정서 현황  */
export const dashboardAccountApi = () => {
  return axios.get(`dashboard/account`);
};
/** 대시보드  계좌이체약정서 신청 현황  */
export const AccountListApi = (page: number) => {
  return axios.get(`dashboard/account/list?page=${page}`);
};
