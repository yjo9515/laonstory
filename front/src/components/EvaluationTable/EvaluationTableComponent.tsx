import React, { useEffect, useRef, useState } from "react";
import styled from "styled-components";
import theme from "../../theme";
import { ViewObjectWrapperBox } from "../../theme/common";
import BigButton from "../Common/Button/BigButton";
import HighRankFolderIcon from "./../../assets/Icon/EvaluationTableIcon/HighRankFolder.svg";
import LowRankFolderIcon from "./../../assets/Icon/EvaluationTableIcon/lowRankFolder.svg";
import PlusBtnIcon from "./../../assets/Icon/EvaluationTableIcon/plus.svg";
import MinusBtnIcon from "./../../assets/Icon/EvaluationTableIcon/minus.svg";
import SearchWhiteIcon from "./../../assets/Icon/searchWhite.svg";
import { useData, useSendData } from "../../modules/Server/QueryHook";
import { Regex } from "../../utils/RegularExpression";
import { addEvaluationTableApi, getEvaluationTableApi } from "../../api/EvaluationTableApi";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import {
  alertModalState,
  contentModalState,
  loadingModalState,
  footerZIndexControl,
} from "../../modules/Client/Modal/Modal";
import {
  TableArrayItemTypeReq,
  TableArrayItemType,
  TableContentItem,
  TableArrayItemModifyTypeReq,
} from "../../interface/System/EvaluationTable/EvaluationTableTypes";
import CategoryAddModal from "./CategoryAddModal/CategoryAddModal";
import { useLocation, useNavigate, useParams } from "react-router";
import EvaluationScoreTableComponent from "../EvaluationScoreTable/EvaluationScoreTableComponent";
import EvaluationTableDivisionModal from "./EvaluationTableDivisionModal";
import { TableDivisionEnumType } from "./EvaluationTableComponentType";
import { getEvaluationInCheckTableApi } from "../../api/EvaluationRoomApi";

interface EvaluationTableComponentTypes {
  usingAsPage?: boolean;
  modifyCheck?: boolean;
  roomOpenCheck?: boolean;
  evaluationTableInfo?: TableArrayItemModifyTypeReq | null;
  onClose: () => void;
  onModify?: (data: TableArrayItemTypeReq) => void;
  onDelete?: () => void;
  getTableData?: (data: TableArrayItemTypeReq) => void;
  getTableId?: (id: number) => void;
  tableId?: number | null;
  editCheck?: boolean;
  lockerStatus?: "useLocker" | "noLocker" | "useLockerTemplete";
  newCheck?: boolean;
  onOpenEvaluationRoomCheck?: boolean;
}

type AddModalType = {
  idNum: string;
  check: boolean;
};

type ScoreModalType = {
  type: string;
  check: boolean;
};

type EvaluationTableWrapBlockType = {
  usingAsPage?: boolean;
  scoreTableModal: ScoreModalType;
};

