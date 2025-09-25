import { useState } from "react";
import { useLocation } from "react-router";
import { useNavigate, useParams } from "react-router";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import {
  deleteEvaluationTableApi,
  getEvaluationTableApi,
  modifyEvaluationTableApi,
} from "../../../api/EvaluationTableApi";
import {
  TableArrayItemModifyTypeReq,
  TableArrayItemTypeReq,
} from "../../../interface/System/EvaluationTable/EvaluationTableTypes";
import { alertModalState, loadingModalState } from "../../../modules/Client/Modal/Modal";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import EvaluationTableDetailView from "../../../view/System/EvaluationTableDetail/EvaluationTableDetailView";
import Layout from "../../Common/Layout/Layout";

function EvaluationTableDetail() {
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const params = useParams();
  const location = useLocation();
  const navigate = useNavigate();

  const [tableData, setTableData] = useState<TableArrayItemModifyTypeReq | null>(null);

  /** 이전 페이지로 이동 */
  const returnPage = () => {
    let pageState = sessionStorage.getItem("pageState");

    let data: { page: number; search: string } = {
      page: 0,
      search: "",
    };

    if (pageState) {
      let item = JSON.parse(pageState);
      data = {
        page: item.page,
        search: item.search,
      };
    }

    navigate(
      `/west/system/evaluation-table${pageState && `?page=${data.page}&search=${data.search}`}`
    );

    sessionStorage.removeItem("pageState");
  };

  // 평가항목표 상세정보 가져오기
  const { data: evaluationTableInfo } = useData<TableArrayItemModifyTypeReq, null>(
    ["evaluationTableInfo", null],
    () => getEvaluationTableApi(Number(params.id)),
    {
      enabled: params.id ? true : false,
      refetchOnWindowFocus: false,
      onSuccess: (item) => {
        setTableData(item.data);
      },
      onError() {
        setAlertModal({
          isModal: true,
          content: "알 수 없는 오류로 값을 가져올 수 없습니다.",
          onClick() {
            returnPage();
            resetAlertModal();
          },
        });
      },
    }
  );

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
            returnPage();
            resetAlertModal();
          },
        });
        resetLoadingModal();
      },
    }
  );

  // 평가항목표 삭제하기
  const evaluationTableInfoDelete = useSendData<string, number>(deleteEvaluationTableApi, {
    onSuccess: () => {
      setAlertModal({
        type: "check",
        isModal: true,
        content: "해당 평가항목표가 삭제되었습니다.",
        onClick() {
          navigate("/west/system/evaluation-table");
          resetAlertModal();
        },
      });
      resetLoadingModal();
    },
  });

  /** 평가항목표 수정하기
   * @data TableArrayItemTypeReq
   */
  const onModify = (data: TableArrayItemTypeReq) => {
    let item: TableArrayItemModifyTypeReq = {
      id: Number(params.id),
      list: data?.data,
      title: data?.title,
    };

    evaluationTableInfoModify.mutate(item);
  };

  /** 평가항목표 삭제하기 */
  const onDelete = () => {
    evaluationTableInfoDelete.mutate(Number(params.id));
  };

  return (
    <Layout>
      <EvaluationTableDetailView
        modifyCheck={params.id ? true : false}
        evaluationTableInfo={tableData ? tableData : null}
        onModify={onModify}
        onDelete={onDelete}
        returnPage={returnPage}
        tableId={Number(params.id)}
        templete={location.pathname.includes("/templete")}
      />
    </Layout>
  );
}

export default EvaluationTableDetail;
