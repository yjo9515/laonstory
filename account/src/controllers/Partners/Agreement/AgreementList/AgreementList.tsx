/* eslint-disable react-hooks/exhaustive-deps */
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router";
import Layout from "../../../Common/Layout/Layout";
import AgreementListView from "../../../../view/Partners/Agreement/AgreementListView/AgreementListView";
import { userState } from "../../../../modules/Client/Auth/Auth";
import { useRecoilValue } from "recoil";
import RoleUtils from "../../../../utils/RoleUtils";
import { IAgreementListRes } from "../../../../interface/List/ListResponse";
import { IAgreementListData } from "../../../../interface/List/ListData";
import { useData } from "../../../../modules/Server/QueryHook";
import { accountListApi } from "../../../../api/ListApi";
import queryString from "query-string";
import { PageStateType } from "../../../../interface/Common/PageStateType";

function AgreementList() {
  const userData = useRecoilValue(userState);
  const authority = RoleUtils.getClientRole(userData.role);
  const role = RoleUtils.getRole(userData.role);
  const location = useLocation();
  const navigate = useNavigate();
  const parsed = queryString.parse(location.search);
  const [search, setSearch] = useState("");
  const [startDate, setStartDate] = useState("");    
  const [endDate, setEndDate] = useState("");    
  const isAccountant: boolean = RoleUtils.isAccountant(userData.isAccountant);
  const [type, setType] = useState("agreement");

  const changeTab = (type: string) => {
    setPageState({
      page: 0,
      search: "",
      startDate:"",
      endDate:""
    });
    setSearch("");
    setType(type);
  };
  const [pageState, setPageState] = useState<PageStateType>({
    page: Number(parsed.page) || 0,
    search: (parsed.search as string) || "",
    startDate:"",
    endDate:""
  });
  useEffect(() => {
    navigate(`/west/partners/agreement?page=${pageState.page}&search=${pageState.search}`);
  }, [pageState.page, pageState.page, type]);

  // 계좌이체거래약정서 신청 리스트
  const { data: agreementData } = useData<IAgreementListRes, IAgreementListData>(
    ["agreementList", pageState],
    accountListApi,
    {
      enabled: type === "agreement",
    }
  );
  

  agreementData?.data?.items?.forEach((el, i) => {
    el.id = el.uuid;
    el.personalName = el.personal?.name;
  });

  /** 페이지 이동 */
  const onPageMove = (page: number) => {
    setPageState({ ...pageState, page });
  };

  /** 검색 조건 세팅하기 */
  const onSearchContent = (search: string) => {
    setSearch(search);
  };

  /** 리스트 검색결과 요청하기 */
  const onRefetch = () => {
    setPageState({ page: 0, search, startDate, endDate });
  };

  /** 리스트 초기화 */
  const onReflesh = () => {
    setSearch("");
    setPageState({ page: 0, search: "", startDate:"", endDate:"" });
  };

  return (
    <Layout>
      <>
        {agreementData && (
          <AgreementListView
            isAccountant={isAccountant}
            data={agreementData?.data?.items}
            meta={agreementData?.data?.meta}
            role={role}
            authority={authority}
            pageState={pageState}
            onPageMove={onPageMove}
            onSearchContent={onSearchContent}
            onRefetch={onRefetch}
            onReflesh={onReflesh}
            changeTab={changeTab}
            type={type}
            search={search}
          />
        )}
      </>
    </Layout>
  );
}

export default AgreementList;
