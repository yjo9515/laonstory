import { AxiosResponse } from "axios";
import { useInfiniteQuery } from "react-query";
import { useRecoilValue } from "recoil";
import { AccountListApi, dashboardAccountApi, dashboardUserApi } from "../../../api/DashboardApi";
import {
  IAccountListRes,
  IDashboardAccountsType,
  IDashboardPartnersType,
} from "../../../interface/Dashboard/DashboardResponse";
import { GlobalResponse } from "../../../interface/Response/GlobalResponse";
import { userState } from "../../../modules/Client/Auth/Auth";
import { useData } from "../../../modules/Server/QueryHook";
import RoleUtils from "../../../utils/RoleUtils";

import DashboardView from "../../../view/Partners/Dashboard/DashboardView";
import Layout from "../../Common/Layout/Layout";
import { getCookie } from "../../../utils/ReactCookie";
import { useEffect, useState } from "react";
import {Buffer} from "buffer";

function Dashboard() {
  const userData = useRecoilValue(userState);
  const isAccountant: boolean = RoleUtils.isAccountant(userData.isAccountant);
  const [token, setToken] = useState<string>(getCookie("token"));
  const [empId, setEmpId] = useState<string>("");

  /** 이용자 가입 현황 정보 */
  const { data: users } = useData<IDashboardPartnersType, null>(
    ["dashboardUsers", null],
    () => dashboardUserApi(),
    {
      refetchOnWindowFocus: false,
    }
  );
  /** 계좌이체약정서 발급 현황 */
  const { data: accounts } = useData<IDashboardAccountsType, null>(
    ["dashboardAccounts", null],
    () => dashboardAccountApi(),
    {
      refetchOnWindowFocus: false,
    }
  );
  // 계좌이체거래약정서 신청 현황
  const accountList = useInfiniteQuery<
    AxiosResponse<GlobalResponse<IAccountListRes>>,
    { page: number }
  >(["accountList"], ({ pageParam = 1 }) => AccountListApi(pageParam), {
    getNextPageParam: (lastPage) => {
      if (lastPage.data.data.meta.currentPage === lastPage.data.data.meta.totalPages) return;
      return lastPage?.data.data.meta.currentPage + 1;
    },
  });

  const getNextPage = () => {
    if (accountList.isFetchingNextPage) return;
    accountList.fetchNextPage();
  };


  const parseJwt = (token: string) => {
    const base64Payload = token.split('.')[1]; //value 0 -> header, 1 -> payload, 2 -> VERIFY SIGNATURE
    // console.log(base64Payload)
    // console.log(Buffer.from(base64Payload,'base64'))
    // console.log(Buffer.from(base64Payload,'base64').toString('utf-8'))
    const payload =
      base64Payload === undefined
        ? ''
        : Buffer.from(base64Payload.toString(), 'base64').toString('utf8');
    const result =
      base64Payload === undefined ? {} : JSON.parse(payload.toString());
    return result;
  };



  useEffect(() => {
    setToken(getCookie("token"));
  }, [getCookie("token")]);

  useEffect(() => {
    if(token === undefined) return;
    console.log(token);
    const parse = parseJwt(token);
    setEmpId(parse.sub);
  }, [token]);


  return (
    <Layout>
      <DashboardView
        usersCount={users?.data}
        accountsCount={accounts?.data}
        accountList={accountList?.data?.pages}
        getNextPage={getNextPage}
        isAccountant={isAccountant}
        empId={empId}
      />
    </Layout>
  );
}

export default Dashboard;
