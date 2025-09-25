import { meta } from "../../List/ListResponse";
import {
  TableArrayItemModifyTypeReq,
  TableArrayItemTypeReq,
} from "../EvaluationTable/EvaluationTableTypes";

export type StepOneState = {
  businessName: string;
  date: string;
  startTime: string;
  endTime: string;
  gradeType: string;
  gradeKind: string;
};

export type StepTwoCommitter = {
  id: string;
  name: string;
  birth: string;
  phone: string;
  chairman?: boolean;
  email?: string;
};

export type StepTwoCompany = {
  id: string;
  companyName: string;
  email: string;
  phone: string;
  name: string;
  username: string;
};

export type StepTwoCommitterRes = {
  items: StepTwoCommitter[];
  meta: meta;
};

export type StepTwoCompanyRes = {
  items: StepTwoCompany[];
  meta: meta;
};

export type StepTwoSearchModal = {
  type: string;
  isModal: boolean;
};

export type EvaluationRoomSetUp = {
  id?: number;
  businessName: string;
  date: string;
  startTime: string;
  endTime: string;
  committer: StepTwoCommitter[];
  company: StepTwoCompany[];
  filse: any[];
  deleteFiles?: number[];
  committerNoticeContent: string;
  companyNoticeContent: string;
  createEvaluationTableDto: TableArrayItemTypeReq | TableArrayItemModifyTypeReq;
};

export type EvaluationRoomCommitterResType = {
  name: string;
  phone: string;
  birth: string;
  chairman: boolean;
  email: string;
};

export type EvaluationRommSetupType = {
  id: number;
  masterId?: number;
  masterName: string;
  masterPhone: string;
  proposedProject: string;
  meetingEnable: boolean;
  meetingUrl: string;
  meetingPassword: string;
  evaluationAt: string;
  startAt: string;
  endAt: string;
  committerNoticeContent: string;
  companyNoticeContent: string;
  company: StepTwoCompany[];
  committer: StepTwoCommitter[];
  notice: string;
  filse: any[];
  committerChairMan?: string;
  evaluationFiles: EvaluationFiles[];
  status: string;
  evaluationTable: evaluationTable;
};

type EvaluationFiles = {
  id: string;
  fileName: string;
  fileUrl: string;
};

export type EvaluationRoomCommitterAutoTypes = {
  count: number;
  ids: number[];
};

export type WebexReqType = {
  code: string;
  state: string;
};

export type evaluationTable = {
  createdAt: string;
  id: string;
  title: string;
  updatedAt: string;
};
