import { ViewObjectWrapperBox } from "../../../../theme/common";
import styled from "styled-components";
import { useNavigate } from "react-router";
import SearchList from "../../../../components/Common/SearchList/SearchList";
import ListComponent from "../../../../components/List/ListComponent/ListComponent";
import { applicationColumns, userColumns } from "./ListColumnName";
import theme from "../../../../theme";
import {
  IAgreementListResItem,
  IPersonalListResItem,
  meta,
} from "../../../../interface/List/ListResponse";
import { IAgreementListData } from "../../../../interface/List/ListData";
import { useState } from "react";

interface AgreementListViewTypes {
  isAccountant: boolean;
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

function AgreementListView(props: AgreementListViewTypes) {
  const navigate = useNavigate();

  const [isSearched, setIsSearched] = useState(false);

  const goPosition = (id: string) => {
    if (props.type === "agreement") {
      navigate(`/west/partners/agreement/detail`, { state: { id, role: "userAgreement" } });
    } else {
      navigate(`/west/partners/agreement/detail`, { state: { id, role: "agreement" } });
    }
  };

  const goInfo = (id: string) => {
    if (props.type === "user") {
      navigate(`/west/partners/agreement/detail`, { state: { id, role: "userAgreement" } });
    } else {
      navigate(`/west/partners/agreement/detail`, { state: { id, role: "agreement" } });
    }
  };
  // console.log(props.data);    

  return (
    <AgreementListViewBlock>
      <ViewObjectWrapperBox>
        <h1 className="viewTitle">계좌이체거래약정서 신청현황</h1>
        <div className="searchBox">
          <div className="tagSelect">
            {/* <span
              onClick={() => {
                props.changeTab("agreement");
                props.onReflesh();
              }}
              className={props.type === "agreement" ? "isActive" : ""}
            >
              신청 내역
            </span>
            <span
              onClick={() => {
                props.changeTab("user");
                props.onReflesh();
              }}
              className={props.type === "user" ? "isActive" : ""}
            >
              발급완료 이용자
            </span> */}
          </div>
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
                props.type === "agreement" &&
                "계좌이체거래약정서 발급내역이 없습니다.") ||
              (props?.data?.length === 0 &&
                !isSearched &&
                "계좌이체거래약정서 신청내역이 없습니다.") ||
              ""
            }
            columns={props.isAccountant ? userColumns : applicationColumns}
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

export default AgreementListView;

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