function EvaluationTableComponent(props: EvaluationTableComponentTypes) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const setContentModal = useSetRecoilState(contentModalState);
  const resetContentModal = useResetRecoilState(contentModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const setFooterZIndexControl = useSetRecoilState(footerZIndexControl);
  const navigate = useNavigate();
  const location = useLocation();
  const params = useParams();

  const [tableArray, setTableArray] = useState<TableArrayItemType[] | []>([]);
  const [tableTitle, setTableTitle] = useState<string>("");
  const [tableDivision, setTableDivision] = useState<TableDivisionEnumType>(
    TableDivisionEnumType.DIVISION_UNSELECT
  );

  const [newRoomCheck, setNewRoomCheck] = useState<boolean>(true);

  // 카테고리 추가 버튼시 모달
  const [addModal, setAddModal] = useState<AddModalType>({
    idNum: "",
    check: false,
  });

  // 미리보기 모달
  const [scoreTableModal, setScoreTableModal] = useState<ScoreModalType>({
    type: "",
    check: false,
  });

  // 클릭되는 영역 설정
  const modalRef = useRef<HTMLDivElement>(null);

  // 모달이 열릴 때 footer z-index를 0으로 설정 (usingAsPage가 아닌 경우에만)
  useEffect(() => {
    if (!props.usingAsPage) {      
      setFooterZIndexControl(true);

      // 컴포넌트가 언마운트될 때 footer z-index를 원래대로 복원
      return () => {        
        setFooterZIndexControl(false);
      };
    }
  }, [props.usingAsPage, tableDivision, setFooterZIndexControl]);

  useEffect(() => {
    if (!params.id) setNewRoomCheck(false);
    setTimeout(() => {
      if (props.tableId && !props.newCheck) getEvaluationTable.refetch();
    }, 10);
  }, [params.id, props.tableId]);

  /** 저장된 평가표 가져오기 */
  const getEvaluationTable = useData<TableArrayItemModifyTypeReq, number>(
    ["getEvaluationTableApi", props?.tableId as number],
    props.lockerStatus === "noLocker" && newRoomCheck
      ? getEvaluationInCheckTableApi
      : getEvaluationTableApi,
    // props.lockerStatus === "useLocker" || props.lockerStatus === "useLockerTemplete"
    // ? getEvaluationTableApi
    // : getEvaluationInCheckTableApi,
    {
      // enabled: props?.tableId ? true : false,
      enabled: false,
      onSuccess(data) {
        setTimeout(() => {
          setTableArray(data?.data?.list as TableArrayItemType[]);
          setTableDivision(data.data.type as TableDivisionEnumType);
          if (!props.editCheck) {
            setTableTitle(data?.data?.title);
          }
          if (props.editCheck) {
            setTableTitle(data?.data?.title);
          }
        }, 10);
      },
    }
  );
  useEffect(() => {
    return () => {
      setTableArray([]);
      setTableTitle("");
    };
  }, []);

  /** 평가표 작성 api 호출 */
  const addEvaluationTable = useSendData<number, TableArrayItemTypeReq>(addEvaluationTableApi, {
    onSuccess: (item) => {
      if (props.getTableData)
        props.getTableData({
          data: tableArray,
          title: tableTitle,
          type: tableDivision,
        });

      const d: number = Number(item.data.data);

      if (props.getTableId) props.getTableId(d);
      resetLoadingModal();
      setAlertModal({
        type: "check",
        isModal: true,
        content: "해당 평가항목표가 등록되었습니다.",
        onClick() {
          if (props.usingAsPage) navigate("/west/system/evaluation-table");
          resetAlertModal();
          props.onClose();
        },
      });
    },
  });

  /** 영역 외 클릭시 동작 함수 */
  const handleClickOutside = ({ target }: any) => {
    if (modalRef.current && modalRef.current.contains(target) === false) {
      onCloseModal();
    }
  };

  useEffect(() => {
    window.addEventListener("click", handleClickOutside);
    return () => {
      window.removeEventListener("click", handleClickOutside);
    };
  }, []);

  // 상세 정보가 있을 경우
  useEffect(() => {
    if (props?.evaluationTableInfo?.list && props?.evaluationTableInfo?.list?.length > 0) {
      // if (tableArray.length > 0) return;

      setTableArray(props.evaluationTableInfo.list);
      if (!props.editCheck) setTableTitle(props.evaluationTableInfo.title);
    } else {
      setTableArray([]);
      setTableTitle("");
    }
  }, [props.evaluationTableInfo?.list?.length]);

  /** 항목 선택 모달
   * @idNum string - 해당 모달을 지칭할 고유값
   */
  const onAddModal = (idNum: string) => {
    if ((addModal.check && addModal.idNum === idNum) || !idNum) {
      setAddModal({
        idNum: "",
        check: false,
      });
      return;
    }

    let data: AddModalType = {
      idNum: idNum,
      check: true,
    };

    setTimeout(() => {
      setAddModal(data);
    }, 20);
  };

  /** 항목 선택 모달 닫기 */
  const onCloseModal = () => {
    setAddModal({
      idNum: "",
      check: false,
    });
  };

  /** 평가채점표 미리보기 모달
   * @check boolean - 모달 여부
   */
  const onScoreModal = (check: boolean) => {
    setScoreTableModal({ type: props.usingAsPage ? "page" : "modal", check: check });
  };

  /** 카테고리 추가
   * @largeIndex number - 대분류 카테고리 인덱스
   * @middleIndex number - 중분류 카테고리 인덱스
   */
  const onAddCategory = (largeIndex?: number, middleIndex?: number) => {
    let array = [...tableArray];

    let data: TableArrayItemType = {
      title: "",
      content: [],
      sub: [],
    };

    // 평가항목 (대분류) 추가
    if (middleIndex === undefined && largeIndex === undefined) {
      data.criteria = ""; // 대분류일 경우 criteria 값 추가
      array.push(data);
    }
    // 구분 (중분류) 추가
    if (middleIndex === undefined && largeIndex !== undefined) array[largeIndex].sub.push(data);
    // 세부평가항목 (소분류) 추가
    if (middleIndex !== undefined && largeIndex !== undefined)
      array[largeIndex].sub[middleIndex].sub.push(data);

    setTableArray(array);
    viewScrollMove();
    onCloseModal();
  };

  /** 카테고리 삭제
   * @largeIndex number - 대분류 카테고리 인덱스*
   * @middleIndex number - 중분류 카테고리 인덱스
   * @smallIndex number - 소분류 카테고리 인덱스
   */
  const onRemoveCategory = (largeIndex: number, middleIndex?: number, smallIndex?: number) => {
    let array = [...tableArray];

    // 평가항목 (대분류) 삭제
    if (middleIndex === undefined && smallIndex === undefined) array.splice(largeIndex, 1);
    // 구분 (중분류) 삭제
    if (middleIndex !== undefined && smallIndex === undefined)
      array[largeIndex].sub.splice(middleIndex, 1);
    // 세부평가항목 (소분류) 삭제
    if (middleIndex !== undefined && smallIndex !== undefined)
      array[largeIndex].sub[middleIndex].sub.splice(smallIndex, 1);

    setTableArray(array);
  };

  /** 평가기준 란 추가
   * @largeIndex number - 대분류 카테고리 인덱스*
   * @middleIndex number - 중분류 카테고리 인덱스
   * @smallIndex number - 소분류 카테고리 인덱스
   */
  const onAddContent = (largeIndex: number, middleIndex?: number, smallIndex?: number) => {
    let array = [...tableArray];

    let data: TableContentItem = {
      content: "",
      score: "",
      inputScore: 0,
    };

    // 평가항목 (대분류) 평가기준 추가
    if (middleIndex === undefined && smallIndex === undefined) array[largeIndex].content.push(data);
    // 구분 (중분류) 평가기준 추가
    if (middleIndex !== undefined && smallIndex === undefined)
      array[largeIndex].sub[middleIndex].content.push(data);
    // 세부평가항목 (소분류) 평가기준 추가
    if (middleIndex !== undefined && smallIndex !== undefined)
      array[largeIndex].sub[middleIndex].sub[smallIndex].content.push(data);

    setTableArray(array);
    viewScrollMove();
    onCloseModal();
  };

  /** 평가기준 란 삭제
   * @index number - 삭제할 데이터*
   * @largeIndex number - 대분류 카테고리 인덱스*
   * @middleIndex number - 중분류 카테고리 인덱스
   * @smallIndex number - 소분류 카테고리 인덱스
   */
  const onRemoveContent = (
    index: number,
    largeIndex: number,
    middleIndex?: number,
    smallIndex?: number
  ) => {
    let array = [...tableArray];

    // 평가항목 (대분류) 평가기준 삭제
    if (middleIndex === undefined && smallIndex === undefined)
      array[largeIndex].content.splice(index, 1);
    // 구분 (중분류) 평가기준 삭제
    if (middleIndex !== undefined && smallIndex === undefined)
      array[largeIndex].sub[middleIndex].content.splice(index, 1);
    // 세부평가항목 (소분류) 평가기준 삭제
    if (middleIndex !== undefined && smallIndex !== undefined)
      array[largeIndex].sub[middleIndex].sub[smallIndex].content.splice(index, 1);

    setTableArray((prev) => {
      return [...array];
    });
  };

  /** 카테고리 입력
   * @e HTMLInputElement - 입력 input event*
   * @largeIndex number - 대분류 카테고리 인덱스*
   * @middleIndex number - 중분류 카테고리 인덱스
   * @smallIndex number - 소분류 카테고리 인덱스
   */
  const onChange = (
    e: React.ChangeEvent<HTMLInputElement>,
    largeIndex: number,
    middleIndex?: number,
    smallIndex?: number
  ) => {
    let array = [...tableArray];

    const { name, value } = e.target;

    let val: string = value;

    if (name === "criteria") {
      if (value === "") {
        val = "";
      } else {
        const pattern = Regex.numberRegex;
        if (!pattern.test(value)) return;
      }
    }

    // 평가항목 (대분류) 타이틀 입력
    if (middleIndex === undefined && smallIndex === undefined) {
      if (name === "title") array[largeIndex].title = val;
      if (name === "criteria") array[largeIndex].criteria = val;
    }
    // 구분 (중분류) 타이틀 입력
    if (middleIndex !== undefined && smallIndex === undefined)
      array[largeIndex].sub[middleIndex].title = val;
    // 세부평가항목 (소분류) 타이틀 입력
    if (middleIndex !== undefined && smallIndex !== undefined)
      array[largeIndex].sub[middleIndex].sub[smallIndex].title = val;

    setTableArray(array);
  };

  /** 평가기준, 배점 입력
   * @e HTMLInputElement - 입력 input event*
   * @index number - 입력할 위치*
   * @largeIndex number - 대분류 카테고리 인덱스*
   * @middleIndex number - 중분류 카테고리 인덱스
   * @smallIndex number - 소분류 카테고리 인덱스
   */
  const onContentChange = (
    e: React.ChangeEvent<HTMLInputElement>,
    index: number,
    largeIndex: number,
    middleIndex?: number,
    smallIndex?: number
  ) => {
    let array = [...tableArray];

    const { name, value } = e.target;

    let val: string = value;

    // 소수점 체크
    if (name === "score") {
      if (value === "" && !value) {
        val = "";
      } else {
        const pattern = Regex.primeNumberRegex;
        if (!pattern.test(value)) return;
      }
    }

    // 평가항목 (대분류) 평가기준 배점 입력
    if (middleIndex === undefined && smallIndex === undefined) {
      let item = array[largeIndex].content.map((data, i) =>
        i === index ? { ...data, [name]: val } : data
      );
      array[largeIndex].content = item;
    }
    // 구분 (중분류) 평가기준 배점 입력
    if (middleIndex !== undefined && smallIndex === undefined) {
      let item = array[largeIndex].sub[middleIndex].content.map((data, i) =>
        i === index ? { ...data, [name]: val } : data
      );
      array[largeIndex].sub[middleIndex].content = item;
    }
    // 세부평가항목 (소분류) 평가기준 배점 입력
    if (middleIndex !== undefined && smallIndex !== undefined) {
      let item = array[largeIndex].sub[middleIndex].sub[smallIndex].content.map((data, i) =>
        i === index ? { ...data, [name]: val } : data
      );
      array[largeIndex].sub[middleIndex].sub[smallIndex].content = item;
    }

    setTableArray(array);
  };

  const onFoucsOut = (
    e: React.ChangeEvent<HTMLInputElement>,
    index: number,
    largeIndex: number,
    middleIndex?: number,
    smallIndex?: number
  ) => {
    let array = [...tableArray];

    const { name, value } = e.target;

    let val: string = String(Math.round(Number(value) * 10000) / 10000);

    // 평가항목 (대분류) 평가기준 배점 입력
    if (middleIndex === undefined && smallIndex === undefined) {
      let item = array[largeIndex].content.map((data, i) =>
        i === index ? { ...data, [name]: val } : data
      );
      array[largeIndex].content = item;
    }
    // 구분 (중분류) 평가기준 배점 입력
    if (middleIndex !== undefined && smallIndex === undefined) {
      let item = array[largeIndex].sub[middleIndex].content.map((data, i) =>
        i === index ? { ...data, [name]: val } : data
      );
      array[largeIndex].sub[middleIndex].content = item;
    }
    // 세부평가항목 (소분류) 평가기준 배점 입력
    if (middleIndex !== undefined && smallIndex !== undefined) {
      let item = array[largeIndex].sub[middleIndex].sub[smallIndex].content.map((data, i) =>
        i === index ? { ...data, [name]: val } : data
      );
      array[largeIndex].sub[middleIndex].sub[smallIndex].content = item;
    }

    setTableArray(array);
  };

  /** 배점 합계
   * @list TableArrayItemType
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

    const d = Math.round(sum * 10000) / 10000;
    return d;
  };

  /** 총 배점 합계 */
  const onTotalSumScore = () => {
    let array = [...tableArray];

    // 전체 score 총 합산
    let sum: number = 0;

    // 상위의 재귀함수롤 반복으로 호출
    array.map((d, i) => (sum += onSumScore(d)));

    const d = Math.round(sum * 10000) / 10000;

    return d;
  };

  /** 평가기준 퍼센트 합계 */
  const onSumCriteria = () => {
    let array = [...tableArray];

    // 전체 퍼센트 총합
    let sum: number = 0;

    // 평가항목 (대분류) 포인트 합산
    array.map((d, i) => (sum += Number(d.criteria)));

    return sum;
  };

  /** 평가표 저장 */
  const onSave = () => {
    if (onSaveCheck() === false) return;

    let item: TableArrayItemTypeReq = {
      data: tableArray,
      title: tableTitle,
      type: tableDivision,
    };

    if (props.tableId) item.id = props.tableId;

    // console.log(item);

    // console.log(props.roomOpenCheck);
    // console.log(props.editCheck);
    // console.log(props.modifyCheck);
    // console.log(props.lockerStatus);

    if (!props.roomOpenCheck) {
      if (props.editCheck || !props.modifyCheck) {
        addEvaluationTable.mutate(item);
        return;
      }

      if (!props.editCheck && props.modifyCheck && props.onModify) {
        props.onModify(item);
        return;
      }
    }

    if (props.roomOpenCheck) {
      if (
        !props.modifyCheck ||
        props.lockerStatus === "useLocker" ||
        props.lockerStatus === "useLockerTemplete"
      ) {
        // console.log("신규생성");
        addEvaluationTable.mutate(item);
        return;
      }

      if (props.lockerStatus === "noLocker" && props.onModify) {
        if (props.getTableData)
          props.getTableData({
            data: tableArray,
            title: tableTitle,
            type: tableDivision,
          });
        props.onModify(item);
        return;
      }
    }
  };

  /** 평가항목표 저장시 평가내용 체크 */
  const onSaveCheck = (): boolean => {
    let array = [...tableArray];
    let nullCheck = true;

    if (array.length <= 0) {
      nullCheck = false;
      setTimeout(() => {
        setAlertModal({
          isModal: true,
          content:
            "'평가항목표 제목'을 입력해 주세요.\n필수 항목 입력 후 평가항목표를 저장할 수 있습니다.",
          type: "error",
          title: "필수 입력 사항을 입력해 주세요.",
        });
      }, 10);
      return nullCheck;
    }

    /** 재귀함수 영역 - 순회하면서 평가기준 체크
     * @list TableArrayItemType
     */
    const onNullCheckRepetition = (subList: TableArrayItemType): any => {
      let data: TableArrayItemType[] = subList.sub; // 카테고리 리스트
      let item: TableContentItem[] = subList.content; // 평가기준 영역
      let title: string = subList.title;

      // 카테고리의 항목이름이 빈값일 경우
      if (!title) {
        nullCheck = false;
        setTimeout(() => {
          setAlertModal({
            isModal: true,
            content:
              "'평가항목 및 세부평가항목'을 입력해 주세요.\n필수 항목 입력 후 평가항목표를 저장할 수 있습니다.",
            type: "error",
            title: "필수 입력 사항을 입력해 주세요.",
          });
        }, 10);
        return nullCheck;
      }

      // 카테고리 리스트가 없을 경우 - 재귀 이탈 후 합산 (카테고리가 있으면 평가기준 리스트가 비어있음)
      if (data.length === 0) {
        if (item.length <= 0) {
          // 구분만 있고 평가기준이 배열에 없을 경우
          nullCheck = false;
          setTimeout(() => {
            setAlertModal({
              isModal: true,
              content: `'평가 내용${
                tableDivision === TableDivisionEnumType.DIVISION_SCORE ? " 및 배점" : ""
              }'을 입력해 주세요.\n필수 항목 입력 후 평가항목표를 저장할 수 있습니다.`,
              type: "error",
              title: "필수 입력 사항을 입력해 주세요.",
            });
          }, 10);
        } else {
          // 평가기준이 있을 경우 빈값 체크
          item.map((content, i) => {
            if (
              (tableDivision === TableDivisionEnumType.DIVISION_SCORE &&
                (!content.content || !content.score)) ||
              (tableDivision === TableDivisionEnumType.DIVISION_SUITABLE && !content.content)
            ) {
              nullCheck = false;
              setTimeout(() => {
                setAlertModal({
                  isModal: true,
                  content: `'평가 내용${
                    tableDivision === TableDivisionEnumType.DIVISION_SCORE ? " 및 배점" : ""
                  }'을 입력해 주세요.\n필수 항목 입력 후 평가항목표를 저장할 수 있습니다.`,
                  type: "error",
                  title: "필수 입력 사항을 입력해 주세요.",
                });
              }, 10);
            }
          });
        }
      } else {
        data.map((d, i) => {
          if (!d.title) {
            nullCheck = false;
            setTimeout(() => {
              setAlertModal({
                isModal: true,
                content:
                  "'평가항목 및 세부평가항목'을 입력해 주세요.\n필수 항목 입력 후 평가항목표를 저장할 수 있습니다.",
                type: "error",
                title: "필수 입력 사항을 입력해 주세요.",
              });
            }, 10);
          }
        });
      }

      // 카테고리 리스트가 있을 경우 재귀 -> 리스트기에 반복으로 호출
      return data.map((d, i) => onNullCheckRepetition(d));
    };

    // 재귀함수 호출
    array.map((d, i) => onNullCheckRepetition(d));

    return nullCheck;
  };

  /** 평가표 저장, 수정 컨펌 */
  const onSaveConfirm = () => {
    if (!tableTitle) {
      setAlertModal({
        isModal: true,
        content:
          "'평가항목표 제목'을 입력해 주세요.\n필수 항목 입력 후 평가항목표를 저장할 수 있습니다.",
        type: "error",
        title: "필수 입력 사항을 입력해 주세요.",
      });
      return;
    }
    setAlertModal({
      isModal: true,
      content: `평가항목표를 ${props.modifyCheck ? "수정" : "등록"} 하시겠습니까?`,
      onClick() {
        onSave();
        resetAlertModal();
      },
    });
  };

  /** 평가표 삭제 컨펌 */
  const onDeleteConfirm = () => {
    setAlertModal({
      isModal: true,
      content: `평가항목표를 삭제 하시겠습니까?`,
      onClick() {
        if (props.onDelete) props.onDelete();
        resetAlertModal();
      },
    });
  };

  /** 카테고리, 평가내용 삭제 여부 체크
   * @func Function - 카테고리, 평가내용 삭제함수
   */
  const onDeleteContentConfirm = (func: Function) => {
    setAlertModal({
      isModal: true,
      content: `해당내용을 삭제 하시겠습니까?`,
      onClick() {
        func();
        resetAlertModal();
      },
    });
  };

  /** 카테고리나 컨텐츠란 추가시 스크롤의 맨 아래로 이동 */

  let tableRef = useRef<HTMLTableElement | null>(null);
  const viewScrollMove = () => {
    // tableRef.current?.scrollIntoView({ behavior: "smooth", block: "end", inline: "start" });
  };

  /** 평가 구분 선택하기 */
  const onDivisionSelect = (type: TableDivisionEnumType) => {
    setTableDivision(type);
  };

  const onDivisionText = (type: TableDivisionEnumType): string => {
    let text = "";
    if (type === TableDivisionEnumType.DIVISION_SCORE) text = "정량평가(배점입력 평가)";
    if (type === TableDivisionEnumType.DIVISION_SUITABLE) text = "적합/부적합(항목선택 평가)";
    return text;
  };

  const temporarySave = () => {
    const nextLevel = () => {
      const data = {
        data: tableArray,
        title: tableTitle,
        type: tableDivision,
      };

      localStorage.setItem("temporary", JSON.stringify(data));
    };

    const item = localStorage.getItem("temporary") ?? null;
    if (item) {
      setAlertModal({
        isModal: true,
        content: "기존 임시저장 정보가 남아있습니다. 변경하시겠습니까?",
        onClick() {
          nextLevel();
          resetAlertModal();
        },
      });
    } else {
      nextLevel();
    }
  };

  const getTemporarySave = () => {
    const data = localStorage.getItem("temporary") ?? null;
    if (data) {
      const item: TableArrayItemTypeReq = JSON.parse(data);

      let i: TableDivisionEnumType | null = null;

      if (item.type === TableDivisionEnumType.DIVISION_SCORE)
        i = TableDivisionEnumType.DIVISION_SCORE;
      if (item.type === TableDivisionEnumType.DIVISION_SUITABLE)
        i = TableDivisionEnumType.DIVISION_SUITABLE;

      if (i !== tableDivision) {
        setAlertModal({
          isModal: true,
          type: "error",
          title: "임시저장 정보를 가져올 수 없습니다",
          content: "평가항목표 구분이 다릅니다.",
        });
        return;
      }

      if (i) {
        setTableArray(item.data);
        setTableTitle(item.title);
        setTableDivision(i);
      }
    }
  };

  return (
    <>
      <EvaluationTableWrapBlock usingAsPage={props.usingAsPage} scoreTableModal={scoreTableModal}>
        <section>
          <ViewObjectWrapperBox>
            {tableDivision === TableDivisionEnumType.DIVISION_UNSELECT && (
              <EvaluationTableDivisionModal
                onDivisionSelect={onDivisionSelect}
                onClose={props.onClose}
              />
            )}
            {tableDivision !== TableDivisionEnumType.DIVISION_UNSELECT && (
              <>
                <div className="headWrap">
                  <h1 className="viewTitle">
                    평가항목표 {props.modifyCheck && !props.editCheck ? "수정" : "작성"}
                    <span className="subViewTitle"> - {onDivisionText(tableDivision)}</span>
                  </h1>
                  <div>
                    <p>
                      * 항목, 평가내용이 입력되어 있지 않을 경우 제대로 표현되지 않을 수 있습니다.
                    </p>
                    <button
                      type="button"
                      onClick={() => {
                        setContentModal({
                          isModal: true,
                          subText: "",
                          title: "",
                          content: (
                            <EvaluationScoreTableComponent
                              tableArray={tableArray}
                              tableTitle={tableTitle}
                              titleType={"미리보기"}
                              tableDivision={tableDivision}
                              onClose={resetContentModal}
                              noSave
                            />
                          ),
                        });
                      }}
                    >
                      <span>
                        <img src={SearchWhiteIcon} alt="" />
                      </span>
                      미리보기
                    </button>
                  </div>
                </div>
                <div className="tableTitle">
                  <p>평가항목표 제목</p>
                  <input
                    placeholder="평가항목표 제목을 입력해주세요."
                    value={tableTitle}
                    onChange={(e) => setTableTitle(e.target.value)}
                  />
                </div>
                <div className="mainContent">
                  <EvaluationTableBlock ref={tableRef}>
                    <thead>
                      <tr>
                        <th>분류명</th>
                        <th>평가항목 및 세부평가항목</th>
                        <th>평가내용</th>
                        {tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                          <>
                            <th>배점</th>
                            {/* <th>평가기준</th> */}
                          </>
                        )}
                      </tr>
                    </thead>
                    <tbody>
                      {/* 평가항목(대분류) */}
                      {tableArray.map((large, largeIndex) => (
                        <React.Fragment key={largeIndex}>
                          <tr className="largeCategory">
                            <td>대분류</td>
                            <td>
                              <div>
                                <div>
                                  <div className="plusIcon">
                                    <img src={HighRankFolderIcon} alt="" />
                                  </div>
                                  <input
                                    name="title"
                                    value={large.title}
                                    placeholder="내용을 입력해주세요."
                                    onChange={(e) => onChange(e, largeIndex)}
                                  />
                                </div>
                                <div ref={modalRef}>
                                  <div
                                    className="plusIcon"
                                    onClick={() => onAddModal(`${largeIndex}`)}
                                  >
                                    <img src={PlusBtnIcon} alt="" />
                                  </div>
                                  <div
                                    className="plusIcon"
                                    onClick={() =>
                                      onDeleteContentConfirm(() => onRemoveCategory(largeIndex))
                                    }
                                  >
                                    <img src={MinusBtnIcon} alt="" />
                                  </div>
                                </div>
                                {addModal.idNum === `${largeIndex}` && addModal.check && (
                                  <CategoryAddModal
                                    nexAddCategoryType="중분류"
                                    subCheck={large.sub.length > 0}
                                    contentCheck={large.content.length > 0}
                                    onAddCategory={() => onAddCategory(largeIndex)}
                                    onAddContent={() => onAddContent(largeIndex)}
                                  />
                                )}
                              </div>
                            </td>
                            <td></td>
                            {tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                              <>
                                <td>
                                  총 합계: <span>{onSumScore(large)}</span>
                                </td>
                                {/* <td>
                                  평가최하:{" "}
                                  <input
                                    name="criteria"
                                    value={large.criteria}
                                    onChange={(e) => onChange(e, largeIndex)}
                                  />{" "}
                                  %
                                </td> */}
                              </>
                            )}
                          </tr>
                          {/* 중분류 */}
                          {large.sub.length > 0 ? (
                            <>
                              {large.sub.map((middle, middleIndex) => (
                                <React.Fragment key={middleIndex}>
                                  <tr>
                                    <td>중분류</td>
                                    <td className="middleCategory">
                                      <div>
                                        <div>
                                          <div className="plusIcon">
                                            <img src={LowRankFolderIcon} alt="" />
                                          </div>
                                          <input
                                            name="title"
                                            value={middle.title}
                                            placeholder="내용을 입력해주세요."
                                            onChange={(e) => onChange(e, largeIndex, middleIndex)}
                                          />
                                        </div>
                                        <div ref={modalRef}>
                                          <div
                                            className="plusIcon"
                                            onClick={() =>
                                              onAddModal(`${largeIndex}-${middleIndex}`)
                                            }
                                          >
                                            <img src={PlusBtnIcon} alt="" />
                                          </div>
                                          <div
                                            className="plusIcon"
                                            onClick={() =>
                                              onDeleteContentConfirm(() =>
                                                onRemoveCategory(largeIndex, middleIndex)
                                              )
                                            }
                                          >
                                            <img src={MinusBtnIcon} alt="" />
                                          </div>
                                        </div>
                                        {addModal.idNum === `${largeIndex}-${middleIndex}` &&
                                          addModal.check && (
                                            <CategoryAddModal
                                              nexAddCategoryType="소분류"
                                              subCheck={middle.sub.length > 0}
                                              contentCheck={middle.content.length > 0}
                                              onAddCategory={() =>
                                                onAddCategory(largeIndex, middleIndex)
                                              }
                                              onAddContent={() =>
                                                onAddContent(largeIndex, middleIndex)
                                              }
                                            />
                                          )}
                                      </div>
                                    </td>
                                    <td></td>
                                    {tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                                      <>
                                        <td>
                                          항목 합계: <span>{onSumScore(middle)}</span>
                                        </td>
                                        {/* <td></td> */}
                                      </>
                                    )}
                                  </tr>

                                  {/* 소분류 */}
                                  {middle.sub.length > 0 ? (
                                    <>
                                      {middle.sub.map((small, smallIndex) => (
                                        <React.Fragment key={smallIndex}>
                                          <tr>
                                            <td>소분류</td>
                                            <td className="smallCategory">
                                              <div>
                                                <div>
                                                  <div className="plusIcon">
                                                    <img src={LowRankFolderIcon} alt="" />
                                                  </div>
                                                  <input
                                                    name="title"
                                                    value={small.title}
                                                    placeholder="내용을 입력해주세요."
                                                    onChange={(e) =>
                                                      onChange(
                                                        e,
                                                        largeIndex,
                                                        middleIndex,
                                                        smallIndex
                                                      )
                                                    }
                                                  />
                                                </div>
                                                <div ref={modalRef}>
                                                  <div
                                                    className="plusIcon"
                                                    onClick={() =>
                                                      onAddModal(
                                                        `${largeIndex}-${middleIndex}-${smallIndex}`
                                                      )
                                                    }
                                                  >
                                                    <img src={PlusBtnIcon} alt="" />
                                                  </div>
                                                  <div
                                                    className="plusIcon"
                                                    onClick={() =>
                                                      onDeleteContentConfirm(() =>
                                                        onRemoveCategory(
                                                          largeIndex,
                                                          middleIndex,
                                                          smallIndex
                                                        )
                                                      )
                                                    }
                                                  >
                                                    <img src={MinusBtnIcon} alt="" />
                                                  </div>
                                                </div>
                                                {addModal.idNum ===
                                                  `${largeIndex}-${middleIndex}-${smallIndex}` &&
                                                  addModal.check && (
                                                    <CategoryAddModal
                                                      subCheck={false}
                                                      contentCheck
                                                      onAddContent={() =>
                                                        onAddContent(
                                                          largeIndex,
                                                          middleIndex,
                                                          smallIndex
                                                        )
                                                      }
                                                    />
                                                  )}
                                              </div>
                                            </td>
                                            <td></td>
                                            {tableDivision ===
                                              TableDivisionEnumType.DIVISION_SCORE && (
                                              <>
                                                <td>
                                                  세부항목 합계: <span>{onSumScore(small)}</span>
                                                </td>
                                                {/* <td></td> */}
                                              </>
                                            )}
                                          </tr>
                                          {small.content.map((smallContent, smallContentIndex) => (
                                            <tr key={smallContentIndex}>
                                              <td>내용</td>
                                              <td></td>
                                              <td>
                                                <div>
                                                  <div>
                                                    <input
                                                      name="content"
                                                      value={smallContent.content}
                                                      placeholder="내용을 입력해주세요."
                                                      onChange={(e) =>
                                                        onContentChange(
                                                          e,
                                                          smallContentIndex,
                                                          largeIndex,
                                                          middleIndex,
                                                          smallIndex
                                                        )
                                                      }
                                                    />
                                                  </div>
                                                  <div>
                                                    <div
                                                      className="plusIcon"
                                                      onClick={() =>
                                                        onDeleteContentConfirm(() =>
                                                          onRemoveContent(
                                                            smallContentIndex,
                                                            largeIndex,
                                                            middleIndex,
                                                            smallIndex
                                                          )
                                                        )
                                                      }
                                                    >
                                                      <img src={MinusBtnIcon} alt="" />
                                                    </div>
                                                  </div>
                                                </div>
                                              </td>
                                              {tableDivision ===
                                                TableDivisionEnumType.DIVISION_SCORE && (
                                                <>
                                                  <td>
                                                    <input
                                                      name="score"
                                                      value={smallContent.score}
                                                      onBlur={(e) =>
                                                        onFoucsOut(
                                                          e,
                                                          smallContentIndex,
                                                          largeIndex,
                                                          middleIndex,
                                                          smallIndex
                                                        )
                                                      }
                                                      onChange={(e) =>
                                                        onContentChange(
                                                          e,
                                                          smallContentIndex,
                                                          largeIndex,
                                                          middleIndex,
                                                          smallIndex
                                                        )
                                                      }
                                                    />
                                                  </td>
                                                  {/* <td></td> */}
                                                </>
                                              )}
                                            </tr>
                                          ))}
                                        </React.Fragment>
                                      ))}
                                    </>
                                  ) : (
                                    <>
                                      {middle.content.map((middleContent, middleContentIndex) => (
                                        <tr key={middleContentIndex}>
                                          <td>평가내용</td>
                                          <td></td>
                                          <td>
                                            <div>
                                              <div>
                                                <input
                                                  name="content"
                                                  value={middleContent.content}
                                                  placeholder="내용을 입력해주세요."
                                                  onChange={(e) =>
                                                    onContentChange(
                                                      e,
                                                      middleContentIndex,
                                                      largeIndex,
                                                      middleIndex
                                                    )
                                                  }
                                                />
                                              </div>
                                              <div>
                                                <div
                                                  className="plusIcon"
                                                  onClick={() =>
                                                    onDeleteContentConfirm(() =>
                                                      onRemoveContent(
                                                        middleContentIndex,
                                                        largeIndex,
                                                        middleIndex
                                                      )
                                                    )
                                                  }
                                                >
                                                  <img src={MinusBtnIcon} alt="" />
                                                </div>
                                              </div>
                                            </div>
                                          </td>
                                          {tableDivision ===
                                            TableDivisionEnumType.DIVISION_SCORE && (
                                            <>
                                              <td>
                                                <input
                                                  name="score"
                                                  value={middleContent.score}
                                                  onBlur={(e) =>
                                                    onFoucsOut(
                                                      e,
                                                      middleContentIndex,
                                                      largeIndex,
                                                      middleIndex
                                                    )
                                                  }
                                                  onChange={(e) =>
                                                    onContentChange(
                                                      e,
                                                      middleContentIndex,
                                                      largeIndex,
                                                      middleIndex
                                                    )
                                                  }
                                                />
                                              </td>
                                              {/* <td></td> */}
                                            </>
                                          )}
                                        </tr>
                                      ))}
                                    </>
                                  )}
                                </React.Fragment>
                              ))}
                            </>
                          ) : (
                            <>
                              {large.content.map((largeContent, largeContentIndex) => (
                                <tr key={largeContentIndex}>
                                  <td>평가내용</td>
                                  <td></td>
                                  <td>
                                    <div>
                                      <div>
                                        <input
                                          name="content"
                                          value={largeContent.content}
                                          placeholder="내용을 입력해주세요."
                                          onChange={(e) =>
                                            onContentChange(e, largeContentIndex, largeIndex)
                                          }
                                        />
                                      </div>
                                      <div>
                                        <div
                                          className="plusIcon"
                                          onClick={() =>
                                            onDeleteContentConfirm(() =>
                                              onRemoveContent(largeContentIndex, largeIndex)
                                            )
                                          }
                                        >
                                          <img src={MinusBtnIcon} alt="" />
                                        </div>
                                      </div>
                                    </div>
                                  </td>
                                  {tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                                    <>
                                      <td>
                                        <input
                                          name="score"
                                          value={largeContent.score}
                                          onBlur={(e) => {
                                            onFoucsOut(e, largeContentIndex, largeIndex);
                                          }}
                                          onChange={(e) =>
                                            onContentChange(e, largeContentIndex, largeIndex)
                                          }
                                        />
                                      </td>
                                      {/* <td></td> */}
                                    </>
                                  )}
                                </tr>
                              ))}
                            </>
                          )}
                        </React.Fragment>
                      ))}
                    </tbody>
                    {/* 평가항목 (대분류) 추가 영역  */}
                    <tbody className="plusButtonWrap">
                      <tr>
                        <td colSpan={3}>
                          <div>
                            <div className="plusIcon" onClick={() => onAddCategory()}>
                              <img src={PlusBtnIcon} alt="" />
                            </div>{" "}
                            평가항목 추가
                          </div>
                        </td>
                        {tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                          <>
                            <td></td>
                            {/* <td></td> */}
                          </>
                        )}
                      </tr>
                    </tbody>
                    {/* 배점합계 영역 */}
                    <tbody className="totalScore">
                      <tr>
                        {tableDivision === TableDivisionEnumType.DIVISION_SCORE && (
                          <>
                            <td colSpan={3}>배점 합계</td>
                            <td>{onTotalSumScore()}</td>
                            {/* <td></td> */}
                          </>
                        )}
                        {tableDivision === TableDivisionEnumType.DIVISION_SUITABLE && (
                          <td colSpan={3}></td>
                        )}
                      </tr>
                    </tbody>
                  </EvaluationTableBlock>
                </div>
                <div className="buttonContainer">
                  <BigButton text="취소" onClick={props.onClose} white />
                  {props.modifyCheck && !props.editCheck && !props.onOpenEvaluationRoomCheck && (
                    <BigButton
                      text="삭제"
                      onClick={onDeleteConfirm}
                      color={theme.colors.red}
                      white
                    />
                  )}
                  <BigButton text="저장" onClick={onSaveConfirm} />
                  <button onClick={temporarySave}>임시저장</button>
                  <button onClick={getTemporarySave}>임시저장 가져오기</button>
                </div>
              </>
            )}
          </ViewObjectWrapperBox>
        </section>
      </EvaluationTableWrapBlock>
    </>
  );
}

