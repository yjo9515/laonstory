import { useState } from "react";
import { useNavigate } from "react-router";
import styled from "styled-components";
import { userAccountListApi } from "../../api/ListApi";
import { IUserAgreementListData } from "../../interface/List/ListData";
import { IPersonalAgreementListRes } from "../../interface/List/ListResponse";
import { useData } from "../../modules/Server/QueryHook";
import theme from "../../theme";
import ListComponent from "../List/ListComponent/ListComponent";
import { userAgreementColumn } from "./userAgreementColumn";
import list from "../../assets/Icon/list.svg";
import { GridCellParams } from "@mui/x-data-grid";

export default function UserAgreementList({ id }: { id?: string }) {
  const navigate = useNavigate();
  // 리스트

  const [pageState, setPageState] = useState({
    page: 0,
  });
  // 계좌이체거래 약정서 리스트 가져오기
  const userAccountList = useData<IPersonalAgreementListRes, IUserAgreementListData | null>(
    ["userAccountList", { page: pageState.page, id: id ? id : "" }],
    userAccountListApi,
    {
      enabled: !!id,
    }
  );

  const goPosition = (id: string, e?: GridCellParams) => {
    navigate(`/west/partners/agreement/view/${id}`, {
      state: { id, role: "userAgreement", isPin: e?.row.isPin },
    });
  };
  const goInfo = (id: string, e?: GridCellParams) => {
    navigate(`/west/partners/agreement/view/${id}`, {
      state: { id, role: "userAgreement", isPin: e?.row.isPin },
    });
  };
  const onPageMove = (page: number) => {
    setPageState({ page });
  };

  return (
    <LandingListBlock>
      <label>
        <img src={list} alt="이미지" /> 계좌이체거래약정서
      </label>
      <div className="board">
        {userAccountList && (
          <ListComponent
            isUserAgreement
            columns={userAgreementColumn}
            goInfo={goInfo}
            goPosition={goPosition}
            onPageMove={onPageMove}
            page={pageState.page}
            rows={userAccountList?.data?.data?.items || []}
            meta={userAccountList?.data?.data?.meta}
            cellClick
          />
        )}
      </div>
    </LandingListBlock>
  );
}

const LandingListBlock = styled.div`
  width: 100%;
  .board {
    height: 570px;
  }
  label {
    width: 176px;
    margin-bottom: 24px;
    font-weight: 700;
    font-size: 16px;
    color: ${theme.colors.body2};
    display: flex;
    align-items: center;
    line-height: 24px;
    gap: 16px;
    white-space: nowrap;
    & > img,
    svg {
      display: block;
      width: 24px;
      height: 24px;
      > path {
        fill: ${theme.colors.body2};
      }
    }
  }
`;
