import EvaluationRoomFinishedView from "../../../view/System/EvaluationRoomFinished/EvaluationRoomFinishedView";
import Layout from "../../Common/Layout/Layout";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import { useRecoilState, useResetRecoilState, useSetRecoilState } from "recoil";
import { alertModalState, loadingModalState } from "../../../modules/Client/Modal/Modal";
import {
  getEvaluationCommitterScoreListDown,
  getEvaluationInCheckTableApi,
  getEvaluationRoomFinishScoreApi,
  getEvaluationRoomFinishSimpleDataApi,
} from "../../../api/EvaluationRoomApi";
import { useLocation, useNavigate, useParams } from "react-router";
import { EvaluationRoomFinishSimpleReqInterface } from "../../../interface/System/EvaluationRoomProceed/EvaluationRoomProceedTypes";
import { useEffect, useState } from "react";
import {
  TableArrayItemModifyTypeReq,
  TableArrayItemType,
} from "../../../interface/System/EvaluationTable/EvaluationTableTypes";

export default function EvaluationRoomFinished() {
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const setLoadingModal = useSetRecoilState(loadingModalState);
  const loadingMoal = useRecoilState(loadingModalState);

  const params = useParams();
  const location = useLocation();
  const navigate = useNavigate();

  const [evaluationSimpleData, setEvaluationSimpleData] =
    useState<EvaluationRoomFinishSimpleReqInterface | null>(null);

  const [fileData, setFileData] = useState<any | null>(null);
  const [scoreFileData, setScoreFileData] = useState<any | null>(null);

  // 해당 평가방에 지정된 평가표 정보
  const [evaluationTableInfo, setEvaluationTableInfo] = useState<TableArrayItemType[] | null>(null);

  useEffect(() => {
    setTimeout(() => {
      setLoadingModal({ isButton: false, isModal: true, type: "default" });
    }, 10);
  }, [location.pathname]);

  const { refetch: evaluationRoomFinishedSimpleDataRefetch } = useData<
    EvaluationRoomFinishSimpleReqInterface,
    null
  >(
    ["evaluationRoomFinishedSimpleData", null],
    () => getEvaluationRoomFinishSimpleDataApi(Number(params.id)),
    {
      enabled: params.id ? true : false,
      onSuccess(item) {
        setEvaluationSimpleData(item.data);
        finishedSimpleTableScoreRefetch();
        finishedCommitterScoreRefetch();
      },
      onError() {
        resetLoadingModal();
      },
    }
  );

  // 최종점수표 다운로드
  const { refetch: finishedSimpleTableScoreRefetch } = useData<any, null>(
    ["finishedSimpleTableScore", null],
    () => getEvaluationRoomFinishScoreApi(Number(params.id)),
    {
      enabled: false,
      onSuccess(item) {
        if (!item) return;

        const file = new Blob([item as any], {
          type: "application/pdf",
        });

        const fileURL = URL.createObjectURL(file);

        setTimeout(() => {
          resetLoadingModal();
          setFileData(fileURL);
        }, 500);
      },
      onError() {},
    }
  );

  // 평가서 정보 다운로드
  const { refetch: finishedCommitterScoreRefetch } = useData<any, null>(
    ["finishedCommitterScore", null],
    () => getEvaluationCommitterScoreListDown(Number(params.id)),
    {
      enabled: false,
      onSuccess(item) {
        if (!item) return;

        const file = new Blob([item as any], {
          type: "application/pdf",
        });

        const fileURL = URL.createObjectURL(file);

        setTimeout(() => {
          resetLoadingModal();
          setScoreFileData(fileURL);
        }, 500);
      },
    }
  );

  // 평가표 정보 가져오기
  const { data: evaluationTableInfoData, refetch: evaluationTableInfoDataRefetch } = useData<
    TableArrayItemModifyTypeReq,
    null
  >(
    ["evaluationTableInfoFinishData", null],
    () => getEvaluationInCheckTableApi(Number(evaluationSimpleData?.usedEvaluationTable.id)),
    {
      enabled: evaluationSimpleData?.usedEvaluationTable ? true : false,
      onSuccess: (item) => {
        setEvaluationTableInfo(item.data.list ?? []);
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

  const goBack = () => {
    navigate(-1);
  };

  return (
    <Layout>
      <EvaluationRoomFinishedView
        evaluationSimpleData={evaluationSimpleData}
        evaluationTableInfo={evaluationTableInfo}
        fileData={fileData}
        scoreFileData={scoreFileData}
        goBack={goBack}
      />
    </Layout>
  );
}
