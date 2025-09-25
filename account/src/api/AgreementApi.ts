import { accountOwnerCheckData } from "../interface/Agreement/AgreementData";
import axios from "./DefaultClient";
/**계좌이체거래약정서 발급 신청  Api*/
export const personalAccountApplicationApi = (data: FormData) => {
  return axios.post(`personal/account`, data, {
    headers: { "Content-Type": "multipart/form-data; charset: UTF-8;" },
  });
};

/**계좌이체거래약정서 발급 신청  Api*/
export const companyAccountApplicationApi = (data: FormData) => {
  return axios.post(`company/account`, data, {
    headers: { "Content-Type": "multipart/form-data; charset: UTF-8;" },
  });
};

/**계좌이체거래약정서 발급 유무 api */
export const accountCheckApi = () => {
  return axios.get(`personal/account-check`);
};
/**계좌이체거래약정서 가져오기 api*/
export const getAccountApplicationApi = () => {
  return axios.get(`personal/account`);
};
/** 계좌이체거래약정 pdf 불러오기  api*/
export const getAccountApplicationPDFApi = (data: { uuid: string } | null) => {
  return axios.post(`account/docs`, data, {
    responseType: "blob",
  });
};
/** 개인 계좌이체거래약정 pdf 불러오기 api*/
export const personalMainApplicationApi = (data: { uuid: string } | null) => {
  return axios.patch(`personal/account/main/${data?.uuid}`);
};

/** 개인 계좌이체거래약정 pdf 불러오기 api*/
export const companyMainApplicationApi = (data: { uuid: string } | null) => {
  return axios.patch(`company/account/main/${data?.uuid}`);
};

/** 개인 유효성 검사(계좌 소유주 확인) api */
export const personalAccountOwnerCheckApi = (data: accountOwnerCheckData) => {
  return axios.post(`personal/account-check`, data);
};
/** 법인 유효성 검사(계좌 소유주 확인) api */
export const companyAccountOwnerCheckApi = (data: accountOwnerCheckData) => {
  return axios.post(`company/account-check`, data);
};

/** 담당자 찾기 */
export const getEmpApi = (data: { name: string; type: string }) => {
  return axios.get(`${data.type}/emp`, { params: { name: data.name } });
};
/** 담당자 변경 */
export const patchEmpApi = (data: { empId: string; uuid: string; type: string }) => {
  let item = {
    empId: data.empId,
    uuid: data.uuid,
  };
  return axios.patch(`${data.type}/emp`, item);
};
/** 특정 담당자 정보 가져오기 */
export const getMasterInfoEmpApi = (data: { masterId: string; type: string }) => {
  return axios.get(`${data.type}/emp/${data.masterId}`);
};
