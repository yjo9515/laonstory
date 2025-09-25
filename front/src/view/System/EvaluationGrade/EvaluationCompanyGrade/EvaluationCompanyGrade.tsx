import React, { useEffect, useState } from "react";
import styled from "styled-components";
import SmallButton1 from "../../../../components/Common/Button/SmallButton1";
import { IAlertModalDefault, IContentModalDefault } from "../../../../modules/Client/Modal/Modal";
import theme from "../../../../theme";
import { ViewObjectWrapperBox } from "../../../../theme/common";
import { EvaluationGradeViewBlock } from "../EvaluationGradeView";
import {
  evaluationItem1,
  evaluationItem2,
  evaluationItem3,
  evaluationItem4,
  evaluationItem5,
  evaluationItem6,
} from "./EvaluationItem";
import EvaluationItem from "./EvaluationItem/EvaluationItem";
import NumberUtils from "./../../../../utils/NumberUtils";

interface EvaluationCompanyGradeTypes {
  companyInfo: any;
  onCompanyEvaluationSubmit: () => void;
  setContentModal: (data: IContentModalDefault) => void;
  setAlertModal: (data: IAlertModalDefault) => void;
  evaluationGradeItems: any;
  onCompanyGradeStatus: (data: any) => void;
  assessmentType: string;
}

type EvaluationItemType = {
  rowSpan: number;
  evaluationName: string;
  totalAllotment: number;
  content: any[];
};