export default EvaluationTableComponent;

const EvaluationTableWrapBlock = styled.div<EvaluationTableWrapBlockType>`
  width: 100%;
  height: 100%;
  position: ${(props) => (props.usingAsPage ? "static" : "fixed")};
  top: 0;
  left: 0;
  background-color: ${(props) => (props.usingAsPage ? "transparent" : "rgba(0, 0, 0, 0.3)")};
  z-index: 100;
  display: ${(props) =>
    props.scoreTableModal.check && props.scoreTableModal.type === "modal"
      ? "none"
      : props.usingAsPage
      ? "block"
      : "flex"};
  justify-content: center;
  align-items: center;
  font-size: 12px;
  font-weight: ${theme.fontType.subTitle1.bold};
  & > section {
    display: ${(props) => (props.usingAsPage ? "block" : "flex")};
    justify-content: center;
    align-items: center;
    width: ${(props) => (props.usingAsPage ? "auto" : "1200px")};
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
        & > div {
          display: flex;
          align-items: center;
          & > p {
            margin-right: 14px;
            color: ${theme.colors.gray3};
          }
          & > button {
            width: 120px;
            height: 36px;
            background-color: ${theme.systemColors.systemPrimary};
            border-radius: 18px;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;

            & > span {
              margin-right: 6px;
              display: flex;
              justify-content: center;
              align-items: center;
            }
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
        color: ${theme.colors.body2};
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
`;

