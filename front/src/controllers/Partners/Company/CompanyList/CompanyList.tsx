import { useEffect, useState } from "react";
import { PageStateType } from "../../../../interface/Common/PageStateType";
import Layout from "../../../Common/Layout/Layout";
import CompanyListView from "../../../../view/Partners/Company/CompanyListView/CompanyListView";
import { userState } from "../../../../modules/Client/Auth/Auth";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import RoleUtils from "../../../../utils/RoleUtils";
import { useData, useSendData } from "../../../../modules/Server/QueryHook";
import { companyListApi } from "../../../../api/ListApi";
import { ICompanyListRes } from "../../../../interface/List/ListResponse";
import { useLocation, useNavigate } from "react-router";
import queryString from "query-string";
import { alertModalState, contentModalState } from "../../../../modules/Client/Modal/Modal";
import { useForm } from "react-hook-form";
import { CompanyAdd } from "../../../../interface/Partners/Company/CompanyTypes";
import theme from "../../../../theme";
import { IInviteCompany } from "../../../../interface/Master/MasterData";
import { inviteCompanyApi } from "../../../../api/MasterApi";
import { queryClient } from "../../../..";

function CompanyList() {
  const userData = useRecoilValue(userState);
  const role = RoleUtils.getRole(userData.role);
  const authority = RoleUtils.getClientRole(userData.role);
  const setContentModal = useSetRecoilState(contentModalState);
  const resetModal = useResetRecoilState(contentModalState);
  const setAlertModal = useSetRecoilState(alertModalState);
  const [search, setSearch] = useState("");
  const location = useLocation();
  const [startDate, setStartDate] = useState("");    
  const [endDate, setEndDate] = useState("");    
  const navigate = useNavigate();
  const parsed = queryString.parse(location.search);
  const [pageState, setPageState] = useState<PageStateType>({
    page: Number(parsed.page) || 0,
    search: (parsed.search as string) || "",
    startDate:"",
      endDate:""
  });

  useEffect(() => {
    navigate(`/west/system/company?page=${pageState.page}&search=${pageState.search}`);
  }, [pageState]);

  const {
    register, // input 과 연결해주는 객체
    setValue, // input의 값을 설정 가능한 메서드
    watch, // 실시간으로 input의 값을 확인하는 메서드
  } = useForm<CompanyAdd>({});

  const data = useData<ICompanyListRes, PageStateType>(["companyList", pageState], companyListApi);

  // 제안업체 초대
  const inviteCommitter = useSendData<string, IInviteCompany>(inviteCompanyApi);
  const onInviteCompany = (data: IInviteCompany) => {
    inviteCommitter.mutate(data, {
      onSuccess() {
        queryClient.invalidateQueries(["committerList"]);
        onSendInvitation();
      },
    });
  };

  const onSendInvitation = () => {
    resetModal();
    setAlertModal({
      content: (
        <span
          style={{
            textAlign: "center",
            lineHeight: theme.fontType.bodyLineHeight.lineHeight,
          }}
        >
          {/* 평가위원에게 회원가입 링크가 발송되었습니다.
          <br /> 회원가입 진행 후 자동 승인되어 회원으로 등록됩니다. */}
          제안업체가 등록되었습니다.
        </span>
      ),
      onClick: () => {
        data.refetch();
        onReset();
      },
      type: "check",
      isModal: true,
    });
  };

  const onPageMove = (page: number) => {
    setPageState({ ...pageState, page });
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

  const onReset = () => {
    setValue("username", "");
    setValue("password", "");
    setValue("name", "");
    setValue("phone", "");
    setValue("email", "");
    setValue("companyName", "");
  };

  return (
    <Layout>
      <CompanyListView
        data={data?.data?.data?.items || []}
        meta={data?.data?.data?.meta}
        role={role}
        authority={authority}
        pageState={pageState}
        onPageMove={onPageMove}
        onSearchContent={onSearchContent}
        onRefetch={onRefetch}
        onReflesh={onReflesh}
        register={register}
        watch={watch}
        setContentModal={setContentModal}
        setAlertModal={setAlertModal}
        search={search}
        onReset={onReset}
        onInviteCompany={onInviteCompany}
      />
    </Layout>
  );
}

export default CompanyList;
