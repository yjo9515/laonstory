/* eslint-disable react-hooks/exhaustive-deps */
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router";
import Layout from "../../../Common/Layout/Layout";
import { userState } from "../../../../modules/Client/Auth/Auth";
import { useRecoilValue } from "recoil";
import RoleUtils from "../../../../utils/RoleUtils";
import { IPersonalListRes } from "../../../../interface/List/ListResponse";
import { IPersonalListData } from "../../../../interface/List/ListData";
import { useData } from "../../../../modules/Server/QueryHook";
import { appliedAgreementList } from "../../../../api/ListApi";
import queryString from "query-string";
import { PageStateType } from "../../../../interface/Common/PageStateType";
import IssuanceCompletedListView from "../../../../view/Partners/Issuance/IssuanceCompleted/IssuanceCompletedListView";

function IssuanceCompletedList() {
  const userData = useRecoilValue(userState);
  const authority = RoleUtils.getClientRole(userData.role);
  const role = RoleUtils.getRole(userData.role);
  const location = useLocation();
  const navigate = useNavigate();
  const parsed = queryString.parse(location.search);
  const [search, setSearch] = useState("");
  const [startDate, setStartDate] = useState("");    
  const [endDate, setEndDate] = useState("");    
  //   const [type, setType] = useState((parsed.type as string) || "user");
  const [type, setType] = useState("user");

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
    navigate(`/west/partners/issuance?page=${pageState.page}&search=${pageState.search}`);
  }, [pageState.page, pageState.page, type]);

  // 유저 리스트
  const { data: userListData } = useData<IPersonalListRes, IPersonalListData>(
    ["personalList", pageState],
    appliedAgreementList,
    {
      enabled: type === "user",
    }
  );

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
    setPageState({ page: 0, search,  startDate, endDate});
  };

  /** 리스트 초기화 */
  const onReflesh = () => {
    setSearch("");
    setPageState({ page: 0, search: "",startDate:"",endDate:"" });
  };

  // console.log(userListData);

  return (
    <Layout>
      <>
        {userListData && (
          <IssuanceCompletedListView
            data={userListData?.data?.items}
            meta={userListData?.data?.meta}
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

export default IssuanceCompletedList;
