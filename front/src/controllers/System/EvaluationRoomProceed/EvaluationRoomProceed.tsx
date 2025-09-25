/* eslint-disable react-hooks/exhaustive-deps */
import { useEffect, useRef, useState } from "react";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import {
  AttendeeListTypes,
  EvaluationRoomInfoTypes,
  EvaluationTableStatusInterface,
  ParticipantsListInterface,
  COM,
  EvaluationRoomTimeSetReqInterface,
  EvaluationCommitterScoreReqInterface,
} from "../../../interface/System/EvaluationRoomProceed/EvaluationRoomProceedTypes";
import { userState } from "../../../modules/Client/Auth/Auth";
import {
  alertModalState,
  contentModalState,
  loadingModalState,
} from "../../../modules/Client/Modal/Modal";
import RoleUtils from "../../../utils/RoleUtils";
import EvaluationRoomProceedView from "../../../view/System/EvaluationRoomProceed/EvaluationRoomProceedView";
import TimeSetting from "../../../view/System/EvaluationRoomProceed/TimeSetting/TimeSetting";
import { getCookie } from "../../../utils/ReactCookie";
import {
  evaluationRoomCommitterInfoApi,
  evaluationRoomCompanyInfoApi,
  evaluationRoomInfoApi,
  getCommitterEvaluationRoomDataApi,
  getCommitterEValuationRoomOutCheckApi,
  getCommitterEvaluationRoomParticipantsApi,
  getCommitterEvaluationTableApi,
  getCompanyEValuationRoomOutCheckApi,
  getCompanyEvaluationRoomParticipantsApi,
  getEvaluationCommitterScoreListDown,
  getEvaluationCommitterScoreView,
  getEvaluationInCheckTableApi,
  getEvaluationRoomStartCheckApi,
  getEvaluationSummaryTableApi,
  getEvaluationTimeCatchApi,
  getMasterEvaluationRoomDataApi,
  getMasterEvaluationRoomParticipantsApi,
  getMasterEvaluationSummaryTableApi,
  getStartEvaluationApi,
  getTimeByAdminApi,
  patchCommitterEvaluationScoreDataApi,
  patchEvaluationFinish,
  patchEvaluationRoomTimeSetApi,
  patchEvaluationTimeStartApi,
  patchMasterSubmitCheckApi,
  patchParticipantsWithdrawalApi,
  postEvaluationTableScoreSaveApi,
} from "../../../api/EvaluationRoomApi";
import { EvaluationRommSetupType } from "../../../interface/System/EvaluationRoomDetail/EvaluationRoomDetailTypes";
import { useParams } from "react-router";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import EvaluationRoomNotice from "../../../components/EvaluationRoomProceed/EvaluationRoomNotice";
import { EvaluationSumScoreTableType } from "../../../components/EvaluationSumScoreTable/EvaluationSumScoreTableComponent";
import {
  TableArrayItemModifyTypeReq,
  TableArrayItemResType,
  TableArrayItemType,
  TableMutateListType,
} from "../../../interface/System/EvaluationTable/EvaluationTableTypes";
import { throttle } from "lodash";

interface EvaluationRoomProceedTypes {}

export type notice = {
  committerNoticeContent: string;
  companyNoticeContent: string;
};

