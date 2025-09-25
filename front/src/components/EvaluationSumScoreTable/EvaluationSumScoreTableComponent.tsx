import { useEffect, useState } from "react";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import styled from "styled-components";
import { alertModalState } from "../../modules/Client/Modal/Modal";
import theme from "../../theme";
import { ViewObjectWrapperBox } from "../../theme/common";
import SmallButton2 from "../Common/Button/SmallButton2";
import { EvaluationScoreTableBlock } from "../EvaluationScoreTable/EvaluationScoreTableComponent";
import { TableDivisionEnumType } from "../EvaluationTable/EvaluationTableComponentType";

interface EvaluationSumScoreTableComponentTypes {
  evaluationTableData: EvaluationSumScoreTableType[];
  onEvaluationClick: (id: number, companyName: string) => void;
  onMasterEvaluationClick: (committerId: number, companyId: number, companyName: string) => void;
  isAdmin?: boolean;
  onMasterEvaluationSubmitCheck: (committerId: number, status: string) => void;
  setSummaryInfoAllOpenCheck?: (data: boolean) => void;
}

export type EvaluationSumScoreTableType = {
  committer?: Committer;

  companyList: CompanyListType[];
  list: CompanyScoreListType[];
  status?: string;
  type: string;
};

interface Committer {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  name: string;
  phone: string;
  birth: string;
  email: null | string;
}

type CompanyListType = {
  id: number;
  companyName: string;
};

type CompanyScoreListType = {
  eluvationId: number;
  evaluationTitle: string;
  totalScore: number;
  scoreList: Array<{
    companyId: number;
    companyName: string;
    score: number;
    suitable: boolean | null;
  }>;
};

type ScoreSumType = {
  totalScore: number;
  sumScoreList: number[];
  sumSuitableList: any[];
};

