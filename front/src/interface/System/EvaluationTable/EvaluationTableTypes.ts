import { meta } from "../../List/ListResponse";

export type TableArrayItemTypeReq = {
  id?: number;
  data: TableArrayItemType[];
  title: string;
  type: string;
};

export type TableArrayItemModifyTypeReq = {
  id?: number;
  title: string;
  list?: TableArrayItemType[];
  data?: TableArrayItemType[];
  type?: string;
};

export type TableArrayItemResType = {
  type: string;
  title: string;
  list: TableArrayItemType[];
};

export type TableArrayItemType = {
  id?: number;
  title: string;
  content: TableContentItem[];
  sub: TableArrayItemType[];
  criteria?: string;
};

export type TableContentItem = {
  id?: number;
  content: string;
  score: string;
  isSuitable?: boolean;
  inputScore: number;
};

export interface EvaluationTableList {
  items: {
    createdAt: string;
    id: string;
    title: string;
  }[];
  meta: meta;
}

export type TableMutateListType = {
  inputScore: number | string;
  id: number | null;
  isSuitable: boolean;
};