function EvaluationRoomProceed(props: EvaluationRoomProceedTypes) {
  const t =
    Number(process.env.REACT_APP_REFETCH_TIME) > 0
      ? Number(process.env.REACT_APP_REFETCH_TIME)
      : false;

  let refetchTime: number | boolean = t;
  const params = useParams();
  const userData = useRecoilValue(userState);
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const setContentModal = useSetRecoilState(contentModalState);
  const resetContentModal = useResetRecoilState(contentModalState);
  const setLoadingModal = useSetRecoilState(loadingModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);

  const [roomOpenCheck, setRoomOpenCheck] = useState(false);

  const isAdmin = RoleUtils.getClientRole(userData.role) === "admin";
  const isCommitter = RoleUtils.getClientRole(userData.role) === "committer";
  const isCompany = RoleUtils.getClientRole(userData.role) === "company";

  // 평가 정보
  const [evaluationRoomInfo, setEvaluationRoomInfo] = useState<EvaluationRoomInfoTypes | null>(
    null
  );

  // 해당 평가방에 지정된 평가표 정보
  const [evaluationTableInfo, setEvaluationTableInfo] = useState<TableArrayItemType[] | null>(null);
  const [evaluationTableDivision, setEvaluationTableDivision] = useState<string>("");
  // 해당 평가방에 지정된 평가표 정보 모달 체크
  const [evaluationTableModalCheck, setEvaluationTableModalCheck] = useState<boolean>(false);

  // 평가 시 평가항목 채점리스트
  const [evaluationTableData, setEvaluationTableData] = useState<TableArrayItemType[] | []>([]);
  // 평가 시 평가항목표 제목
  const [evaluationTableTitle, setEvaluationTableTitle] = useState<string>("");
  // 평가 시 평가항목표 타입
  const [evaluationTableType, setEvaluationTableType] = useState<string>("");

  // ================================================================================================================================ STEP
  // 진행 스텝 state
  const [step, setStep] = useState(0);
  // 스텝 변경 함수
  const changeStep = (step: number) => {
    window.localStorage.setItem("step", String(step));
    setStep(step);
  };
  // 새로고침시 저장된 스텝에 따라 스텝이동
  useEffect(() => {
    const step = window.localStorage.getItem("step");
    if (!step) {
      if (isAdmin) {
        setStep(2);
      } else setStep(0);
      return;
    }
    setStep(Number(step));
  }, []);
  // 스텝 이동시마다 실행될 동작
  useEffect(() => {
    if (step === 2) {
      setStepReady(true);
    }
    if (step === 3 && !isAdmin) {
      setStepReady(true);
    }
    if (step === 4 && !isAdmin) {
      setStepReady(false);
    }
  }, [step]);

  // 평가위원의 시점에서 평가사전 준비가 끝나면 true 아니면 false
  const [stepReady, setStepReady] = useState(isCommitter || isCompany ? false : true);
  // 평가완료 버튼 클릭 후 로딩 모달 띄우기 state
  const [evaluationCompleteLoading, setEvaluationCompleteLoading] = useState<
    "loading" | "success" | "fail" | ""
  >("");

  // 참석자 리스트
  const [attendeeList, setAttendeeList] = useState<AttendeeListTypes[]>([]);
  // 공지사항
  const [notice, setNotice] = useState<notice>({
    committerNoticeContent: "",
    companyNoticeContent: "",
  });
  useEffect(() => {
    onNotice();
  }, [notice.committerNoticeContent, notice.companyNoticeContent]);
  /** 평가방 세팅 정보, 시간 카운트는 여기서 진행 */
  const [evaluationRoomStatus, setEvaluationRoomStatus] = useState({
    announcement: "00:00",
    inquiry: "00:00",
  });
  /** 설정에서 설정한 시간 데이터, 리셋 시킬시 사용 */
  const [timeSettingModalStatus, setTimeSettingModalStatus] = useState({
    announcement: "00:00",
    inquiry: "00:00",
  });

  // 시간 저장 state
  const [timeSettingCheck, setTimeSettingCheck] = useState(false);

  // 선택한 회사 아이디
  const [companyId, setCompanyId] = useState<number | null>(null);

  // 평가담당자 선택한 스코어 정보
  const [scoreIds, setScoreIds] = useState<EvaluationCommitterScoreReqInterface | null>(null);

  // 평가방 평가항목표 요약 가져오기 (평가항목점수표)
  const [summaryInfoArray, setSummaryInfoArray] = useState<EvaluationSumScoreTableType[]>([]);

  // 평가위원 본인 정보
  const [committerInfo, setCommitterInfo] = useState<COM | null>(null);

  // 평가방 평가점수표 제출현황
  const [committerScoreSubmissionStatus, setCommitterScoreSubmissionStatus] = useState<
    EvaluationTableStatusInterface[]
  >([]);

  // 평가방 참석자 현황
  const [participantsListInfo, setParticipantsListInfo] = useState<ParticipantsListInterface[]>([]);

  // 블록체인 적용된 최종평가표 정보
  const [finalEvaluationTable, setFinalEvaluationTable] = useState<any | null>(null);

  // 평가 시작 체크
  const [evaluationStartCheck, setEvaluationStartCheck] = useState<boolean>(false);

  // 평가위원 점수제출 시 평가표 완료여부 확인
  const [committerScoreSubmissionCheck, setCommitterScoreSubmissionCheck] = useState<boolean>(true);

  const [summaryInfoAllOpenCheck, setSummaryInfoAllOpenCheck] = useState<boolean>(false);

  // 평가방 정보 가져오기
  const { data: evaluationProceedInfo, refetch: evaluationProceedInfoRefetch } = useData<
    EvaluationRommSetupType,
    null
  >(["evaluationProceedInfo", null], () => requestApi(Number(params.id))!, {
    refetchOnWindowFocus: false,
    onSuccess: (item) => {
      // 공지사항 세팅

      setNotice({
        committerNoticeContent: item.data.committerNoticeContent,
        companyNoticeContent: item.data.companyNoticeContent,
      });

      if (item?.data?.status === "평가 중") {
        setEvaluationStartCheck(true);
        setRoomOpenCheck(true);
      }

      // 평가 정보 세팅
      setEvaluationRoomInfo({
        evaluationRoomId: Number(item.data?.id),
        proposedProject: item?.data?.proposedProject ?? "",
        masterName: item?.data?.masterName ?? "",
        masterPhone: item?.data?.masterPhone ?? "",
        evaluationAt: item?.data?.evaluationAt ?? "",
        startAt: item?.data?.startAt ?? "",
        endAt: item?.data?.endAt ?? "",
        committerChairMan: item?.data?.committerChairMan ?? "",
        evaluationFiles: item?.data?.evaluationFiles,
        evaluationTable: item?.data?.evaluationTable,
        meetingUrl: item?.data?.meetingUrl ?? "",
        meetingPassword: item?.data?.meetingPassword ?? "",
        committerNoticeContent: item?.data?.committerNoticeContent,
        companyNoticeContent: item?.data?.companyNoticeContent,
        status: item?.data?.status,
      });
      // 참석자 정보 세팅
      // trunIn = submission 제출, notSubmitted 미제출
      let list: any[] = [];
      item?.data?.committer?.map((i) =>
        list?.push({
          // id: i.id,
          name: i.name,
          type: "committer",
          status: "before",
          turnIn: "notSubmitted",
        })
      );
      item?.data?.company?.map((i) =>
        list.push({
          id: i.id,
          name: i.companyName,
          type: "company",
          status: "before",
        })
      );
      setAttendeeList(list);
    },
    onError: (e) => {
      // 강퇴로 인한 예외처리 메세지 띄우기 방지용
      console.log("");
      if(e.response?.status === 401){
        window.close();
      }
    },
  });

  // 평가방 평가항목표 요약 가져오기 (평가항목점수표)
  const { data: summaryInfo, refetch: summaryInfoRefetch } = useData<
    EvaluationSumScoreTableType[],
    null
  >(["evaluationSummaryTableInfo", null], () => getEvaluationSummaryTableApi(Number(params.id)), {
    refetchOnWindowFocus: false,
    enabled: step === 3 && !isAdmin,
    onSuccess: (item) => {
      let role = RoleUtils.getClientRole(userData.role);
      if (role === "committer" && !sessionStorage.getItem("evaluationStatus"))
        sessionStorage.setItem("evaluationStatus", String(item.data ? item.data[0].status : ""));

      if (item.data[0].status !== sessionStorage.getItem("evaluationStatus")) {
        if (item.data[0].status === "FIRST_SUBMIT") setEvaluationCompleteLoading("loading");
        if (item.data[0].status === "REQUEST_MODIFY") setEvaluationCompleteLoading("fail");
        if (item.data[0].status === "FINAL_SUBMIT") setEvaluationCompleteLoading("success");
        sessionStorage.setItem("evaluationStatus", String(item.data ? item.data[0].status : ""));
      } else {
        let status = sessionStorage.getItem("evaluationStatus");
        if (status === "FIRST_SUBMIT") setEvaluationCompleteLoading("loading");
        if (status === "REQUEST_MODIFY") setEvaluationCompleteLoading("fail");
        if (status === "FINAL_SUBMIT") setEvaluationCompleteLoading("success");
      }

      item.data.forEach((data) => {
        if (data.type === "suitable") {
          data.list.forEach((inData) => {
            for (let i = 0; i < inData.scoreList.length; i++) {
              setCommitterScoreSubmissionCheck(true);
              if (inData.scoreList[i].suitable === null) {
                setCommitterScoreSubmissionCheck(false);
                break;
              }
            }
          });
        }
        if (data.type === "quantitative") {
          const status = data.status;
          let sumArray: number[] = [...Array(data.list[0].scoreList.length)];
          if (status === "NOT_SUBMIT") {
            setCommitterScoreSubmissionCheck(true);
            // for (let i = 0; i < data.list.length; i++) {
            //   const inData = data.list[i];

            //   inData.scoreList.forEach((inInData, index) => {
            //     if (sumArray[index] === undefined) {
            //       sumArray[index] = Number(inInData.score);
            //     } else {
            //       sumArray[index] += Number(inInData.score);
            //     }
            //   });
            // }
            // if (!sumArray.includes(0)) {
            //   // setCommitterScoreSubmissionCheck(false);
            //   setSummaryInfoAllOpenCheck(true);
            // }
          } else {
            setSummaryInfoAllOpenCheck(true);
            setCommitterScoreSubmissionCheck(true);
          }
        }
      });

      setTimeout(() => {
        setSummaryInfoArray(item.data);
      }, 20);
    },
  });

  const { data: masterSummaryInfo, refetch: masterSummaryInfoRefetch } = useData<
    EvaluationSumScoreTableType[],
    null
  >(
    ["masterEvaluationSummaryTableInfo", null],
    () => getMasterEvaluationSummaryTableApi(Number(params.id)),
    {
      refetchOnWindowFocus: false,
      enabled: step === 3 && isAdmin,
      onSuccess: (item) => {
        setTimeout(() => {
          setSummaryInfoArray(item.data);
        }, 20);
      },
    }
  );

  // 유저 평가 담당자가 설정한 시간 가져오기
  const getTimeByAdmin = useData(
    ["getTimeByAdmin", null],
    () => getTimeByAdminApi(Number(params.id)),
    {
      enabled: (!isAdmin && step >= 2) || isAdmin,
      refetchInterval: refetchTime,
      onSuccess(data: { data: { presentationTime: string; questionTime: string } }) {
        setEvaluationRoomStatus({
          announcement: data.data.presentationTime ?? "00:00",
          inquiry: data.data.questionTime ?? "00:00",
        });
        // setTimeSettingModalStatus({
        //   announcement: data.data.presentationTime ?? "00:00",
        //   inquiry: data.data.questionTime ?? "00:00",
        // });
      },
    }
  );

  // 평가 시작 요청하기 (평가 담당자용)
  const { data: evaluationStart, refetch: evaluationStartRefetch } = useData<any, null>(
    ["evaluationStart", null],
    () => getStartEvaluationApi(Number(params.id)),
    {
      refetchOnWindowFocus: false,
      enabled: false,
      onSuccess: (item) => {
        setEvaluationStartCheck(true);
        resetLoadingModal();
      },
    }
  );

  // 평가위원 선택한 제안업체 평가표 가져오기
  const { data: companyEvaluationTable, refetch: companyEvaluationTableRefetch } = useData<
    TableArrayItemResType,
    number | null
  >(
    ["companyEvaluationTable", companyId],
    () => getCommitterEvaluationTableApi(Number(params.id), companyId!),
    {
      refetchOnWindowFocus: false,
      enabled: false,
      onSuccess: (item) => {
        setEvaluationTableTitle(item.data.title);
        setEvaluationTableType(item.data.type);
        setEvaluationTableData(item.data.list);
      },
    }
  );
  // 평가담당자 평가위원 점수 확인
  const { data: committerSuitableTable, refetch: committerSuitableTableRefetch } = useData<
    TableArrayItemResType,
    number | null
  >(["committerSuitableTable", null], () => getEvaluationCommitterScoreView(scoreIds!), {
    refetchOnWindowFocus: false,
    enabled: false,
    onSuccess: (item) => {
      setEvaluationTableTitle(item.data.title);
      setEvaluationTableType(item.data.type);
      setEvaluationTableData(item.data.list);
    },
  });

  // 평가방 평가위원이 선택한 제안업체 평가표 채점 저장하기
  const modifyEvaluationTableScore = useSendData<
    any,
    { id: number; companyId: number; scoreList: TableMutateListType[] }
  >(postEvaluationTableScoreSaveApi, {
    onSuccess: () => {
      summaryInfoRefetch();
      resetLoadingModal();
    },
  });

  // 평가방 평가위원  점수제출 요청
  const patchEvaluationScoreSubmit = useSendData<any, number>(
    patchCommitterEvaluationScoreDataApi,
    {
      onSuccess: () => {
        resetLoadingModal();
        setEvaluationCompleteLoading("loading");
        summaryInfoRefetch();
      },
    }
  );

  // 평가담당자 보정평가 및 제출 여부 확인
  const patchMasterEvaluationSubmitCheck = useSendData<
    any,
    { id: number; committerId: number; status: string }
  >(patchMasterSubmitCheckApi, {
    onSuccess: () => {
      resetLoadingModal();
    },
  });

  // 평가담당자 평가방 평가점수 제출현황 정보 가져오기 (5초)
  const { data: masterScoreSubmissionStatus, refetch: masterScoreSubmissionStatusRefetch } =
    useData<any, null>(
      [`masterScoreSubmissionStatus`, null],
      () => getMasterEvaluationRoomDataApi(Number(params.id)),
      {
        enabled: isAdmin,
        refetchInterval: isAdmin ? refetchTime : false,
        onSuccess: (item) => {
          if (committerScoreSubmissionStatus.length <= 0) {
            setCommitterScoreSubmissionStatus(item.data);
          } else {
            let dd = committerScoreSubmissionStatus.filter((d) => item.data.includes(d));

            if (dd.length < committerScoreSubmissionStatus.length) {
              setCommitterScoreSubmissionStatus(item.data);
              masterSummaryInfoRefetch();
            }
          }
        },
      }
    );

  // 평가위원 평가방 평가점수 제출현황 정보 가져오기 (5초)
  const { data: scoreSubmissionStatus, refetch: scoreSubmissionStatusRefetch } = useData<any, null>(
    [`scoreSubmissionStatus`, null],
    () => getCommitterEvaluationRoomDataApi(Number(params.id)),
    {
      enabled: isCommitter,
      refetchInterval: evaluationStartCheck && isCommitter ? refetchTime : false,
      onSuccess: (item) => {
        if (committerScoreSubmissionStatus.length <= 0) {
          setCommitterScoreSubmissionStatus(item.data);
        } else {
          let dd = committerScoreSubmissionStatus.filter((d) => item.data.includes(d));

          if (dd.length < committerScoreSubmissionStatus.length) {
            setCommitterScoreSubmissionStatus(item.data);
            summaryInfoRefetch();
          }
        }
      },
    }
  );

  // 접속중인 참석자 확인 (5초)
  const { data: masterEvaluationParticipants, refetch: masterEvaluationParticipantsRefetch } =
    useData<ParticipantsListInterface[], null>(
      ["masterEvaluationParticipants", null],
      () => getMasterEvaluationRoomParticipantsApi(Number(params.id)),
      {
        refetchInterval: refetchTime,
        onSuccess: (item) => {
          let data = item.data.sort((a, b) => {
            if (a.committer) return -1;
            if (!a.committer) return 1;
            return 0;
          });

          const withdrawalAlert = () => {
            refetchTime = false;
            setAlertModal({
              isModal: true,
              content: "강퇴처리 되어 입장하실 수 없습니다.",
              onClick: () => window.close(),
              type: "check",
            });
          };

          if (isCommitter)
            item.data.find((d) => {
              if (d.committer?.isMe) {
                if (!d.enable) {
                  withdrawalAlert();
                } else {
                  setCommitterInfo(d.committer);
                }
              }
            });
          if (isCompany)
            item.data.find((d) => {
              if (d.company?.isMe) {
                if (!d.enable) {
                  withdrawalAlert();
                } else {
                  setCommitterInfo(d.company);
                }
              }
            });

          setParticipantsListInfo(data);
        },
      }
    );

  //  해당 평가위원이 접속 중인지 체크 (5초)
  const { data: evaluationParticipants, refetch: evaluationParticipantsRefetch } = useData<
    ParticipantsListInterface[],
    null
  >(
    ["evaluationParticipants", null],
    () => getCommitterEvaluationRoomParticipantsApi(Number(params.id)),
    {
      enabled: isCommitter,
      refetchInterval: isCommitter ? refetchTime : false,
      onSuccess: (item) => {
        // console.log(item);
      },
    }
  );

  // 해당 평가위원이 평가방 이탈 여부 서버에 전송
  const { data: committerEvaluationRoomOut, refetch: committerEvaluationRoomOutRefetch } = useData<
    null,
    null
  >(
    ["committerEvaluationRoomOut", null],
    () => getCommitterEValuationRoomOutCheckApi(Number(params.id)),
    {
      refetchOnWindowFocus: false,
      enabled: false,
      onSuccess: (item) => {
        if (item.data) window.close();
      },
    }
  );

  //  해당 제안업체가 접속 중인지 체크 (5초)
  const { data: companyEvaluationParticipants, refetch: companyEvaluationParticipantsRefetch } =
    useData<ParticipantsListInterface[], null>(
      ["companyEvaluationParticipants", null],
      () => getCompanyEvaluationRoomParticipantsApi(Number(params.id)),
      {
        enabled: isCompany,
        refetchInterval: isCompany ? refetchTime : false,
        onSuccess: (item) => {
          // console.log(item);
        },
      }
    );

  // 해당 제안업체가 평가방 이탈 여부 서버에 전송
  const { data: companyEvaluationRoomOut, refetch: companyEvaluationRoomOutRefetch } = useData<
    null,
    null
  >(
    ["companyEvaluationRoomOut", null],
    () => getCompanyEValuationRoomOutCheckApi(Number(params.id)),
    {
      refetchOnWindowFocus: false,
      enabled: false,
      onSuccess: (item) => {
        if (item.data) window.close();
      },
    }
  );

  // 평가방 시작여부 체크 (5초)
  const getEvaluationRoomStartCheck = useData<string, null>(
    ["getEvaluationRoomStartCheck", null],
    () => getEvaluationRoomStartCheckApi(Number(params.id)),
    {
      enabled: !isAdmin,
      refetchInterval: !isAdmin ? refetchTime : false,
      onSuccess(item) {
        if (item.data === "PROGRESS") {
          setEvaluationStartCheck(true);
        } else {
          setEvaluationStartCheck(false);
        }
      },
    }
  );

  // 평가담당자 참석자 강퇴 처리
  const patchParticipantsWithdrawal = useSendData<any, { id: number; disableUserId: number }>(
    patchParticipantsWithdrawalApi,
    {
      onSuccess: (data) => {
        resetLoadingModal();
        if (data.data.data.code === "001") {
          setAlertModal({
            isModal: true,
            type: "nextFlow",
            title: "평가 종료 안내",
            buttonText: "확인",
            content:
              "모든 평가위원이 퇴장되어 평가를 진행할 수 없습니다.\n새로운 평가방을 개설 후 평가를 진행해 주세요.\n현재 평가방을 종료합니다.",
            onClick: () => {
              window.close();
            },
          });
        } else {
          masterEvaluationParticipantsRefetch();
        }
      },
    }
  );

  // 평가담당자 평가방 평가종료 처리
  const patchEvaluationRoomFinish = useSendData<any, number>(patchEvaluationFinish, {
    onMutate() {
      setLoadingModal({
        isButton: false,
        isModal: true,
        type: "block",
        subText: (
          <>
            <h1>블록체인 생성중...</h1>
            <p>잠시만 기다려주세요.</p>
          </>
        ),
      });
    },
    onSuccess(item) {
      // console.log("1");
      if (!item) return;

      const file = new Blob([item.data as any], {
        type: "application/pdf",
      });

      const fileURL = URL.createObjectURL(file);

      setTimeout(() => {
        resetLoadingModal();
        setFinalEvaluationTable(fileURL);
      }, 2000);

      resetLoadingModal();

      setAlertModal({
        isModal: true,
        content: "평가가 종료 되었습니다.",
      });
    },
    // retry: 0,
  });

  // 평가담당자 평가시간 설정하기
  const patchEvaluationRoomTimeSet = useSendData<any, EvaluationRoomTimeSetReqInterface>(
    patchEvaluationRoomTimeSetApi,
    {
      onSuccess: () => {
        resetLoadingModal();
        setAlertModal({
          isModal: true,
          content: "시간이 반영되었습니다.",
        });
      },
    }
  );

  // 평가표 정보 가져오기
  const { data: evaluationTableInfoData, refetch: evaluationTableInfoDataRefetch } = useData<
    TableArrayItemModifyTypeReq,
    null
  >(
    ["evaluationTableInfoData", null],
    () => getEvaluationInCheckTableApi(Number(evaluationRoomInfo?.evaluationTable.id)),
    {
      enabled: false,
      refetchOnWindowFocus: false,
      onSuccess: (item) => {
        setEvaluationTableInfo(item.data.list ?? []);
        setEvaluationTableDivision(item.data.type ?? "");
      },
      onError() {
        setAlertModal({
          isModal: true,
          content: "알 수 없는 오류로 값을 가져올 수 없습니다.",
          onClick() {
            // returnPage();
            resetAlertModal();
          },
        });
      },
    }
  );

  const requestApi = (id: number) => {
    if (getCookie("authority") === "admin") return evaluationRoomInfoApi(id);
    if (getCookie("authority") === "committer") return evaluationRoomCommitterInfoApi(id);
    if (getCookie("authority") === "company") return evaluationRoomCompanyInfoApi(id);
  };

  /** 참석자 리스트 세팅 */
  // useEffect(() => {
  //   setAttendeeList(AttendeeListDummy);
  // }, [AttendeeListDummy]);

  /** 평가방 퇴장 처리 */
  const onExit = (id: number) => {
    let item = [...attendeeList];
    setAttendeeList(item.map((i) => (i.id === id ? { ...i, status: "exit" } : i)));
  };

  // useEffect(() => {
  //   onNotice();
  // }, []);

  /** 공지사항 모달 */
  const onNotice = () => {
    setContentModal({
      isModal: true,
      title: "공지사항",
      subText: "",
      type: "ok",
      content: (
        <EvaluationRoomNotice
          readOnly={true}
          notice={notice}
          authority={RoleUtils.getClientRole(userData.role)}
        />
      ),
    });
  };

  /** 공지사항 수정 */
  const onNoticeChange = () => {
    resetContentModal();
  };

  /** 공지사항 입력 */
  const onChange = (value: string) => {
    // console.log(value);
  };

  /** 시간설정 모달 */
  const onTime = () => {
    setTimeSettingCheck(false);
    setContentModal({
      isModal: true,
      title: "시간 설정",
      subText: "발표시간 및 질의 응답 시간을 설정해주세요.",
      content: (
        <TimeSetting onSetTime={onSetTime} timeSettingModalStatus={timeSettingModalStatus} />
      ),
      buttonText: "확인",
      onClick: () => onTimeDataSave(),
    });
  };

  // 시간설정하기
  const onSetTime = (e: any) => {
    setTimeSettingModalStatus(e);
  };
  /** 시간 설정 저장 */
  const onTimeDataSave = () => {
    setTimeSettingCheck(true);
  };

  /** 시간 설정 모달에서 확인 눌렀을 시 트리거 */
  useEffect(() => {
    if (timeSettingCheck) {
      setEvaluationRoomStatus(timeSettingModalStatus);
      onEvaluationRoomTimeSet(timeSettingModalStatus);
      resetContentModal();
    }
  }, [timeSettingCheck]);

  /** 평가방 종료, 웹소켓 구독 취소 */
  const onCloseEvaluationRoom = () => {
    // console.log("웹소켓 종료");
    // console.log("평가방을 종료합니다.");
    setAlertModal({
      isModal: true,
      content: "해당 평가가 종료되었습니다.",
    });
    // setRoomOpenCheck(false);
  };

  /** 평가담당자가 평가방 평가시작 요청하기 */
  const onEvaluationStartReq = () => {
    setAlertModal({
      isModal: true,
      type: "nextFlow",
      title: "평가위원 '퇴장' 조치 안내",
      content:
        "평가를 진행하지 않은 평가위원이 있을 경우 평가 완료를 할 수 없습니다.\n참석하지 않은 평가위원은 참석자 목록에서 '퇴장' 버튼을 눌러주세요.",
      onClick: () => {
        setLoadingModal({ isButton: false, isModal: true, type: "default" });
        setTimeout(() => {
          evaluationStartRefetch();
        }, 10);
      },
    });
  };

  const onCommitterKickOutModal = (fn: Function) => {
    setAlertModal({
      isModal: true,
      type: "nextFlow",
      title: "평가위원 '퇴장' 조치 안내",
      content:
        "평가를 진행하지 않은 평가위원이 있을 경우 평가 완료를 할 수 없습니다.\n참석하지 않은 평가위원은 참석자 목록에서 '퇴장' 버튼을 눌러주세요.",
      onClick: () => {
        fn();
      },
    });
  };

  /** 평가방 평가위원이 선택한 제안업체 평가표 가져오기 */
  const onCompanyEvaluationTable = (id: number) => {
    setCompanyId(id);
    setTimeout(() => {
      companyEvaluationTableRefetch();
    }, 10);
  };

  /** 평가담당자가 평가위원 점수표 상세 조회하기 */
  const onMasterEvaluationCommitterScoreView = (committerId: number, companyId: number) => {
    let data: EvaluationCommitterScoreReqInterface = {
      id: Number(params.id),
      committerId,
      companyId: Number(companyId),
    };

    setScoreIds(data);

    setTimeout(() => {
      committerSuitableTableRefetch();
    }, 10);
  };

  /** 평가방 평가위원이 선택한 제안업체 평가표 채점 저장하기 */
  const onSaveEvaluationScore = (scoreList: TableMutateListType[]) => {
    if (!companyId) return;

    let data = {
      id: Number(params.id),
      companyId,
      scoreList,
    };

    modifyEvaluationTableScore.mutate(data);
  };

  /** 평가방 평가위원  점수제출 요청 */
  const onEvaluationScoreSubmit = () => {
    if (committerScoreSubmissionCheck && summaryInfoAllOpenCheck) {
      patchEvaluationScoreSubmit.mutate(Number(params.id));
    } else {
      setAlertModal({
        isModal: true,
        type: "error",
        title: "경고",
        content: `모든 평가를 완료 후 점수제출을 눌러주세요.`,
      });
    }
  };

  /** 평가담당자 보정평가 및 제출 여부 확인 */
  const onMasterEvaluationSubmitCheck = (committerId: number, status: string) => {
    let data = {
      id: Number(params.id),
      committerId,
      status,
    };

    patchMasterEvaluationSubmitCheck.mutate(data);
  };

  /** 담당자 최종점수표 확인 블록체인 트렌젝션 요청 */
  const onEvaluationStateClick = () => {
    let noSubmitScore = committerScoreSubmissionStatus.find(
      (d, index) => d.evaluationTableStatus !== "FINAL_SUBMIT"
    );

    if (noSubmitScore) {
      setAlertModal({
        isModal: true,
        content: "모든 평가위원의 평가 결과 확인이 완료된 후\n최종점수표를 확인하실 수 있습니다.",
        type: "error",
        title: "평가 결과를 확인해주세요.",
      });
      return;
    }

    if (isAdmin) {
      setAlertModal({
        isModal: true,
        content: `평가 결과를 종합하여 최종점수표를 생성합니다.\n최종점수표는 블록체인에 정보를 저장합니다.\n(확인 버튼을 누르시면 수정이 불가하오니 신중히 확인 후 진행 부탁드립니다.)`,
        onClick() {
          const finish = patchEvaluationRoomFinish.mutateAsync(Number(params.id));
          resetAlertModal();

          finish
            .then(() => {
              resetLoadingModal();
              changeStep(4);
            })
            .catch((e) => {
              setAlertModal({
                isModal: true,
                content: `블록체인 저장 중에 에러가 발생했습니다.\n잠시 후 다시 시도해주세요.`,
              });
            });
        },
      });
    }
  };

  /** 평가담당자 해당 평가 종료처리 */
  const onEvaluationFinish = () => {
    setAlertModal({
      isModal: true,
      content: "현재 평가를 종료하시겠습니까?",
      onClick() {
        changeStep(5);
        resetAlertModal();
      },
    });
  };

  /** 참석자 퇴장 처리 */
  const onWithdrawal = (disableUserId: number) => {
    setAlertModal({
      isModal: true,
      type: "error",
      title: "경고",
      content: `해당 평가위원을 퇴장처리 하시겠습니까?\n한번 퇴장처리된 평가위원은 다시 참석할 수 없습니다.`,
      onClick() {
        resetAlertModal();
        patchParticipantsWithdrawal.mutate({ id: Number(params.id), disableUserId });
      },
    });
  };

  // 브라우저 탭 종료 감지시 평가방 나가기 api 호출
  useEffect(() => {
    window.addEventListener("beforeunload", onEvaluationRoomOut);
  }, []);

  /** 평가방 나가기 */
  const onEvaluationRoomOut = () => {
    if (isAdmin) {
      return;
    }
    if (isCommitter) committerEvaluationRoomOutRefetch();
    if (isCompany) companyEvaluationRoomOutRefetch();
  };

  /**
   * 시간 설정하기
   * @param data {announcement: string; inquiry:string}
   */
  const onEvaluationRoomTimeSet = (data: { announcement: string; inquiry: string }) => {
    let item = {
      id: Number(params.id),
      presentationTime: data.announcement,
      questionTime: data.inquiry,
    };
    
    patchEvaluationRoomTimeSet.mutate(item);
  };

  /** 평가표 미리보기 토글 */
  const onEvaluationTableView = (check: boolean) => {
    if (!evaluationTableInfo) evaluationTableInfoDataRefetch();
    setEvaluationTableModalCheck(check);
  };

  /** 평가담당자 평가위원 점수표 다운로드 */
  const getEvaluationCommitterScoreList = useData<string, null>(
    ["getEvaluationCommitterScoreListDown", null],
    () => getEvaluationCommitterScoreListDown(Number(params.id)),
    {
      enabled: false,
      refetchInterval: false,
      onSuccess(item) {
        if (!item) return;

        const file = new Blob([item as any], {
          type: "application/pdf",
        });

        const fileObjectUrl = URL.createObjectURL(file);

        const link = document.createElement("a");
        link.href = fileObjectUrl;
        link.style.display = "none";

        link.download = `${evaluationRoomInfo?.proposedProject}_평가위원 평가 점수표_${evaluationRoomInfo?.evaluationAt}`;

        document.body.appendChild(link);
        link.click();
        link.remove();

        window.URL.revokeObjectURL(fileObjectUrl);
      },
      onError() {
        resetLoadingModal();
      },
    }
  );

  const onScoreListDown = () => {
    getEvaluationCommitterScoreList.refetch();
  };

  return (
    <EvaluationRoomProceedView
      role={userData.role}
      evaluationRoomInfo={evaluationRoomInfo}
      authority={RoleUtils.getClientRole(userData.role)}
      onNotice={onNotice}
      onTime={onTime}
      evaluationRoomStatus={evaluationRoomStatus}
      attendeeList={attendeeList}
      onExit={onExit}
      setAlertModal={setAlertModal}
      resetAlertModal={resetAlertModal}
      onCloseEvaluationRoom={onCloseEvaluationRoom}
      roomOpenCheck={roomOpenCheck}
      summaryInfo={summaryInfoArray}
      onEvaluationStartReq={onEvaluationStartReq}
      onCompanyEvaluationTable={onCompanyEvaluationTable}
      onMasterEvaluationCommitterScoreView={onMasterEvaluationCommitterScoreView}
      companyEvaluationTable={evaluationTableData}
      evaluationTableTitle={evaluationTableTitle}
      evaluationTableType={evaluationTableType}
      onSaveEvaluationScore={onSaveEvaluationScore}
      step={step}
      setStep={changeStep}
      evaluationCompleteLoading={evaluationCompleteLoading}
      setEvaluationCompleteLoading={setEvaluationCompleteLoading}
      onEvaluationScoreSubmit={onEvaluationScoreSubmit}
      setStepReady={() => setStepReady(true)}
      stepReady={stepReady}
      onMasterEvaluationSubmitCheck={onMasterEvaluationSubmitCheck}
      onEvaluationStateClick={onEvaluationStateClick}
      committerScoreSubmissionStatus={committerScoreSubmissionStatus}
      participantsListInfo={participantsListInfo}
      onWithdrawal={onWithdrawal}
      committerInfo={committerInfo}
      onEvaluationRoomOut={onEvaluationRoomOut}
      onEvaluationFinish={onEvaluationFinish}
      onEvaluationTableView={onEvaluationTableView}
      evaluationTableModalCheck={evaluationTableModalCheck}
      evaluationTableInfo={evaluationTableInfo}
      finalEvaluationTable={finalEvaluationTable}
      evaluationStartCheck={evaluationStartCheck}
      onScoreListDown={onScoreListDown}
      onCommitterKickOutModal={onCommitterKickOutModal}
      evaluationTableDivision={evaluationTableDivision}
      setSummaryInfoAllOpenCheck={setSummaryInfoAllOpenCheck}
    />
  );
}

export default EvaluationRoomProceed;