export const EvaluationTableBlock = styled.table`
  width: 100%;
  border-collapse: collapse;
  border-spacing: 0;
  th,
  td {
    box-sizing: border-box;
    border: 1px solid ${theme.colors.blueGray2};
    margin: 0;
    padding: 3px 0;
    height: 42px;
    vertical-align: middle;
  }
  th {
    background-color: ${theme.colors.blueGray2};
    position: -webkit-sticky;
    position: sticky;
    top: 0;
    z-index: 1;
    &:nth-child(1) {
      width: 110px;
    }
    &:nth-child(2),
    &:nth-child(3) {
      width: 400px;
    }
    &:nth-child(4),
    :nth-child(5) {
      width: 130px;
    }
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
    padding-left: ${theme.commonMargin.gap4};
    padding-right: ${theme.commonMargin.gap4};
    vertical-align: middle;
    & > div {
      width: 100%;
      height: auto;
      position: relative;
      display: flex;
      justify-content: space-between;
      align-items: center;
      & > div {
        width: auto;
        display: flex;
      }
      & > div:nth-child(1) {
        flex: 1;
        margin-right: 80px;
        padding-left: 12px;
        align-items: center;
        height: 42px;
      }
      & > div.plusIcon {
        flex: none;
        padding-left: 0;
        margin-right: ${theme.commonMargin.gap4};
      }
    }
    input {
      border: 0;
      border-bottom: 1px solid ${theme.colors.blueDeep};
      width: 100%;
      padding: 3px;
      height: 30px;
      background-color: transparent;
      border-radius: 0;
    }
    input:focus {
      outline: none;
      border-bottom: 1px solid ${theme.systemColors.systemPrimary};
    }
    &:nth-child(4) {
      & > span {
        margin-left: 4px;
      }
    }
    &:last-child {
      /* display: flex;
      align-items: center; */
      & > input {
        width: 90px !important;
        margin-left: 6px;
      }
    }
  }

  .largeCategory {
    background-color: ${theme.colors.bluepurpleLight};
  }

  .middleCategory {
    padding-left: 40px;
  }
  .smallCategory {
    padding-left: 70px;
  }

  .inputWrap {
    width: 200px;
  }

  .plusButtonWrap {
    & > tr {
      & > td {
        & > div {
          justify-content: flex-start;
          align-items: center;
        }
      }
    }
  }

  .totalScore {
    td {
      background-color: ${theme.colors.blueGray2};
      position: sticky;
      position: -webkit-sticky;
      bottom: 0;
      z-index: 1;
      &:nth-child(1) {
        text-align: right;
      }
      &:nth-child(2),
      &:nth-child(3) {
        text-align: right;
        padding-right: 20px;
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

  .plusIcon {
    width: 20px;
    height: 20px;
    margin-right: ${theme.commonMargin.gap4};
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
  }
`;
