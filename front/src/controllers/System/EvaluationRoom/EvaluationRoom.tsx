import { useEffect, useState } from "react";
import { useNavigate } from "react-router";
import { PageStateType } from "../../../interface/Common/PageStateType";
import EvaluationRoomView from "../../../view/System/EvaluationRoom/EvaluationRoomView";
import Layout from "../../Common/Layout/Layout";
import { userState } from "../../../modules/Client/Auth/Auth";
import { useRecoilValue } from "recoil";
import RoleUtils from "../../../utils/RoleUtils";
import { useData } from "../../../modules/Server/QueryHook";
import { IAdminListRes } from "../../../interface/List/ListResponse";
import {
  evaluationCompanyListApi,
  evaluationMasterListApi,
  evaluationRoomCommitterListApi,
} from "../../../api/EvaluationRoomApi";
import { useLocation } from "react-router";
import queryString from "query-string";

function EvaluationRoom() {
  const userData = useRecoilValue(userState);

  const authority = RoleUtils.getClientRole(userData.role);
  const role = RoleUtils.getRole(userData.role);
  const [search, setSearch] = useState("");
  const navigate = useNavigate();
  const location = useLocation();
  const parsed = queryString.parse(location.search);
  const [pageState, setPageState] = useState<PageStateType>({
    page: Number(parsed.page) || 0,
    search: (parsed.search as string) || "",
    startDate:"",
      endDate:""
  });

  useEffect(() => {
    navigate(`/west/system/evaluation-room?page=${pageState.page}&search=${pageState.search}`);
  }, [pageState]);

  // 마스터 평가방
  const { data: master } = useData<IAdminListRes, PageStateType>(
    ["adminEvaluation", pageState],
    evaluationMasterListApi,
    {
      enabled: authority === "admin",
    }
  );
  // 평가위원 평가방
  const { data: committer } = useData<IAdminListRes, PageStateType>(
    ["committerEvaluation", pageState],
    evaluationRoomCommitterListApi,
    {
      enabled: authority === "committer",
    }
  );
  // 제안업체 평가방
  const { data: company } = useData<IAdminListRes, PageStateType>(
    ["adminEvaluation", pageState],
    evaluationCompanyListApi,
    {
      enabled: authority === "company",
    }
  );
  // console.log(master);
  // console.log(committer);
  // console.log(company);
  
  const data = authority === "admin" ? master : authority === "committer" ? committer : company;

  const onPageMove = (page: number) => {
    setPageState((prev) => ({ ...prev, page }));
  };

  const onSearchContent = (search: string) => {
    setSearch(search);
  };

  const onRefetch = () => {
    setPageState({ ...pageState, search });
  };

  const onReflesh = () => {
    setPageState({ page: 0, search: "",  startDate:"",
      endDate:""});
    setSearch("");
  };

  return (
    <Layout notSideBar={role === "user"} noBottom>
      <>
        <EvaluationRoomView
          data={data?.data.items || []}
          meta={data?.data.meta}
          role={role}
          pageState={pageState}
          onPageMove={onPageMove}
          onSearchContent={onSearchContent}
          onRefetch={onRefetch}
          onReflesh={onReflesh}
          search={search}
        />
      </>
    </Layout>
  );
}

export default EvaluationRoom;
