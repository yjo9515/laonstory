/* eslint-disable react-hooks/exhaustive-deps */
import React, { useState, useEffect } from "react";
import { useForm } from "react-hook-form";
import { useNavigate, useParams } from "react-router";
import styled from "styled-components";
import BigButton from "../../../components/Common/Button/BigButton";
import {
  alertModalState,
  IAlertModalDefault,
  loadingModalState,
  sideBarCover,
  footerZIndexControl,
} from "../../../modules/Client/Modal/Modal";
import theme from "../../../theme";
import { ViewObjectWrapperBox } from "../../../theme/common";
import { StepOne } from "./StepComponent/StepOne";
import { StepThree } from "./StepComponent/StepThree";
import { StepTwo } from "./StepComponent/StepTwo";
import {
  EvaluationRommSetupType,
  EvaluationRoomSetUp,
  StepOneState,
  StepTwoCommitter,
  StepTwoCompany,
  StepTwoSearchModal,
} from "../../../interface/System/EvaluationRoomDetail/EvaluationRoomDetailTypes";
import AttendeeSelectorModal from "./AttendeeSelectorModal/AttendeeSelectorModal";
import { PageStateType } from "../../../interface/Common/PageStateType";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import box from "../../../assets/Icon/box.svg";
import plus from "../../../assets/Icon/plus.svg";
import EvaluationTableComponent from "../../../components/EvaluationTable/EvaluationTableComponent";
import {
  TableArrayItemModifyTypeReq,
  TableArrayItemTypeReq,
} from "../../../interface/System/EvaluationTable/EvaluationTableTypes";
import EvaluationTableLocker from "../../../components/EvaluationTable/EvaluationTableLocker";
import close from "../../../assets/Icon/close.svg";
import DateUtils from "../../../utils/DateUtils";
import { DetailSection } from "../../../components/Detail/DetailSection";
import { useSendData } from "../../../modules/Server/QueryHook";
import { modifyEvaluationTableApi } from "../../../api/EvaluationTableApi";
import { putEvaluationUseTableModify } from "../../../api/EvaluationRoomApi";

interface EvaluationRoomDetailViewTypes {
  state: PageStateType;
  onPageMove: (page: number) => void;
  onRefetch: () => void;
  onReflesh: () => void;
  onSearchChange: (search: string) => void;
  onSearchRefetch: () => void;
  committerList: StepTwoCommitter[];
  companyList: StepTwoCompany[];
  pageInfo?: number;
  setErrorMessage: (data: IAlertModalDefault) => void;
  setAlertModal: (data: IAlertModalDefault) => void;
  onEvaluationRoomSetUp: (data: EvaluationRoomSetUp, type: string) => void;
  onEvaluationRoomRemove: (id: string) => void;
  stepTwoSearchModal: StepTwoSearchModal;
  setStepTwoSearchModal: (data: { type: string; isModal: boolean }) => void;
  evaluationTableModal: StepTwoSearchModal;
  paramsId: number;
  evaluationRoomInfo?: EvaluationRommSetupType;
  submitCheck: string;
  setSubmitCheck: (data: string) => void;
  type: "add" | "modify";
  searchedList: StepTwoCommitter[];
  changeName: (name: string) => void;
  setEvaluationTableModal: (data: { type: string; isModal: boolean }) => void;
  onModify: (data: TableArrayItemTypeReq) => void;
}

