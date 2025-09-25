import SearchList from "../../Common/SearchList/SearchList";
import ListComponent from "../ListComponent/ListComponent";
import { useLocation, useNavigate } from "react-router";
import { useState } from "react";
import styled from "styled-components";
import { useRecoilValue, useSetRecoilState } from "recoil";
import { userState } from "../../../modules/Client/Auth/Auth";
import RoleUtils from "../../../utils/RoleUtils";
import { alertModalState } from "../../../modules/Client/Modal/Modal";
import { GridCellParams } from "@mui/x-data-grid";
import { columns } from "./ListColumnName";
import { useData } from "../../../modules/Server/QueryHook";
import { IAdminListRes } from "../../../interface/List/ListResponse";
import { IEvaluationListData } from "../../../interface/List/ListData";
import {
  evaluationCommitterListApi,
  evaluationCompanyListApi,
} from "../../../api/EvaluationRoomApi";
import theme from "../../../theme";
import ManualDownloadButton from "../../Common/Button/ManualDownloadButton";

export default function LandingList() {
  const userData = useRecoilValue(userState);
  const authority = RoleUtils.getClientRole(userData.role);
  const [isSearched, setIsSearched] = useState(false);
  const [search, setSearch] = useState("");
  const [startDate, setStartDate] = useState("");    
  const [endDate, setEndDate] = useState("");    
  const navigate = useNavigate();
  const [pageState, setPageState] = useState({
    page: 0,
    search: "",
    startDate:"",
      endDate:""
  });

  // 평가위원 평가방
  const { data: committer } = useData<IAdminListRes, IEvaluationListData>(
    ["committerEvaluation", { ...pageState }],
    () => evaluationCommitterListApi(pageState),
    {
      enabled: authority === "committer" ? true : false,
    }
  );
  // 제안업체 평가방
  const { data: company } = useData<IAdminListRes, IEvaluationListData>(
    ["adminEvaluation", { ...pageState }],
    () => evaluationCompanyListApi(pageState),
    {
      enabled: authority === "company" ? true : false,
    }
  );
  const data = authority === "committer" ? committer : company;

  const goPosition = async (id: number, e?: GridCellParams) => {
    // if (e?.row.status === "평가 전") {
    //   setAlertModal({
    //     isModal: true,
    //     content: "아직 평가가 시작되지 않았습니다.",
    //   });
    // } else {
    await window.localStorage.removeItem("step");
    navigate('/waiting');
    window.open(`/user/system/evaluation-room/proceed/${id}`, "_black");
    // }
  };
  const goInfo = (id: string) => {};
  const onPageMove = (page: number) => {
    setPageState((prev) => ({ ...prev, page }));
  };
  /** 검색 조건 세팅하기 */
  const onSearchContent = (search: string) => {
    setSearch(search);
  };
  /** 리스트 검색결과 요청하기 */
  const onRefetch = () => {
    setIsSearched(true);
    setPageState({ page: 0, search,  startDate, endDate});
  };
  /** 리스트 초기화 */
  const onReflesh = () => {
    setIsSearched(false);
    setSearch("");
    setPageState({ page: 0, search: "",startDate:"",endDate:"" });
  };

  return (
    <LandingListBlock>
      <div className={`board`}>
        <div className="boardHeader">
          <div className="manualBtn">
            <h1>평가방</h1>
            <ManualDownloadButton />
          </div>
          <SearchList
            onSearch={onRefetch}
            onReflesh={onReflesh}
            searchValue={search}
            onSearchContent={onSearchContent}
          />
        </div>
        <div className="boardContent">
          <ListComponent
            columns={columns}
            goInfo={goInfo}
            goPosition={goPosition}
            onPageMove={onPageMove}
            page={pageState.page}
            rows={data?.data.items || []}
            meta={data?.data.meta}
            pageType={"evaluation"}
            role={authority}
          />
        </div>
      </div>
    </LandingListBlock>
  );
}

const LandingListBlock = styled.div`
  width: 100%;
  .board {
    & > .boardHeader {
      margin-top: 56px;
      margin-bottom: 40px;
      display: flex;
      align-items: center;
      justify-content: space-between;

      & > .manualBtn {
        display: flex;
        align-items: flex-end;

        & > h1 {
          width: 100px;
          font-weight: ${theme.fontType.title2.bold};
          font-size: ${theme.fontType.title2.fontSize};
          line-height: 29px;
          color: #333333;
        }
        & > button {
          margin-top: 5px;
        }
      }
    }
    & > .boardContent {
      width: 100%;
      height: 652px;
      background-color: #fff;
      margin-bottom: 64px;
    }
  }
`;
