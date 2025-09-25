import { ViewObjectWrapperBox } from "../../../../theme/common";
import styled from "styled-components";
import { useNavigate } from "react-router";
import SearchList from "../../../../components/Common/SearchList/SearchList";
import ListComponent from "../../../../components/List/ListComponent/ListComponent";
import { issuanceColumns } from "./ListColumnName";
import theme from "../../../../theme";
import {
  IAgreementListResItem,
  IPersonalListResItem,
  meta,
} from "../../../../interface/List/ListResponse";
import { IAgreementListData } from "../../../../interface/List/ListData";
import { useState } from "react";
import { GridCellParams } from "@mui/x-data-grid";
import { useSetRecoilState } from "recoil";
import { alertModalState } from "../../../../modules/Client/Modal/Modal";

interface AgreementListViewTypes {
  data?: IAgreementListResItem[] | IPersonalListResItem[];
  meta?: meta;
  role: string;
  authority: string;
  pageState: IAgreementListData;
  onPageMove: (page: number) => void;
  onSearchContent: (search: string) => void;
  onRefetch: () => void;
  onReflesh: () => void;
  changeTab: (type: string) => void;
  type: string;
  emptyMessage?: string;
  search?: string;
}

function IssuanceCompletedListView(props: AgreementListViewTypes) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const navigate = useNavigate();

  const [isSearched, setIsSearched] = useState(false);

  const goPosition = (id: string) => {
    if (props.type === "agreement") {
      navigate(`/west/partners/agreement/detail`, { state: { id, role: "userAgreement" } });
    } else {
      navigate(`/west/partners/agreement/detail`, { state: { id, role: "agreement" } });
    }
  };

  const goInfo = (id: string, e?: GridCellParams) => {
    if (props.type === "user") {
      if (e?.row.isChecked === false) {
        navigate(`/west/partners/issuance/view/${e.row.accountUDID}`, {
          state: { id, role: "userAgreement", isPin: e?.row.isPin },
        });
      } else {
        // navigate(`/west/partners/agreement/detail`, { state: { id, role: "userAgreement" } });
        setAlertModal({
          isModal: true,
          content: (
            <div
              style={{
                height: "100px",
                display: "flex",
                flexDirection: "column",
                justifyContent: "center",
                alignItems: "center",
              }}
            >
              <p style={{ marginBottom: "10px" }}>
                * 출납/회계 담당자가 발급완료를 확인하여 첨부파일 및 고객의 개인정보가
                폐기되었습니다.
              </p>
              <p>
                * 발급완료된 계좌이체 거래약정서는 전사적관리시스템(SAP)에서 확인할 수 있습니다.
              </p>
            </div>
          ),
        });
      }
    } else {
      navigate(`/west/partners/agreement/detail`, { state: { id, role: "agreement" } });
    }
  };

  return (
    <AgreementListViewBlock>
      <ViewObjectWrapperBox>
        <h1 className="viewTitle">계좌이체거래약정서 발급완료</h1>
        <div className="searchBox">
          <div className="tagSelect">{/* 영역잡는 위치 - 기존에 선택박스 있었음 */}</div>
          <SearchList
            onSearch={() => {
              setIsSearched(true);
              props.onRefetch();
            }}
            onReflesh={() => {
              setIsSearched(false);
              props.onReflesh();
            }}
            searchValue={props.pageState.search}
            onSearchContent={props.onSearchContent}
            search={props.search}
          />
        </div>
        <div className="listWrapper">
          <ListComponent
            emptyMessage={
              (props?.data?.length === 0 && isSearched && "검색 결과가 없습니다.") ||
              (props?.data?.length === 0 &&
                !isSearched &&
                "계좌이체거래약정서 신청내역이 없습니다.") ||
              ""
            }
            columns={issuanceColumns}
            rows={props.data || []}
            page={props.pageState.page}
            meta={props.meta}
            goPosition={goPosition}
            goInfo={goInfo}
            onPageMove={props.onPageMove}
            cellClick={true}
            isAgreement
          />
        </div>
      </ViewObjectWrapperBox>
    </AgreementListViewBlock>
  );
}

export default IssuanceCompletedListView;

const AgreementListViewBlock = styled.div`
  .searchBox {
    width: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    .tagSelect {
      width: auto;
      height: 100%;
      display: flex;
      justify-content: space-between;
      align-items: flex-end;
      & > span {
        cursor: pointer;
        color: ${theme.colors.gray4};
        font-size: ${theme.fontType.body.fontSize};
        font-weight: ${theme.fontType.body.bold};
      }
      & > span:first-child {
        margin-right: ${theme.commonMargin.gap3};
      }
      & > .isActive {
        color: ${theme.partnersColors.primary};
      }
    }
  }
`;