// 헤드 Current Step Info
function EvaluationRoomDetailView(props: EvaluationRoomDetailViewTypes) {
  const navigate = useNavigate();
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const params = useParams();

  const [tableData, setTableData] = useState<TableArrayItemTypeReq | TableArrayItemModifyTypeReq>();
  const [tableId, setTableId] = useState<number | null>();
  const [tableTitle, setTableTitle] = useState("");
  const [datarRenewal, setDataRenewal] = useState<boolean>(false);

  const [lockerStatus, setLockerStatus] = useState<"useLocker" | "noLocker" | "useLockerTemplete">(
    "noLocker"
  );

  const getTableData = (data: TableArrayItemTypeReq | TableArrayItemModifyTypeReq) => {
    setTableData(data);
    if (tableData) setDataRenewal(true);
  };

  const getTableId = (id: number) => {
    setTableId(id);
  };

  // 평가항목표 삭제 버튼 클릭 이벤트
  const onEvaluateTableDeleteClick = () => {
    setTableData(undefined);
    setTableTitle("");
    setTableId(null);
  };

  //   StepOne State ---------------------------------------------------------
  const {
    register, // input 과 연결해주는 객체
    setValue, // input의 값을 설정 가능한 메서드
    watch, // 실시간으로 input의 값을 확인하는 메서드
    reset,
    getValues,
  } = useForm<StepOneState>({
    defaultValues: {
      date: DateUtils.boardDateFormat(Date()),
    },
  });

  //   StepTwo State ---------------------------------------------------------
  const [stepTwoCommitter, setStepTwoCommitter] = useState<StepTwoCommitter[]>([]);
  const [stepTwoCompany, setStepTwoCompany] = useState<StepTwoCompany[]>([]);

  //  StepThree State ---------------------------------------------------------
  const [resFiles, setResFiles] = useState<any>([]);
  const [deleteFiles, setDeleteFiles] = useState<number[]>([]);
  const [files, setFiles] = useState<any[]>([]);
  const [notice, setNotice] = useState({
    committerNoticeContent: "",
    companyNoticeContent: "",
  });

  useEffect(() => {
    reset();
  }, []);

  // 평가방 아이디와 정보가 있을 경우 상태값 설정
  useEffect(() => {
    if (props.paramsId && props.evaluationRoomInfo) {
      setValue("businessName", props.evaluationRoomInfo.proposedProject);
      setValue("date", props.evaluationRoomInfo.evaluationAt);
      setValue("startTime", props.evaluationRoomInfo.startAt);
      setValue("endTime", props.evaluationRoomInfo.endAt);
      setStepTwoCommitter(props.evaluationRoomInfo.committer);
      setStepTwoCompany(props.evaluationRoomInfo.company);
      setResFiles(props.evaluationRoomInfo.evaluationFiles ?? []);
      setNotice({
        committerNoticeContent: props.evaluationRoomInfo.committerNoticeContent,
        companyNoticeContent: props.evaluationRoomInfo.companyNoticeContent,
      });
      setTableTitle(props?.evaluationRoomInfo?.evaluationTable?.title);
      // if (!tableId)
      setTableId(Number(props.evaluationRoomInfo.evaluationTable.id));
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [props.paramsId, props.evaluationRoomInfo]);

  //   StepTwo 컨트롤 영역 ---------------------------------------------------------
  //   검색 모달 열기
  const onStepTwoModal = (type: string, isModal: boolean) => {
    props.onRefetch();
    props.setStepTwoSearchModal({
      type,
      isModal,
    });
  };

  //   검색 모달 닫기
  const onStepTwoModalClose = () => {
    props.setStepTwoSearchModal({
      type: "",
      isModal: false,
    });
  };

  // 검색 모달에서 선택한 리스트 데이터 저장하기
  const onStepTwoSelectData = (array: StepTwoCommitter[]) => {
    setStepTwoCommitter((prev) => {
      let isDuplicate = false;
      prev.forEach((el) => {
        if (el.phone === array[0].phone) isDuplicate = true;
      });
      if (isDuplicate) {
        const a = prev.filter((el) => el.phone !== array[0].phone);
        return [...a, ...array];
      }
      return [...prev, ...array];
    });
    props.onSearchChange("");
  };

  const onStepTwoCompanySelectData = (array: StepTwoCompany[]) => {
    props.onReflesh();
    setStepTwoCompany(array);
  };

  // 선택한 리스트에서 제외
  // 평가위원
  const onCommitterException = (id: string) => {
    let array: StepTwoCommitter[] = [...stepTwoCommitter];
    let item = array.filter((i) => i.id !== id);
    setStepTwoCommitter(item);
  };
  // 제안업체
  const onCompanyException = (id: string) => {
    let array: StepTwoCompany[] = [...stepTwoCompany];
    let item = array.filter((i) => i.id !== id);
    setStepTwoCompany(item);
  };

  //   평가위원 정보 수정
  const onCommitterInfoModify = (e: React.ChangeEvent<HTMLInputElement>, id: string) => {
    const { name, checked } = e.target;

    let array: StepTwoCommitter[] = [...stepTwoCommitter];

    let data: StepTwoCommitter[] = [];

    if (name === "chairman") {
      data = array.map((i) =>
        i.id === id ? { ...i, chairman: checked } : { ...i, chairman: false }
      );
    }

    setStepTwoCommitter(data);
  };

  //   StepThree 컨트롤 영역 ---------------------------------------------------------
  // 파일 입력
  const onFiles = (e: any) => {
    let array: any[] = [...files];

    const data = array.concat(Array.from(e.target.files));

    setFiles(data);
  };
  // 저장된 파일 중 선택 제외
  const onFilesException = (id: number, type: string) => {
    // type이 new 일경우 id는 index, modify 일경우 id는 id
    if (type === "new") {
      if (files.length <= 0) {
        return;
      }
      let array = [...files];
      let item = Array.from(array).filter((i, idx) => idx !== id);
      setFiles(item);
    }
    if (type === "modify") {
      if (resFiles.length <= 0) {
        return;
      }
      let array = [...resFiles];
      let item = array.filter((i) => i.id !== id);

      let deleteArray = [...deleteFiles];
      deleteArray.push(id);

      setDeleteFiles(deleteArray);
      setResFiles(item);
    }
  };
  // 공지사항 입력
  const onNoticeInput = (text: string, type: string) => {
    setNotice((prev) => ({
      ...prev,
      [type]: text,
    }));
  };

  // 평가방 개설, 수정 ------------------------------------------------------------------------
  const onSubmit = () => {
    let data: EvaluationRoomSetUp = {
      id: props.paramsId ? props.paramsId : undefined,
      businessName: watch("businessName"),
      date: watch("date"),
      startTime: watch("startTime"),
      endTime: watch("endTime"),
      committer: stepTwoCommitter,
      company: stepTwoCompany,
      deleteFiles: deleteFiles,
      filse: files,
      committerNoticeContent: notice.committerNoticeContent,
      companyNoticeContent: notice.companyNoticeContent,
      createEvaluationTableDto: tableData as TableArrayItemTypeReq,
    };
    if (props.paramsId) {
      // 평가방 수정 요청
      props.onEvaluationRoomSetUp(data, "modify");
    } else {
      // 평가방 개설 요청
      props.onEvaluationRoomSetUp(data, "add");
    }
  };

  // 평가방 삭제 ------------------------------------------------------------------------
  const onDelete = () => {
    props.onEvaluationRoomRemove(props.paramsId.toString())
  }
  // 수정 및 개설 완료 모달
  useEffect(() => {
    if (!props.submitCheck) return;

    // 성공 했을 시 알림창
    if (props.submitCheck === "success") {
      props.setAlertModal({
        content: `평가방이 ${props.paramsId ? "수정" : "개설"}되었습니다.`,
        onClick: () => {
          onReset();
          navigate("/west/system/evaluation-room", { replace: true });
        },
        type: "check",
        isModal: true,
      });
    }
    if (props.submitCheck === "delete") {
      props.setAlertModal({
        content: `평가방이 삭제 되었습니다.`,
        onClick: () => {
          onReset();
          navigate("/west/system/evaluation-room", { replace: true });
        },
        type: "check",
        isModal: true,
      });
    }
    // // 실패 했을 시 알림창
    // if (props.submitCheck === "fail") {
    //   props.setAlertModal({
    //     content: `평가방 ${props.paramsId ? "수정" : "개설"} 실패하였습니다.\n다시 시도해 주세요.`,
    //     onClick: () => {},
    //     type: "check",
    //     isModal: true,
    //   });
    // }
  }, [props.submitCheck]);

  // 상태값 초기화
  const onReset = () => {
    // StepOne Reset
    reset({
      businessName: "",
      date: "",
      startTime: "",
      endTime: "",
    });

    // StepTwo Reset
    setStepTwoCommitter([]);
    setStepTwoCompany([]);

    // StepThree Reset
    setFiles([]);
    setNotice({
      committerNoticeContent: "",
      companyNoticeContent: "",
    });
  };

  //   하단 버튼 스탭진행 및 완료 버튼 ---------------------------------------------------------
  const onPrevNextStep = () => {
    // StepOne 예외처리

    if (!watch("businessName")) {
      props.setErrorMessage({
        isModal: true,
        content: "사업이름을 입력하세요.",
      });
      return;
    }
    const { date } = getValues();

    if (!date || !watch("startTime") || !watch("endTime")) {
      props.setErrorMessage({
        isModal: true,
        content: "평가일시를 입력해주세요.",
      });
      return;
    }

    const currentDate = new Date();
    const splitEvaluationRoomDate = watch("date").split("-");
    const evaluationRoomStartDate = new Date(
      splitEvaluationRoomDate.join(", ") + " " + watch("startTime")
    );
    const evaluationRoomEndDate = new Date(
      splitEvaluationRoomDate.join(", ") + " " + watch("endTime")
    );

    if (currentDate > evaluationRoomStartDate) {
      props.setErrorMessage({
        isModal: true,
        content: "현재 날짜 및 시간보다 이후의 날짜 및 시간을 입력해주세요.",
      });
      return;
    }
    if (evaluationRoomStartDate > evaluationRoomEndDate) {
      props.setErrorMessage({
        isModal: true,
        content: "평가방의 종료시간이 시작시간보다 빠릅니다.",
      });
      return;
    }
    if (
      (new Date(evaluationRoomEndDate).getTime() - new Date(evaluationRoomStartDate).getTime()) /
        (1000 * 60) <
      15
    ) {
      props.setErrorMessage({
        isModal: true,
        content: "평가 시간은 최소 15분 이상이어야 합니다.",
      });
      return;
    }

    const tes = new Date(`${splitEvaluationRoomDate.join(", ")} 23:59:59`);

    if (new Date(evaluationRoomEndDate) >= tes) {
      props.setErrorMessage({
        isModal: true,
        content: "종료 시간은 24시를 넘길 수 없습니다.",
      });
      return;
    }

    // 평가항목표 예외처리
    if (!tableData && !tableId) {
      props.setErrorMessage({
        isModal: true,
        content: "평가항목표를 등록하세요.",
      });
      return;
    }

    if (stepTwoCompany.length === 0 && props.paramsId) {
      props.setErrorMessage({
        isModal: true,
        content: "제안업체를 선택해주세요.",
      });
      return;
    }

    props.setAlertModal({
      content: `입력하신 내용으로 평가방을 ${props.paramsId ? "수정" : "개설"}하시겠습니까?`,
      onClick: onSubmit,
      isModal: true,
    });
    return;
  };

  const onDeleteStep = () => {
    props.setAlertModal({
      content: `평가방을 삭제 하시겠습니까?`,
      onClick: onDelete,
      isModal: true,
    });
    return;
  }

  const setSideBarCover = useSetRecoilState(sideBarCover);
  const setFooterZIndexControl = useSetRecoilState(footerZIndexControl);

  useEffect(() => {
    if (props.stepTwoSearchModal.isModal === true || props.evaluationTableModal.isModal === true) {
      setSideBarCover(true);
      setFooterZIndexControl(true);
    } else {
      setSideBarCover(false);
      setFooterZIndexControl(false);
    }
  }, [props.stepTwoSearchModal.isModal, props.evaluationTableModal.isModal, setSideBarCover, setFooterZIndexControl]);

  // 평가항목표 수정하기
  const evaluationTableInfoModify = useSendData<string, TableArrayItemModifyTypeReq>(
    lockerStatus === "noLocker" && tableId && !params.id
      ? modifyEvaluationTableApi
      : putEvaluationUseTableModify,
    {
      onSuccess: () => {
        setAlertModal({
          type: "check",
          isModal: true,
          content: "해당 평가항목표가 수정되었습니다.",
          onClick() {
            if (lockerStatus === "useLockerTemplete") {
              setLockerStatus("noLocker");
              if (!tableId) setTableId(Number(props.evaluationRoomInfo?.evaluationTable.id));
            }
            props.setEvaluationTableModal({ isModal: false, type: "new" });
            resetAlertModal();
          },
        });
        resetLoadingModal();
      },
    }
  );

  /** 평가항목표 수정하기
   * @data TableArrayItemTypeReq
   */
  const onModify = (data: TableArrayItemTypeReq) => {
    let item: TableArrayItemModifyTypeReq = {
      id: Number(data.id),
      list: data?.data,
      title: data?.title,
    };

    evaluationTableInfoModify.mutate(item);
  };

  return (
    <EvaluationRoomDetailViewBlock>
      <ViewObjectWrapperBox>
        <h1 className="viewTitle">{props.paramsId ? "평가방 수정" : "평가방 개설"}</h1>
        <div className="guideInfo">
          <ul>
            <li>* 기본정보 입력과 평가항목표 등록 후 평가방을 개설하실 수 있습니다.</li>
            <li>평가방 개설 및 저장 시 화상평가방 예약 일정 및 URL이 자동으로 생성됩니다.</li>
            <li>* 개설 완료 시 평가방 목록에 추가됩니다.</li>
            <li>
              * 평가방 수정을 통해 평가 시작 전까지 추가 사항 입력 및 내용을 수정을 하실 수
              있습니다.
            </li>
          </ul>
          <span>
            ( <span style={{ color: "#DA0043" }}>*</span> 은 필수 입력 항목입니다. )
          </span>
        </div>
        <div className="mainContent">
          <StepOne register={register} setValue={setValue} watch={watch} />
          <DetailSection>
            <DetailSection.Title>
              2. 평가항목표 등록<span style={{ color: "#DA0043", marginLeft: "-12px" }}>*</span>
              <span>
                아래의 버튼을 선택하여 본 평가에 사용할 평가항목표를 새로 만들거나 기존에 저장한
                평가항목표를 불러오기 할 수 있으며 편집과 삭제를 할 수 있습니다.
              </span>
            </DetailSection.Title>
            <div className="chart">
              <div className="chartButtons">
                <button
                  type="button"
                  onClick={() => props.setEvaluationTableModal({ isModal: true, type: "new" })}
                >
                  새로만들기 <img src={plus} alt="새로만들기 아이콘" />
                </button>
                <button
                  type="button"
                  onClick={() => props.setEvaluationTableModal({ isModal: true, type: "locker" })}
                >
                  보관함 <img src={box} alt="보관함 아이콘" />
                </button>
              </div>
              <DetailSection.InfoBlock labelText="선택한 평가항목표">
                <span
                  onClick={() => props.setEvaluationTableModal({ isModal: true, type: "modify" })}
                >
                  {tableData?.title || tableTitle}
                </span>
                {tableData?.title && (
                  <img src={close} alt="삭제" onClick={onEvaluateTableDeleteClick} />
                )}
              </DetailSection.InfoBlock>
              <span className="evaluationTableWarning">
                * 선택한 평가항목표의 수정 내용은 본 평가에만 적용됩니다. 다른 평가에도 이용을
                해야하는 경우 사이드 메뉴의 평가항목표에서 만들어 주세요.
              </span>
            </div>
          </DetailSection>
          <StepTwo
            committerList={stepTwoCommitter}
            companyList={stepTwoCompany}
            onStepTwoModal={onStepTwoModal}
            onChange={onCommitterInfoModify}
            onCommitterException={onCommitterException}
            onCompanyException={onCompanyException}
            onStepTwoSelectData={onStepTwoSelectData}
            searchedList={props.searchedList}
            changeName={props.changeName}
          />
          <StepThree
            onFilesException={onFilesException}
            resFiles={resFiles}
            onFiles={onFiles}
            files={files}
            onNoticeInput={onNoticeInput}
            notice={notice}
          />
        </div>
        <div className="btnWrap">
          <BigButton
            text="취소"
            white={true}
            onClick={() => navigate("/west/system/evaluation-room")}
          />
          <BigButton
            text={props.type === "add" ? "완료" : "수정"}
            onClick={() => onPrevNextStep()}
          />
          {
            props.type !== "add" && props.evaluationRoomInfo?.status === '평가 전' &&
            <BigButton
            text={ "삭제" }
            onClick={() => onDeleteStep()}
          />
          }
          
        </div>
      </ViewObjectWrapperBox>
      {props.stepTwoSearchModal.isModal && (
        <AttendeeSelectorModal
          stepTwoCommitter={stepTwoCommitter}
          stepTwoCompany={stepTwoCompany}
          onStepTwoSelectData={onStepTwoSelectData}
          onStepTwoCompanySelectData={onStepTwoCompanySelectData}
          onStepTwoModalClose={onStepTwoModalClose}
          stepTwoSearchModal={props.stepTwoSearchModal}
          onPageMove={props.onPageMove}
          committerList={props.committerList}
          companyList={props.companyList}
          state={props.state}
          onSearch={props.onRefetch}
          onReflesh={props.onReflesh}
          onSearchChange={props.onSearchChange}
          onSearchRefetch={props.onSearchRefetch}
          pageInfo={props.pageInfo}
        />
      )}
      {props.evaluationTableModal.isModal &&
        (props.evaluationTableModal.type === "new" ||
          props.evaluationTableModal.type === "modify") && (
          <EvaluationTableComponent
            onClose={() => {
              // setTableId(undefined);
              if (lockerStatus === "useLockerTemplete") {
                // setLockerStatus("noLocker");
                if (!tableId) setTableId(Number(props.evaluationRoomInfo?.evaluationTable.id));
              }
              props.setEvaluationTableModal({ isModal: false, type: "new" });
            }}
            roomOpenCheck={true}
            lockerStatus={lockerStatus}
            getTableData={getTableData}
            getTableId={getTableId}
            tableId={tableId}
            modifyCheck={props.evaluationTableModal.type === "modify" ? true : false}
            editCheck={lockerStatus === "useLockerTemplete" ? true : false}
            onModify={props.evaluationTableModal.type === "modify" ? onModify : undefined}
            newCheck={props.evaluationTableModal.type === "new" ? true : false}
            onOpenEvaluationRoomCheck={true}
          />
        )}
      {props.evaluationTableModal.isModal && props.evaluationTableModal.type === "locker" && (
        <EvaluationTableLocker
          onOpen={() => props.setEvaluationTableModal({ isModal: true, type: "modify" })}
          onClose={() => {
            props.setEvaluationTableModal({ isModal: false, type: "locker" });
          }}
          getTableId={getTableId}
          getTableData={getTableData}
          setLockerStatus={setLockerStatus}
        />
      )}
    </EvaluationRoomDetailViewBlock>
  );
}

export default EvaluationRoomDetailView;

const EvaluationRoomDetailViewBlock = styled.div`
  /* padding-bottom: ${theme.commonMargin.gap1}; */
  margin-bottom: 130px;

  .mainContent {
    margin-top: 20px;
  }

  .btnWrap {
    /* height: auto; */
    height: 100px;
    display: flex;
    justify-content: center;
    align-items: center;
    /* margin-top: ${theme.commonMargin.gap1}; */
    & > button:nth-child(1) {
      margin-right: ${theme.commonMargin.gap3};
    }
    & > button:nth-child(2) {
      margin-right: ${theme.commonMargin.gap3};
    }
  }
  .chart {
    & > .chartButtons {
      margin-bottom: 24px;
      display: flex;
      gap: 24px;
      & > button {
        width: 140px;
        height: 42px;
        padding: 11.5px 24px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        font-size: ${theme.fontType.subTitle1.fontSize};
        font-weight: ${theme.fontType.subTitle1.bold};
        background-color: ${theme.systemColors.systemPrimary};
        color: white;
        border-radius: 67px;
        &:last-child {
          background-color: #edeff4;
          color: ${theme.colors.body};
        }
      }
    }
    .evaluationTableWarning {
      display: block;
      margin-top: 8px;
      font-weight: 700;
      font-size: ${theme.fontType.contentTitle1.fontSize};
      color: ${theme.systemColors.closeTimer};
    }
  }
  .guideInfo {
    font-size: 12px;
    margin-top: 15px;
    color: ${theme.colors.gray3};
    & > ul {
      margin-bottom: 5px;
      & > li:nth-child(2) {
        text-indent: 7.6px;
      }
    }
    & > span {
      font-size: 13px;
    }
  }
  /* & button.headerBtn {
    display: flex;
    align-items: center;
    gap: 4px;
    margin-left: auto;
    padding: 4px 16px;
    color: white;
    background-color: ${theme.systemColors.systemPrimary};
    border-radius: 67px;
    > svg {
      > path {
        fill: white;
      }
    }
  }  */
`;
