/* eslint-disable react-hooks/exhaustive-deps */
import React, { useEffect, useState } from "react";
import {
  DataGrid,
  GridRowsProp,
  GridColDef,
  GridCellParams,
  GridRowClassNameParams,
} from "@mui/x-data-grid";
import styled from "styled-components";
import NumberUtils from "../../../utils/NumberUtils";
import theme from "../../../theme";
import { meta } from "../../../interface/List/ListResponse";
import DateUtils from "../../../utils/DateUtils";
import masking from "../../../utils/masking";
import { UrlMatching } from "../../../utils/UrlMatching";

const storage = window.localStorage;

interface ListComponentTypes {
  goPosition: (id: string & number) => void;
  goInfo: (id: number & string, e?: GridCellParams) => void;
  columns: any[];
  rows: any[];
  page: number;
  meta?: meta;
  pageType?: string;
  onPageMove: (page: number) => void;
  cellClick?: boolean;
  columnButton?: { headerName: string; rowsName: string };
  isAgreement?: boolean;
  emptyMessage?: string;
  isUserAgreement?: boolean;
  role?: string;
}

function ListComponent({ isAgreement = false, ...props }: ListComponentTypes) {
  const [columnState, setColumnState] = useState<GridColDef[]>([]);
  const [rowState, setRowState] = useState<GridRowsProp>([]);
  const [config, setConfig] = useState<any>(null);

  // class 세팅
  const setCellClass = (params: GridCellParams) => {
    if (params.field === "status" && params.value === "발급완료") return "finish";
    if (params.field === "status" && params.value === "요청중") return "invite";
    if (params.field === "status" && params.value === "반려") return "block";
    if (params.field === "num" && params.value === "주거래계좌") return "invite";
    if (params.field === "isChecked" && params.value === false) return "invite";
    if (params.field === "isChecked" && params.value === true) return "block";
    return "";
  };
  const setRowClass = (params: GridRowClassNameParams) => {
    // if (params?.row?.isPin && props?.isUserAgreement) return "isPin";
    return "";
  };

  function maskAll(input?: string): string {
    // input이 존재하지 않으면 빈 문자열 반환
    if (!input) {
      return "";
    }
  
    // 입력 문자열의 길이만큼 *로 대체
    return "*".repeat(input.length);
  }    


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
    if (!config) return; // config가 로드되지 않았으면 대기
    
    const maskingConfig = config; // fetchConfig로 가져온 최신 설정 사용
      // 리스트 전체 갯수및 현 페이지로 역순으로 보여줄 번호 가져오기
      let listNumber = NumberUtils.numberToList(
        props.meta?.currentPage ? props.meta?.currentPage : 1,
        props.meta?.totalItems ?? 1,
        props.meta?.itemsPerPage ?? 10
      );

      if(props.role == "logList"){
        let array = props.rows.map((i, index) => ({
          ...i,          
          accountBank : maskingConfig["isBank"] == true ? masking.maskingBank(i.accountBank) : i.accountBank,
          accountNumber: maskingConfig["isAccountNumber"] == true ? masking.maskingAccount(i.accountNumber) : i.accountNumber,
          name: maskingConfig["isName"] == true ? masking.maskingName(i.name) : i.name,
          accountName: maskingConfig["isName"] == true ? masking.maskingName(i.accountName) : i.accountName,      
          num: listNumber[index],
          masterName : maskingConfig["isName"] == true ? masking.maskingName(i.masterName) : i.masterName,
          company: i.companyCount > 0 ? `${i.company} 외 ${i.companyCount}개사` : i.company,
          evaluationDate: i.evaluationDate
            ? DateUtils.dateToFormat(i.evaluationDate, "YYYY-MM-DD HH:mm")
            : "",
          createdAt: i.createdAt ? DateUtils.dateToFormat(i.createdAt, "YYYY-MM-DD HH:mm") : "",
          approvalAt: i.approvalAt ? DateUtils.dateToFormat(i.approvalAt, "YYYY-MM-DD HH:mm") : "",
          phone: i.phone ? NumberUtils.phoneFormat(i.phone) : "",
          user: i.user ? parseJSON(i.user).role : "",
          response: i.response ? parseJSON(checkData(i.response)).data : "",           
          action:
  //         UrlMatching[                                 
  //           i.url
  //           .replace(/\?.*$/, "") // 쿼리 제거
  // .replace(
  //   /\/([0-9]+|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})(?=\/|$)/g,
  //   "/:id"
  // ) ?? ""]?.[i.action ?? ""][0] || i.action,
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
          url: 
  //         UrlMatching[                                 
  //           i.url
  //           .replace(/\?.*$/, "") // 쿼리 제거
  // .replace(
  //   /\/([0-9]+|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})(?=\/|$)/g,
  //   "/:id"
  // ) ?? ""]?.[i.action ?? ""][1] ?? i.url,
  UrlMatching[
    (
      i.url
        .replace(/\?.*$/, "") // 쿼리 제거
        .replace(
          /\/([0-9]+|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})(?=\/|$)/g,
          "/:id"
        ) ?? ""
    )
  ]?.[i.action ?? ""]?.[1] ?? i.url
        }));
        setRowState(array);
      }else{
        let array = props.rows.map((i, index) => ({
          ...i,          
          accountBank : maskingConfig["isBank"] == true ? masking.maskingBank(i.accountBank) : i.accountBank,
          accountNumber: maskingConfig["isAccountNumber"] == true ? masking.maskingAccount(i.accountNumber) : i.accountNumber,
          name: maskingConfig["isName"] == true ? masking.maskingName(i.name) : i.name,
          accountName: maskingConfig["isName"] == true ? masking.maskingName(i.accountName) : i.accountName,      
          num: listNumber[index],
          masterName : maskingConfig["isName"] == true ? masking.maskingName(i.masterName) : i.masterName,
          company: i.companyCount > 0 ? `${i.company} 외 ${i.companyCount}개사` : i.company,
          evaluationDate: i.evaluationDate
            ? DateUtils.dateToFormat(i.evaluationDate, "YYYY-MM-DD HH:mm")
            : "",
          createdAt: i.createdAt ? DateUtils.dateToFormat(i.createdAt, "YYYY-MM-DD HH:mm") : "",
          approvalAt: i.approvalAt ? DateUtils.dateToFormat(i.approvalAt, "YYYY-MM-DD HH:mm") : "",
          phone: i.phone 
            ? (maskingConfig["isPhone"] === true 
                ? masking.maskingPhone(NumberUtils.phoneFormat(i.phone)) 
                : NumberUtils.phoneFormat(i.phone))
            : "",
          email: maskingConfig["isEmail"] == true ? masking.maskingEmail(i.email) : i.email ,
        }));
        setRowState(array);
      }      
}, [props.rows, config]); // config 변경 시에도 다시 렌더링

  // columns 세팅
  useEffect(() => {
    let array: GridColDef[] = props.columns.map((i) => ({
      field: i.field,
      headerName: i.headerName,
      cellClassName: i.cellClassName ? i.cellClassName : "",
      [i.width ? "width" : "flex"]: i.width ? i.width : 1,
    }));

    if (array.length > 0) {
      array.forEach((d) => {
        
        if (d.field === "isChecked") {
          d.renderCell = (e: GridCellParams) => {
            return <span>{e?.row?.isChecked ? "폐기완료" : "확인필요"}</span>;
          };
        }
      });
    }

    setColumnState(array);
  }, [props.columns]);

  useEffect(()=>{
    const fetchData = async () => {
      const data = await masking.fetchConfig();
      setConfig(data);
      // localStorage에도 최신 설정 저장
      storage.setItem("masking", JSON.stringify(data));
    }
    fetchData();
  }, []);

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
          rowHeight={51}
          onCellClick={(e) => {
            if (props.cellClick) props.goInfo(e.id as string & number, e);
          }}
          rowsPerPageOptions={[10]}
          hideFooterSelectedRowCount={true}
          sx={{
            fontSize: theme.fontType.body.fontSize,
            fontWeight: theme.fontType.body.bold,
            cursor: "pointer",
            focus: 0,
            "& .MuiDataGrid-row:hover": { backgroundColor: "#EDEFF4" },
          }}
          getCellClassName={setCellClass}
          getRowClassName={setRowClass}
        />
      ) : (
        <div className="notSearch">{props.emptyMessage}</div>
      )}
    </ListComponentBlock>
  );
}

export default ListComponent;

const ListComponentBlock = styled.div`
  height: 100%;
  background-color: #fff;

  .notSearch {
    width: 100%;
    height: 100%;
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
  .invite {
    color: #2f80ed;
  }
  .finish {
    color: #6fcf97;
  }
  .block {
    color: #da0043;
  }
  .isPin {
    background-color: rgba(242, 153, 74, 0.1);
  }
`;

// rows 세팅 예시
// const rows: GridRowsProp = [
//   {
//     id: 1,
//     num: 1,
//     commitDate: "2022-02-03",
//     businessNumber: "B12312312",
//     business: "사업이름",
//     personal: "이용자장님",
//     company: "법인",
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
//   { field: "business", headerName: "사업이름", sortable: false, flex: 1 },
//   { field: "personal", headerName: "이용자장", sortable: false, flex: 1 },
//   { field: "company", headerName: "법인", sortable: false, flex: 1 },
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
