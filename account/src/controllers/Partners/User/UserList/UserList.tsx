import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router";
import { PageStateType } from "../../../../interface/Common/PageStateType";
import Layout from "../../../Common/Layout/Layout";
import { alertModalState, contentModalState } from "../../../../modules/Client/Modal/Modal";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import { userState } from "../../../../modules/Client/Auth/Auth";
import RoleUtils from "../../../../utils/RoleUtils";
import { useData } from "../../../../modules/Server/QueryHook";
import { personalListApi } from "../../../../api/ListApi";
import { IPersonalListRes } from "../../../../interface/List/ListResponse";
import { IPersonalListData } from "../../../../interface/List/ListData";
import UserListView from "../../../../view/Partners/Personal/PersonalListview/UserListView";
import queryString from "query-string";
import {Buffer} from "buffer";

import { getCookie } from "../../../../utils/ReactCookie";



function UserList() {
  const userData = useRecoilValue(userState);
  const role = RoleUtils.getRole(userData.role);
  const authority = RoleUtils.getClientRole(userData.role);
  const setContentModal = useSetRecoilState(contentModalState);
  const resetModal = useResetRecoilState(contentModalState);
  const setAlertModal = useSetRecoilState(alertModalState);
  const navigate = useNavigate();
  const location = useLocation();
  const parsed = queryString.parse(location.search);
  const isAccountant: boolean = RoleUtils.isAccountant(userData.isAccountant);
  const [token, setToken] = useState<string>(getCookie("token"));
  const [empId, setEmpId] = useState<string>("");

  const [search, setSearch] = useState("");
  const [startDate, setStartDate] = useState("");    
  const [endDate, setEndDate] = useState("");    

  const [pageState, setPageState] = useState<PageStateType>({
    page: Number(parsed.page) || 0,
    search: (parsed.search as string) || "",
    startDate:"",
    endDate:""
  });
  

  useEffect(() => {
    if (parsed && (pageState.page || pageState.search)) {
      navigate(`/west/partners/user?page=${pageState.page}&search=${pageState.search}`);
    }
  }, [pageState]);

  useEffect(() => {
    if(token === undefined) return;
    const parse = parseJwt(token);
    setEmpId(parse.sub);
  }, [token]);

  // useEffect(() => {
  //   if(isAccountant || empId !== '04160266'){
  //     setAlertModal({
  //       isModal : true,
  //       content : "접근권한이 없습니다"
  //     })
  //   }
  // }, [empId])

  const parseJwt = (token: string) => {
    const base64Payload = token.split('.')[1]; //value 0 -> header, 1 -> payload, 2 -> VERIFY SIGNATURE
    const payload =
      base64Payload === undefined
        ? ''
        : Buffer.from(base64Payload.toString(), 'base64').toString('utf8');
    const result =
      base64Payload === undefined ? {} : JSON.parse(payload.toString());
    return result;
  };

  const { data, isSuccess } = useData<IPersonalListRes, IPersonalListData>(
    ["personalList", pageState],
    personalListApi
  );

  if(isSuccess === true){
    data?.data?.items?.forEach((el, i) => {
      const role = RoleUtils.getClientRole(el.role) === "personal" ? "개인" : "법인";
      // 이미 처리된 데이터인지 확인하여 중복 처리 방지
      if (!el.name.includes(`(${role})`)) {
        el.name = `${el.name} (${role})`;
      }
    });
  }      

  const onPageMove = (page: number) => {
    setPageState({ ...pageState, page });
    navigate(`/west/partners/user?page=${page}&search=${pageState.search}`);
  };

  const onSearchContent = (search: string) => {
    setSearch(search);
  };

  const onRefetch = () => {
    setPageState({ page: 0, search,  startDate, endDate});
  };

  const onReflesh = () => {
    setPageState({ page: 0, search: "",startDate:"",endDate:"" });
    setSearch("");
  };

  return (
    <Layout>
      <>
        <UserListView
          data={data?.data.items ?? []}
          meta={data?.data.meta}
          role={role}
          authority={authority}
          pageState={pageState}
          onPageMove={onPageMove}
          onSearchContent={onSearchContent}
          onRefetch={onRefetch}
          onReflesh={onReflesh}
          setContentModal={setContentModal}
          setAlertModal={setAlertModal}
          resetModal={resetModal}
          search={search}
        />
      </>
    </Layout>
  );
}

export default UserList;
