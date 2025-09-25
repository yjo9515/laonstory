import {
  EvaluationRoomCommitterAutoTypes,
  WebexReqType,
} from "../interface/System/EvaluationRoomDetail/EvaluationRoomDetailTypes";

import axios from "./DefaultClient";
import { PageStateType } from "../interface/Common/PageStateType";
import {
  TableArrayItemModifyTypeReq,
  TableMutateListType,
} from "../interface/System/EvaluationTable/EvaluationTableTypes";
import {
  EvaluationCommitterScoreReqInterface,
  EvaluationRoomTimeSetReqInterface,
} from "../interface/System/EvaluationRoomProceed/EvaluationRoomProceedTypes";

/** 평가방 생성 */
export const evaluationRoomSetUpApi = (data: HTMLFormElement): any => {
  return axios.post("/evaluation/master", data);
};

/** 평가방 수정 */
export const EvaluationRoomModifyApi = (data: HTMLFormElement): any => {
  return axios.patch(`/evaluation/master/${data.get("id")}`, data);
};

/** 평가방 삭제 */
export const EvaluationRoomRemoveApi = (id: string): any => {
  return axios.delete(`/evaluation/master/${id}`);
};

/** 평가방 개설 모달 평가위원 리스트 */
export const evaluationRoomCommitterListApi = (data?: PageStateType) => {
  return axios.get(`/master/committer?page=${data?.page ?? 0}&query=${data?.search ?? ""}`);
};

/** 평가방 개설 평가위원 랜덤 배정 */
export const evaluationRoomCommitterAutoApi = (data: EvaluationRoomCommitterAutoTypes) => {
  return axios.get(`/master/committer/auto`, {
    params: {
      count: data.count,
      ids: data.ids,
    },
  });
};

/** 평가방 개설 모달 제안업체 리스트 */
export const evaluationRoomCompanyListApi = (data?: {
  page: number;
  search: string;
  isSuccess?: boolean;
}) => {
  return axios.get(`/master/company`, {
    params: {
      page: data?.page ? data.page + 1 : 1,
      query: data?.search ?? "",
      isSuccess: data?.isSuccess,
    },
  });
};

/** 평가방 리스트 마스터 */
export const evaluationMasterListApi = (data: PageStateType) => {
  const { page, search } = data;
  return axios.get(`evaluation/master?page=${page + 1}&query=${search}`);
};
/** 평가방 리스트 평가위원 */
export const evaluationCommitterListApi = (data: PageStateType) => {
  const { page, search } = data;
  return axios.get(`evaluation/committer?page=${page + 1}&query=${search}`);
};
/** 평가방 리스트 제안업체 */
export const evaluationCompanyListApi = (data: PageStateType) => {
  const { page, search } = data;
  return axios.get(`evaluation/company?page=${page + 1}&query=${search}`);
};

/** 평가방 정보 마스터, 평가방 수정 데이터 */
export const evaluationRoomInfoApi = (id: number) => {
  return axios.get(`/evaluation/master/${id}`);
};
/** 평가방 정보 평가위원 */
export const evaluationRoomCommitterInfoApi = (id: number) => {
  return axios.get(`/evaluation/committer/${id}`);
};
/** 제안업체 정보 평가위원 */
export const evaluationRoomCompanyInfoApi = (id: number) => {
  return axios.get(`/evaluation/company/${id}`);
};

/** Webex 방 생성 1 */
export const createWebexRoomApi = () => {
  return axios.get(`/webex/oauth-url`);
};

/** Webex 방 생성 2 */
export const createWebexRoomResultApi = (data: WebexReqType) => {
  return axios.post(`/webex/oauth-login`, data);
};

/**평가위원 검색 리스트 */
export const searchedCommitterList = (name: string | null) => {
  return axios.get(`master/committer?name=${name}`);
};

/** 평가표 작성 등록 */
// export const createEvaluationTableApi = (data: any) => {
//   return axios.post(`/evaluation-table`, data);
// };

/** 평가위원 평가항목표(평가항목 점수확인표) 요약 정보 api */
export const getEvaluationSummaryTableApi = (id: number) => {
  return axios.get(`/evaluation/committer/${id}/evaluation-table`);
};

/** 평가담당자 평가항목표(평가항목 점수확인표) 요약 정보 api */
export const getMasterEvaluationSummaryTableApi = (id: number) => {
  return axios.get(`/evaluation/master/${id}/evaluation-table`);
};

/** 평가 시작하기 */
export const getStartEvaluationApi = (id: number) => {
  return axios.get(`/evaluation/start/${id}`);
};

/** 평가위원 평가채점표 가져오기 */
export const getCommitterEvaluationTableApi = (id: number, companyId: number) => {
  return axios.get(`/evaluation/committer/${id}/evaluation-table/${companyId}`);
};

/** 평가담당자 평가위원 평가표 상세 가져오기 */
export const getEvaluationCommitterScoreView = (data: EvaluationCommitterScoreReqInterface) => {
  return axios.get(
    `/evaluation/master/${data.id}/evaluation-table/${data.committerId}/${data.companyId}`
  );
};

/** 평가방 평가위원이 선택한 제안업체 평가표 채점 저장하기 */
export const postEvaluationTableScoreSaveApi = (data: {
  id: number;
  companyId: number;
  scoreList: TableMutateListType[];
}) => {
  return axios.post(
    `/evaluation/committer/${data.id}/evaluation-table/${data.companyId}`,
    data.scoreList
  );
};

