import { useNavigate } from "react-router";
import styled from "styled-components";
import SmallButton1 from "../../../components/Common/Button/SmallButton1";
import SearchList from "../../../components/Common/SearchList/SearchList";
import ListComponent from "../../../components/List/ListComponent/ListComponent";
import { meta } from "../../../interface/List/ListResponse";
import { EvaluationTableList } from "../../../interface/System/EvaluationTable/EvaluationTableTypes";
import { ViewObjectWrapperBox } from "../../../theme/common";
import { columns } from "./EvaluationTableListColumn";

interface EvaluationTableViewTypes {
  data: EvaluationTableList["items"];
  meta?: meta;
  role: string;
  pageState: { page: number; search: string };
  onPageMove: (page: number) => void;
  onSearchContent: (search: string) => void;
  onRefetch: () => void;
  onReflesh: () => void;
  search: string;
}

export default function EvaluationTableView(props: EvaluationTableViewTypes) {
  const navigate = useNavigate();

  const goPage = (link: string) => {
    navigate(link);
    sessionStorage.setItem("pageState", JSON.stringify(props.pageState));
  };

  const goPosition = (id: number) => {
    // navigate(`/${props.role}/system/evaluation-room/proceed/${id}`);
  };

  return (
    <ViewObjectWrapperBox>
      <h1 className="viewTitle">평가항목표</h1>
      <div className="searchBox">
        <div className="searchBoxInfo">
          <p>* 수정 - 평가항목표의 내용을 수정합니다.</p>
          <p>* 탬플릿 가져오기 - 평가항목표의 내용을 수정하여 새로운 평가항목표로 저장합니다.</p>
        </div>
        {props.role === String(process.env.REACT_APP_ROLE_ADMIN) && (
          <div className="btnWrap">
            <SmallButton1
              text={`평가항목표 생성 +`}
              onClick={() => goPage("/west/system/evaluation-table/add")}
            />
          </div>
        )}
        <SearchList
          onSearch={props.onRefetch}
          onReflesh={props.onReflesh}
          searchValue={props.search}
          onSearchContent={props.onSearchContent}
        />
      </div>
      <div className="listWrapper">
        <ListComponent
          columns={columns}
          rows={props.data}
          page={props.pageState.page}
          meta={props.meta}
          goPosition={goPage}
          goInfo={goPage}
          onPageMove={props.onPageMove}
          cellClick={false}
          pageType="evaluationTableList"
        />
      </div>
    </ViewObjectWrapperBox>
  );
}
