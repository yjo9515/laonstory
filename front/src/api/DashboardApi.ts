import axios from "./DefaultClient";

/** 대시보드 평가현황 */
export const dashboardEvaluationApi = () => {
  return axios.get(`/dashboard/evaluation`);
};

/** 대시보드 파트너가입현황 */
export const dashboardPartnersApi = () => {
  return axios.get(`/dashboard/partner`);
};

/** 대시보드 금일 평가 리스트 */
export const dashboardTodayEvaluationListApi = () => {
  return axios.get(`/dashboard/evaluation/today`);
};
