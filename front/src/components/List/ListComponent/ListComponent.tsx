/* eslint-disable react-hooks/exhaustive-deps */
import { Component, useEffect, useState } from "react";
import {
  DataGrid,
  GridRowsProp,
  GridColDef,
  GridCellParams,
  GridRowClassNameParams,
  GridCell,
  GridRowId,
} from "@mui/x-data-grid";
import styled from "styled-components";
import NumberUtils from "../../../utils/NumberUtils";
import { useNavigate } from "react-router";
import theme from "../../../theme";
import { meta } from "../../../interface/List/ListResponse";
import DateUtils from "../../../utils/DateUtils";
import masking from "../../../utils/masking";
import { UrlMatching } from "../../../utils/UrlMatching";
const storage = window.localStorage;

interface ListComponentTypes {
  goPosition: (id: string & number, e: GridCellParams) => void;
  goInfo: (id: string & number, e: GridCellParams) => void;
  emptyMessage?: string;
  columns: any[];
  rows: any[];
  page: number;
  meta?: meta;
  pageType?: string;
  onPageMove: (page: number) => void;
  cellClick?: boolean;
  columnButton?: { headerName: string; rowsName: string };
  isAgreement?: boolean;
  role?: string;
}

function ListComponent({ isAgreement = false, ...props }: ListComponentTypes) {
  const navigate = useNavigate();
  const [columnState, setColumnState] = useState<GridColDef[]>([]);
  const [rowState, setRowState] = useState<GridRowsProp>([]);
  const [rowDetailState,setDetailRowState] = useState<GridRowsProp>([]);

  const onTableType = (type: string): string => {
    let text = "";

    if (type === "quantitative") text = "정량평가";
    if (type === "suitable") text = "적합/부적합";

    return text;
  };
  // class 세팅
  const setCellClass = (params: GridCellParams) => {
    let text = "";
    if (params.row.status === "평가 취소") text += "evaluationCancel ";
    if (params.field === "num") text += "center ";

    return text;
  };

  const setRowClass = (params: GridRowClassNameParams) => {
    // if (params.row.status === "평가 취소") return "evaluationCancel";
    return "";
  };

  const deepParseJSON = (data: any): any => {
    try {      
      return typeof data === "string" ? deepParseJSON(JSON.parse(data)) : data;
    } catch (error) {
      return data;
    }
  };

  const checkData = (data: any): any => {
    try{
      if(deepParseJSON(data).data.items?.[0].response){
        return JSON.parse(deepParseJSON(data).data.items[0].response);
      }
      return JSON.parse(data);
    } catch (error){
      return data;
    }    
  }
  
  const parseJSON = (data: any) : any => {
    try{
      return JSON.parse(data);
    }catch (error){
      return data;
    }
  } 

  // rows 세팅
  useEffect(() => {
    // masking.fetchConfig().then(()=>{

    const maskingConfig = JSON.parse(storage.getItem("masking") ?? "");
 // 리스트 전체 갯수및 현 페이지로 역순으로 보여줄 번호 가져오기
 let listNumber = NumberUtils.numberToList(
  props.meta?.currentPage ? props.meta?.currentPage : 1,
  props.meta?.totalItems ?? 1,
  props.meta?.itemsPerPage ?? 10
);

if(props.role == "logList"){
  let array = props?.rows?.map((i, index) => ({
    ...i,
  
    phone:maskingConfig["isPhone"] == true ? masking.maskingPhone(i.phone) : i.phone ,
    email: maskingConfig["isEmail"] == true ? masking.maskingEmail(i.email) : i.email ,
    num: listNumber[index],
    masterName: maskingConfig["isName"] == true ? masking.maskingName(i.masterName) : i.masterName,  
    name: maskingConfig["isName"] == true ? masking.maskingName(i.name) : i.name ,  
    companyName: maskingConfig["isCompanyName"] == true ? masking.maskingCompanyName(i.companyName) : i.companyName ,  
    user: i.user ? parseJSON(i.user).role : "",
    response: i.response ? parseJSON(checkData(i.response)).data : "",
    url: 
    // UrlMatching[                                 
    //   i.url
    //   .replace(/\?.*$/, "") // 쿼리 제거
    //             .replace(
    //               /\/([0-9]+|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})(?=\/|$)/g,
    //               "/:id"
    //             ) ?? ""]?.[i.action ?? ""][1] || i.url,
    UrlMatching[
      (
        i.url
          .replace(/\?.*$/, "") // 쿼리 제거
          .replace(
            /\/([0-9]+|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})(?=\/|$)/g,
            "/:id"
          ) ?? ""
      )
    ]?.[i.action ?? ""]?.[1] ?? i.url,

    action:
    // UrlMatching[                                 
    //   i.url
    //             .replace(/\?.*$/, "") // 쿼리 제거
    //             .replace(
    //               /\/([0-9]+|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})(?=\/|$)/g,
    //               "/:id"
    //             ) ?? ""]?.[i.action ?? ""][0] || i.action,
    UrlMatching[
      (
        i.url
          .replace(/\?.*$/, "") // 쿼리 제거
          .replace(
            /\/([0-9]+|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})(?=\/|$)/g,
            "/:id"
          ) ?? ""
      )
    ]?.[i.action ?? ""]?.[0] ?? i.action,
    // url: UrlMatching[                                 
    //   i.url
    //   .replace(/\/\d+/g, "/:id")                
    //   .replace(/\?.*$/,"")
    //   .replace(/\/(personal|consignment|security|agreement|company|committer)/g, "/:type") ?? ""]?.[i.action ?? ""] || i.url,    
    company:
    maskingConfig["isCompanyName"] == true ? 
    masking.maskingCompanyName(i.companyCount > 0
      ? `${
          props.role === "admin"
            ? `${i.company} 외 ${i.companyCount}개사`
            : `${i.companyCount}개사`
        }`
      : i.company) : i.companyCount > 0
      ? `${
          props.role === "admin"
            ? `${i.company} 외 ${i.companyCount}개사`
            : `${i.companyCount}개사`
        }`
      : i.company,
    evaluationDate: i.evaluationDate
      ? DateUtils.dateToFormat(i.evaluationDate, "YYYY-MM-DD HH:mm")
      : "",
    tableType: onTableType(i.tableType),
    createdAt: i.createdAt ? DateUtils.dateToFormat(i.createdAt, "YYYY-MM-DD HH:mm") : "",
    enter: "입장",
  }));
  setRowState(array);
}else{

  let array = props?.rows?.map((i, index) => ({
    ...i,
  
    phone:maskingConfig["isPhone"] == true ? masking.maskingPhone(i.phone) : i.phone ,
    email: maskingConfig["isEmail"] == true ? masking.maskingEmail(i.email) : i.email ,
    num: listNumber[index],
    masterName: maskingConfig["isName"] == true ? masking.maskingName(i.masterName) : i.masterName,  
    name: maskingConfig["isName"] == true ? masking.maskingName(i.name) : i.name ,  
    companyName: maskingConfig["isCompanyName"] == true ? masking.maskingCompanyName(i.companyName) : i.companyName ,      
    company:
    maskingConfig["isCompanyName"] == true ? 
    masking.maskingCompanyName(i.companyCount > 0
      ? `${
          props.role === "admin"
            ? `${i.company} 외 ${i.companyCount}개사`
            : `${i.companyCount}개사`
        }`
      : i.company) : i.companyCount > 0
      ? `${
          props.role === "admin"
            ? `${i.company} 외 ${i.companyCount}개사`
            : `${i.companyCount}개사`
        }`
      : i.company,
    evaluationDate: i.evaluationDate
      ? DateUtils.dateToFormat(i.evaluationDate, "YYYY-MM-DD HH:mm")
      : "",
    tableType: onTableType(i.tableType),
    createdAt: i.createdAt ? DateUtils.dateToFormat(i.createdAt, "YYYY-MM-DD HH:mm") : "",
    enter: "입장",
  }));
  setRowState(array);
}

let array2 = props?.rows?.map((i, index) => ({
  ...i,  
  num: listNumber[index],  
  company:
    i.companyCount > 0
      ? `${
          props.role === "admin"
            ? `${i.company} 외 ${i.companyCount}개사`
            : `${i.companyCount}개사`
        }`
      : i.company,
  evaluationDate: i.evaluationDate
    ? DateUtils.dateToFormat(i.evaluationDate, "YYYY-MM-DD HH:mm")
    : "",
  tableType: onTableType(i.tableType),
  createdAt: i.createdAt ? DateUtils.dateToFormat(i.createdAt, "YYYY-MM-DD HH:mm") : "",
  enter: "입장",
}));

setDetailRowState(array2);
    // });   
  }, [props.rows]);

  // columns 세팅
  useEffect(() => {
    let array: GridColDef[] = props.columns.map((i) => ({
      field: i.field,
      headerName: i.headerName,
      cellClassName: i.cellClassName ? i.cellClassName : "",
      [i.width ? "width" : "flex"]: i.width ? i.width : 1,
    }));

    if (props.pageType && props.pageType === "evaluation") {
      array.push({
        field: "participate",
        headerName: props.columnButton?.headerName ?? "참여",
        renderCell: (e: GridCellParams) => {
          if (e.row.status === "평가 종료" || e.row.status === "평가 취소") {
            return <span className="textCenter"></span>;
          } else {
            return (
              <span
                className="enter"
                onClick={(i: any) => {
                  // 부모 이벤트 반응하는 것 제거
                  i.stopPropagation();
                  props.goPosition(e.id as string & number, e);                  
                }}
              >
                입장하기
              </span>
            );
          }
        },
        width: 100,
      });
    }

    if (props.pageType && props.pageType === "evaluationTableList") {
      array.push({
        field: "choice",
        headerName: "선택",
        renderCell: (e: GridCellParams) => {
          return (
            <ButtonStyleBlock>
              <button
                type="button"
                onClick={(i: any) => {
                  i.stopPropagation();
                  props.goPosition(e.id as string & number, e);
                }}
              >
                수정
              </button>
              <button
                type="button"
                onClick={(i: any) => {
                  i.stopPropagation();
                  let page = `${e.id}/templete`;
                  props.goPosition(page as string & number, e);
                }}
              >
                탬플릿 가져오기
              </button>
            </ButtonStyleBlock>
          );
        },
        width: 200,
      });
    }

    setColumnState(array);

    
  }, [props.columns]);

  return (
    
    <ListComponentBlock>
      {props.rows.length > 0 ? (
        <DataGrid
          pagination
          paginationMode="server" // 서버 기준으로 데이터 설정
          page={props.page} // 현재 불러온 페이지 0부터 시작
          pageSize={props.meta?.itemsPerPage ?? 10} // 랜더링할 페이지 사이즈 size: ;
          rowCount={props.meta?.totalItems ?? 1} // 데이터 전체 갯수 totalCount , totalPage 사용 안할듯
          onPageChange={props.onPageMove}
          rows={rowState}          
          columns={columnState}
          rowHeight={45}          
          onCellClick={(e) => {                        
            const matchedRow = rowDetailState.find((row) => row.id === e.id);            
            const k:GridCellParams<any,any,any> = {
              id: e.id,
              field: e.field,
              row: matchedRow,
              rowNode: e.rowNode,
              colDef: e.colDef,
              cellMode: e.cellMode,
              hasFocus: e.hasFocus,
              tabIndex: e.tabIndex,
              getValue: e.getValue
            };
            if (props.cellClick){
              if(matchedRow){                                      
                props.goInfo(e.id as string & number,k);
              }
            } 
          }}
          rowsPerPageOptions={[10]}
          hideFooterSelectedRowCount={true}
          sx={{
            fontSize: theme.fontType.body.fontSize,
            fontWeight: theme.fontType.body.bold,
            cursor: props.cellClick ? "pointer" : "default",
            focus: 0,
            "& .Mui-selected": { backgroundColor: "transparent !important" },
          }}
          getCellClassName={setCellClass}
          getRowClassName={setRowClass}
        />
      ): (
        <div className="notSearch">{props.emptyMessage ?? "검색된 결과가 없습니다."}</div>
      )}      
    </ListComponentBlock>
  );
}

