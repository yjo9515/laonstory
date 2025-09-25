import { GridColDef } from "@mui/x-data-grid";

export const columns: GridColDef[] = [
  {
    headerName: "번호",
    field: "num",
    width: 70,
    align: "center",
    cellClassName: "center",
  },
  {
    headerName: "평가일시",
    field: "evaluationDate",
    width: 147,
  },
  {
    headerName: "사업 이름",
    field: "proposedProject",
    width: 512,
  },
  {
    headerName: "평가담당자",
    field: "masterName",
    width: 116,
  },
  {
    headerName: "제안업체(개사)",
    field: "company",
    width: 138,
  },
  {
    headerName: "평가현황",
    field: "status",
    width: 95,
  },
];
