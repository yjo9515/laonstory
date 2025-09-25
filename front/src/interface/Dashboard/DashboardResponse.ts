export interface IDashboardEvaluationType {
  beforeEvaluation: number;
  myBeforeEvaluation: number;
  finishEvaluation: number;
  myFinishEvaluation: number;
}
export interface IDashboardUsersType {
  committer: number;
  company: number;
}

export interface IDashboardUserInfoChange {
  items: IDashboardUserInfoChangeItem[];
}

export interface IDashboardUserInfoChangeItem {
  type: string;
  name: string;
  changeType: string;
  createdAt: string;
}

export interface IDashboardTodayEvaluationList {
  id: number;
  startAt: string;
  evaluationAt: string;
  proposedProject: string;
  isMine: boolean;
}
