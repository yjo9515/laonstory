import styled from "styled-components";
import ScrollBoxContainer from "../../../components/Common/Container/ScrollBoxContainer";
import {
  IDashboardEvaluationType,
  IDashboardTodayEvaluationList,
  IDashboardUsersType,
} from "../../../interface/Dashboard/DashboardResponse";
import theme from "../../../theme";
import presentationCheck from "../../../assets/Icon/presentationCheck.svg";
import presentation from "../../../assets/Icon/presentation.svg";
import userPlus from "../../../assets/Icon/userPlus.svg";
import accountApplication from "../../../assets/Icon/accountApplication.svg";
import { useNavigate } from "react-router";

interface DashboardViewTypes {
  evaluationCount?: IDashboardEvaluationType;
  partnersCount?: IDashboardUsersType;
  todayEvaluation?: IDashboardTodayEvaluationList[];
}

export default function DashboardView(props: DashboardViewTypes) {
  const navigate = useNavigate();
  return (
    <DashboardViewContainer>
      {/* <div className="header">
        <h2>한국서부발전 평가시스템에 오신 여러분 환영합니다!</h2> 
        <p> 편리하고 간편하지만 공정하고 안전한 평가시스템을 이용해보세요!</p>
      </div> */}
      <div className="top">
        <div>
          <div>
            <h3>
              <img src={presentation} alt="평가준비 아이콘" />
              평가 준비 중
            </h3>
            <div>
              <div className="number">
                <div>
                  <span>{props.evaluationCount?.myBeforeEvaluation ?? 0}</span>
                  <span>나의평가</span>
                </div>
                <div>
                  <span>/</span>
                  <span>&nbsp;</span>
                </div>
                <div>
                  <span>{props.evaluationCount?.beforeEvaluation ?? 0}</span>
                  <span>전체</span>
                </div>
              </div>
              <div className="button">
                <MoreButton
                  onClick={() => {
                    let location = "";
                    location = "/west/system/evaluation-room";
                    navigate(location);
                  }}
                  type="button"
                >
                  + 더보기
                </MoreButton>
              </div>
            </div>
          </div>
          <div>
            <h3>
              <img src={presentationCheck} alt="평가완료 아이콘" />
              평가 완료
            </h3>
            <div>
              <div className="number">
                <div>
                  <span>{props.evaluationCount?.myFinishEvaluation ?? 0}</span>
                  <span>나의평가</span>
                </div>
                <div>
                  <span>/</span>
                  <span>&nbsp;</span>
                </div>
                <div>
                  <span>{props.evaluationCount?.finishEvaluation ?? 0}</span>
                  <span>전체</span>
                </div>
              </div>
              <div className="button">
                <MoreButton
                  onClick={() => {
                    let location = "";
                    location = "/west/system/evaluation-room";
                    navigate(location);
                  }}
                  type="button"
                >
                  + 더보기
                </MoreButton>
              </div>
            </div>
          </div>
          <div>
            <h3>
              <img src={userPlus} alt="평가위원 아이콘" />
              나의 평가위원 추가 현황
            </h3>
            <div>
              <div className="number single">
                <div>
                  <span>{props.partnersCount?.committer ?? 0}</span>
                  <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
                </div>
              </div>
              <div className="button">
                <MoreButton
                  onClick={() => {
                    let location = "";
                    location = "/west/system/committer";
                    navigate(location);
                  }}
                  type="button"
                >
                  + 더보기
                </MoreButton>
              </div>
            </div>
          </div>
          <div>
            <h3>
              <img src={userPlus} alt="제안업체 아이콘" />
              전체 제안업체 가입 현황
            </h3>
            <div>
              <div className="number single">
                <div>
                  <span>{props.partnersCount?.company ?? 0}</span>
                  <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
                </div>
              </div>
              <div className="button">
                <MoreButton
                  onClick={() => {
                    let location = "";
                    location = "/west/system/company";
                    navigate(location);
                  }}
                  type="button"
                >
                  + 더보기
                </MoreButton>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div className="bottom">
        <div>
          <>
            <div>
              <h3>
                <img src={accountApplication} alt="평가준비 아이콘" />
                금일 제안서 평가 진행 리스트
              </h3>
              <ScrollBoxContainer hideScroll>
                {props.todayEvaluation &&
                  props.todayEvaluation.map((el, i) => (
                    <div className="contentBox" key={i}>
                      <p>
                        <span>
                          {el.evaluationAt} {el.startAt}
                        </span>{" "}
                        {el.proposedProject}
                      </p>
                      {el.isMine && (
                        <MoreButton
                          onClick={() => {
                            let location = "";
                            location = "/west/system/evaluation-room";
                            navigate(location);
                          }}
                          type="button"
                        >
                          + 더보기
                        </MoreButton>
                      )}
                    </div>
                  ))}
              </ScrollBoxContainer>
            </div>
          </>
        </div>
      </div>
    </DashboardViewContainer>
  );
}

