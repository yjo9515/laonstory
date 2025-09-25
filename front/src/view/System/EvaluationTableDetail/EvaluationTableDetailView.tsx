import styled from "styled-components";
import EvaluationTableComponent from "../../../components/EvaluationTable/EvaluationTableComponent";
import {
  TableArrayItemModifyTypeReq,
  TableArrayItemTypeReq,
} from "../../../interface/System/EvaluationTable/EvaluationTableTypes";

interface EvaluationTableDetailViewTypes {
  evaluationTableInfo?: TableArrayItemModifyTypeReq | null;
  onModify: (data: TableArrayItemTypeReq) => void;
  onDelete: () => void;
  modifyCheck?: boolean;
  returnPage: () => void;
  tableId?: number;
  templete?: boolean;
}

function EvaluationTableDetailView(props: EvaluationTableDetailViewTypes) {
  /** 페이지 뒤로가기 */
  const goPage = () => {
    props.returnPage();
  };

  return (
    <EvaluationTableDetailViewBlock>
      <EvaluationTableComponent
        evaluationTableInfo={props.evaluationTableInfo}
        onClose={goPage}
        onModify={props.onModify}
        onDelete={props.onDelete}
        modifyCheck={props.modifyCheck}
        tableId={props.tableId}
        usingAsPage
        editCheck={props.templete}
        lockerStatus={"useLocker"}
      />
    </EvaluationTableDetailViewBlock>
  );
}

export default EvaluationTableDetailView;
const EvaluationTableDetailViewBlock = styled.div``;
