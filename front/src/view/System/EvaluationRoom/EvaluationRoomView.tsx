import { ViewObjectWrapperBox } from "../../../theme/common";
import styled from "styled-components";
import SmallButton1 from "../../../components/Common/Button/SmallButton1";
import { useNavigate } from "react-router";
import SearchList from "../../../components/Common/SearchList/SearchList";

import ListComponent from "../../../components/List/ListComponent/ListComponent";

import { columns } from "./ListColumnName";
import { useLocation } from "react-router";
import { meta } from "../../../interface/List/ListResponse";
import { GridCellParams } from "@mui/x-data-grid";
import { useSetRecoilState } from "recoil";
import { alertModalState } from "../../../modules/Client/Modal/Modal";

interface EvaluationRoomViewTypes {
  data: any[];
  meta?: meta;
  role: string;
  pageState: { page: number; search: string };
  onPageMove: (page: number) => void;
  onSearchContent: (search: string) => void;
  onRefetch: () => void;
  onReflesh: () => void;
  search: string;
}

function EvaluationRoomView(props: EvaluationRoomViewTypes) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const navigate = useNavigate();
  const location = useLocation();

  const goPage = (link: string) => {
    navigate(link);
  };

  const goPosition = async (id: number, e?: GridCellParams) => {
    // navigate(`/${props.role}/system/evaluation-room/proceed/${id}`);
    if (e && e?.row.status === "평가 종료")
      return setAlertModal({
        isModal: true,
        content: `종료된 평가방 입니다.\n입장하실 수 없습니다.`,
      });

    await window.localStorage.removeItem("step");    
    navigate('/waiting');
    window.open(`${location.pathname}/proceed/${id}`, "_black");
  };

  const goEvaluationRoomInfo = (id: number, e: GridCellParams) => {
    if (e.row.status === "평가 취소") {
      return;
    }
    if (e.row.status === "평가 종료" && props.role === "admin") {
      navigate(`/west/system/evaluation-room/finished/${id}`);
      return;
    }

    if (props.role === String(process.env.REACT_APP_ROLE_ADMIN))
      navigate(`/west/system/evaluation-room/${id}`);
  };

  return (
    <EvaluationRoomViewBlock>
      <ViewObjectWrapperBox>
        <h1 className="viewTitle">평가방 목록</h1>
        <div className="searchBox">
          {props.role === String(process.env.REACT_APP_ROLE_ADMIN) && (
            <div className="btnWrap">
              <SmallButton1
                text={`평가방 개설 +`}
                onClick={() => goPage("/west/system/evaluation-room/add")}
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
            goPosition={goPosition}
            goInfo={goEvaluationRoomInfo}
            onPageMove={props.onPageMove}
            pageType={"evaluation"}
            cellClick={true}
            role={props.role}
          />
        </div>
        {/* <div className="pageNation">
          {props.role === String(process.env.REACT_APP_ROLE_ADMIN) && (
            <div className="btnWrap">
              <SmallButton1
                text="평가방 개설"
                onClick={() => goPage("/west/system/evaluation-room/add")}
              />
            </div>
          )}
        </div> */}
      </ViewObjectWrapperBox>
    </EvaluationRoomViewBlock>
  );
}

export default EvaluationRoomView;

const EvaluationRoomViewBlock = styled.div``;