function EvaluationCompanyGrade(props: EvaluationCompanyGradeTypes) {
  /** 배점 총합계 */
  const [totalAllotment, setTotalAllotment] = useState<number>(0);
  const [totalPoint, setTotalPoint] = useState<number>(0);

  const [evaluationItem, setEvaluationItem] = useState<any>({
    id: null,
    companyName: "",
    evaluationItem1: {
      item1: 0,
      item2: 0,
      opinion: "",
    },
    evaluationItem2: {
      item1: 0,
      item2: 0,
      item3: 0,
      item4: 0,
      item5: 0,
      opinion: "",
    },
    evaluationItem3: {
      item1: 0,
      item2: 0,
      opinion: "",
    },
    evaluationItem4: {
      item1: 0,
      item2: 0,
      opinion: "",
    },
    evaluationItem5: {
      item1: 0,
      item2: 0,
      opinion: "",
    },
    evaluationItem6: {
      item1: 0,
      opinion: "",
    },
    totalOpinion: "",
  });

  useEffect(() => {
    const evaluationAllCategory: EvaluationItemType[] = [
      evaluationItem1,
      evaluationItem2,
      evaluationItem3,
      evaluationItem4,
      evaluationItem5,
      evaluationItem6,
    ];

    if (evaluationAllCategory.length > 0) {
      let count = 0;
      evaluationAllCategory.map((item, index) => (count += item.totalAllotment));

      setTotalAllotment(count);
    }
  }, []);

  useEffect(() => {
    if (props.evaluationGradeItems) {
      let item = { ...props.evaluationGradeItems };
      // //   더미용 아이디, 나중에 지워야함
      // item.id = props.companyInfo.id;
      // item.companyName = props.companyInfo.companyName;

      // console.log(item);

      let data = {
        id: item.id,
        companyName: item.companyName,
        evaluationItem1: {
          item1: 0,
          item2: 0,
          opinion: "",
        },
        evaluationItem2: {
          item1: 0,
          item2: 0,
          item3: 0,
          item4: 0,
          item5: 0,
          opinion: "",
        },
        evaluationItem3: {
          item1: 0,
          item2: 0,
          opinion: "",
        },
        evaluationItem4: {
          item1: 0,
          item2: 0,
          opinion: "",
        },
        evaluationItem5: {
          item1: 0,
          item2: 0,
          opinion: "",
        },
        evaluationItem6: {
          item1: 0,
          opinion: "",
        },
        totalOpinion: item.totalOpinion,
      };

      setEvaluationItem(data);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [props.evaluationGradeItems]);

  useEffect(() => {
    let itemPoint1 = evaluationItem.evaluationItem1.item1 + evaluationItem.evaluationItem1.item2;
    let itemPoint2 =
      evaluationItem.evaluationItem2.item1 +
      evaluationItem.evaluationItem2.item2 +
      evaluationItem.evaluationItem2.item3 +
      evaluationItem.evaluationItem2.item4 +
      evaluationItem.evaluationItem2.item5;
    let itemPoint3 = evaluationItem.evaluationItem3.item1 + evaluationItem.evaluationItem3.item2;
    let itemPoint4 = evaluationItem.evaluationItem4.item1 + evaluationItem.evaluationItem4.item2;
    let itemPoint5 = evaluationItem.evaluationItem5.item1 + evaluationItem.evaluationItem5.item2;
    let itemPoint6 = evaluationItem.evaluationItem6.item1;

    let total = itemPoint1 + itemPoint2 + itemPoint3 + itemPoint4 + itemPoint5 + itemPoint6;
    setTotalPoint(Number(total));
  }, [evaluationItem]);

  const onRegistration = () => {
    props.setAlertModal({
      isModal: true,
      content: (
        <span style={{ lineHeight: "25px" }}>
          개별 평가점수를 저장하시겠습니까?
          <br />
          개별 평가점수는 최종 제출 전 까지 수정 가능합니다.
        </span>
      ),
      onClick: () => onCompanyGradeStatus(),
    });
  };

  /** 점수등록(임시저장) */
  const onCompanyGradeStatus = () => {
    props.onCompanyGradeStatus(evaluationItem);
  };

  /** 점수 반영, input select 포함 */
  const onGrandChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>,
    group: string,
    type: string,
    allotment: number
  ) => {
    if (!type) return;

    const { name, value } = e.target;

    let data = { ...evaluationItem };

    if (isNaN(Number(value))) return;

    const num = NumberUtils.numberOnlyToString(value);

    /**
     * QUANTITATIVE 정량평가
     * QUALITATIVE 정성평가
     */
    if (type === "QUALITATIVE") {
      if (allotment < Number(num)) {
        data[group][name] = Number(allotment);
      } else {
        data[group][name] = Number(NumberUtils.firstNotZero(num));
      }
    }

    if (type === "QUANTITATIVE") {
      let item = Math.floor(allotment / Number(num));
      data[group][name] = item;
    }

    setEvaluationItem(data);
  };

  const onGrandOpinion = (e: React.ChangeEvent<HTMLTextAreaElement>, group: string) => {
    let data = { ...evaluationItem };

    data[group].opinion = e.target.value;
    setEvaluationItem(data);
  };

  const onTotalGrandOpiniton = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    setEvaluationItem({ ...evaluationItem, totalOpinion: e.target.value });
  };

  return (
    <ViewObjectWrapperBox>
      <EvaluationCompanyGradeBlock>
        <div className="section">
          <div className="title">
            <div>
              <div>{props.companyInfo.companyName}</div>
              <p>- 개별 평가점수를 등록하는 화면입니다.</p>
              <p>- 개별 평가점수는 최종 제출 전 까지 수정 가능합니다.</p>
            </div>
            <p>
              배점 총합계: <span>{totalAllotment}</span>
            </p>
          </div>
          <TableBlock className="table">
            <thead>
              <tr>
                <th>평가항목</th>
                <th>배점기준</th>
                <th>세부평가항목</th>
                <th>평가내용</th>
                <th>배점한도</th>
                <th>점수</th>
                {props.assessmentType === "QUANTITATIVE" && <th>평가의견</th>}
              </tr>
            </thead>
            <tbody>
              {/* 평가항목 1 */}
              <EvaluationItem
                list={evaluationItem1}
                item={evaluationItem.evaluationItem1}
                onGrandChange={onGrandChange}
                onGrandOpinion={onGrandOpinion}
                groupName="evaluationItem1"
                assessmentType={props.assessmentType}
              />
              {/* 평가항목 2 */}
              <EvaluationItem
                list={evaluationItem2}
                item={evaluationItem.evaluationItem2}
                onGrandChange={onGrandChange}
                onGrandOpinion={onGrandOpinion}
                groupName="evaluationItem2"
                assessmentType={props.assessmentType}
              />
              {/* 평가항목 3 */}
              <EvaluationItem
                list={evaluationItem3}
                item={evaluationItem.evaluationItem3}
                onGrandChange={onGrandChange}
                onGrandOpinion={onGrandOpinion}
                groupName="evaluationItem3"
                assessmentType={props.assessmentType}
              />
              {/* 평가항목 4 */}
              <EvaluationItem
                list={evaluationItem4}
                item={evaluationItem.evaluationItem4}
                onGrandChange={onGrandChange}
                onGrandOpinion={onGrandOpinion}
                groupName="evaluationItem4"
                assessmentType={props.assessmentType}
              />
              {/* 평가항목 5 */}
              <EvaluationItem
                list={evaluationItem5}
                item={evaluationItem.evaluationItem5}
                onGrandChange={onGrandChange}
                onGrandOpinion={onGrandOpinion}
                groupName="evaluationItem5"
                assessmentType={props.assessmentType}
              />
              {/* 평가항목 6 */}
              <EvaluationItem
                list={evaluationItem6}
                item={evaluationItem.evaluationItem6}
                onGrandChange={onGrandChange}
                onGrandOpinion={onGrandOpinion}
                groupName="evaluationItem6"
                assessmentType={props.assessmentType}
              />
              {/* 평가항목 합계점수 */}
              <tr className="totalAllotment">
                <td>합계</td>
                <td>{totalAllotment}</td>
                <td></td>
                <td></td>
                <td>{totalAllotment}</td>
                <td>{totalPoint}</td>
              </tr>
            </tbody>
          </TableBlock>
          <div className="evaluationOpinion">
            <div>평가의견</div>
            <div>
              <textarea
                placeholder="평가의견을 입력해주세요."
                value={evaluationItem.totalOpinion}
                onChange={(e) => onTotalGrandOpiniton(e)}
              ></textarea>
            </div>
          </div>
          <div className="btnBox">
            <SmallButton1 text="점수등록(임시저장)" onClick={onRegistration} />
          </div>
        </div>
      </EvaluationCompanyGradeBlock>
    </ViewObjectWrapperBox>
  );
}

