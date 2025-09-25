import {
  ICompanyChangePhoneData,
  ICompanyChangeEmailData,
  ICompanyChangePasswordData,
  IPersonalChangePhoneData,
  IPersonalChangeEmailData,
  IPersonalChangePasswordData,
} from "../interface/MyInfo/ApiData";
import axios from "./DefaultClient";

// 내 정보 파일 목록
export const myInfoChangeApi = async (id?: string) => {
  return axios.get(`/myinfo/${id}`);
};

// =====================법인
/** company 담당자 정보 변경  */
export const companyChangePhoneApi = async (data: ICompanyChangePhoneData) => {
  return axios.patch(`company/info/manager`, data);
};
/** company 이메일 변경  */
export const companyChangeEmailApi = async (data: ICompanyChangeEmailData) => {
  return axios.patch(`company/info/email`, data);
};
/** company 비밀번호 변경  */
export const companyChangePasswordApi = async (data: ICompanyChangePasswordData) => {
  return axios.patch(`company/info/password`, data);
};
/** company 내 정보 조회  */
export const companyMyInfoApi = async () => {
  return axios.get(`company/me`);
};
/** company 내 정보 변경 내역  */
export const companyMyHistoryApi = async () => {
  return axios.get(`company/me/history`);
};

// ======================개인

/** personal 전화번호 변경 */
export const personalChangePhoneApi = async (data: IPersonalChangePhoneData) => {
  return axios.patch(`personal/info/phone`, data);
};
/** personal 이메일 변경  */
export const personalChangeEmailApi = async (data: IPersonalChangeEmailData) => {
  return axios.patch(`personal/info/email`, data);
};
/** personal 이메일 변경  */
export const personalChangePasswordApi = async (data: IPersonalChangePasswordData) => {
  return axios.patch(`personal/info/password`, data);
};
/** personal 내 정보 조회  */
export const personalMyInfoApi = async () => {
  return axios.get(`personal/me`);
};
/** personal 내 정보 변경 내역  */
export const personalMyHistoryApi = async () => {
  return axios.get(`personal/me/history`);
};

