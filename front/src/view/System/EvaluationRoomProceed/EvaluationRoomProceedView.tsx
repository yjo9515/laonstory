import { useEffect, useRef, useState } from "react";
import styled from "styled-components";
import EvaluationRoomListBox from "../../../components/EvaluationRoomProceed/EvaluationRoomListBox";
import EvaluationRoomInfo from "../../../components/EvaluationRoomProceed/EvaluationRoomInfo";
import theme from "../../../theme";
import EvaluationRoomTime from "../../../components/EvaluationRoomProceed/EvaluationRoomTime";
import {
  AttendeeListTypes,
  COM,
  EvaluationCommitterScoreReqInterface,
  EvaluationRoomInfoTypes,
  EvaluationTableStatusInterface,
  ParticipantsListInterface,
} from "../../../interface/System/EvaluationRoomProceed/EvaluationRoomProceedTypes";
import { useLocation } from "react-router";
import { IAlertModalDefault } from "../../../modules/Client/Modal/Modal";
import EvaluationRoomInfoLayout from "../../../components/EvaluationRoomProceed/EvaluationRoomInfoLayout/EvaluationRoomInfoLayout";
import { infoContent } from "./EvaluationRoomContentInfo";
import logo from "../../../assets/Logo/logoBlue.svg";
import EvaluationRoomStep from "../../../components/EvaluationRoomProceed/EvaluationRoomStep";
import { EvaluationSumScoreTableType } from "../../../components/EvaluationSumScoreTable/EvaluationSumScoreTableComponent";
import {
  TableArrayItemType,
  TableMutateListType,
} from "../../../interface/System/EvaluationTable/EvaluationTableTypes";
import { BlockChain } from "../../../components/Common/Loading/Loading";
import failIcon from "../../../assets/Icon/fail.svg";
import BigButton from "../../../components/Common/Button/BigButton";
import EvaluationScoreTableComponent from "../../../components/EvaluationScoreTable/EvaluationScoreTableComponent";
import EvaluationWebexStepModal from "../../../components/EvaluationRoomProceed/EvaluationWebexStepModal";
import { TableDivisionEnumType } from "../../../components/EvaluationScoreTable/EvaluationTableComponentType";
interface EvaluationRoomProceedViewTypes {
  role: string;
  evaluationRoomInfo: EvaluationRoomInfoTypes | null;
  authority: string;
  onNotice: () => void;
  onTime: () => void;
  evaluationRoomStatus: { announcement: string; inquiry: string };
  attendeeList: AttendeeListTypes[];
  onExit: (id: number) => void;
  setAlertModal: (data: IAlertModalDefault) => void;
  resetAlertModal: () => void;
  onCloseEvaluationRoom: () => void;
  roomOpenCheck: boolean;
  summaryInfo: EvaluationSumScoreTableType[];
  onEvaluationStartReq: () => void;
  onCompanyEvaluationTable: (id: number) => void;
  onMasterEvaluationCommitterScoreView: (committerId: number, companyId: number) => void;
  companyEvaluationTable: TableArrayItemType[];
  evaluationTableTitle: string;
  evaluationTableType: string;
  onSaveEvaluationScore: (scoreList: TableMutateListType[]) => void;
  step: number;
  setStep: (step: number) => void;
  evaluationCompleteLoading: "loading" | "success" | "fail" | "";
  setEvaluationCompleteLoading: React.Dispatch<
    React.SetStateAction<"" | "loading" | "success" | "fail">
  >;
  setSummaryInfoAllOpenCheck: (data: boolean) => void;
  onEvaluationScoreSubmit: () => void;
  stepReady: boolean;
  setStepReady: () => void;
  onMasterEvaluationSubmitCheck: (committerId: number, status: string) => void;
  onEvaluationStateClick: () => void;
  committerScoreSubmissionStatus: EvaluationTableStatusInterface[];
  participantsListInfo: ParticipantsListInterface[];
  onWithdrawal: (disableUserId: number) => void;
  committerInfo: COM | null;
  onEvaluationRoomOut: () => void;
  onEvaluationFinish: () => void;
  onEvaluationTableView: (check: boolean) => void;
  evaluationTableModalCheck: boolean;
  evaluationTableInfo: TableArrayItemType[] | null;
  finalEvaluationTable: any | null;
  evaluationStartCheck: boolean;
  onScoreListDown: () => void;
  onCommitterKickOutModal: (fn: Function) => void;
  evaluationTableDivision: string;
}

