import React, { useEffect, useState } from "react";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import styled from "styled-components";
import {
  TableArrayItemType,
  TableContentItem,
  TableMutateListType,
} from "../../interface/System/EvaluationTable/EvaluationTableTypes";
import { alertModalState, footerZIndexControl } from "../../modules/Client/Modal/Modal";
import theme from "../../theme";
import { ViewObjectWrapperBox } from "../../theme/common";
import NumberUtils from "../../utils/NumberUtils";
import { Regex } from "../../utils/RegularExpression";
import BigButton from "../Common/Button/BigButton";
import { TableDivisionEnumType } from "./EvaluationTableComponentType";

interface EvaluationScoreTableComponentTypes {
  titleType: string;
  usingAsPage?: boolean;
  onClose: () => void;
  tableArray: TableArrayItemType[] | [];
  tableTitle: string;
  noSave?: boolean;
  companyId?: number;
  companyName?: string;
  onlyView?: boolean;
  tableDivision?: TableDivisionEnumType;
  isAdmin?: boolean;
  onSaveEvaluationScore?: (scoreList: TableMutateListType[]) => void;
}

type EvaluationScoreTableComponentBlockType = {
  usingAsPage?: boolean;
};

type CategoryType = {
  rowSpan: number | null;
  score: number | null;
  title: string | null;
};

type ContentType = {
  content: string;
  score: number | string;
  limit: number;
  suitable: string;
  id: number | null;
};

type TableArrayType = {
  id: number | null;
  largeCategory: {
    title: string | null;
    rowSpan: number | null;
    score: number;
    criteria: string | null;
  };
  middleCategory: CategoryType;
  smallCategory: CategoryType;
  content: string;
  limit: number;
  score: number | string;
  suitable: string | null;
};

type CorrectionCheckListType = {
  allCheck: boolean;
  allInputCheck: boolean;
  comparisonCheck: boolean;
  checkArray: Array<{
    check: boolean;
    inputCheck: boolean;
  }>;
};

