import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router";
import { PageStateType } from "../../../../interface/Common/PageStateType";
import Layout from "../../../Common/Layout/Layout";
import CommitterListView from "../../../../view/Partners/Committer/CommitterListview/CommitterListView";
import { alertModalState, contentModalState } from "../../../../modules/Client/Modal/Modal";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import { userState } from "../../../../modules/Client/Auth/Auth";
import RoleUtils from "../../../../utils/RoleUtils";
import { useData, useSendData } from "../../../../modules/Server/QueryHook";
import { committerListApi } from "../../../../api/ListApi";
import { ICommitterListRes } from "../../../../interface/List/ListResponse";
import { inviteCommitterApi } from "../../../../api/MasterApi";
import { IInviteCommitter } from "../../../../interface/Master/MasterData";
import theme from "../../../../theme";
import { useForm } from "react-hook-form";
import { CommitterAdd } from "../../../../interface/Partners/Committer/CommitterTypes";
import { queryClient } from "../../../..";
import queryString from "query-string";

function CommitterList() {
  const userData = useRecoilValue(userState);
  const role = RoleUtils.getRole(userData.role);
  const authority = RoleUtils.getClientRole(userData.role);
  const [search, setSearch] = useState("");
  const setContentModal = useSetRecoilState(contentModalState);
  const resetModal = useResetRecoilState(contentModalState);
  const setAlertModal = useSetRecoilState(alertModalState);
  const location = useLocation();
  const navigate = useNavigate();
  const parsed = queryString.parse(location.search);
  const [pageState, setPageState] = useState<PageStateType>({
    page: Number(parsed.page) || 0,
    search: (parsed.search as string) || "",
    startDate:"",
      endDate:""
  });

  useEffect(() => {
    navigate(`/west/system/committer?page=${pageState.page}&search=${pageState.search}`);
  }, [pageState]);

  const {
    register, // input 과 연결해주는 객체
    setValue, // input의 값을 설정 가능한 메서드
    watch, // 실시간으로 input의 값을 확인하는 메서드
    reset,
  } = useForm<CommitterAdd>({});

  // 평가위원 리스트
  const { data, refetch } = useData<ICommitterListRes, PageStateType>(
    ["committerList", pageState],
    committerListApi
  );

  // 평가위원 초대 api
  const inviteCommitter = useSendData<string, IInviteCommitter>(inviteCommitterApi);
  const onInviteCommitter = (data: IInviteCommitter) => {
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
          평가위원이 추가되었습니다.
        </span>
      ),
      onClick: () => {
        reset();
      },
      type: "check",
      isModal: true,
    });
  };

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
    setPageState({ page: 0, search: "",startDate:"",endDate:"" });
    setSearch("");
  };

  const onCommitterListRefetch = () => {
    refetch();
  };

  return (
    <Layout noBottom>
      <>
        <CommitterListView
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
          onInviteCommitter={onInviteCommitter}
          watch={watch}
          register={register}
          search={search}
          onCommitterListRefetch={onCommitterListRefetch}
          onReset={reset}
        />
      </>
    </Layout>
  );
}

export default CommitterList;