export default ListComponent;

const ListComponentBlock = styled.div`
  height: 100%;
  background-color: #fff;
  position: relative;
  .notSearch {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: ${theme.fontType.subTitle1.fontSize};
    font-weight: ${theme.fontType.subTitle1.bold};
    color: ${theme.colors.gray2};
  }
  .color {
    color: ${theme.colors.gray4};
  }
  .MuiDataGrid-cell:focus {
    outline: none !important;
  }
  .center {
    justify-content: center !important;
  }
  .textCenter {
    text-align: center !important;
  }
  .enter {
    color: #fff;
    font-weight: 600;
    padding: 2px 4px;
    border-radius: 4px;
    cursor: pointer;
    /* justify-content: center !important; */
    background-color: ${theme.systemColors.systemPrimary};
  }
  .blockEnter {
    color: #8f8f8f;
    /* justify-content: center !important; */
  }
  .none {
    color: red;
  }
  .MuiDataGrid-columnHeader {
    &:first-child {
      .MuiDataGrid-columnHeaderTitleContainer {
        justify-content: center !important;
        margin-left: -10px;
      }
    }
  }
  .MuiDataGrid-overlay {
    display: none;
  }

  .evaluationCancel {
    text-decoration: line-through;
  }
`;

const ButtonStyleBlock = styled.div`
  /* background-color: red; */
  & > button {
    color: #fff;
    background-color: ${theme.systemColors.systemPrimary};
    padding: 3px 10px;
    border-radius: 5px;
    font-weight: 600;
    &:first-child {
      margin-right: 6px;
    }
    &:hover {
      text-decoration: underline;
    }
  }
`;

