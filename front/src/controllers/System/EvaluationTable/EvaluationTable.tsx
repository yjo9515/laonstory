import { useRecoilValue } from "recoil";
import { PageStateType } from "../../../interface/Common/PageStateType";
import { userState } from "../../../modules/Client/Auth/Auth";
import RoleUtils from "../../../utils/RoleUtils";
import EvaluationTableView from "../../../view/System/EvaluationTable/EvaluationTableView";
import Layout from "../../Common/Layout/Layout";
import { useEffect, useState } from "react";
import { useData } from "../../../modules/Server/QueryHook";
import { EvaluationTableListApi } from "../../../api/EvaluationTableApi";
import { EvaluationTableList } from "../../../interface/System/EvaluationTable/EvaluationTableTypes";
import { useLocation, useNavigate } from "react-router";
import queryString from "query-string";

export default function EvaluationTable() {
  const userData = useRecoilValue(userState);
  const role = RoleUtils.getRole(userData.role);
  const [search, setSearch] = useState("");
  const location = useLocation();
  const navigate = useNavigate();
  const parsed = queryString.parse(location.search);
  const [startDate, setStartDate] = useState("");    
  const [endDate, setEndDate] = useState("");    
  const [pageState, setPageState] = useState<PageStateType>({
    page: Number(parsed.page) || 0,
    search: (parsed.search as string) || "",
    startDate:"",
      endDate:""
  });

  useEffect(() => {
    navigate(`/west/system/evaluation-table?page=${pageState.page}&search=${pageState.search}`);
  }, [pageState]);

  const onPageMove = (page: number) => {
    setPageState((prev) => ({ ...prev, page }));
  };

  const onSearchContent = (search: string) => {
    setSearch(search);
  };

  const onRefetch = () => {
    setPageState({ page: 0, search, startDate, endDate });
  };

  const onReflesh = () => {
    setPageState({ page: 0, search: "",startDate:"",endDate:"" });
    setSearch("");
  };

  /** 평가항목표 리스트 가져오기 */
  const EvaluationTableList = useData<EvaluationTableList, PageStateType>(
    ["EvaluationTableListApi", pageState],
    EvaluationTableListApi
  );

  return (
    <Layout noBottom>
      <EvaluationTableView
        role={role}
        pageState={pageState}
        onPageMove={onPageMove}
        onSearchContent={onSearchContent}
        onRefetch={onRefetch}
        onReflesh={onReflesh}
        data={EvaluationTableList?.data?.data.items || []}
        meta={EvaluationTableList.data?.data.meta}
        search={search}
      />
    </Layout>
  );
}