function EvaluationSumScoreTableComponent(props: EvaluationSumScoreTableComponentTypes) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);

  const [sumScoreTable, setSumScoreTable] = useState<EvaluationSumScoreTableType[]>([]);
  const [scoreSum, setScoreSum] = useState<ScoreSumType[]>([]);

  const [scoreTableOpenCheck, setScoreTableOpenCheck] = useState<number[]>([]);

  useEffect(() => {
    if (props.evaluationTableData) {
      setSumScoreTable(props.evaluationTableData);

      let submitCheck: boolean = true;

      let array: ScoreSumType[] = [];

      // 평가위원 평가표 배열
      props.evaluationTableData.forEach((data) => {
        let companySumListData: Array<number> = [];

        if (data.status !== "FINAL_SUBMIT") submitCheck = false;

        let totalScoreSum: number = 0;

        // 대분류 리스트 배열
        data.list.forEach((d, i) => {
          totalScoreSum += d.totalScore;

          // 해당 대분류의 각 제안업체별 점수 배열
          d.scoreList.forEach((inD, index) => {
            // 배열의 첫번째일 경우 해당 데이터를 배열에 push
            if (i === 0) companySumListData.push(Number(inD.score) ?? Number(0));
            // 첫번째 이후 부터는 해당 위치에 있는 데이터와 합침
            if (i > 0) companySumListData[index] += Number(inD.score);
          });
        });

        companySumListData.forEach((inData, index) => {
          if (inData > 0) {
            const id = data.companyList[index].id;
            onScoreTableOpen(Number(id));
          }
        });

        // 해당 평가위원 평가표의 배점 합산 및 각 제안업체별 점수 합산
        let totalDataForm = {
          totalScore: totalScoreSum,
          sumScoreList: companySumListData,
          sumSuitableList: onSuitableCheck(data),
        };
        array.push(totalDataForm);
      });

      setScoreSum(array);

      // 담당자일 경우 평가 상태값이 전부 FINAL_SUBMIT 일 경우 해당 모달 출력
      if (submitCheck && array.length > 0 && props.isAdmin) {
        setAlertModal({
          isModal: true,
          content:
            "모든 평가위원이 점수표를 제출완료 하였습니다.\n평가상태 메뉴의 [최종평가점수표 확인 및 평가종료]\n버튼을 클릭하시면 최종점수표를 확인 하실 수 있습니다.",
        });
      }
    }
  }, [props.evaluationTableData]);

  const onAdminTableButtonText = (committerId: number, status: string) => {
    let data: string = "";

    if (status === "modify") data = "REQUEST_MODIFY";
    if (status === "final") data = "FINAL_SUBMIT";

    props.onMasterEvaluationSubmitCheck(committerId, data);
    resetAlertModal();
  };

  // 적합 여부
  const onSuitableCheck = (data: EvaluationSumScoreTableType) => {
    let array: any[] = [];

    data.list.map((d, index) => {
      d.scoreList.map((inD, inIndex) => {
        let item = "적합";
        if (inD.suitable === null) item = "-";
        if (inD.suitable === false) item = "부적합";

        if (!array[inIndex]) {
          array.push(item);
        } else {
          if (array[inIndex] === "적합" && item === "-") array[inIndex] = "-";
          if (array[inIndex] === "적합" && item === "부적합") array[inIndex] = "부적합";
        }
      });
    });

    return array;
  };

  const onSuitableConverter = (type: boolean | null) => {
    let text = "적합";
    if (type === null) {
      text = "-";
    }
    if (type !== null && type === false) {
      text = "부적합";
    }
    return text;
  };

  const onScoreTableOpen = (companyId: number) => {
    if (scoreTableOpenCheck.includes(companyId)) return;
    setScoreTableOpenCheck([...scoreTableOpenCheck, companyId]);
  };

  useEffect(() => {
    if (props.setSummaryInfoAllOpenCheck && sumScoreTable[0] && !props.isAdmin) {
      const companyLength = sumScoreTable[0].companyList.length;
      if (companyLength === scoreTableOpenCheck.length) {
        props.setSummaryInfoAllOpenCheck(true);
      }
    }
  }, [scoreTableOpenCheck, sumScoreTable]);

  return (
    <EvaluationSumScoreTableComponentBlock>
      <>
        {sumScoreTable.map((tableData, index) => (
          <section
            className={`${sumScoreTable.length === index + 1 && "lastEvaluation"}`}
            key={index}
          >
            <ViewObjectWrapperBox>
              <div className="headWrap">
                {!tableData.committer && <h1 className="viewTitle">평가표</h1>}
                {tableData.committer && (
                  <h1 className="viewTitle">평가위원 : {tableData.committer.name}</h1>
                )}
              </div>
              <div className="mainContent">
                <EvaluationSumScoreTableBlock>
                  <thead>
                    <tr>
                      <th colSpan={2}>평가부분</th>
                      {tableData.companyList.map((company, companyIndex) => (
                        <th key={companyIndex}>{company.companyName}</th>
                      ))}
                    </tr>
                    <tr>
                      <th colSpan={tableData.type === TableDivisionEnumType.DIVISION_SCORE ? 1 : 2}>
                        평가부분별
                      </th>
                      {tableData.type === TableDivisionEnumType.DIVISION_SCORE && <th>배점</th>}
                      {tableData.companyList.map((company, companyIndex) => (
                        <th key={companyIndex}>
                          {!props.isAdmin && (
                            <SmallButton2
                              onClick={() => {
                                onScoreTableOpen(Number(company.id));
                                props.onEvaluationClick(company.id, company.companyName);
                              }}
                              text={"평가"}
                            />
                          )}
                          {props.isAdmin && (
                            <SmallButton2
                              onClick={() =>
                                props.onMasterEvaluationClick(
                                  Number(tableData.committer!.id),
                                  company.id,
                                  company.companyName
                                )
                              }
                              text={"상세보기"}
                            />
                          )}
                        </th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    {tableData.list.map((data, tableDataIndex) => (
                      <tr key={tableDataIndex}>
                        <td
                          colSpan={tableData.type === TableDivisionEnumType.DIVISION_SCORE ? 1 : 2}
                        >
                          {data.evaluationTitle}
                        </td>

                        {tableData.type === TableDivisionEnumType.DIVISION_SUITABLE && (
                          <>
                            {data.scoreList.map((d, scoreListIndex) => (
                              <td key={scoreListIndex}>{onSuitableConverter(d.suitable)}</td>
                            ))}
                          </>
                        )}
                        {tableData.type === TableDivisionEnumType.DIVISION_SCORE && (
                          <>
                            <td>{data.totalScore}</td>
                            {data.scoreList.map((d, scoreListIndex) => (
                              <td key={scoreListIndex}>
                                {Math.round(Number(d.score) * 10000) / 10000}
                              </td>
                            ))}
                          </>
                        )}
                      </tr>
                    ))}
                    <tr>
                      {tableData.type === TableDivisionEnumType.DIVISION_SUITABLE && (
                        <>
                          <td className="bold" colSpan={2}>
                            최종평가 결과
                          </td>
                          {scoreSum[index].sumSuitableList.map((isSuitable, suitableIndex) => (
                            <td className="bold" key={suitableIndex}>
                              {isSuitable}
                            </td>
                          ))}
                        </>
                      )}
                      {tableData.type === TableDivisionEnumType.DIVISION_SCORE && (
                        <>
                          <td>합계</td>
                          <td className="bold">
                            {Math.round(Number(scoreSum[index].totalScore) * 10000) / 10000}
                          </td>
                          {scoreSum[index].sumScoreList.map((score, scoreIndex) => (
                            <td className="bold" key={scoreIndex}>
                              {Math.round(Number(score) * 10000) / 10000}
                            </td>
                          ))}
                        </>
                      )}
                    </tr>
                  </tbody>
                </EvaluationSumScoreTableBlock>
                {props.isAdmin && (
                  <div className="buttons admin red">
                    <>
                      {tableData.status !== "NOT_SUBMIT" && (
                        <>
                          {tableData.status === "FIRST_SUBMIT" && (
                            <div>
                              <SmallButton2
                                text="수정요청"
                                onClick={() => {
                                  setAlertModal({
                                    isModal: true,
                                    content:
                                      "해당 평가위원의 평가점수표를 수정요청 하시겠습니까?\n(확인버튼을 누르시면 수정이 불가하오니 신중히 확인 후 진행 부탁드립니다.)",
                                    onClick() {
                                      onAdminTableButtonText(
                                        Number(tableData.committer?.id),
                                        "modify"
                                      );
                                    },
                                  });
                                }}
                              />
                              <SmallButton2
                                text="확인완료"
                                onClick={() => {
                                  setAlertModal({
                                    isModal: true,
                                    content:
                                      "해당 평가위원의 평가점수표를 확인완료 하시겠습니까?\n(확인버튼을 누르시면 수정이 불가하오니 신중히 확인 후 진행 부탁드립니다.)",
                                    onClick() {
                                      onAdminTableButtonText(
                                        Number(tableData.committer?.id),
                                        "final"
                                      );
                                    },
                                  });
                                }}
                              />
                            </div>
                          )}
                          {tableData.status === "REQUEST_MODIFY" && (
                            <p className={`red`}>
                              수정요청을 보냈습니다. 평가위원이 수정 중입니다.
                            </p>
                          )}
                          {tableData.status === "FINAL_SUBMIT" && (
                            <p className={`blue`}>확인 완료 되었습니다.</p>
                          )}
                        </>
                      )}
                      {tableData.status === "NOT_SUBMIT" && (
                        <p>아직 점수표를 제출하지 않았습니다.</p>
                      )}
                    </>
                  </div>
                )}
              </div>
            </ViewObjectWrapperBox>
          </section>
        ))}
      </>
    </EvaluationSumScoreTableComponentBlock>
  );
}

export default EvaluationSumScoreTableComponent;

const EvaluationSumScoreTableComponentBlock = styled.div`
  section {
    width: 100%;
    height: 100%;
    /* background-color: pink; */
    .viewTitle {
      font-size: 16px;
      margin-top: 40px;
    }
    .mainContent {
      margin-top: 20px;
    }
    & > div {
      border-radius: 0;
      width: 100%;
      height: 100%;
      min-height: 0;
      display: flex;
      flex-direction: column;
      box-shadow: none;
      border: 0 !important;
    }
    &.lastEvaluation {
      padding-bottom: 100px;
    }
  }
  .bold {
    font-weight: 900 !important;
    font-size: 14px;
    color: #2a374b;
  }
`;

const EvaluationSumScoreTableBlock = styled(EvaluationScoreTableBlock)`
  th {
    position: static;
    border: 1px solid ${theme.colors.blueGray1};
    &:nth-child(2) {
      width: auto;
    }
    &:last-child {
      width: auto;
    }
  }
`;