type EvaluationRoomProceedViewBlockType = {
  widthOrHeight?: string;
  authority?: string;
  screenWidth?: string;
};

function EvaluationRoomProceedView(props: EvaluationRoomProceedViewTypes) {
  const location = useLocation();

  const [focusType, setFocusType] = useState<string>("");
  const [focusInfo, setFocusInfo] = useState<string>("");

  const [selectFile, setSelectFile] = useState<string>("");
  const [selectFileName, setSelectFileName] = useState<string>("");
  const [onFileViwer, setOnFileViewer] = useState(false);
  const [widthOrHeight, setWidthOrHeight] = useState<string>("width");
  const [webexOpenCheck, setWebexOpenCheck] = useState<boolean>(false);
  const [webexGuideModal, setWebexGuideModal] = useState<boolean>(false);
  const [submissionStatus, setSubmissionStatus] = useState<boolean>(false);

  const [scoreFailStatus, setScoreFailStatus] = useState<boolean>(false);

  const [internalAccessCheck, setInternalAccessCheck] = useState<"OUTSIDE" | "INTERNAL">("OUTSIDE");

  // 평가위원 시점 단계별 조건 추가 - 단계별로 버튼 활성화 유무에 대한 조건을 반환함
  const getCommitterStepCondition = (fn: () => void) => {
    if (props.authority !== "admin" && !props.stepReady) return;
    // console.log(props.authority);
    // console.log(props.stepReady);
    fn();
  };

  const onFileSelect = (url: string, fileName?: string) => {
    props.setStep(2);
    setOnFileViewer(true);
    setSelectFile(url);
    if (fileName) setSelectFileName(fileName);
  };
  
  useEffect(() => {
    if (
      props.evaluationRoomInfo?.evaluationFiles &&
      props.evaluationRoomInfo.evaluationFiles.length > 0 &&
      !selectFile
    ) {
      setSelectFile(props.evaluationRoomInfo.evaluationFiles[0].fileUrl);
    }
  }, [props.evaluationRoomInfo?.evaluationFiles]);

  useEffect(() => {
    if (props.committerScoreSubmissionStatus) {
      let item = props.committerScoreSubmissionStatus.find(
        (d) => d.evaluationTableStatus !== "NOT_SUBMIT"
      )
        ? true
        : false;

      setSubmissionStatus(item);
    }
  }, [props.committerScoreSubmissionStatus]);

  useEffect(() => {
    if (process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL") {
      setInternalAccessCheck(process.env.REACT_APP_SOURCE_DISTRIBUTE);
      setWebexOpenCheck(true);
    }
  }, []);

  // useEffect(() => {
  //   if (!scoreFailStatus) {
  //     if (props.evaluationCompleteLoading === "fail") {
  //       setScoreFailStatus(true);
  //     }
  //   }
  // }, [props.evaluationCompleteLoading]);

  const onFocusType = (type: string) => {
    if (type === "info") setFocusInfo(infoContent.info);
    if (type === "start") setFocusInfo(infoContent.startTime);
    if (type === "reset") setFocusInfo(infoContent.resetTime);
    if (type === "attendee") setFocusInfo(infoContent.attendee);
    if (type === "fileList") setFocusInfo(infoContent.fileList);
    if (type === "grade") setFocusInfo(infoContent.grade);
    if (type === "meeting") setFocusInfo(infoContent.meeting);
    if (type === "totalGradeAdmin") setFocusInfo(infoContent.totalGradeAdmin);
    if (type === "totalGradeUser") setFocusInfo(infoContent.totalGradeUser);
    if (type === "gradeStatus") setFocusInfo(infoContent.gradeStatus);
    if (type === "assessment") setFocusInfo(infoContent.assessment);
    if (!type) setFocusInfo("");
    setFocusType(type);
  };

  const onFocusClose = () => {
    setFocusInfo("");
    setFocusType("");
  };

  const onTextCopy = (text: string, title: string) => {
    if (window.navigator.clipboard !== undefined) {
      window.navigator.clipboard
        .writeText(text)
        .then(() => {
          props.setAlertModal({
            isModal: true,
            content: `${title} 복사 되었습니다.`,
          });
        })
        .catch((e) => {
          // console.log(e);
        });
    } else {
      // execCommand 사용
      const textArea = document.createElement("textarea");
      textArea.value = `${text}`;
      document.body.appendChild(textArea);
      textArea.select();
      textArea.setSelectionRange(0, 99999);
      try {
        document.execCommand("copy");
        props.setAlertModal({
          isModal: true,
          content: `${title} 복사 되었습니다.`,
        });
      } catch (err) {
        console.error("복사 실패", err);
      }
      textArea.setSelectionRange(0, 0);
      document.body.removeChild(textArea);
      // alert("텍스트가 복사되었습니다.");
    }
  };

  const internalWebexNotUseModal = () => {
    props.setAlertModal({
      isModal: true,
      content: `화상평가 입장은 인터넷 환경에서만 이용하실 수 있습니다.\n인터넷 환경에서 다시 접속 후 진행해 주세요.`,
    });
  };

  const centerBoxRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    window.addEventListener("resize", () => {
      const d = document.body.offsetWidth;
      const scrennWidth = Number(window.screen.width);
      if (d >= 1280 && d <= 1920) {
        const item = Math.round((Number(d) / scrennWidth) * 100);

        if (centerBoxRef.current) {
          if (item > 70 && item <= 100) {
            centerBoxRef.current.style.transform = `scale(${item / 100})`;
            centerBoxRef.current.style.transformOrigin = "left top";
            centerBoxRef.current.style.overflow = "none";
          } else {
            centerBoxRef.current.style.overflow = "auto";
          }
        }
      }
    });
    return () => {
      window.removeEventListener("resize", () => console.log(""));
    };
  });

  return (
    <>
      <EvaluationRoomProceedViewBlock widthOrHeight={widthOrHeight}>
        <div className="header">
          <img src={logo} alt="로고" />          
        </div>
        <div className="content" ref={centerBoxRef}>
          <div className="leftBox">
            {/* 평가 정보 */}
            <EvaluationRoomInfo
              evaluationRoomInfo={props.evaluationRoomInfo}
              infoText={infoContent.info}
              selectFocus={onFocusType}
              focusType="info"
              selectFocusType={focusType}
              direction={"left"}
              categoryNum={0}
              stepReady={props.stepReady}
            />

            <>
              <div className="leftBtnBox">
                {/* 공지사항 버튼 */}
                <div onClick={props.onNotice}>공지사항</div>
                {props.authority === "admin" && (
                  <div className="timeSetting" onClick={() => props.onEvaluationTableView(true)}>
                    평가항목표
                  </div>
                )}
              </div>
              {/* 참석자 */}
              <div className="wrapCover">
                {/* 화상회의 URL */}
                <EvaluationRoomInfoLayout
                  title="화상평가 정보"
                  focusType="meeting"
                  selectFocusType={focusType}
                  selectFocus={onFocusType}
                  direction={"left"}
                  categoryNum={1}
                  stepReady={props.stepReady}
                >
                  <div className="rightUrlBox">
                    {/* <div
                      style={{ cursor: "pointer" }}
                      className="password"
                      onClick={() =>
                        getCommitterStepCondition(() =>
                          navigator.clipboard.writeText(
                            props.evaluationRoomInfo?.meetingPassword as string
                          )
                        )
                      }
                    >
                      <span>평가방 번호</span>
                      <p>{props.authority === "admin" ? "00000" : "00000"}</p>
                      <div
                        className="copyBtn"
                        onClick={() =>
                          onTextCopy(
                            String(
                              props.authority === "admin" ? "평가담당자" : props.committerInfo?.name
                            ),
                            "내 이름이"
                          )
                        }
                      >
                        복사
                      </div>
                    </div> */}
                    {props.authority !== "admin" && (
                      <div
                        style={{ cursor: "pointer" }}
                        className="password"
                        onClick={() =>
                          getCommitterStepCondition(() =>
                            navigator.clipboard.writeText(props.committerInfo?.name as string)
                          )
                        }
                      >
                        <span>내 이름</span>
                        <p>
                          {props.authority === "admin" ? "평가담당자" : props.committerInfo?.name}
                        </p>
                        <div
                          className="copyBtn"
                          onClick={() =>
                            onTextCopy(
                              String(
                                props.authority === "admin"
                                  ? "평가담당자"
                                  : props.committerInfo?.name
                              ),
                              "내 이름이"
                            )
                          }
                        >
                          복사
                        </div>
                      </div>
                    )}
                    <div
                      style={{ cursor: "pointer" }}
                      className="password"
                      onClick={() =>
                        getCommitterStepCondition(() =>
                          navigator.clipboard.writeText(
                            props.evaluationRoomInfo?.meetingPassword as string
                          )
                        )
                      }
                    >
                      <span>미팅 비밀번호</span>
                      <p>{props.evaluationRoomInfo?.meetingPassword}</p>
                      <div
                        className="copyBtn"
                        onClick={() =>
                          onTextCopy(
                            String(props.evaluationRoomInfo?.meetingPassword),
                            "미팅 비밀번호가"
                          )
                        }
                      >
                        복사
                      </div>
                    </div>
                    <div
                      className={props.step > 1 ? "" : "nonSelect"}
                      onClick={() => {
                        if (props.evaluationStartCheck) {
                          if (props.step > 1) {
                            if (internalAccessCheck === "INTERNAL") {
                              internalWebexNotUseModal();
                            }

                            if (internalAccessCheck === "OUTSIDE") {
                              setWebexOpenCheck(true);
                              setWebexGuideModal(true);
                            }
                          }
                        }
                      }}
                    >
                      <span>화상평가입장</span>
                      {/* {props.authority !== "admin" ? (
                        <span>화상평가입장</span>
                      ) : (
                        <>
                          {props.stepReady ? (
                            <a
                              href={props.evaluationRoomInfo?.meetingUrl}
                              target="_blank"
                              rel="noreferrer"
                            >
                              화상평가입장
                            </a>
                          ) : (
                            <span>화상평가입장</span>
                          )}
                        </>
                      )} */}
                    </div>
                  </div>
                </EvaluationRoomInfoLayout>
                {props.authority !== "company" && (
                  <EvaluationRoomListBox
                    title="제안서 검토"
                    type={"fileList"}
                    evaluationRoomInfo={props.evaluationRoomInfo}
                    role={props.authority}
                    selectFile={selectFile}
                    onFileSelect={onFileSelect}
                    focusType={"fileList"}
                    selectFocusType={focusType}
                    selectFocus={onFocusType}
                    direction={"left"}
                    categoryNum={2}
                    stepReady={props.stepReady}
                  />
                )}
                <EvaluationRoomListBox
                  title="참석자"
                  type={"attendee"}
                  evaluationRoomInfo={props.evaluationRoomInfo}
                  role={props.authority}
                  attendeeList={props.attendeeList}
                  onExit={props.onExit}
                  focusType={"attendee"}
                  selectFocusType={focusType}
                  selectFocus={onFocusType}
                  direction={"left"}
                  categoryNum={3}
                  stepReady={props.stepReady}
                  participantsListInfo={props.participantsListInfo}
                  onWithdrawal={props.onWithdrawal}
                  evaluationStartCheck={props.evaluationStartCheck}
                />

                {(!props.evaluationStartCheck ||
                  (props.authority === "admin" && props.step > 3)) && (
                  <div className="blurWrap"></div>
                )}
              </div>
            </>
          </div>
          <div className="centerBox">
            <EvaluationRoomStep
              setStepReady={props.setStepReady}
              selectFile={selectFile}
              selectFileName={selectFileName}
              setWidthOrHeight={setWidthOrHeight}
              authority={props.authority}
              onFileViewer={onFileViwer}
              setOnFileViewer={setOnFileViewer}
              summaryInfo={props.summaryInfo}
              onCompanyEvaluationTable={props.onCompanyEvaluationTable}
              onMasterEvaluationCommitterScoreView={props.onMasterEvaluationCommitterScoreView}
              companyEvaluationTable={props.companyEvaluationTable}
              evaluationTableTitle={props.evaluationTableTitle}
              evaluationTableType={props.evaluationTableType}
              onSaveEvaluationScore={props.onSaveEvaluationScore}
              step={props.step}
              setStep={props.setStep}
              onEvaluationScoreSubmit={props.onEvaluationScoreSubmit}
              onMasterEvaluationSubmitCheck={props.onMasterEvaluationSubmitCheck}
              onEvaluationStartReq={props.onEvaluationStartReq}
              evaluationRoomInfo={props.evaluationRoomInfo}
              committerScoreSubmissionStatus={props.committerScoreSubmissionStatus}
              onEvaluationRoomOut={props.onEvaluationRoomOut}
              onEvaluationFinish={props.onEvaluationFinish}
              participantsListInfo={props.participantsListInfo}
              finalEvaluationTable={props.finalEvaluationTable}
              evaluationStartCheck={props.evaluationStartCheck}
              onScoreListDown={props.onScoreListDown}
              setSummaryInfoAllOpenCheck={props.setSummaryInfoAllOpenCheck}
            />
            {props.authority === "committer" && (
              <>
                {props.evaluationCompleteLoading === "loading" && (
                  <div className="evaluationCompleteLoading">
                    <BlockChain />
                    <p className="">
                      평가담당자가 결과를 확인하고 있습니다.
                      <br /> 확인 완료까지 다소 시간이 걸릴 수도 있으니
                      <br /> 잠시만 기다려 주시기를 바랍니다.
                    </p>
                  </div>
                )}
                {props.step === 3 && props.evaluationCompleteLoading === "success" && (
                  <div className="evaluationCompleteLoading success">
                    <p className="">
                      제출하신 평가 점수표가 확인 완료되었습니다.
                      <br /> 아래의 확인 버튼을 누르면 평가가 종료됩니다.
                    </p>
                    <BigButton text="확인" onClick={() => props.setStep(4)} />
                  </div>
                )}
                {props.evaluationCompleteLoading === "fail" && !scoreFailStatus && (
                  <div className="evaluationCompleteLoading fail">
                    <img src={failIcon} alt="" />
                    <p className="">
                      점수 수정 요청이 있습니다. <br />
                      수정 후 다시 한번 점수 제출을 해주세요.
                    </p>
                    <BigButton
                      text="확인"
                      onClick={() => {
                        setScoreFailStatus(true);
                        props.setEvaluationCompleteLoading("");
                        props.setStep(3);
                      }}
                    />
                  </div>
                )}
              </>
            )}
            {/* <div className={`focusInfoText ${focusInfo && "view"}`}>
         {focusInfo}
         <span onClick={onFocusClose}>
           <HiOutlineX />
         </span>
       </div> */}
          </div>
          <div className={`rightBox ${!props.stepReady && "blur"}`}>
            <div className="rightScrollWrap">
              {/* 발표 시간 */}
              <EvaluationRoomTime
                role={props.authority}
                authority={props.authority}
                evaluationRoomStatus={props.evaluationRoomStatus}
                setAlertModal={props.setAlertModal}
                resetAlertModal={props.resetAlertModal}
                infoText={{ start: infoContent.startTime, reset: infoContent.resetTime }}
                selectFocus={onFocusType}
                focusType={{ start: "start", reset: "reset" }}
                selectFocusType={focusType}
                direction={"right"}
                onTime={props.onTime}
                stepReady={props.stepReady}
                evaluationRoomInfo={props.evaluationRoomInfo}
              />
              {props.authority === "committer" && (
                <EvaluationRoomInfoLayout
                  title="평가 수행"
                  focusType="assessment"
                  selectFocusType={focusType}
                  selectFocus={onFocusType}
                  direction={"right"}
                  stepReady={props.stepReady}
                  categoryNum={6}
                >
                  <button
                    className={
                      !props.evaluationStartCheck || props.step <= 1 ? "webexOpenNoCheck" : ""
                    }
                    onClick={() => {
                      if (props.evaluationStartCheck && props.step > 1) props.setStep(3);
                      // props.setStep(3);
                    }}
                  >
                    평가하기
                  </button>
                </EvaluationRoomInfoLayout>
              )}
              {/* 평가 점수표 제출 현황 */}
              {props.authority === "admin" && (
                <EvaluationRoomListBox
                  title="평가점수표 제출현황"
                  type={"grade"}
                  role={props.authority}
                  attendeeList={props.attendeeList}
                  focusType={"grade"}
                  selectFocusType={focusType}
                  selectFocus={onFocusType}
                  direction={"right"}
                  stepReady={props.stepReady}
                  committerScoreSubmissionStatus={props.committerScoreSubmissionStatus}
                  categoryNum={7}
                />
              )}
              {/* 최종평가 점수표 */}
              {props.authority === "admin" && (
                <EvaluationRoomInfoLayout
                  title="평가결과확인"
                  focusType="totalGradeAdmin"
                  selectFocusType={focusType}
                  selectFocus={onFocusType}
                  direction={"right"}
                  stepReady={props.stepReady}
                  categoryNum={8}
                >
                  <div className="totalGrade">
                    {/* <div>최종평가점수표</div> */}
                    <button
                      type="button"
                      className={!submissionStatus ? "noSubmission" : ""}
                      onClick={() => {
                        if (
                          (props.evaluationRoomInfo?.status !== "평가 전" ||
                            props.evaluationStartCheck) &&
                          submissionStatus
                        )
                          props.onCommitterKickOutModal(() => props.setStep(3));
                      }}
                    >
                      확인
                    </button>
                  </div>
                </EvaluationRoomInfoLayout>
              )}
              {props.authority === "admin" && props.step < 4 && (
                <EvaluationRoomInfoLayout
                  title="평가상태"
                  focusType="gradeStatus"
                  selectFocusType={focusType}
                  selectFocus={onFocusType}
                  direction={"right"}
                  stepReady={props.stepReady}
                  categoryNum={9}
                >
                  <div className={`totalGrade ${!props.roomOpenCheck && "isClose"}`}>
                    <div onClick={props.onEvaluationStateClick}>최종점수표 확인 및 평가종료</div>
                  </div>
                </EvaluationRoomInfoLayout>
              )}
            </div>
            {(!props.evaluationStartCheck || (props.authority === "admin" && props.step > 3)) && (
              <div className="blurWrap"></div>
            )}
          </div>
        </div>
        {/* <div className="footer">
     <p>copyright(c)2019 Korea Western Power co.,Ltd.All Rights Reserved.</p>
   </div> */}
      </EvaluationRoomProceedViewBlock>
      {props.evaluationTableModalCheck && props.evaluationTableInfo && (
        <>
          <EvaluationScoreTableComponent
            tableArray={props.evaluationTableInfo}
            tableTitle={props.evaluationRoomInfo?.evaluationTable.title ?? ""}
            titleType={"미리보기"}
            onClose={() => props.onEvaluationTableView(false)}
            noSave={true}
            tableDivision={
              (TableDivisionEnumType.DIVISION_SCORE === props.evaluationTableDivision &&
                TableDivisionEnumType.DIVISION_SCORE) ||
              (TableDivisionEnumType.DIVISION_SUITABLE === props.evaluationTableDivision &&
                TableDivisionEnumType.DIVISION_SUITABLE) ||
              TableDivisionEnumType.DIVISION_UNSELECT
            }
            onlyView
          />
        </>
      )}
      {webexGuideModal && (
        <EvaluationWebexStepModal
          role={props.authority}
          url={String(props.evaluationRoomInfo?.meetingUrl)}
          onClose={() => setWebexGuideModal(false)}
        />
      )}
    </>
  );
}

