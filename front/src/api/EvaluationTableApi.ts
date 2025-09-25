import { PageStateType } from "../interface/Common/PageStateType";
import {
  TableArrayItemModifyTypeReq,
  TableArrayItemTypeReq,
} from "../interface/System/EvaluationTable/EvaluationTableTypes";
import axios from "./DefaultClient";

/** 평가표 리스트 */
export const EvaluationTableListApi = (data: PageStateType) => {
  return axios.get(`/evaluation-table`, {
    params: {
      page: data?.page + 1,
      query: data?.search,
    },
  });
};

/** 평가항목표 상세정보 api */
export const getEvaluationTableApi = (id: number) => {
  return axios.get(`/evaluation-table/${id}`);
};

/** 평가항목표 등록 api */
export const addEvaluationTableApi = (data: TableArrayItemTypeReq) => {
  return axios.post(`/evaluation-table`, data);
};

/** 평가항목표 수정 api */
export const modifyEvaluationTableApi = (data: TableArrayItemModifyTypeReq) => {
  return axios.patch(`/evaluation-table/${data.id}`, { data: data.list, title: data.title });
};

/** 평가항목표 삭제 api */
export const deleteEvaluationTableApi = (id: number) => {
  return axios.delete(`/evaluation-table/${id}`);
};
