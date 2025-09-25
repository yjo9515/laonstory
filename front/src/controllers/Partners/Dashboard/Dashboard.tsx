import {
  dashboardEvaluationApi,
  dashboardPartnersApi,
  dashboardTodayEvaluationListApi,
} from "../../../api/DashboardApi";
import {
  IDashboardEvaluationType,
  IDashboardTodayEvaluationList,
  IDashboardUsersType,
} from "../../../interface/Dashboard/DashboardResponse";
import { useData } from "../../../modules/Server/QueryHook";
import DashboardView from "../../../view/Partners/Dashboard/DashboardView";
import Layout from "../../Common/Layout/Layout";

function Dashboard() {
  /** 평가현황 정보 */
  const { data: evaluation } = useData<IDashboardEvaluationType, null>(
    ["dashboardEvaluation", null],
    () => dashboardEvaluationApi()
  );
  const { data: userData } = useData<IDashboardUsersType, null>(
    ["dashboardUserData", null],
    dashboardPartnersApi
  );
  const { data: todayEvaluation } = useData<IDashboardTodayEvaluationList[], null>(
    ["todayEvaluation", null],
    dashboardTodayEvaluationListApi
  );

  return (
    <Layout noBottom>
      <DashboardView
        evaluationCount={evaluation?.data}
        partnersCount={userData?.data}
        todayEvaluation={todayEvaluation?.data}
      />
    </Layout>
  );
}

export default Dashboard;