function EvaluationScoreTableComponent(props: EvaluationScoreTableComponentTypes) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const setFooterZIndexControl = useSetRecoilState(footerZIndexControl);
  const [totalScore, setTotalScore] = useState<number>(0);
  const [evaluationScoreTable, setEvaluationScoreTable] = useState<TableArrayType[][]>([]);
  const [tableDivision, setTableDivision] = useState<TableDivisionEnumType | null>(null);
  const [isSuitable, setIsSuitable] = useState<boolean | null>(null);
  const [correctionCheck, setCorrectionCheck] = useState<CorrectionCheckListType>({
    allCheck: false,
    allInputCheck: false,
    comparisonCheck: false,
    checkArray: [],
  });

  // 모달이 열릴 때 footer z-index를 0으로 설정 (usingAsPage가 아닌 경우에만)
  useEffect(() => {
    if (!props.usingAsPage) {
      setFooterZIndexControl(true);

      // 컴포넌트가 언마운트될 때 footer z-index를 원래대로 복원
      return () => {
        setFooterZIndexControl(false);
      };
    }
  }, [props.usingAsPage, setFooterZIndexControl]);

  // 해당 페이지 호출시 배열정리 함수 호출
  useEffect(() => {
    onTableRearrangement();
  }, [props.tableArray]);

  useEffect(() => {
    if (props.tableDivision) {
      setTableDivision(props.tableDivision);
    }
  }, [props.tableDivision]);

  // 입력된 배점 합산
  useEffect(() => {
    if (evaluationScoreTable.length > 0) {
      let sum: number = 0;

      let checkArray = correctionCheck.checkArray;

      // 화면 표기용 빈값 여부 체크 - 여기는 한번 변경되면 false로 돌리지 않음
      let allCheck: boolean = false;
      // 저장시 빈값 여부 체크
      let allInputCheck: boolean = true;
      // 적합, 부적합 여부 체크
      let comparisonCheck: boolean = true;

      evaluationScoreTable.map((array, index) => {
        let contentSum: number = 0;
        // 빈값 여부 체크
        let inputCheck = true;
        // 해당 대분류의 마지막 input값 입력 체크
        let lastContentInputCheck = false;

        array.map((d, i) => {
          sum += Number(d.score);

          if (d.suitable === "un_suitable" || !d.suitable) {
            comparisonCheck = false;
          }

          // contentSum += Number(d.score);
          // if (array.length - 1 === i) lastContentInputCheck = true;
          // if (!d.score) {
          //   inputCheck = false;
          // }
        });

        // if (inputCheck && lastContentInputCheck) {
        //   let inComparisonCheck = true;

        //   // 평가최하 점수 기준
        //   let correction = array[0].largeCategory.criteria;
        //   // 전체 배점한도
        //   let contentTotalScore = array[0].largeCategory.score;
        //   // 배점한도에서 평가최하 점수 구하기
        //   let t = Math.floor(Number(correction) * 0.01 * 100) / 100;
        //   // 구해진 평가최하 점수 소수점 올림
        //   let comparison: number = Math.ceil(contentTotalScore * Number(t));
        //   // 평가최하 점수보다 입력값이 낮을 경우
        //   if (comparison > contentSum) inComparisonCheck = false;

        //   let checkItem = {
        //     check: inComparisonCheck,
        //     inputCheck: inputCheck,
        //   };

        //   checkArray[index] = checkItem;
        // }

        // if (!inputCheck) allInputCheck = false;
      });

      // if (!checkArray.find((d) => d.inputCheck === false)) allCheck = true;
      // if (!checkArray.find((d) => d.check === false)) comparisonCheck = true;

      // setCorrectionCheck({
      //   allCheck,
      //   allInputCheck,
      //   comparisonCheck,
      //   checkArray,
      // });
      setIsSuitable(comparisonCheck);
      setTotalScore(Math.round(Number(sum) * 10000) / 10000);
    }
  }, [evaluationScoreTable]);

  /** 평가항목표 데이터를 채점표에 사용할 수 있게 재배열 */
  const onTableRearrangement = () => {
    let tableArray = [...props.tableArray];
    /** 각 대분류에 속하는 평가내용 갯수를 대분류 별로 배열정리 */
    let allArray: number[] = [];

    let data = tableArray.map((d) => onTableGridSum(d));

    allArray = data;

    let array: any[] = [];

    // 각 카테고리 배열에 정리되는 객체 구조
    class CategoryItem {
      rowSpan: number;
      score: number;
      title: string | null;
      constructor(rowSpan: number, sum: number, title: string) {
        this.rowSpan = rowSpan;
        this.score = sum;
        this.title = title;
      }
      data() {
        return {
          rowSpan: this.rowSpan,
          score: this.score,
          title: this.title,
        };
      }
    }

    // 평가내용 배열에 정리되는 객체 구조
    class ContentItem {
      content: string;
      score: number | string;
      limit: number;
      suitable: string;
      id: number | null;
      constructor(
        content: string,
        score: number | string,
        limit: number,
        suitable: string,
        id: number | null
      ) {
        this.content = content;
        this.score = score;
        this.limit = limit;
        this.suitable = suitable;
        this.id = id;
      }
      data() {
        return {
          content: this.content,
          score: this.score,
          limit: this.limit,
          suitable: this.suitable,
          id: this.id,
        };
      }
    }

    /** 대분류안에 속하는 데이터들을 단순 배열로 정리
     * @list TableArrayItemType / 대분류 안에서 반복되는 데이터들
     * @num 대분류 안에 속하는 평가내용 갯수
     */
    const onLowRankTable = (list: TableArrayItemType, num: number) => {
      // 해당 중분류 또는 소분류의 평가내용 배점한도 합산
      let largeScore: number = onSumScore(list);

      // 중분류 카테고리 정리
      let middleCategory: Array<CategoryType | null> = [];
      // 소분류 카테고리 정리
      let smallCategory: Array<CategoryType | null> = [];
      // 평가내용 정리x
      let contentArray: ContentType[] = [];

      // 대분류, 중분류, 소분류, 평가내용 정리된 데이터 배열
      let inArray: any[] = [];

      /** 대, 중, 소 분류 배열 정리 및 평가내용 배열 정리
       * @subList 계산할 카테고리의 배열
       * @requestType 계산되어야할 카테고리 배열 위치
       */
      const onRowSumRepetition = (subList: TableArrayItemType, requestType: string): any => {
        let data: TableArrayItemType = subList; // 카테고리 리스트
        let inSum = 0; // rowSpan 값
        let scoreSum: number = 0; // 해당 분류의 score 합계
        let inTitle: string = data.title; // 해당 분류의 타이틀

        if (data.sub.length > 0) {
          // 하위의 카테고리가 존재할 경우 (sub O)
          data.sub.map((d, i) => {
            inSum += d.content.length;
            if (d.content.length > 0)
              d.content.map((content) => (scoreSum += Number(content.score)));
          });
        } else {
          // 마지막 카테고리일 경우 (sub X)
          inSum += data.content.length;
          data.content.map((content) => {
            scoreSum += Number(content.score);
            // 마지막 카테고리일 경우에 평가내용 배열 정리 진행
            const contentItem = new ContentItem(
              String(content.content ?? ""),
              Number(content.inputScore ?? 0),
              Number(content.score ?? 0),
              content.isSuitable ? "suitable" : "un_suitable",
              content.id ? Number(content.id) : null
            );
            contentArray.push(contentItem.data());
          });
        }

        // console.log(inSum);

        // middleCategory에 정리된 데이터 배열 정리
        if (requestType === "middle") {
          const categoryItem = new CategoryItem(inSum, scoreSum, inTitle);
          if (!inSum) return;
          middleCategory.push(categoryItem.data());
          [...Array(inSum - 1)].map((none) => middleCategory.push(null));
          // 중분류에서 소분류가 없을 경우 평가내용 갯수만큼 소분류 카테고리에 추가
          if (data.sub.length === 0) [...Array(inSum)].map((none) => smallCategory.push(null));
        }
        // smallCategory 정리된 데이터 배열 정리
        if (requestType === "small") {
          const categoryItem = new CategoryItem(inSum, scoreSum, inTitle);
          if (!inSum) return;
          smallCategory.push(categoryItem.data());
          [...Array(inSum - 1)].map((none) => smallCategory.push(null));
        }
      };

      // 카테고리 배열정리 계산 요청
      onRowSumRepetition(list, "large");
      list.sub.map((d) => {
        onRowSumRepetition(d, "middle");
        if (d.sub.length > 0)
          d.sub.map((inD) => {
            onRowSumRepetition(inD, "small");
          });
      });

      // console.log(list);
      // console.log(num);
      // console.log(middleCategory);
      // console.log(smallCategory);
      // console.log(contentArray);
      // console.log(test);

      // 카테고리별로 데이터 정리, 계층형으로 들어오는 데이터를 단순 배열로 변경
      // 정리된 배열은 해당 대분류에 속하는 데이터
      [...Array(num)].map((none, index) => {
        let tableData: TableArrayType = {
          id: contentArray[index].id,
          largeCategory: {
            title: index === 0 ? list.title : null, // 대분류 내용입니다.
            rowSpan: index === 0 ? num : null, // 대분류아래 채점항목 갯수들을 정리합니다. 채점항목 갯수만큼 대분류의 row 영역을 구성합니다.
            score: index === 0 ? largeScore : 0, // 대분류 아래 모든 채점항목의 배점 점수의 합산입니다.
            criteria: index === 0 ? String(list.criteria ?? "") : null, // 최소 점수 입력입니다. 현재는 사용하지 않습니다.
          },
          middleCategory: {
            title: middleCategory[index] && (middleCategory[index]?.title ?? null), // 중분류 내용입니다.
            rowSpan: middleCategory[index] && (middleCategory[index]?.rowSpan ?? null), // 중분류 아래 채점항목 갯수들을 정리합니다. 채점항목 갯수만큼 중분류의 row 영역을 구성합니다.
            score: middleCategory[index] && (middleCategory[index]?.score ?? null), // 중분류 아래 모든 채점항목의 배점점수의 합산입니다.
          },
          smallCategory: {
            title: smallCategory[index] && (smallCategory[index]?.title ?? null), // 소분류 내용입니다.
            rowSpan: smallCategory[index] && (smallCategory[index]?.rowSpan ?? null), // 소분류 아래 채점항목 갯수들을 정리합니다. 채점항목 갯수만큼 소분류의 row 영역을 구성합니다.
            score: smallCategory[index] && (smallCategory[index]?.score ?? null), // 소분류 아래 모든 채점항목의 배점점수의 합산입니다.
          },
          limit: contentArray[index].limit, // 배점 한도 입니다.
          content: contentArray[index].content, // 채점 내용입니다.
          score:
            contentArray[index].score && Number(contentArray[index].score) > 0
              ? contentArray[index].score
              : 0, // 유저가 입력한 점수 입니다.
          suitable: contentArray[index].suitable === "suitable" ? "suitable" : "un_suitable", // 적합, 부적합 구분값입니다.
        };

        inArray.push(tableData);
      });

      array.push(inArray);
    };

    let correctionCheckArray: Array<{ check: boolean; inputCheck: boolean }> = [];

    // 대분류 기준으로 데이터 정리 호출
    allArray.map((num, numIndex) => {
      let dd = tableArray[numIndex];
      onLowRankTable(dd, num);
      // correctionCheckArray.push({
      //   check: true,
      //   inputCheck: false,
      // });
    });

    // setCorrectionCheck((prev) => ({ ...prev, checkArray: correctionCheckArray }));
    setEvaluationScoreTable(array);
  };

  /** 배점 합계
   * @list TableArrayItemType / 계산할 대분류 배열
   */
  const onSumScore = (list: TableArrayItemType) => {
    // 호출 위치에서 score 총 합산
    let sum = 0;

    /** 재귀함수 영역 - 순회하면서 score 합산, sub 리스트가 있을경우  */
    const onSumRepetition = (subList: TableArrayItemType): any => {
      let data: TableArrayItemType[] = subList.sub; // 카테고리 리스트
      let item: TableContentItem[] = subList.content; // 평가기준 영역

      let inSum: number = 0; // 반복 진행중 score 내용 합산

      // 카테고리 리스트가 없을 경우 - 재귀 이탈 후 합산 (카테고리가 있으면 평가기준 리스트가 비어있음)
      if (data.length === 0) {
        // 평가기준 리스트를 돌면서 score 를 inSum과 합산
        item.map((content, i) => (inSum += Number(content.score)));
        return (sum += inSum);
      }

      // 카테고리 리스트가 있을 경우 재귀 -> 리스트기에 반복으로 호출
      return data.map((d, i) => onSumRepetition(d));
    };

    // 재귀함수 호출
    onSumRepetition(list);

    const d = Math.round(Number(sum) * 10000) / 10000;
    return d;
  };

  /** 대분류 기준 평가내용 갯수 계산 정리
   * @list TableArrayItemType / 계산할 대분류 배열
   */
  const onTableGridSum = (list: TableArrayItemType): number => {
    // 호출 위치에서 grid 총 합산
    let sum = 0;

    // 재귀함수 영역
    /** row 합산 */
    const onRowSumRepetition = (subList: TableArrayItemType): any => {
      let data: TableArrayItemType[] = subList.sub; // 카테고리 리스트
      let item: TableContentItem[] = subList.content; // 평가기준 영역

      let inSum: number = 0; // 반복 진행중 row 개수 내용 합산

      // 카테고리 리스트가 없을 경우 - 재귀 이탈 후 합산 (카테고리가 있으면 평가기준 리스트가 비어있음)
      if (data.length === 0) {
        // 평가내용 리스트를 돌면서 해당 부분에 속한 평가내용 개수만큼 + 1
        item.map((content, i) => (inSum += 1));
        return (sum += inSum);
      }

      // 카테고리 리스트가 있을 경우 재귀 -> 리스트기에 반복으로 호출
      return data.map((d, i) => onRowSumRepetition(d));
    };

    // 재귀함수 호출
    onRowSumRepetition(list);

    return sum;
  };

  /** 테이블 colSpan 계산
   * @categoryType string / 호출하는 카테고리 위치
   * @small string | null / smallCategory의 title
   * @middle string | null / middleCategory의 title
   */
  const onCallSpanCheck = (categoryType: string, small: string | null, middle: string | null) => {
    // 기본은 colSpan 대분류 1 중분류 1 소분류 1
    let colSpan = 1;

    if (!small && middle) {
      // 중분류에서 호출되었을때 하위에 소분류가 없을 경우
      if (categoryType === "middle") colSpan = 2;
    }

    // 대분류에서 호출되었을 때 중분류 소분류가 없을 경우
    if (!small && !middle && categoryType === "large") colSpan = 3;

    return colSpan;
  };

  /** 배점 수정하기
   * @e HTMLInputElement / input의 이벤트 데이터
   * @largeIndex number / 대분류 기준 index 번호
   * @contentIndex number / 대분류 안에서 index 번호
   * @limitScore number / 입력되는 부분의 배점한도
   */
  const onChangeScore = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>,
    largeIndex: number,
    contentIndex: number,
    limitScore: number,
    type?: string
  ) => {
    let array = [...evaluationScoreTable];

    let { name, value } = e.target;

    let val: number | string = value;

    let names = name;

    if (e.target.type === "radio") {
      names = name.split("-")[0];
    }

    // value에 값이 없으면 0을 입력
    if (Number(value) === 0 && type && type === "focus") val = "";
    if (!value && type && type === "blur") val = "";

    if (!value && !type) {
      val = "";
    }

    // 숫자가 아니면 리턴
    if (tableDivision === TableDivisionEnumType.DIVISION_SCORE) {
      const pattern = Regex.primeNumberRegex;
      if (value && !pattern.test(value)) return;
    }

    // 입력된 값이 limit보다 크면 limit값으로 고정
    if (Number(value) > limitScore) val = limitScore;

    // 대분류 index의 배열에서 수정될 index값 찾아서 값 변경
    let data = array[largeIndex].map((d, i) =>
      i === Number(contentIndex)
        ? {
            ...d,
            [names]:
              type && (type === "focus" || type === "blur")
                ? Math.round(Number(val) * 10000) / 10000
                : val,
          }
        : d
    );

    array[largeIndex] = data;

    setEvaluationScoreTable(array);
  };

  /** 배점 저장하기 */
  const onScoreSave = () => {
    if (!props.onSaveEvaluationScore) return;

    let array = [...evaluationScoreTable];

    // 저장할 배점 정리
    let mutateList: TableMutateListType[] = [];

    // if (!correctionCheck.allInputCheck)
    //   return setAlertModal({
    //     isModal: true,
    //     content: "배점을 모두 입력해주세요.",
    //   });

    // if (!correctionCheck.comparisonCheck)
    //   return setAlertModal({
    //     isModal: true,
    //     content: "보정평가가 필요한 항목이 있습니다. 수정 후 다시 진행해주세요.",
    //   });

    array.map((category) =>
      category.map((d) =>
        mutateList.push({
          id: d.id,
          inputScore: d.score ? Number(d.score) : 0,
          isSuitable: d.suitable === "suitable" ? true : false,
        })
      )
    );

    // let reqData = {
    //   companyId: props.companyId ?? 1,
    //   scoreList: mutateList,
    // };

    props.onSaveEvaluationScore(mutateList);
    props.onClose();
  };

  const onScoreCheck = () => {
    if (evaluationScoreTable.length > 0) {
      let checkArray = correctionCheck.checkArray;
      // 적합, 부적합 여부 체크
      let comparisonCheck: boolean = false;
      // 배점이 0인 항목이 있는 경우 체크
      let scoreZero: boolean = false;

      evaluationScoreTable.map((array, index) => {
        let contentSum: number = 0;

        // 빈값 여부 체크
        let inputCheck = true;
        // 해당 대분류의 마지막 input값 입력 체크
        let lastContentInputCheck = false;

        array.map((d, i) => {
          if (!d.score && Number(d.score) < 0) scoreZero = true;
          contentSum += Number(d.score);
        });

        let inComparisonCheck = true;

        // 평가최하 점수 기준
        let correction = array[0].largeCategory.criteria;
        // 전체 배점한도
        let contentTotalScore = array[0].largeCategory.score;
        // 배점한도에서 평가최하 점수 구하기
        let t = Math.floor(Number(correction) * 0.01 * 100) / 100;
        // 구해진 평가최하 점수 소수점 올림
        let comparison: number = Math.ceil(contentTotalScore * Number(t));
        // 평가최하 점수보다 입력값이 낮을 경우
        if (comparison > contentSum) inComparisonCheck = false;

        let checkItem = {
          check: inComparisonCheck,
          inputCheck: inputCheck,
        };

        checkArray[index] = checkItem;
      });

      if (!checkArray.find((d) => d.check === false)) comparisonCheck = true;

      setCorrectionCheck({
        allCheck: false,
        allInputCheck: true,
        comparisonCheck,
        checkArray,
      });

      // if (!comparisonCheck) {
      //   setAlertModal({
      //     isModal: true,
      //     content: "배점이 충분하지 않습니다.",
      //   });
      // }

      if (
        comparisonCheck &&
        scoreZero &&
        props.tableDivision === TableDivisionEnumType.DIVISION_SCORE
      ) {
        setAlertModal({
          isModal: true,
          content: "입력하지 않은 점수가 있습니다. 점수를 입력해주세요.",
        });
      }

      if (
        comparisonCheck &&
        !scoreZero &&
        props.tableDivision === TableDivisionEnumType.DIVISION_SCORE
      ) {
        setAlertModal({
          isModal: true,
          content: "입력하신 점수를 제출하시겠습니까?",
          onClick() {
            onScoreSave();
            resetAlertModal();
          },
        });
      }

      if (comparisonCheck && props.tableDivision === TableDivisionEnumType.DIVISION_SUITABLE) {
        setAlertModal({
          isModal: true,
          content: "입력하신 점수를 제출하시겠습니까?",
          onClick() {
            onScoreSave();
            resetAlertModal();
          },
        });
      }
    }
  };

  return (
    <EvaluationScoreTableComponentBlock>
      <section>
        <ViewObjectWrapperBox>
          <div className="headWrap">
            <h1 className="viewTitle">
              평가항목표 {props.titleType}{" "}
              {!props.titleType && props.companyName ? (
                <span className="companyName">( 업체명: {props.companyName} )</span>
              ) : (
                ""
              )}
            </h1>
          </div>
          <div className="tableTitle">
            <p>평가항목표 제목: </p>
            <input value={props.tableTitle} readOnly disabled />
          </div>
          <div className="mainContent">
            <EvaluationScoreTableBlock>
              <thead>
                <tr>
                  <th colSpan={3}>평가구분</th>
                  <th>평가내용</th>
                  {tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                    <>{!props.onlyView && <th>배점한도</th>}</>
                  )}
                  <th
                    className={
                      tableDivision === TableDivisionEnumType.DIVISION_SCORE
                        ? "score"
                        : "scoreRadio"
                    }
                  >
                    {tableDivision === TableDivisionEnumType.DIVISION_SCORE && "배점"}
                    {tableDivision === TableDivisionEnumType.DIVISION_SUITABLE && "적합/부적합"}
                  </th>
                  {/* {props.onlyView &&
                    props.tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                      <th>평가기준</th>
                    )} */}
                  {/* <th className="etc-th">비고</th> */}
                </tr>
              </thead>
              {/* 채점표 영역 */}
              {evaluationScoreTable.map((data, index) => (
                <tbody
                  key={index}
                  className={`${
                    correctionCheck.allCheck &&
                    !correctionCheck.checkArray[index].check &&
                    "warning"
                  }`}
                >
                  {data.map((item, itemIndex) => (
                    <tr key={itemIndex}>
                      {item.largeCategory.title && (
                        <td
                          rowSpan={item.largeCategory.rowSpan ?? 0}
                          colSpan={onCallSpanCheck(
                            "large",
                            item.smallCategory.title,
                            item.middleCategory.title
                          )}
                        >
                          <div>
                            {item.largeCategory.title}
                            {tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                              <span>
                                ({Math.round(Number(item.largeCategory.score) * 10000) / 10000}점)
                              </span>
                            )}
                          </div>
                        </td>
                      )}
                      {item.middleCategory.title && (
                        <td
                          rowSpan={item.middleCategory.rowSpan ?? 0}
                          colSpan={onCallSpanCheck(
                            "middle",
                            item.smallCategory.title,
                            item.middleCategory.title
                          )}
                        >
                          <div>
                            {item.middleCategory.title}
                            {tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                              <span>
                                (
                                {item.middleCategory.score
                                  ? Math.round(Number(item.middleCategory.score) * 10000) / 10000
                                  : 0}
                                점)
                              </span>
                            )}
                          </div>
                        </td>
                      )}
                      {item.smallCategory.title && (
                        <td rowSpan={item.smallCategory.rowSpan ?? 0}>
                          <div>
                            {item.smallCategory.title}
                            {tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                              <span>
                                (
                                {item.smallCategory.score
                                  ? Math.round(Number(item.smallCategory.score) * 10000) / 10000
                                  : 0}
                                점)
                              </span>
                            )}
                          </div>
                        </td>
                      )}
                      <td className="textAlignLeft">{item.content}</td>
                      {tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                        <>
                          {!props.onlyView && (
                            <td>{Math.round(Number(item.limit) * 10000) / 10000}</td>
                          )}
                        </>
                      )}
                      <td className="scoreInput">
                        {tableDivision === TableDivisionEnumType.DIVISION_SUITABLE ? (
                          <>
                            {" "}
                            {/* <select
                              name="suitable"
                              value={item.suitable ?? "un_suitable"}
                              disabled={props.isAdmin}
                              onChange={(e) => onChangeScore(e, index, itemIndex, item.limit)}
                            >
                              <option value="suitable">적합</option>
                              <option value="un_suitable">부적합</option>
                            </select> */}
                            <div className="scoreInputRadio">
                              <label>
                                <input
                                  type={"radio"}
                                  name={`suitable-${index}-${itemIndex}`}
                                  value="suitable"
                                  disabled={props.isAdmin}
                                  onChange={(e) => onChangeScore(e, index, itemIndex, item.limit)}
                                  checked={item.suitable === "suitable"}
                                />
                                적합
                              </label>
                              <label>
                                <input
                                  type={"radio"}
                                  name={`suitable-${index}-${itemIndex}`}
                                  value="un_suitable"
                                  disabled={props.isAdmin}
                                  onChange={(e) => onChangeScore(e, index, itemIndex, item.limit)}
                                  checked={item.suitable === "un_suitable"}
                                />
                                부적합
                              </label>
                            </div>
                          </>
                        ) : (
                          <>
                            {props.onlyView ? (
                              <>{isNaN(Number(item.limit))
                                ? 0
                                : Math.round(Number(item.limit) * 10000) / 10000}</>
                            ) : (
                              <input
                                name="score"
                                disabled={props.isAdmin}
                                value={item.score ?? ""}
                                onChange={(e) => onChangeScore(e, index, itemIndex, item.limit)}
                                onFocus={(e) =>
                                  onChangeScore(e, index, itemIndex, item.limit, "focus")
                                }
                                onBlur={(e) =>
                                  onChangeScore(e, index, itemIndex, item.limit, "blur")
                                }
                              />
                            )}
                          </>
                        )}
                      </td>
                      {/* {props.onlyView &&
                        item.largeCategory.title &&
                        props.tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                          <td rowSpan={item.largeCategory.rowSpan ?? 0}>
                            {item.largeCategory.criteria
                              ? `합계 ${item.largeCategory.criteria}% 이상`
                              : "-"}
                          </td>
                        )} */}
                      {/* {item.largeCategory.title && (
                        <td rowSpan={item.largeCategory.rowSpan ?? 0} className="etc-td">
                          {item.largeCategory.criteria && (
                            <>
                              합계점수 <br />
                              <span style={{ color: "blue", fontSize: "16px" }}>
                                {item.largeCategory.criteria}%
                              </span>
                              <br /> 이상 입력
                            </>
                          )}
                        </td>
                      )} */}
                    </tr>
                  ))}
                </tbody>
              ))}
              {/* 배점합계, 보정평가 여부 영역 */}
              <tbody className="totalScore">
                {tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                  <>
                    <tr>
                      <td colSpan={props.onlyView ? 4 : 5} className="textAlignRight">
                        {!props.onlyView && <>합&nbsp;&nbsp;&nbsp;&nbsp;계</>}
                      </td>
                      <td className={"textAlignRight"} colSpan={props.onlyView ? 2 : 1}>
                        {!props.onlyView && <>{Math.round(Number(totalScore) * 10000) / 10000}</>}
                      </td>
                    </tr>
                  </>
                )}
                {tableDivision === TableDivisionEnumType.DIVISION_SUITABLE && (
                  <>
                    <tr>
                      <td colSpan={props.onlyView ? 3 : 4} className="textAlignRight">
                        {!props.onlyView && <>최종평가 결과</>}
                      </td>
                      <td className={"textAlignRight"} colSpan={props.onlyView ? 2 : 1}>
                        {isSuitable ? "적합" : "부적합"}
                      </td>
                    </tr>
                  </>
                )}
                <tr>
                  <td colSpan={7} className="textAlignRight correction">
                    {!props.onlyView && (
                      <>
                        {/* 보정평가 */}
                        {correctionCheck.allCheck ? (
                          <>
                            {correctionCheck.comparisonCheck ? (
                              <span className={"accept"}>제출 가능합니다.</span>
                            ) : (
                              <span className={"unAccept"}>
                                평가기준에 적합하지 않습니다. 배점을 수정해주세요.
                              </span>
                            )}
                          </>
                        ) : (
                          ""
                        )}
                      </>
                    )}
                  </td>
                </tr>
              </tbody>
            </EvaluationScoreTableBlock>
          </div>
          <div className="buttonContainer">
            <BigButton
              text={!props.noSave ? "취소" : "닫기"}
              onClick={props.onClose}
              white={!props.onlyView}
            />
            {!props.noSave && (
              <BigButton text="저장" onClick={() => onScoreCheck()} />
              // <BigButton
              //   text="저장"
              //   white={!correctionCheck.allInputCheck}
              //   onClick={() => correctionCheck.allInputCheck && onScoreCheck()}
              // />
            )}
            {/* <BigButton text="저장" onClick={() => onScoreCheck()} /> */}
          </div>
        </ViewObjectWrapperBox>
      </section>
    </EvaluationScoreTableComponentBlock>
  );
}