const DashboardViewContainer = styled.div`
  width: 100%;
  height: 100%;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  > div {
    width: 100%;
  }
  & h3 {
    width: 100%;
    display: flex;
    align-items: center;
    gap: 16px;
    /* font-size: ${theme.fontType.title2.fontSize}; */
    font-size: 18px;
    font-weight: ${theme.fontType.title2.bold};
    > img {
      display: block;
      width: 24px;
      height: 24px;
    }
  }
  .top {
    & > div {
      width: 100%;
      display: flex;
      gap: 24px;
      & > div {
        padding: 24px;
        width: 25%;
        height: 270px;
        display: flex;
        flex-direction: column;
        align-items: center;
        border-radius: 22px;
        background-color: #fff;
        box-shadow: 0px 1px 47px 8px rgba(53, 88, 122, 0.1);
        & > div {
          display: flex;
          flex-direction: column;
          justify-content: center;
          & > .number {
            min-width: 140px;
            margin-top: 40px;
            margin-bottom: 16px;
            font-size: 60px;
            display: flex;
            align-items: center;
            justify-content: space-between;

            & > div {
              display: flex;
              flex-direction: column;
              justify-content: center;
              text-align: center;
              & > span:last-child {
                font-size: 14px;
                color: ${theme.systemColors.systemFont};
              }
            }
          }
          & > .single {
            justify-content: center;
          }
          & > .button {
            margin: 0 auto;
          }
        }
      }
    }
  }
  .bottom {
    width: 100%;
    flex: 1;
    margin-top: 24px;
    /* overflow-y: auto; */
    & h3 {
      justify-content: flex-start;
    }
    & > div {
      width: 100%;
      height: 450px;
      display: flex;
      justify-content: space-between;
      gap: 30px;
      & > div {
        width: 100%;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        gap: 29px;
        padding: 24px;
        border-radius: 22px;
        background-color: #fff;
        box-shadow: 0px 1px 47px 8px rgba(53, 88, 122, 0.1);
        overflow-y: auto;
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
      height: 42px;
      padding: 8px 24px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      border: 1px solid ${theme.colors.gray5};
      border-radius: 5px;
      cursor: pointer;
      > p {
        font-weight: 400;
        color: #425061;
        font-size: ${theme.fontType.contentTitle1.fontSize};
        font-weight: ${theme.fontType.contentTitle1.bold};
        > span {
          margin-right: 32px;
        }
      }
    }
  }
`;

const MoreButton = styled.button`
  width: 63px;
  height: 27px;
  padding: 4px 8px;
  background: #808fa2;
  border-radius: 67px;
  text-align: center;
  color: white;
  font-weight: 500;
  font-size: 13px;
  /* &:hover {
    background-color: #fff;
    color: #2d9cdb;
    border: 1px solid #2d9cdb;
  } */
`;
