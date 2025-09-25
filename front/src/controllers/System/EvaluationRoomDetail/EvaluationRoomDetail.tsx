/* eslint-disable react-hooks/exhaustive-deps */
import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import {
  evaluationRoomCompanyListApi,
  evaluationRoomInfoApi,
  EvaluationRoomModifyApi,
  EvaluationRoomRemoveApi,
  evaluationRoomSetUpApi,
  searchedCommitterList,
} from "../../../api/EvaluationRoomApi";
import { modifyEvaluationTableApi } from "../../../api/EvaluationTableApi";
import { PageStateType } from "../../../interface/Common/PageStateType";
import {
  EvaluationRommSetupType,
  EvaluationRoomCommitterResType,
  EvaluationRoomSetUp,
  StepTwoCommitter,
  StepTwoCompany,
  StepTwoCompanyRes,
  StepTwoSearchModal,
} from "../../../interface/System/EvaluationRoomDetail/EvaluationRoomDetailTypes";
import {
  TableArrayItemModifyTypeReq,
  TableArrayItemTypeReq,
} from "../../../interface/System/EvaluationTable/EvaluationTableTypes";
import { alertModalState, loadingModalState } from "../../../modules/Client/Modal/Modal";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import EvaluationRoomDetailView from "../../../view/System/EvaluationRoomDetail/EvaluationRoomDetailView";
import Layout from "../../Common/Layout/Layout";

interface EvaluationRoomDetailTypes {
  type: "add" | "modify";
}