export default EvaluationScoreTableComponent;

const EvaluationScoreTableComponentBlock = styled.div<EvaluationScoreTableComponentBlockType>`
  width: 100%;
  height: 100%;
  position: ${(props) => (props.usingAsPage ? "static" : "fixed")};
  top: 0;
  left: 0;
  background-color: ${(props) => (props.usingAsPage ? "transparent" : "rgba(0, 0, 0, 0.3)")};
  z-index: 100;
  display: ${(props) => (props.usingAsPage ? "block" : "flex")};
  justify-content: center;
  align-items: center;
  & > section {
    display: ${(props) => (props.usingAsPage ? "block" : "flex")};
    justify-content: center;
    align-items: center;
    width: ${(props) => (props.usingAsPage ? "auto" : "1300px")};
    height: auto;
    & > div {
      // ViewObjectWrapperBox 영역
      height: 100%;
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      align-items: center;
      & > .headWrap {
        width: 100%;
        display: flex;
        justify-content: space-between;
        & > button {
          width: 120px;
          height: 36px;
          background-color: ${theme.systemColors.systemPrimary};
          border-radius: 18px;
          color: #fff;
          display: flex;
          justify-content: center;
          align-items: center;
          font-size: 14px;
          & > span {
            margin-right: 6px;
            display: flex;
            justify-content: center;
            align-items: center;
          }
        }
      }
      & > .mainContent {
        width: 100%;
        height: ${(props) => (props.usingAsPage ? "430px" : "600px")};
        margin: 0;
        overflow-y: scroll;
        /* -ms-overflow-style: none; 
        scrollbar-width: none; 
        &::-webkit-scrollbar {
          display: none;
        } */
      }
    }
    .tableTitle {
      width: 100%;
      display: flex;
      align-items: center;
      margin: 16px 0;
      & > p {
        margin-right: 14px;
        font-size: 14px;
      }
      & > input {
        flex: 1;
        height: 30px;
        border: 1px solid ${theme.colors.blueGray2};
        border-radius: 5px;
        padding-left: 16px;
      }
    }
  }
  .companyName {
    font-size: 14px;
  }
`;

