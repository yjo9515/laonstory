import styled from "styled-components";
import ScrollBoxContainer from "../../../components/Common/Container/ScrollBoxContainer";
import {
  IAccountListRes,
  IDashboardAccountsType,
  IDashboardPartnersType,
} from "../../../interface/Dashboard/DashboardResponse";
import theme from "../../../theme";
import presentation from "../../../assets/Icon/presentation.svg";
import presentationCheck from "../../../assets/Icon/presentationCheck.svg";
import userPlus from "../../../assets/Icon/userPlus.svg";
import accountApplication from "../../../assets/Icon/accountApplication.svg";
import { useNavigate } from "react-router";
import { GlobalResponse } from "../../../interface/Response/GlobalResponse";
import DateUtils from "../../../utils/DateUtils";
import React, { useEffect } from "react";
import { AxiosResponse } from "axios";

interface DashboardViewTypes {
  usersCount?: IDashboardPartnersType;
  accountsCount?: IDashboardAccountsType;
  accountList?: AxiosResponse<GlobalResponse<IAccountListRes>, any>[];
  getNextPage: () => void;
  isAccountant?: boolean;
  empId: string;
}

export default function DashboardView(props: DashboardViewTypes) {
  const navigate = useNavigate();

  useEffect(() => {
    const target = document.querySelector("#scrollBox");
    function scroll(this: HTMLElement, e: Event) {
      if (this.scrollHeight - this.scrollTop <= 394) props.getNextPage();
    }
    target?.addEventListener("scroll", scroll);
    return () => target?.removeEventListener("scroll", scroll);
  }, []);

  return (
    <DashboardViewContainer>
      <div className="top">
        <div>
          <div>
            <h3>
              <img src={presentation} alt="평가준비 아이콘" />
              약정서 발급 요청
            </h3>
            <span className="number">{props.accountsCount?.request ?? 0}</span>
            <MoreButton
              onClick={() => {
                let location = "";
                location = "/west/partners/agreement";
                navigate(location);
              }}
              type="button"
            >
              + 더보기
            </MoreButton>
          </div>
          <div>
            <h3>
              <img src={presentationCheck} alt="평가완료 아이콘" /> 약정서 발급 완료
            </h3>
            <span className="number">{props.accountsCount?.success ?? 0}</span>
            <MoreButton
              onClick={() => {
                let location = "";
                location = "/west/partners/agreement?page=0&search=&type=user";
                navigate(location, { state: { isUser: true } });
              }}
              type="button"
            >
              + 더보기
            </MoreButton>
          </div>
          <div>
            <h3>
              <img src={userPlus} alt="이용자 아이콘" /> 개인 가입 현황
            </h3>
            <span className="number">{props.usersCount?.personal ?? 0}</span>
            {!props.isAccountant && props.empId === '04160266' && (
              <MoreButton
                onClick={() => {
                  let location = "";
                  location = "/west/partners/user";
                  navigate(location);
                }}
                type="button"
              >
                + 더보기
              </MoreButton>
            )}
          </div>
          <div>
            <h3>
              <img src={userPlus} alt="법인 아이콘" /> 사업자/법인 가입 현황
            </h3>
            <span className="number">{props.usersCount?.company ?? 0}</span>
            {!props.isAccountant && props.empId === '04160266' && (
              <MoreButton
                onClick={() => {
                  let location = "";
                  location = "/west/partners/user";
                  navigate(location);
                }}
                type="button"
              >
                + 더보기
              </MoreButton>
            )}
          </div>
        </div>
      </div>
      <div className="bottom">
        <div>
          <div>
            <h3>
              <img src={accountApplication} alt="평가준비 아이콘" />
              계좌이체거래약정서 신청 현황
            </h3>
            <ScrollBoxContainer hideScroll id={"scrollBox"}>
              <>
                {props.accountList?.map((el, i) => (
                  <React.Fragment key={i}>
                    {el?.data?.data?.items?.map((el, i) => (
                      <div
                        className="contentBox"
                        key={i}
                        onClick={() =>
                          navigate(`/west/partners/agreement/detail`, {
                            state: { id: el?.id, role: "agreement" },
                          })
                        }
                      >
                        <span>{`${el.role === "[기업]" ? "[사업자 및 법인]" : "[개인]"} ${
                          el.title
                        }`}</span>
                        <span>{DateUtils.listDateFormat(el.date)}</span>
                      </div>
                    ))}
                  </React.Fragment>
                ))}
              </>
            </ScrollBoxContainer>
          </div>
        </div>
      </div>
    </DashboardViewContainer>
  );
}

const DashboardViewContainer = styled.div`
  width: 100%;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  > div {
    width: 100%;
  }
  h3 {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: flex-start;
    gap: 16px;
    font-size: 20px;
    > img {
      width: 24px;
      height: 24px;
    }
  }
  /* .header {
    padding-top: 56px;
    height: auto;
    h2 {
      color: white;
      font-size: 20px;
      font-weight: 700px;
    }
    > p {
      margin-top: 8px;
      font-size: 13px;
      font-weight: 400;
      color: white;
    }
  } */
  .top {
    /* margin-top: 26px; */
    height: 217px;
    > div {
      width: 100%;
      display: flex;
      justify-content: space-between;
      > div {
        padding: 24px;
        /* width: 265px; */
        width: calc(100% / 4 - 20px);
        /* height: 265px; */
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-start;
        border-radius: 22px;
        background-color: #fff;
        box-shadow: 0px 1px 47px 8px rgba(53, 88, 122, 0.1);
        & > h3 {
          font-weight: 600;
        }
        .number {
          margin-top: 42px;
          margin-bottom: 16px;
          font-size: 60px;
        }
      }
    }
  }
  .bottom {
    width: 100%;
    margin-top: 58px;
    & > div {
      width: 100%;
      height: 500px;
      display: flex;
      justify-content: space-between;
      gap: 30px;
      & > div {
        /* width: 561px; */
        width: 100%;
        /* height: 300px; */
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        gap: 29px;
        padding: 24px;
        border-radius: 22px;
        background-color: #fff;
        box-shadow: 0px 1px 47px 8px rgba(53, 88, 122, 0.1);
        overflow-y: auto;
        & > h3 {
          font-weight: 600;
        }
        & > div {
          display: flex;
          flex-direction: column;
          justify-content: flex-start;
          gap: 8px;
        }
      }
    }
    .contentBox {
      width: 100%;
      height: 38px;
      padding: 12px 24px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      border: 1px solid ${theme.colors.gray5};
      border-radius: 5px;
      cursor: pointer;
      > span {
        font-weight: 400;
        color: #425061;
        &:first-child {
          font-size: 13px;
        }
        &:last-child {
          font-size: 12px;
        }
      }
      &:hover {
        border: 1px solid #438cab;
      }
    }
  }
`;

const MoreButton = styled.button`
  padding: 4px 8px;
  font-size: 12px;
  color: white;
  background-color: #808fa2;
  border-radius: 67px;
  font-size: 13px;
  line-height: 19px;
`;
