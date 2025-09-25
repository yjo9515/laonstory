export type AttendeeListTypes = {
  id: number;
  name: string;
  type: string;
  status: string;
  turnIn?: string;
};

export type EvaluationRoomInfoTypes = {
  evaluationRoomId: number;
  proposedProject: string;
  masterName: string;
  masterPhone: string;
  evaluationAt: string;
  startAt: string;
  endAt: string;
  committerChairMan: string;
  evaluationFiles: EvaluationFiles[] | [];
  evaluationTable: EvaluationTable;
  meetingUrl: string;
  meetingPassword: string;
  committerNoticeContent: string;
  companyNoticeContent: string;
  status?: string;
};

type EvaluationFiles = {
  id: string;
  fileName: string;
  fileUrl: string;
};

type EvaluationTable = {
  createdAt: string;
  id: string;
  title: string;
  updatedAt: string;
};

export interface EvaluationTableStatusInterface {
  committer: Committer;
  evaluationTableStatus: string;
}

export interface Committer {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  name: string;
  phone: string;
  birth: string;
  email: null | string;
}

export interface ParticipantsListInterface {
  evaluationUserid: number;
  company: COM | null;
  committer: COM | null;
  checkIn: boolean;
  enable: boolean;
}

export interface COM {
  id: string;
  name: string;
  isMe: boolean;
}

export interface EvaluationRoomTimeSetReqInterface {
  id: number;
  presentationTime: string;
  questionTime: string;
}

export interface EvaluationCommitterScoreReqInterface {
  id: number;
  committerId: number;
  companyId: number;
}

export interface EvaluationRoomFinishSimpleReqInterface {
  projectName: string;
  evaluationDateTime: string;
  master: string;
  usedEvaluationTable: UsedEvaluationTable;
  committers: CommitterElement[];
  companyList: CompanyList[];
}

export interface CommitterElement {
  committer: CommitterCommitter;
  isChairman: boolean;
}

export interface CommitterCommitter {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  name: string;
  phone: string;
  birth: string;
  email?: string;
}

export interface CompanyList {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  name: string;
  phone: string;
  companyName: string;
  email?: string;
}

export interface UsedEvaluationTable {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  title: string;
}