export const EvaluationScoreTableBlock = styled.table`
  width: 100%;
  border-collapse: collapse;
  border-spacing: 0;

  th,
  td {
    box-sizing: border-box;
    border: 1px solid ${theme.colors.blueGray2};
    margin: 0;
    padding: 3px 0;
    font-size: 12px;
    height: 42px;
    vertical-align: middle;
  }

  th {
    background-color: ${theme.colors.blueGray2};
    position: -webkit-sticky;
    position: sticky;
    top: 0;
    z-index: 1;
    font-weight: 500;

    &:nth-child(2) {
      width: 600px;
    }
    /* 
    &:last-child {
      width: 180px;
    } */
  }
  .score {
    width: 125px;
  }
  .scoreRadio {
    width: 180px;
  }
  .etc-th {
    width: 140px !important;
  }

  th:after,
  th:before {
    content: "";
    position: absolute;
    left: 0;
    width: 100%;
  }

  th:before {
    top: -1px;
    border-top: 1px solid ${theme.colors.blueGray2};
  }

  th:after {
    bottom: -1px;
    border-bottom: 1px solid ${theme.colors.blueGray2};
  }

  td {
    padding-left: ${theme.commonMargin.gap3};
    padding-right: ${theme.commonMargin.gap3};
    vertical-align: middle;
    text-align: center;

    & > div {
      display: flex;
      flex-direction: column;
      & > span {
        font-size: 10px;
      }
    }

    input {
      border: 0;
      border-bottom: 1px solid ${theme.colors.blueDeep};
      width: 100%;
      padding: 3px;
      background-color: transparent;
      text-align: right;
      padding-right: 10px;
    }
    input:focus {
      outline: none;
      border-bottom: 1px solid ${theme.systemColors.systemPrimary};
    }
  }

  .etc-td {
    font-size: 12px;
  }

  .textAlignLeft {
    text-align: left;
  }
  .textAlignRight {
    text-align: right;
  }

  .totalScore {
    td {
      background-color: ${theme.colors.blueGray2};
      position: sticky;
      position: -webkit-sticky;
      bottom: 0;
      z-index: 1;
    }

    & > tr:nth-child(1) {
      & > td {
        background-color: #fff;
        bottom: 42px;
      }
    }

    td:after,
    td:before {
      content: "";
      position: absolute;
      left: 0;
      width: 100%;
    }

    td:before {
      top: -1px;
      border-top: 1px solid ${theme.colors.blueGray2};
    }

    td:after {
      bottom: -1px;
      border-bottom: 1px solid ${theme.colors.blueGray2};
    }
  }

  .correction {
    & > span {
      margin-left: ${theme.commonMargin.gap4};
    }
    .accept {
      color: #6fcf97;
    }
    .unAccept {
      color: ${theme.colors.red};
    }
  }

  .warning {
    /* border: 1px solid red !important; */

    & > tr {
      & > .scoreInput {
        & > input {
          border-bottom: 1px solid red !important;
        }
      }
    }
  }

  .scoreInputRadio {
    width: 100%;

    display: flex;
    justify-content: space-between;
    flex-direction: row;

    & > label {
      width: calc(100% / 2);
      display: flex;

      & > input {
        width: 20px;
      }
    }
  }
`;
