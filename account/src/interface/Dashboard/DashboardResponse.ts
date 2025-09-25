export interface IDashboardPartnersType {
  personal: number;
  company: number;
}

export interface IDashboardAccountsType {
  request: number;
  success: number;
}

export interface IAccountListRes {
  items: IAccountListResItem[];
  meta: IMeta;
}

export interface IAccountListResItem {
  role: string;
  title: string;
  date: string;
  id: string;
}

export interface IMeta {
  totalItems: number;
  itemCount: number;
  itemsPerPage: number;
  totalPages: number;
  currentPage: number;
}
