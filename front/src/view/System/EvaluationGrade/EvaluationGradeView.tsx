/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable array-callback-return */
import { useEffect, useState } from "react";
import styled from "styled-components";
import SmallButton1 from "../../../components/Common/Button/SmallButton1";
import { IAlertModalDefault } from "../../../modules/Client/Modal/Modal";
import theme from "../../../theme";
import { ViewObjectWrapperBox } from "../../../theme/common";

interface EvaluationGradeViewTypes {
  evaluationItem: any[];
  gradeStatus: any[];
  setAlertModal: (data: IAlertModalDefault) => void;
  onSelectCompany: (id: number) => void;
}

function EvaluationGradeView(props: EvaluationGradeViewTypes) {
  const [tableArray, setTableArray] = useState<any[]>([]);
  const [totalPointData, setTotalPointData] = useState<any>({});

  useEffect(() => {
    if (props.evaluationItem && props.gradeStatus) {
      // 평가항목별 업체 점수
      let array: any[] = [];

      // 배점 합산 값
      let totalAllotmentPoint = 0;

      // 평가항목 갯수
      let columnLength = props.evaluationItem.length;

      // 평가항목 기준으로 배열 생성
      props.evaluationItem.map((item, index) => {
        totalAllotmentPoint += item.allotmentPoint;
        array.push({
          id: item.id,
          name: item.name,
          allotmentPoint: item.allotmentPoint,
        });
      });

      // 생성된 평가항목에 맞게 업체 데이터 분산 저장
      props.gradeStatus.map((status, idx) => {
        [...Array(columnLength)].map((inItem, i) => {
          array[i][`company${idx + 1}`] = status[`evaluationItem${i + 1}`];
        });
      });

      // 분산 저장한 데이터 세팅
      setTableArray(array);

      // 합계 데이터
      let data: any = {
        name: "합계",
        totalAllotmentPoint,
      };

      // 업체 갯수 기준으로 합계 데이터에 업체별 합산 저장
      [...Array(props.gradeStatus.length)].map((item, idx) => {
        let sum = 0;
        array.map((data, index) => {
          sum += Number(data[`company${idx + 1}`] ?? 0);
        });
        data[`company${idx + 1}`] = sum;
      });

      // 합산된 평가 점수 데이터 세팅
      setTotalPointData(data);
    }
  }, [props.gradeStatus]);

  const onTotalRegistration = () => {
    props.setAlertModal({
      isModal: true,

      content: (
        <span style={{ lineHeight: "25px" }}>
          평가점수를 제출하시겠습니까?
          <br />
          제출하실 경우 더 이상의 수정은 불가합니다.
        </span>
      ),
      onClick: onRegistrationComplete,
    });
  };

  const onRegistrationComplete = () => {
    props.setAlertModal({
      isModal: true,

      content: "평가 점수가 제출되었습니다. 수고하셨습니다.",
      type: "check",
      onClick: () => {
        window.close();
      },
    });
  };

  return (
    <ViewObjectWrapperBox isShadow={true}>
      <EvaluationGradeViewBlock>
        <div className="section">
          <div className="viewTitle">평가표</div>
          <table className="table">
            <thead>
              <tr>
                <th colSpan={2}>평가부분</th>
                {props.gradeStatus.map((item, index) => (
                  <th key={index}>{item.companyName}</th>
                ))}
              </tr>
              <tr>
                <th className="evaluationName">평가부분명</th>
                <th className="allotment">배점</th>
                {props.gradeStatus.map((item, index) => (
                  <th key={index}>
                    <button onClick={() => props.onSelectCompany(item.id)}>평가</button>
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {tableArray.map((item, index) => (
                <tr key={index}>
                  <td>{item.name}</td>
                  <td>{item.allotmentPoint}</td>
                  {[...Array(props.gradeStatus.length)].map((company, i) => (
                    <td key={i}>{item[`company${i + 1}`] ?? 0}</td>
                  ))}
                </tr>
              ))}

              <tr className="total">
                <td>{totalPointData.name}</td>
                <td>{totalPointData.totalAllotmentPoint}</td>
                {[...Array(props.gradeStatus.length)].map((company, i) => (
                  <td key={i}>{totalPointData[`company${i + 1}`]}</td>
                ))}
              </tr>
            </tbody>
          </table>
          <div className="btnBox">
            <SmallButton1 text="점수 제출" onClick={onTotalRegistration} />
          </div>
        </div>
      </EvaluationGradeViewBlock>
    </ViewObjectWrapperBox>
  );
}

export default EvaluationGradeView;

export const EvaluationGradeViewBlock = styled.div`
  /* height: 100%; */
  height: auto;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 0 30px;

  .section {
    max-width: 1400px;
    min-width: 1000px;

    & > .btnBox {
      width: 100%;
      display: flex;
      justify-content: flex-end;
      align-items: center;
    }
  }

  .table {
    width: auto;
    margin-top: ${theme.commonMargin.gap3};
    text-align: center;
    font-size: ${theme.fontType.body.fontSize};
    border-top: 2px solid black;
    margin-bottom: ${theme.commonMargin.gap2};
    & > thead {
      /* font-size: ${theme.fontType.subTitle3.fontSize}; */
      & > tr {
        border-bottom: 1px solid ${theme.colors.gray3};
        & > th {
          color: ${theme.partnersColors.primary};
        }
        & > .evaluationName {
          width: 200px;
        }
        & > .allotment {
          width: 100px;
        }
      }
    }
    & > tbody {
      & > tr {
        border-bottom: 1px solid ${theme.colors.gray4};
        & > td {
          color: ${theme.colors.gray1};
        }
      }
      & > .total {
        background-color: ${theme.colors.gray5};
      }
    }
    th,
    td {
      padding: 10px;
      vertical-align: middle;
    }
    button {
      width: auto;
      height: auto;
      border: 1px solid ${theme.partnersColors.primary};
      padding: 2px 10px;
      box-sizing: border-box;
    }
    button:hover {
      color: ${theme.colors.white};
      background-color: ${theme.partnersColors.primary};
      border: 0;
    }
  }
`;