// rows 세팅 예시
// const rows: GridRowsProp = [
//   {
//     id: 1,
//     num: 1,
//     commitDate: "2022-02-03",
//     businessNumber: "B12312312",
//     business: "사업명",
//     committer: "평가위원장님",
//     company: "제안업체",
//     status: "평가완료",
//   },
// ];

// columns 세팅 예시
// const columns: GridColDef[] = [
//   { field: "num", headerName: "번호", sortable: false, width: 80 },
//   { field: "commitDate", headerName: "평가일시", sortable: false, flex: 1 },
//   {
//     field: "businessNumber",
//     headerName: "사업번호",
//     sortable: false,
//     flex: 1,
//   },
//   { field: "business", headerName: "사업명", sortable: false, flex: 1 },
//   { field: "committer", headerName: "평가위원장", sortable: false, flex: 1 },
//   { field: "company", headerName: "제안업체", sortable: false, flex: 1 },
//   {
//     field: "status",
//     headerName: "평가현황",
//     sortable: false,
//     flex: 1,
//   },
//   {
//     field: "participate",
//     headerName: "참여",
//     sortable: false,
//     resizable: false,
//     renderCell: (e) => {
//       return (
//         <SmallButton1
//           text="입장"
//           onClick={(i: any) => {
//             // 부모 이벤트 반응하는 것 제거
//             i.stopPropagation();
//             props.goPosition(Number(e.id));
//           }}
//         />
//       );
//     },
//     width: 100,
//   },
// ];