export default EvaluationRoomProceedView;

const EvaluationRoomProceedViewBlock = styled.div<EvaluationRoomProceedViewBlockType>`
  width: 100%;
  height: 100%;
  overflow: auto;

  & *::-webkit-scrollbar {
    width: 8px;
    height: 10px;
    background-color: ${(props) => props.theme.colors.gray6};
    border-radius: 55px;
    left: 8px;
  }
  & *::-webkit-scrollbar-thumb {
    width: 8px;
    height: 10px;
    background-color: ${(props) => props.theme.colors.gray4};
    border-radius: 55px;
    cursor: pointer;
  }
  & > .header {
    /* min-width: 1850px; */
    min-width: 1280px;
    height: 42px;
    padding: 0px 40px;
    display: flex;
    align-items: center;
    border-bottom: 1px solid ${theme.colors.blueGray1};
    > img {
      display: block;
      width: 200px;
    }
  }
  & > .content {
    /* min-width: 1850px; */
    min-width: 1280px;
    height: calc(100% - 42px);
    display: flex;
    margin: 0 auto;
    /* overflow: auto; */
    & > div {
      /* overflow-y: auto; */
      &::-webkit-scrollbar {
        width: 8px;
        background-color: ${(props) => props.theme.colors.gray6};
        border-radius: 55px;
        left: 8px;
      }
      &::-webkit-scrollbar-thumb {
        width: 8px;
        background-color: ${(props) => props.theme.colors.gray4};
        border-radius: 55px;
      }
    }
    & > .leftBox {
      position: relative;
      width: 282px;
      min-height: 906px;
      height: inherit;
      border-right: 1px solid ${theme.colors.blueGray1};
      & > .wrapCover {
        position: relative;
        & > .blurWrap {
          height: 100%;
        }
      }
      & .leftBtnBox {
        width: 100%;
        display: flex;
        justify-content: center;
        gap: 16px;
        padding: ${theme.commonMargin.gap3};
        border-top: 1px solid ${theme.colors.gray4};
        border-bottom: 1px solid ${theme.colors.gray4};
        background-color: #fff;
        margin-bottom: 0;
        & > div {
          width: 100%;
          padding: 8px 14px;
          background-color: ${theme.partnersColors.primary};
          cursor: pointer;
          display: flex;
          justify-content: center;
          align-items: center;
          font-size: ${theme.fontType.subTitle3.fontSize};
          font-weight: ${theme.fontType.subTitle3.bold};
          color: ${theme.colors.white};
          border-radius: 5px;
          transition: ease-in-out;
          transition-duration: 0.1s;
        }
        & > div:hover {
          background-color: ${theme.partnersColors.primaryHover};
        }
      }
      .rightUrlBox {
        width: 100%;
        /* border: 1px solid ${theme.partnersColors.primary}; */
        box-sizing: border-box;
        & > div {
          display: flex;
          justify-content: flex-start;
          align-items: center;
        }
        & > .password {
          font-size: 12px;
          margin-bottom: 8px;
          display: flex;
          justify-content: space-between;
          align-items: center;

          & > span {
            color: ${theme.colors.gray3};
            /* font-size: ${theme.fontType.body.fontSize}; */
            font-size: 12px;
            font-weight: ${theme.fontType.body.bold};
            margin-right: ${theme.commonMargin.gap4};
            width: 90px;
          }
          & > p {
            text-align: left;
            display: inline-block;
            flex: 1;
          }
          & > .copyBtn {
            font-size: 12px;
            padding: 0px 10px;
            border: 1px solid ${theme.partnersColors.primary};
            border-radius: 10px;
            color: ${theme.partnersColors.primary};
            cursor: pointer;
            &:hover {
              color: #fff;
              background-color: ${theme.partnersColors.primary};
            }
          }
        }
        & > div:last-child {
          width: 100%;
          height: 46px;
          display: flex;
          justify-content: center;
          align-items: center;
          border: 1px solid ${theme.partnersColors.primary};
          box-sizing: border-box;
          font-size: ${theme.fontType.subTitle3.fontSize};
          background-color: ${theme.partnersColors.primary};
          border-radius: ${theme.commonRadius.radius1};
          margin-top: ${theme.commonMargin.gap3};
          transition: ease-in-out;
          transition-duration: 0.1s;
          cursor: pointer;
          & > a,
          span {
            color: #fff;
          }
          &:hover {
            background-color: ${theme.partnersColors.primaryHover};
          }
        }
        /* & > div:nth-child(1) {
          height: 30px;
        } */
      }
    }
    & > .rightBox {
      width: 282px;
      min-height: 906px;
      height: inherit;
      border-left: 1px solid ${theme.colors.blueGray1};
      position: relative;
      & > .rightScrollWrap {
        width: 100%;
        height: auto;
        .webexOpenNoCheck {
          /* color: #0058a2;
          border: 1px solid #0058a2;
          background-color: white; */
          background-color: ${theme.colors.gray4};
        }
      }
      .totalGrade {
        width: 100%;
        height: 48px;
        display: flex;
        justify-content: flex-start;
        align-items: center;
        margin-bottom: ${theme.commonMargin.gap4};
        & > div,
        a,
        span {
          width: 100%;
          height: 100%;
          display: flex;
          justify-content: center;
          align-items: center;
          border: 1px solid ${theme.partnersColors.primary};
          box-sizing: border-box;
          font-size: ${theme.fontType.subTitle3.fontSize};
          background-color: ${theme.partnersColors.primary};
          border-radius: ${theme.commonRadius.radius1};
          transition: ease-in-out;
          transition-duration: 0.1s;
          color: white;
        }
        /* & > div:nth-child(1) {
        width: 120px;
        background-color: ${theme.partnersColors.primary};
        color: ${theme.colors.white};
      } */
        & > a:nth-child(1),
        div:nth-child(1) {
          flex: 1;
          color: ${theme.colors.white};
          cursor: pointer;
        }
        & > div:nth-child(1) {
          background-color: #000;
        }
        & > a:hover {
          border: 1px solid ${theme.partnersColors.primaryHover};
          background-color: ${theme.partnersColors.primaryHover};
        }
        & > div:hover {
          border: 1px solid ${theme.colors.red};
          background-color: ${theme.colors.red};
        }

        .noSubmission {
          background-color: ${theme.colors.gray4};
        }
      }

      .isClose {
        & > div {
          border: 0 !important;
          background-color: ${theme.colors.body2} !important;
        }
      }
      & .blurWrap {
        height: 891px;
      }
    }
    & > .centerBox {
      /* width: calc(1920px - 565px); */

      min-height: 906px;
      height: 100%;
      flex: 1;
      position: relative;
      overflow: auto;
      & > .evaluationInfo {
        overflow-y: scroll;
        /* background-color: red; */
        padding: 40px 0;
        & > div {
          width: 827px;
          height: max-content;
          margin: 0 auto;
          /* margin-top: 40px; */
          padding: 32px 56px;
          display: flex;
          flex-direction: column;
          border: 1px solid ${theme.colors.blueGray1};
          border-radius: 8px;
          color: ${theme.colors.body2};
          font-size: 14px;
          & > div {
            margin-bottom: 20px;
          }
          & h1 {
            margin-bottom: 18px;
            font-weight: 700;
            font-size: 21px;
          }
          & h2 {
            font-weight: 700;
            font-size: 16px;
          }
          & p,
          h2 {
            /* line-height: 31.14px; */
            line-height: 26px;
          }
          & .addInfo {
            margin-top: 24px;
            color: ${theme.systemColors.pointColor};
            font-size: 18px;
            font-weight: 700;
          }
        }
      }
      & > .evaluationCompleteLoading {
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
        background-color: rgba(0, 0, 0, 0.7);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        position: absolute;
        z-index: 80;
        &.success {
          & > button {
            border: 0;
            color: #fff;
            background-color: ${theme.partnersColors.primary};
          }
        }
        &.fail {
          & > button {
            background-color: #fff;
            color: ${theme.partnersColors.primary};
          }
        }
        & > p {
          margin-top: 20px;
          color: white;
          white-space: pre-line;
          font-weight: 700;
          font-size: 20px;
          line-height: 173.02%;
          text-align: center;
        }
        & > button {
          margin-top: 40px;
          width: 234px;
          height: 40px;
          border-radius: 5px;
        }
      }
      & > .closeRoom {
        color: ${theme.colors.gray4};
      }
      & > .focusInfoText {
        width: 500px;
        height: 100px;
        background-color: #ffffcc;
        border: 2.5px solid #ebd400;
        transition: ease-in-out;
        transition-duration: 0.2s;
        position: fixed;
        bottom: -110px;
        left: 50%;
        transform: translateX(-50%);
        border-radius: 15px;
        box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.15);
        display: flex;
        justify-content: center;
        align-items: center;
        white-space: pre-wrap;
        text-align: center;
        font-size: 16px;
        line-height: 22px;
        & > span {
          position: absolute;
          top: 10px;
          right: 10px;
          color: ${theme.colors.gray3};
          cursor: pointer;
        }
      }
      & > .view {
        bottom: 50px;
      }
      & > .fileViewer {
        height: 100%;
      }
    }
  }
  & > .footer {
    width: 100%;
    height: 42px;
    position: fixed;
    bottom: 0px;
    left: 0px;
    border-top: 1px solid ${theme.colors.blueGray1};
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: ${theme.fontType.body.fontSize};
    font-weight: ${theme.fontType.body.bold};
    color: ${theme.colors.gray4};
    background-color: #fff;
  }
  & .blurWrap {
    position: absolute;
    top: 0px;
    left: 0px;
    width: 100%;
    z-index: 20;
    background-color: rgba(255, 255, 255, 0.4);
    backdrop-filter: blur(2px);
  }

  .evaluationStartBtn {
    width: 100%;
    margin-top: 40px;
    display: flex;
    justify-content: center;
    align-items: center;
    & > button {
      width: 333px;
      height: 48px;
      background-color: ${theme.partnersColors.primary};
      color: #fff;
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: ${theme.fontType.subTitle3.fontSize};
      border-radius: ${theme.commonRadius.radius1};
    }
  }

  .nonSelect {
    background-color: ${theme.colors.gray4} !important;
    border: 0 !important;
  }
`;