function EvaluationRoomDetail(props: EvaluationRoomDetailTypes) {
  const params = useParams();
  const setErrorMessage = useSetRecoilState(alertModalState);
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const navigate = useNavigate();

  // 모달 리스트 정보
  const [state, setState] = useState<PageStateType>({
    page: 0,
    search: "",
    startDate:"",
      endDate:"",
      type:""
  });
  // 모달 페이지 정보
  const [stepTwoSearchModal, setStepTwoSearchModal] = useState<StepTwoSearchModal>({
    type: "",
    isModal: false,
  });
  // 평가표 모달 정보
  const [evaluationTableModal, setEvaluationTableModal] = useState<StepTwoSearchModal>({
    type: "",
    isModal: false,
  });

  // 평가위원 선택 리스트
  const [committerSelectList, setCommitterSelectList] = useState<StepTwoCommitter[]>([]);
  // 제안업체 선택 리스트
  const [companySelectList, setCompanySelectList] = useState<StepTwoCompany[]>([]);
  const [submitCheck, setSubmitCheck] = useState<string>("");
  // 평가위원 검색 키워드
  const [name, setName] = useState("");
  const changeName = (name: string) => {
    setName(name);
  };

  // 호출 api 영역 ----------------------------------------------------------------------------
  // 모달 제안업체 요청 데이터
  const { data: companyList, refetch: companyRefetch } = useData<StepTwoCompanyRes, null>(
    ["adminEvaluationCompanyList", null],
    () => evaluationRoomCompanyListApi({ ...state, isSuccess: true }),
    {
      refetchOnWindowFocus: false,
      onSuccess: (item) => {
        setCompanySelectList(item?.data.items ?? []);
      },
    }
  );
  // 평가위원 검색 리스트 가져오기
  const getSearchedCommitterList = useData<StepTwoCommitter[], string>(
    ["getSearchedCommitterList", name],
    searchedCommitterList,
    {
      enabled: !!name,
    }
  );
  // 평가방 정보 가져오기
  const { data: evaluationRoomInfo } = useData<EvaluationRommSetupType, null>(
    ["evaluationRoomInfo", null],
    () => evaluationRoomInfoApi(Number(params.id)),
    {
      enabled: params.id ? true : false,
      refetchOnWindowFocus: false,
      onSuccess: (item) => {},
      onError() {
        setAlertModal({
          isModal: true,
          content: "알 수 없는 오류로 값을 가져올 수 없습니다.",
          onClick() {
            navigate("/west/system/evaluation-room");
            resetAlertModal();
          },
        });
      },
    }
  );
  // 평가방 개설
  const evaluationRoomAdd = useSendData<string, HTMLFormElement>(evaluationRoomSetUpApi, {
    onSuccess: () => {
      resetLoadingModal();
      setSubmitCheck("success");
    },
  });
  // 평가방 수정
  const evaluationRoomModify = useSendData<string, HTMLFormElement>(EvaluationRoomModifyApi, {
    onSuccess: () => {
      resetLoadingModal();
      setSubmitCheck("success");
    },
  });
  // 평가방 삭제
  const evaluationRoomRemove = useSendData<string, string>(EvaluationRoomRemoveApi, {
    onSuccess: () => {
      resetLoadingModal();
      setSubmitCheck("delete");
    },
  });
  // 호출 api 영역 ----------------------------------------------------------------------------

  // 평가방 개설,수정 호출
  const onEvaluationRoomSetUp = (data: EvaluationRoomSetUp, type: string) => {
    resetAlertModal();

    // 평가위원 리스트 리스폰 데이터 정리
    let committerData: EvaluationRoomCommitterResType[] = [];
    data.committer.map((i: any) =>
      committerData.push({
        name: i.name,
        chairman: i.chairman ?? false,
        phone: i.phone,
        birth: i.birth,
        email: i.email,
      })
    );

    // 제안업체 리스트 리스폰 데이터 정리
    let companyData: number[] = [];
    data.company.map((i: any) => companyData.push(Number(i.id)));

    const formData: any = new FormData();

    for (let i = 0; i < data.filse.length; i++) {
      formData.append(`files`, data.filse[i]);
    }

    if (type === "modify" && params.id) formData.append(`id`, params.id); // 평가방 아이디
    formData.append(`proposedProject`, data.businessName ?? ""); // 사업명
    formData.append(`evaluationAt`, data.date ?? ""); // 평가일
    formData.append(`startAt`, data.startTime ?? ""); // 평가 시작시간
    formData.append(`endAt`, data.endTime ?? ""); // 평가 예상 종료시간
    formData.append(`committerNoticeContent`, data.committerNoticeContent ?? ""); // 공지사항
    formData.append(`companyNoticeContent`, data.companyNoticeContent ?? ""); // 공지사항
    formData.append(
      `createEvaluationTableDto`,
      JSON.stringify(data.createEvaluationTableDto) ?? ""
    ); // 평가표

    // 삭제할 파일 리스트
    if (data.deleteFiles && data.deleteFiles.length > 0) {
      data.deleteFiles.forEach((i, index) => {
        formData.append(`deleteFileIds[${index}]`, i);
      });
    }
    // if (committerData.length === 0) {
    //   formData.append(`committer[0]`, "");
    // }
    // if (companyData.length === 0) {
    //   formData.append(`company[0]`, "");
    // }
    committerData.forEach((i, index) => {
      formData.append(`committer[${index}]`, JSON.stringify(i)); // 참여 평가위원 선택 리스트
    });
    companyData.forEach((i, index) => {
      formData.append(`company[${index}]`, i);
    });

    if (type === "add") evaluationRoomAdd.mutate(formData);
    if (type === "modify") evaluationRoomModify.mutate(formData);
  };

  // 평가방 삭제 호출
  const onEvaluationRoomRemove = (id: string) => {
    resetAlertModal();
    evaluationRoomRemove.mutate(id);
  }

  // 각 리스트 페이지 정보 세팅
  // useEffect(() => {
  //   if (stepTwoSearchModal.type === "company") setPageInfo(companyList?.pageInfo);
  // }, [stepTwoSearchModal.type]);

  // 페이지 이동
  const onPageMove = (page: number) => {
    // pagination 컴포넌트 사용시 page에서 1 빼줘야함 (api에서 1을 더해주고 있음)
    setState({ ...state, page: page - 1 });
  };

  useEffect(() => {
    onRefetch();
  }, [state.page]);

  // 데이터 새로 불러오기 (검색 포함)
  const onRefetch = () => {
    if (stepTwoSearchModal.type === "company") companyRefetch();
  };
  const onReflesh = () => {
    setState({ page: 0, search: "", startDate:"",
      endDate:"", type:"" });
    setTimeout(() => {
      if (stepTwoSearchModal.type === "company") companyRefetch();
    }, 1);
  };
  // 검색 요청 정보 세팅하기
  const onSearchChange = (search: string) => {
    setState({ ...state, search });
  };

  const onSearchRefetch = () => {
    setState({ ...state, page: 0 });
    setTimeout(() => {
      companyRefetch();
    }, 10);
  };

  // 평가항목표 수정하기
  const evaluationTableInfoModify = useSendData<string, TableArrayItemModifyTypeReq>(
    modifyEvaluationTableApi,
    {
      onSuccess: () => {
        setAlertModal({
          type: "check",
          isModal: true,
          content: "해당 평가항목표가 수정되었습니다.",
          onClick() {
            resetAlertModal();
          },
        });
        resetLoadingModal();
      },
    }
  );

  /** 평가항목표 수정하기
   * @data TableArrayItemTypeReq
   */
  const onModify = (data: TableArrayItemTypeReq) => {
    let item: TableArrayItemModifyTypeReq = {
      id: Number(data.id),
      list: data?.data,
      title: data?.title,
    };

    evaluationTableInfoModify.mutate(item);
  };

  return (
    <Layout noBottom>
      <>
        <EvaluationRoomDetailView
          state={state}
          onPageMove={onPageMove}
          onSearchChange={onSearchChange}
          onSearchRefetch={onSearchRefetch}
          committerList={committerSelectList}
          companyList={companySelectList}
          onRefetch={onRefetch}
          onReflesh={onReflesh}
          pageInfo={companyList?.data.meta.totalPages as number}
          setErrorMessage={setErrorMessage}
          setAlertModal={setAlertModal}
          onEvaluationRoomSetUp={onEvaluationRoomSetUp}
          onEvaluationRoomRemove={onEvaluationRoomRemove}
          stepTwoSearchModal={stepTwoSearchModal}
          setStepTwoSearchModal={setStepTwoSearchModal}
          evaluationTableModal={evaluationTableModal}
          paramsId={Number(params.id)}
          evaluationRoomInfo={evaluationRoomInfo?.data}
          submitCheck={submitCheck}
          setSubmitCheck={setSubmitCheck}
          type={props.type}
          searchedList={getSearchedCommitterList?.data?.data || []}
          changeName={changeName}
          setEvaluationTableModal={setEvaluationTableModal}
          onModify={onModify}
        />
      </>
    </Layout>
  );
}

export default EvaluationRoomDetail;
