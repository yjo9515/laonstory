import {
  ICompanyChangePhoneData,
  ICompanyChangeEmailData,
  ICompanyChangePasswordData,
  ICommitterChangePhoneData,
  ICommitterChangeEmailData,
  ICommitterChangePasswordData,
} from "../interface/MyInfo/ApiData";
import axios from "./DefaultClient";

// 내 정보 파일 목록
export const myInfoChangeApi = async (id?: string) => {
  return axios.get(`/myinfo/${id}`);
};
/** 정보변경 리스트 API */
export const getChangeInfoList = async (page: number) => {
  return axios.get(`https://6304b2d594b8c58fd7231b16.mockapi.io/api/myinfo?page=${page}`);
};
// =====================COMPANY
/** company 전화번호 변경  */
export const companyChangePhoneApi = async (data: ICompanyChangePhoneData) => {
  return axios.patch(`company/info/phone`, data);
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

// ======================COMMITTER

/** committer 전화번호 변경 */
export const committerChangePhoneApi = async (data: ICommitterChangePhoneData) => {
  return axios.patch(`committer/info/phone`, data);
};
/** committer 이메일 변경  */
export const committerChangeEmailApi = async (data: ICommitterChangeEmailData) => {
  return axios.patch(`committer/info/email`, data);
};
/** committer 이메일 변경  */
export const committerChangePasswordApi = async (data: ICommitterChangePasswordData) => {
  return axios.patch(`committer/info/password`, data);
};
/** committer 내 정보 조회  */
export const committerMyInfoApi = async () => {
  return axios.get(`committer/me`);
};
/** committer 내 정보 변경 내역  */
export const committerMyHistoryApi = async () => {
  return axios.get(`committer/me/history`);
};