/** 평가위원 평가점수 제출하기 */
export const patchCommitterEvaluationScoreDataApi = (id: number) => {
  return axios.patch(`/evaluation/committer/${id}/evaluation-table`);
};

/** 평가담당자 보정평가 및 제출 여부 확인 */
export const patchMasterSubmitCheckApi = (data: {
  id: number;
  committerId: number;
  status: string;
}) => {
  return axios.patch(`/evaluation/master/${data.id}/evaluation-table/${data.committerId}`, {
    status: data.status,
  });
};

/** 평가담당자 평가방 평가점수표 정보 가져오기 (5초) */
export const getMasterEvaluationRoomDataApi = (id: number) => {
  return axios.get(`/evaluation/master/polling/${id}/evaluation-table`);
};

/** 평가담당자 접속중인 참석자 확인 (5초) */
export const getMasterEvaluationRoomParticipantsApi = (id: number) => {
  return axios.get(`/evaluation/user/polling/${id}/evaluation-room-check`);
};

/** 평가위원, 제안업체 평가방 정보 가져오기 (5초) */
export const getCommitterEvaluationRoomDataApi = (id: number) => {
  return axios.get(`/evaluation/committer/polling/${id}/evaluation-table`);
};

/** 해당 평가위원이 접속 중인지 체크 (5초) */
export const getCommitterEvaluationRoomParticipantsApi = (id: number) => {
  return axios.get(`/evaluation/committer/polling/${id}/evaluation-room-check/in`);
};

/** 평가위원, 제안업체 담당자 설정 시간 가져오기 (5초) */
export const getTimeByAdminApi = (id: number) => {
  return axios.get(`/evaluation/user/polling/${id}/evaluation-time-check`);
};

/** 해당 평가위원이 평가방에서 나갔을 때 체크 */
export const getCommitterEValuationRoomOutCheckApi = (id: number) => {
  return axios.get(`/evaluation/committer/polling/${id}/evaluation-room-check/out`);
};

/** 해당 제안업체가 접속 중인지 체크 (5초) */
export const getCompanyEvaluationRoomParticipantsApi = (id: number) => {
  return axios.get(`/evaluation/company/polling/${id}/evaluation-room-check/in`);
};

/** 해당 제안업체가 평가방에서 나갔을 때 체크 */
export const getCompanyEValuationRoomOutCheckApi = (id: number) => {
  return axios.get(`/evaluation/company/polling/${id}/evaluation-room-check/out`);
};

/** 평가담당자 평가방 평가위원 강퇴처리 */
export const patchParticipantsWithdrawalApi = (data: { id: number; disableUserId: number }) => {
  return axios.patch(`/evaluation/master/${data.id}/evaluation-user/committer`, {
    disableUserId: data.disableUserId,
  });
};

/** 평가담당자 평가시간 설정 api */
export const patchEvaluationRoomTimeSetApi = (data: EvaluationRoomTimeSetReqInterface) => {
  return axios.patch(`/evaluation/master/${data.id}/evaluation-room/time`, {
    presentationTime: data.presentationTime,
    questionTime: data.questionTime,
  });
};

/** 평가 시간 시작하기 api */
export const patchEvaluationTimeStartApi = (data: { id: number; type: string }) => {
  return axios.patch(`/evaluation/master/${data.id}/evaluation-room/time/start`, {
    type: data.type,
  });
};
/** 평가 시간 종료, 리셋하기 api */
export const patchEvaluationTimeStopApi = (id: number) => {
  return axios.patch(`/evaluation/master/${id}/evaluation-room/time/stop`);
};

/** 현재 진행중인 평가시간 가져오기 api */
export const getEvaluationTimeCatchApi = (id: number) => {
  return axios.get(`/evaluation/user/polling/${id}/evaluation-room/time`);
};

/** 평가담당자 평가방 종료 api */
export const patchEvaluationFinish = (id: number) => {
  return axios.patch(`/evaluation/master/${id}/evaluation-room/finish`, null, {
    responseType: "blob",
  });
};

/** 평가담당자 평가방 평가표양식 확인 api */
export const getEvaluationInCheckTableApi = (id: number) => {
  return axios.get(`/evaluation-table/evaluation/${id}`);
};

/** 평가방에서 사용된 평가표 수정 */
export const putEvaluationUseTableModify = (data: TableArrayItemModifyTypeReq) => {
  return axios.patch(`/evaluation-table/evaluation/${data.id}`, {
    data: data.list,
    title: data.title,
  });
};

/** 평가종료된 평가방 요약정보 api */
export const getEvaluationRoomFinishSimpleDataApi = (id: number) => {
  return axios.get(`/evaluation/master/${id}/evaluation-room-finish/simple`);
};

/** 평가종료된 평가방 최종평가표 가져오기 api */
export const getEvaluationRoomFinishScoreApi = (id: number) => {
  return axios.get(`/evaluation/master/${id}/evaluation-room/finish/final-score`, {
    responseType: "blob",
  });
};

/** 평가방 시작했는지 확인 (5초) api */
export const getEvaluationRoomStartCheckApi = (id: number) => {
  return axios.get(`/evaluation/user/polling/${id}/evaluation-room-start-check`);
};

/** 평가방 평가위원 평가서 다운로드 */
export const getEvaluationCommitterScoreListDown = (id: number) => {
  return axios.get(`/evaluation/master/manuscript/${id}`, {
    responseType: "blob",
  });
};