export default EvaluationCompanyGrade;

const EvaluationCompanyGradeBlock = styled(EvaluationGradeViewBlock)`
  .section {
    /* background-color: pink; */
    padding-bottom: 100px;
    & > .title {
      display: flex;
      justify-content: space-between;
      align-items: flex-end;
      & > div {
        & > p {
          margin-top: ${theme.commonMargin.gap4};
          font-size: ${theme.fontType.body.fontSize};
          font-weight: ${theme.fontType.body.bold};
          color: ${theme.colors.gray4};
        }
      }
    }

    /* 테이블 스타일은 아래 별도 */

    & > .evaluationOpinion {
      width: 100%;
      height: 100px;

      display: flex;
      justify-content: flex-start;
      align-items: center;
      border-top: 1px solid black;
      border-bottom: 1px solid ${theme.colors.gray4};

      margin-bottom: ${theme.commonMargin.gap3};
      & > div:nth-child(1) {
        width: 150px;
      }
      & > div:nth-child(2) {
        flex: 1;
        height: 100%;
        padding: 10px;
        & > textarea {
          width: 100%;
          height: 100%;
          resize: none;
          padding: 10px;
          border: 1px solid ${theme.colors.gray4};
          font-size: ${theme.fontType.body.fontSize};
          font-weight: ${theme.fontType.body.bold};
        }
      }
    }
  }
`;

export const TableBlock = styled.table`
  width: 100%;
  margin-bottom: 0 !important;
  .alignLeft {
    text-align: left;
  }
  td {
    max-width: 640px;
    border-collapse: collapse;

    line-height: 20px;
    font-size: ${theme.fontType.bodyLineHeight.fontSize} !important;
    font-weight: ${theme.fontType.bodyLineHeight.bold} !important;
    white-space: pre-wrap;
    & > input,
    select {
      width: 100px;
      height: 30px;
      padding-left: ${theme.commonMargin.gap4};
    }
    & > select {
      padding-left: 0;
    }
    & > textarea {
      width: 150px;
      height: 100px;
      resize: none;
      /* padding: 10px; */
      font-size: ${theme.fontType.body.fontSize};
      font-weight: ${theme.fontType.body.bold};
    }
  }
  .minWidth {
    width: 80px;
  }
  .totalAllotment {
    & > td {
      font-weight: ${theme.fontType.subTitle2.bold} !important;
    }
  }
`;
