import { useNavigate } from "react-router";
import { ViewObjectWrapperBox } from "../../../../theme/common";
import SearchList from "../../../../components/Common/SearchList/SearchList";
import ListComponent from "../../../../components/List/ListComponent/ListComponent";
import { columns } from "./ListColumnName";
import { IAlertModalDefault, IContentModalDefault } from "../../../../modules/Client/Modal/Modal";
import { IPersonalListResItem, meta } from "../../../../interface/List/ListResponse";
import { GridCellParams } from "@mui/x-data-grid";
import { useState } from "react";

interface UserListViewTypes {
  data: IPersonalListResItem[];
  meta?: meta;
  role: string;
  authority: string;
  pageState: { page: number; search: string };
  onPageMove: (page: number) => void;
  onSearchContent: (search: string) => void;
  onRefetch: () => void;
  onReflesh: () => void;
  setContentModal: (data: IContentModalDefault) => void;
  setAlertModal: (data: IAlertModalDefault) => void;
  resetModal: () => void;
  search: string;
}

function UserListView(props: UserListViewTypes) {
  const navigate = useNavigate();
  const [isSearched, setIsSearched] = useState(false);

  const goPosition = (id: number) => {};

  const goInfo = (id: number, e?: GridCellParams) => {
    navigate(`/west/partners/user/${id}`, { state: { role: e?.row?.role, id } });
  };

  return (
    <>
      <ViewObjectWrapperBox>
        <h1 className="viewTitle">이용자 목록</h1>
        <div className="searchBox">
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
              (!isSearched && props.data.length === 0 && "등록된 회원이 없습니다.") ||
              (isSearched && "검색 결과가 없습니다.") ||
              ""
            }
            columns={columns}
            rows={props.data}
            page={props.pageState.page}
            meta={props.meta}
            goPosition={goPosition}
            goInfo={goInfo}
            onPageMove={props.onPageMove}
            pageType="partners"
            cellClick
          />
        </div>
      </ViewObjectWrapperBox>
    </>
  );
}

export default UserListView;
