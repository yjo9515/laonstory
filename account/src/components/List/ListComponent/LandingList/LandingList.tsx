import { GridCellParams } from "@mui/x-data-grid";
import { useState } from "react";
import { useNavigate } from "react-router";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import styled from "styled-components";
import {
  getCompanyApplicationListApi,
  getPersonalAccountApplicationListApi,
} from "../../../../api/ListApi";
import { IPersonalListData } from "../../../../interface/List/ListData";
import { IPersonalAgreementListRes } from "../../../../interface/List/ListResponse";
import { userState } from "../../../../modules/Client/Auth/Auth";
import { alertModalState, contentModalState } from "../../../../modules/Client/Modal/Modal";
import { useData } from "../../../../modules/Server/QueryHook";
import RoleUtils from "../../../../utils/RoleUtils";
import ManualDownloadButton from "../../../Common/Button/ManualDownloadButton";
import SearchList from "../../../Common/SearchList/SearchList";
import AdminInfoChange from "../../../Modal/Agreement/AdminInfoChange";
import ListComponent from "../ListComponent";
import { columns } from "./ListColumnName";

export default function LandingList({ animationed }: { animationed: boolean }) {
  const navigate = useNavigate();
  const userData = useRecoilValue(userState);
  const role = RoleUtils.getClientRole(userData.role);
  const [isSearched, setIsSearched] = useState(false);
  const setAlertModal = useSetRecoilState(alertModalState);
  const setContentModal = useSetRecoilState(contentModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const [search, setSearch] = useState("");

  // 리스트

  const [pageState, setPageState] = useState<IPersonalListData>({
    page: 0,
    search: "",
  });
  // 개인 계좌이체거래 약정서 리스트 가져오기
  const getPersonalAccountApplicationList = useData<
    IPersonalAgreementListRes,
    { page: number; search: string } | null
  >(
    ["getPersonalAccountApplicationList", { page: pageState.page, search: pageState.search }],
    getPersonalAccountApplicationListApi,
    {
      enabled: role === "personal",
    }
  );
  getPersonalAccountApplicationList?.data?.data?.items?.forEach((el) => {
    el.id = el.uuid;
  });
  const maskedPersonalAccountApplicationList = getPersonalAccountApplicationList.data?.data?.items?.map((item) => ({
    createdAt: item.createdAt,
    accountNumber: maskAll(item.accountNumber),  // 계좌번호 마스킹 처리
    bank: maskAll(item.bank),  // 은행 정보 마스킹 처리
    uuid: item.uuid,
    status: item.status,
    id: item.id
  }));
    
  function maskAll(value: string): string {    
    return "*".repeat(value.length);
  }

  // 법인 계좌이체거래 약정서 리스트 가져오기
  const getCompanyCompanyApplicationList = useData<
    IPersonalAgreementListRes,
    { page: number; search: string } | null
  >(
    ["getCompanyCompanyApplicationList", { page: pageState.page, search: pageState.search }],
    getCompanyApplicationListApi,
    {
      enabled: role === "company",
    }
  );
  getCompanyCompanyApplicationList?.data?.data?.items?.forEach((el) => {
    el.id = el.uuid;
  });

  const goPosition = (id: string) => {
    navigate(`/user/partners/agreement/view`, { state: { id } });
  };
  const goInfo = (id: string, e?: GridCellParams) => {
    if (e?.row?.status === "요청중") {
      setAlertModal({
        isBlock: true,
        isModal: true,
        buttonText: "담당자 변경",
        onClick() {
          resetAlertModal();
          setContentModal({
            isModal: true,
            content: (
              <AdminInfoChange
                uuid={id}
                masterEmpId={e.row.masterEmpId}
                refetch={onRequestRefetch}
                role={role}
              />
            ),
            subText: "부서 및 담당자를 선택해주세요.",
            title: "담당자 정보 변경",
          });
        },
        content: `담당자가 거래이체약정서를 검토중입니다.\n정보 수정 필요 시 고객센터에 연락해주세요.\n\n부서, 담당자 변경이 필요하시면 담당자 변경 버튼을 클릭해주세요.`,
      });
      return;
    }
    navigate(`/user/partners/agreement/view`, { state: { id } });
  };
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
    setPageState({ page: 0, search });
  };
  /** 리스트 초기화 */
  const onReflesh = () => {
    setIsSearched(false);
    setSearch("");
    setPageState({ page: 0, search: "" });
  };

  const onRequestRefetch = () => {
    if (role === "personal") getPersonalAccountApplicationList.refetch();
    if (role === "company") getCompanyCompanyApplicationList.refetch();
  };

  return (
    <LandingListBlock>
      <div className={`board ${animationed ? "show" : ""}`}>
        <div className="boardHeader">
          <div className="manualBtn">
            <h1>계좌이체거래약정서</h1>
            <ManualDownloadButton type="user" />
          </div>
          <SearchList
            onSearch={onRefetch}
            onReflesh={onReflesh}
            searchValue={pageState.search}
            onSearchContent={onSearchContent}
            search={search}
          />
        </div>
        <div className="boardContent">
          <ListComponent
            isUserAgreement
            emptyMessage={
              isSearched ? "검색 결과가 없습니다." : "계좌이체거래약정서 발급내역이 없습니다."
            }
            columns={columns}
            goInfo={goInfo}
            goPosition={goPosition}
            onPageMove={onPageMove}
            page={pageState.page}
            rows={
              getPersonalAccountApplicationList?.data?.data?.items ||
              getCompanyCompanyApplicationList?.data?.data?.items ||
              []
            }
            meta={
              getPersonalAccountApplicationList?.data?.data?.meta ||
              getCompanyCompanyApplicationList?.data?.data.meta
            }
            cellClick
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
        justify-content: flex-start;
        align-items: flex-end;

        & > h1 {
          font-weight: 700;
          font-size: 20px;
          line-height: 29px;
          width: 300px;
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
    &.show {
      animation: showBoard 0.5s;
      animation-fill-mode: forwards;
    }
    @keyframes showBoard {
      from {
        opacity: 0;
        transform: translateY(800px);
      }
      to {
        opacity: 1;
        transform: translateY(0px);
      }
    }
  }
`;
