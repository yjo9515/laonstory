import { ICommitterListData } from "../interface/List/ListData";
import axios from "./DefaultClient";

/** 평가위원 api */
export const committerListApi = (data: ICommitterListData) => {
  const { search, page } = data;
  return axios.get(`master/committer/list?page=${page + 1}${search && "&query=" + search}`);
};

/** 제안업체 api */
export const companyListApi = (data: ICommitterListData) => {
  const { search, page } = data;
  return axios.get(`master/company?page=${page + 1}&query=${search}`);
};
