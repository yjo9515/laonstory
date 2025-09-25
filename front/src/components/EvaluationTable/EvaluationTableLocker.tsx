import { ChangeEvent, useState } from "react";
import styled from "styled-components";
import { EvaluationTableListApi, getEvaluationTableApi } from "../../api/EvaluationTableApi";
import { PageStateType } from "../../interface/Common/PageStateType";
import {
  EvaluationTableList,
  TableArrayItemModifyTypeReq,
} from "../../interface/System/EvaluationTable/EvaluationTableTypes";
import { useData } from "../../modules/Server/QueryHook";
import theme from "../../theme";
import DateUtils from "../../utils/DateUtils";
import BigButton from "../Common/Button/BigButton";
import SearchList from "../Common/SearchList/SearchList";
import Overlay from "../Modal/Overlay";
import PaginationComponent from "../Pagination/Pagination";

type EvaluationTableLockerProps = {
  onClose: () => void;
  onOpen: () => void;
  getTableId: (id: number) => void;
  getTableData: (data: TableArrayItemModifyTypeReq) => void;
  setLockerStatus: (data: "useLocker" | "noLocker" | "useLockerTemplete") => void;
};

export default function EvaluationTableLocker(props: EvaluationTableLockerProps) {
  const [id, setId] = useState(0);
  const [tableId, setTableId] = useState(0);
  const [search, setSearch] = useState("");
  const [startDate, setStartDate] = useState("");    
  const [endDate, setEndDate] = useState("");    
  const [type, setSelectedOption] = useState("all");
  const [state, setState] = useState<PageStateType>({
    page: 0,
    search: "",
    startDate:"",
      endDate:"",
      type:""
  });

  const onCheck = (e: ChangeEvent<HTMLInputElement>) => {
    setId(Number(e.target.value));
  };

  const onPageMove = (page: number) => {
    setState({ ...state, page: page - 1 });
  };

  const onReflesh = () => {
    setState({ page: 0, search: "",startDate:"",endDate:"" , type:""});
  };

  // 검색 요청 정보 세팅하기
  const onSearchChange = (search: string) => {
    setSearch(search);
  };

  const onRefetch = () => {
    setState({ page: 0, search, startDate, endDate, type });
  };

  /** 평가항목표 리스트 가져오기 */
  const EvaluationTableList = useData<EvaluationTableList, PageStateType>(
    ["EvaluationTableListApi", state],
    EvaluationTableListApi
  );

  /** 평가항목표 상세 */
  const getEvaluationTable = useData<TableArrayItemModifyTypeReq, number>(
    ["getEvaluationTableApi", tableId as number],
    getEvaluationTableApi,
    {
      enabled: !!tableId,
      onSuccess(data) {
        data.data.data = data.data.list;
        delete data.data.list;
        props.getTableData(data.data);

        props.onClose();
      },
    }
  );

  /**편집 버튼 이벤트 */
  const editTable = () => {
    if (!id) return;
    props.getTableId(id);
    props.onClose(); //라커창 닫고
    props.onOpen(); // 새로 만들기 창
    props.setLockerStatus("useLockerTemplete");
  };

  /** 사용 버튼 이벤트 */
  const onSelect = () => {
    setTableId(id);
    props.getTableId(id);
    props.setLockerStatus("useLocker");
  };

  return (
    <Overlay>
      <EvaluationTableLockerContainer>
        <h1>보관함</h1>
        <p>기존 평가항목표를 편집하거나 사용할 수 있습니다.</p>
        <SearchList
          onReflesh={onReflesh}
          onSearch={onRefetch}
          searchValue={search}
          onSearchContent={onSearchChange}
          placeholder="검색하실 평가항목표의 이름을 입력하세요."
        />
        <div className="searchTable">
          <div>
            <table className="table">
              <thead>
                <tr>
                  <th className="name">평가항목표 이름</th>
                  <th className="date">등록일시</th>
                  <th>선택</th>
                </tr>
              </thead>
              <tbody>
                {EvaluationTableList?.data &&
                  EvaluationTableList?.data?.data?.items?.map((el, index) => (
                    <tr key={index}>
                      <td className="name">{el?.title}</td>
                      <td className="date">{DateUtils.listDateFormat(el?.createdAt)}</td>
                      <td>
                        <input
                          type="checkbox"
                          checked={id === Number(el?.id)}
                          value={el?.id}
                          onChange={onCheck}
                        />
                      </td>
                    </tr>
                  ))}
              </tbody>
            </table>
          </div>
        </div>
        <PaginationComponent
          listAction={onPageMove}
          itemsCountPerPage={EvaluationTableList?.data?.data?.meta?.totalPages as number}
          activePage={state.page + 1}
        />
        <div className="buttonContainer">
          <BigButton text="취소" white onClick={() => props.onClose()} />
          <BigButton
            text="탬플릿 가져오기"
            onClick={() => {
              editTable();
            }}
          />
          <BigButton text="사용" onClick={() => onSelect()} />
        </div>
      </EvaluationTableLockerContainer>
    </Overlay>
  );
}

const EvaluationTableLockerContainer = styled.div`
  width: 832px;
  padding: 40px;
  padding-top: 56px;
  background-color: ${theme.colors.white};
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-direction: column;
  border-radius: 5px;
  & > h1 {
    font-size: ${theme.fontType.title2.fontSize};
    font-weight: ${theme.fontType.title2.bold};
    color: ${theme.colors.body2};
  }
  & > p {
    margin-top: 16px;
    margin-bottom: 56px;
    font-size: ${theme.fontType.content1.fontSize};
    font-weight: ${theme.fontType.content1.bold};
    color: ${theme.colors.body};
  }
  & > form {
    width: 100%;
  }
  & > .buttonContainer {
    margin-top: 72px;
    display: flex;
    gap: 32px;
  }
  & > .searchTable {
    width: 100%;
    height: 291px;
    padding: 16px;
    margin-top: 24px;
    margin-bottom: 8px;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
    border: 1px solid ${theme.systemColors.blueDeep};
    border-radius: 5px;
    & > div:nth-child(1) {
      width: 100%;
      flex: 1;
    }
  }
  table {
    width: 100%;
    height: 100%;
    padding: 24px;
    font-size: ${theme.fontType.subTitle1.fontSize};
    font-weight: ${theme.fontType.subTitle1.bold};
    & > thead {
      & > tr {
        width: 100%;
        padding: 0px 8px;
        padding-bottom: 9px;
        border-bottom: 1px solid ${theme.colors.blueGray2};
        display: flex;
        & > th {
          padding-left: 8px;
          border-left: 1px solid ${theme.colors.blueGray1};
          text-align: start;
          color: ${theme.colors.body2};
        }
      }
    }
    & > tbody {
      height: 100%;
      display: block;
      overflow: scroll;
      -ms-overflow-style: none; /* IE and Edge */
      scrollbar-width: none; /* Firefox */
      &::-webkit-scrollbar {
        display: none !important;
      }
      & > tr {
        display: flex;
        padding-left: 16px;
        margin-top: 14px;
        & > td {
          height: 24px;
          color: ${theme.colors.body};
          display: flex;
          align-items: center;
        }
      }
    }
    .name {
      width: 388px;
    }
    .date {
      width: 268px;
      color: ${theme.systemColors.bodyLighter};
    }
  }
`;
