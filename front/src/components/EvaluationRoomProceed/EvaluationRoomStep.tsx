import { useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import styled from "styled-components";
import ArrowRight from "../../assets/Icon/ArrowRight";
import {
  EvaluationCommitterScoreReqInterface,
  EvaluationRoomInfoTypes,
  EvaluationTableStatusInterface,
  ParticipantsListInterface,
} from "../../interface/System/EvaluationRoomProceed/EvaluationRoomProceedTypes";
import {
  TableArrayItemType,
  TableMutateListType,
} from "../../interface/System/EvaluationTable/EvaluationTableTypes";
import { userState } from "../../modules/Client/Auth/Auth";
import { alertModalState, contentModalState } from "../../modules/Client/Modal/Modal";
import theme from "../../theme";
import BigButton from "../Common/Button/BigButton";
import SmallButton2 from "../Common/Button/SmallButton2";
import EvaluationScoreTableComponent from "../EvaluationScoreTable/EvaluationScoreTableComponent";
import { TableDivisionEnumType } from "../EvaluationScoreTable/EvaluationTableComponentType";
import EvaluationSumScoreTableComponent, {
  EvaluationSumScoreTableType,
} from "../EvaluationSumScoreTable/EvaluationSumScoreTableComponent";
import FileViewer from "../Viewer/FileViewer";
import CommitterAgree from "./Modal/CommitterAgree";

// 평가사전준비 input interface
export interface evaluationReadyInput {
  isCheck: boolean;
  isCommitterAgree: boolean;
  agree1: boolean;
  agree2: boolean;
  agree3: boolean;
  isTermsCheck: boolean;
}

interface EvaluationRoomStepProps {
  setStepReady: () => void;
  selectFile?: string;
  selectFileName?: string;
  setWidthOrHeight?: (type: string) => void;
  authority: string;
  onFileViewer: boolean;
  setOnFileViewer: React.Dispatch<React.SetStateAction<boolean>>;
  step: number;
  setStep: (step: number) => void;
  summaryInfo: EvaluationSumScoreTableType[];
  onCompanyEvaluationTable: (id: number) => void;
  onMasterEvaluationCommitterScoreView: (committerId: number, companyId: number) => void;
  companyEvaluationTable: TableArrayItemType[];
  evaluationTableTitle: string;
  evaluationTableType: string;
  onSaveEvaluationScore: (scoreList: TableMutateListType[]) => void;
  onEvaluationScoreSubmit: () => void;
  onMasterEvaluationSubmitCheck: (committerId: number, status: string) => void;
  onEvaluationStartReq: () => void;
  evaluationRoomInfo: EvaluationRoomInfoTypes | null;
  committerScoreSubmissionStatus: EvaluationTableStatusInterface[];
  onEvaluationRoomOut: () => void;
  onEvaluationFinish: () => void;
  participantsListInfo: ParticipantsListInterface[];
  finalEvaluationTable: any | null;
  evaluationStartCheck: boolean;
  onScoreListDown: () => void;
  setSummaryInfoAllOpenCheck: (data: boolean) => void;
}

export default function EvaluationRoomStep(props: EvaluationRoomStepProps) {
  const alertModal = useSetRecoilState(alertModalState);
  const contentModalValue = useRecoilValue(contentModalState);
  const contentModal = useSetRecoilState(contentModalState);
  const resetContentModal = useResetRecoilState(contentModalState);
  const userData = useRecoilValue(userState);

  // 평가채점표 선택시 선택한 업체명
  const [selectCompanyInfo, setSelectCompanyInfo] = useState<string>("");

  // 평가완료 평가종료하기 버튼 state
  const [isFinished, setIsFinished] = useState(false);
  const changeIsFinished = () => {
    setIsFinished(true);
  };

  // 권한 확인 변수
  const isCompany = props.authority === "company";
  const isCommitter = props.authority === "committer";
  const isAdmin = props.authority === "admin";

  // 평가사전준비 input
  const { register, watch, setValue, getValues } = useForm<evaluationReadyInput>();

  useEffect(() => {
    setValue("agree1", false);
    setValue("agree2", false);
    setValue("agree3", false);
  }, [contentModalValue]);

  // 본인 확인 저장 버튼 클릭 이벤트
  const selfCheckClick = () => {
    setValue("isCheck", true);
    alertModal({
      isModal: true,
      content: "확인 완료 되었습니다.",
    });
  };
  // 평가위원 위촉 동의 확인 제출 버튼 클릭 이벤트
  const agreeClick = () => {
    if (!watch("isCheck")) {
      alertModal({
        isModal: true,
        content: "본인 확인을 완료해주세요.",
      });
      return;
    }
    contentModal({
      content: <CommitterAgree register={register} isCommitter={isCommitter} />,
      isModal: true,
      subText: "",
      title: "약관 동의",
      buttonText: "제출",
      onClick() {
        alertModal({
          isModal: true,
          content: "약관 동의 내용을 제출하시겠습니까?",
          onClick() {
            if (
              (isCommitter && (!watch("agree1") || !watch("agree2") || !watch("agree3"))) ||
              (isCompany && (!watch("agree1") || !watch("agree3")))
            ) {
              alertModal({
                isModal: true,
                content: "모든 약관에 동의해야 합니다.",
              });
              return;
            }
            alertModal({
              isModal: true,
              content: "정상적으로 제출되었습니다.",
              onClick() {
                resetContentModal();
                if (isCompany || isCommitter) {
                  props.setStepReady();
                  props.setStep(2);
                }
              },
              type: "check",
            });
          },
        });
      },
    });
  };

  const onIntegrityPledge = () => {
    if (!watch("isCheck")) {
      alertModal({
        isModal: true,
        content: "본인 확인을 완료해주세요.",
      });
      return;
    }
    if (!watch("isTermsCheck")) {
      alertModal({
        isModal: true,
        content: "약관 동의를 완료해주세요.",
      });
      return;
    }

    contentModal({
      content: <CommitterAgree register={register} isCommitter={isCommitter} />,
      isModal: true,
      subText: "",
      title: "청렴서약서",
      buttonText: "동의",
      onClick() {
        alertModal({
          isModal: true,
          content: "청렴서약서를 제출하시겠습니까?",
          onClick() {
            alertModal({
              isModal: true,
              content: "정상적으로 제출되었습니다.",
              onClick() {
                resetContentModal();
                props.setStepReady();
                props.setStep(2);
              },
              type: "check",
            });
          },
        });
      },
    });
  };

  // 전체 props.step 과정 변경 이벤트
  const changeStep = () => {};

  // 평가 수행 평가 버튼 클릭 이벤트
  const [onEvaluationTable, setEvaluationTable] = useState(false);
  const onEvaluationClick = (id: number, companyName: string) => {
    if (
      props.summaryInfo[0].status === "NOT_SUBMIT" ||
      props.summaryInfo[0].status === "REQUEST_MODIFY"
    ) {
      setEvaluationTable(true);
      props.onCompanyEvaluationTable(id);
      setSelectCompanyInfo(companyName);
    }
  };

  const onMasterEvaluationClick = (committerId: number, companyId: number, companyName: string) => {
    setEvaluationTable(true);
    setSelectCompanyInfo(companyName);
    props.onMasterEvaluationCommitterScoreView(committerId, companyId);
  };

  const onSave = () => {
    if (
      props.summaryInfo[0].status === "NOT_SUBMIT" ||
      props.summaryInfo[0].status === "REQUEST_MODIFY"
    )
      props.onEvaluationScoreSubmit();
  };

  // 모든 참석자가 존재하는 지 확인
  const checkAllUserAttend = () => {
    const noAttendedUsers = props.participantsListInfo.filter((el) => !el.checkIn && el.enable);

    const committerCheck = props.participantsListInfo.find((d) => d.committer);
    const companyCheck = props.participantsListInfo.find((d) => d.company);

    if (!committerCheck || !companyCheck) return false;

    if (props.participantsListInfo.length > 0) {
      if (noAttendedUsers.length === 0) return true;
      if (noAttendedUsers.length > 0) return false;
    } else {
      return false;
    }
  };

  // console.log(props.evaluationRoomInfo);

  const fileDown = () => {
    let data = props.finalEvaluationTable;
    let project = props.evaluationRoomInfo;

    const anchorElement = document.createElement("a");
    document.body.appendChild(anchorElement);
    anchorElement.download = `${project?.proposedProject ?? ""}_최종평가점수표_${
      project?.evaluationAt ?? ""
    }`; // a tag에 download 속성을 줘서 클릭할 때 다운로드가 일어날 수 있도록 하기
    anchorElement.href = data; // href에 url 달아주기

    anchorElement.click(); // 코드 상으로 클릭을 해줘서 다운로드를 트리거

    document.body.removeChild(anchorElement);
  };

  const onCompanyClose = () => {
    alertModal({
      isModal: true,
      content: "평가방을 종료하시겠습니까?",
      onClick() {
        window.close();
      },
    });
  };

  return (
    <EvaluationRoomStepContainer isCompany={isCompany}>
      {props.authority !== "admin" && (
        <div className={`headers ${isCompany && "three"}`}>
          <div className={`header ${props.step !== 0 && props.step !== 1 && "block"}`}>
            <span>STEP 01</span>
            <h3>평가사전준비</h3>
            <div className={`arrow ${props.step !== 0 && props.step !== 1 && "block"}`}></div>
          </div>
          <div className={`header ${props.step !== 0 && props.step !== 2 && "block"}`}>
            <span>STEP 02</span>
            <h3>검토 및 화상평가</h3>
            <div className={`arrow ${props.step !== 0 && props.step !== 2 && "block"}`}></div>
          </div>
          {props.authority !== "company" && (
            <div className={`header ${props.step !== 0 && props.step !== 3 && "block"}`}>
              <span>STEP 03</span>
              <h3>평가수행</h3>
              <div className={`arrow ${props.step !== 0 && props.step !== 3 && "block"}`}></div>
            </div>
          )}
          <div className={`header ${props.step !== 0 && props.step !== 4 && "block"}`}>
            <span>STEP 0{isCompany ? "3" : "4"}</span>
            <h3>평가완료</h3>
          </div>
        </div>
      )}
      {props.authority === "admin" && (
        <div className="headers three">
          <div className={`header ${props.step !== 0 && props.step !== 2 && "block"}`}>
            <span>STEP 01</span>
            <h3>검토 및 설정</h3>
            <div className={`arrow ${props.step !== 0 && props.step !== 2 && "block"}`}></div>
          </div>
          <div className={`header ${props.step !== 0 && props.step !== 3 && "block"}`}>
            <span>STEP 02</span>
            <h3>평가 결과 확인</h3>
            <div className={`arrow ${props.step !== 0 && props.step !== 3 && "block"}`}></div>
          </div>
          <div
            className={`header ${
              props.step !== 0 && props.step !== 4 && props.step !== 5 && "block"
            }`}
          >
            <span>STEP 03</span>
            <h3>평가 완료</h3>
            <div
              className={`arrow ${
                props.step !== 0 && props.step !== 4 && props.step !== 5 && "block"
              }`}
            ></div>
          </div>
        </div>
      )}
      {!isAdmin && props.step < 2 && (
        <div className="comments">
          <div>평가진행을 위한 본인확인과 정보 동의 및 제출을 진행하는 단계입니다.</div>
          <div>제안서 검토 및 화상평가를 진행하는 단계입니다.</div>
          {props.authority !== "company" && <div>평가를 수행하는 단계입니다.</div>}
          <div>모든 평가를 완료하는 단계입니다.</div>
        </div>
      )}
      {!isAdmin && props.step <= 1 && (
        <div className="steps">
          {props.step === 0 && (
            <div>
              <div className="info">
                <h3>01 {isCompany ? "업체정보" : "본인정보"} 확인</h3>
                <p>{isCompany ? "업체정보" : "본인정보"}를 확인합니다.</p>
              </div>
              <div className="info">
                <h3>02 약관 동의 및 제출</h3>
                <p>개인정보 이용 약관, 보안 각서 등을 제출합니다.</p>
              </div>
            </div>
          )}
          {/* 본인 정보 확인 STEP */}
          {props.step === 1 && (
            <div>
              <div className="info shortInfo">
                <h3>01 {isCompany ? "업체정보" : "본인정보"} 확인</h3>
              </div>
              {isCommitter && (
                <div className="selfAuth">
                  <div className="inputSet">
                    <label>이름</label>
                    <span>{userData.name}</span>
                  </div>
                  <div className="inputSet">
                    <label>생년월일</label>
                    <span>{userData.birth}</span>
                  </div>
                  <div className="inputSet">
                    <label>휴대폰 번호</label>
                    <span>{userData.phone}</span>
                  </div>
                  <SmallButton2
                    blue={!watch("isCheck")}
                    onClick={() => !watch("isCheck") && selfCheckClick()}
                    text={!watch("isCheck") ? "확인" : "확인 완료"}
                  />
                </div>
              )}
              {isCompany && (
                <div className="selfAuth">
                  <div className="inputSet">
                    <label>업체명</label>
                    <span>{userData.companyName}</span>
                  </div>
                  <div className="inputSet">
                    <label>담당자 이름</label>
                    <span>{userData.name}</span>
                  </div>
                  <div className="inputSet">
                    <label>담당자 전화번호</label>
                    <span>{userData.phone}</span>
                  </div>
                  <SmallButton2
                    blue={!watch("isCheck")}
                    onClick={() => !watch("isCheck") && selfCheckClick()}
                    text={!watch("isCheck") ? "확인" : "확인 완료"}
                  />
                </div>
              )}
              <div className="info shortInfo">
                <h3>02 약관 동의 및 제출</h3>
              </div>
              <div className="selfAuth">
                <h4>다음 항목의 동의 절차를 진행합니다. </h4>
                <p>* 개인정보 수집 및 이용 동의서 </p>
                {isCommitter && <p>* 평가위원 위촉</p>}
                <p>* 보안각서 동의서</p>
                <SmallButton2
                  blue={watch("isCheck") ? true : false}
                  onClick={() => watch("isCheck") && agreeClick()}
                  text={"약관동의 및 확인 제출"}
                />
              </div>
            </div>
          )}
          <div>
            <div className="info">
              <h3>01 제안서 검토</h3>
              <p>평가 전 제안서를 검토합니다.</p>
            </div>
            <div className="info">
              <h3>02 화상평가 진행</h3>
              <p>화상평가에 입장하여 제안업체의 발표와 질의응답을 진행합니다.</p>
            </div>
          </div>
          {props.authority !== "company" && (
            <div>
              <div className="info">
                <h3>01 평가수행</h3>
                <p>제안업체별 평가점수를 등록하고 평가점수를 제출합니다.</p>
              </div>
            </div>
          )}
          <div></div>

          {props.step === 0 && (
            <>
              <div className="bottomWrap">
                <p className="bottomInfoText">
                  위 내용을 확인 하신 후 아래의 <span>'평가 시작하기'</span> 버튼을 눌러주세요.
                  <br />
                  평가 시작하기 버튼을 클릭하면 다음으로 진행됩니다.
                </p>
                <button
                  onClick={() => {
                    props.setStep(1);
                  }}
                >
                  시작하기 <ArrowRight />
                </button>
              </div>
            </>
          )}
        </div>
      )}
      {props.step > 1 && (
        <div className="contents">
          {/* 평가사전검토 */}
          {props.step === 2 && (
            <>
              {props.onFileViewer && (
                <div className="fileViewier">
                  <FileViewer
                    selectFileName={props.selectFileName}
                    selectFile={props.selectFile}
                    setWidthOrHeight={props.setWidthOrHeight}
                  />
                  <div className="prevButtons">
                    <BigButton text="이전" onClick={() => props.setOnFileViewer(false)} />
                  </div>
                </div>
              )}
              {!props.onFileViewer && (
                <div className="evaluationInfo">
                  <div>
                    <h1>
                      {isCommitter && "평가위원"}
                      {isCompany && "제안업체 "}
                      {isAdmin && "서부 평가담당자"} 제안서평가 진행 순서 안내
                    </h1>
                    <p className="subInfo">- 아래의 내용을 숙지하신 후 순서대로 진행해 주세요 -</p>
                    <div className="contentWrap">
                      <div className="contentLeft">
                        <div>
                          <h2>1. 평가정보</h2>
                          <div>
                            {isAdmin && (
                              <ul>
                                <li>
                                  평가정보, 공지사항, 평가항목표 등 평가에 사용될 내용을 확인합니다.
                                </li>
                                <li>
                                  이상이 있을 경우 본 평가방 종료 후 평가방 리스트에서 정보 수정 후
                                  다시 입장해 주세요.
                                </li>
                                <li className="pointLi">
                                  ( * 평가 시작하기 버튼 클릭 후에는 평가 정보를 수정할 수
                                  없습니다.)
                                </li>
                              </ul>
                            )}
                            {!isAdmin && (
                              <ul>
                                <li>평가정보, 공지사항 등 내용을 확인합니다.</li>
                              </ul>
                            )}
                          </div>
                        </div>
                        {isAdmin && (
                          <>
                            <div>
                              <h2>2. 평가 시작하기</h2>
                              <div>
                                <ul>
                                  <li>
                                    준비가 완료되면 아래의{" "}
                                    <span className="emphasisSpan">[평가 시작하기]</span> 버튼을
                                    클릭해 주세요.
                                  </li>
                                  <li className="pointLi">
                                    ( * 이용할 수 있는 기능의 버튼들이 파랑색으로 활성화됩니다.)
                                  </li>
                                </ul>
                              </div>
                            </div>
                            <div>
                              <h2>3. 화상평가 입장</h2>
                              <div>
                                <ul>
                                  <li>
                                    왼쪽 메뉴의 <span className="emphasisSpan">[화상평가입장]</span>{" "}
                                    버튼을 클릭해 주세요.
                                  </li>
                                  <li>
                                    안내되는{" "}
                                    <span className="emphasisSpan">‘화상평가 이용 안내’</span>를
                                    숙지 후 webex를 실행해 주세요.
                                  </li>
                                </ul>
                              </div>
                            </div>
                            <div>
                              <h2>4. 제안서 검토 및 참석자 확인</h2>
                              <div>
                                <ul>
                                  <li>
                                    왼쪽 메뉴의 <span className="emphasisSpan">‘제안서 검토'</span>{" "}
                                    에서 확인이 필요한 파일을 클릭해 주세요.
                                  </li>
                                  <li>
                                    왼쪽 메뉴의 <span className="emphasisSpan">‘참석자'</span> 에서
                                    본 평가방의 참여 인원을 확인할 수 있습니다.
                                  </li>
                                </ul>
                              </div>
                            </div>
                          </>
                        )}

                        {(isCommitter || isCompany) && (
                          <>
                            <div>
                              <h2>2. 화상평가 입장</h2>
                              <div>
                                <ul>
                                  <li>
                                    왼쪽 메뉴의 <span className="emphasisSpan">[화상평가입장]</span>{" "}
                                    버튼을 클릭해 주세요.
                                  </li>
                                  <li>
                                    안내되는{" "}
                                    <span className="emphasisSpan">‘화상평가 이용 안내’</span>를
                                    숙지 후 화상평가에 입장합니다.
                                  </li>
                                  <li className="pointLi">
                                    * 원활한 평가 진행을 위해 평가담당자의 안내 시까지 화상 평가를
                                    종료하지 말아주세요.
                                  </li>
                                </ul>
                              </div>
                            </div>
                            {isCommitter && (
                              <div>
                                <h2>3. 제안서 검토 및 참석자 확인</h2>
                                <div>
                                  <ul>
                                    <li>
                                      왼쪽 메뉴의{" "}
                                      <span className="emphasisSpan">‘제안서 검토'</span> 에서
                                      확인이 필요한 파일을 클릭해 주세요.
                                    </li>
                                    <li>
                                      왼쪽 메뉴의 <span className="emphasisSpan">‘참석자'</span>{" "}
                                      에서 본 평가방의 참여 인원을 확인할 수 있습니다.
                                    </li>
                                  </ul>
                                </div>
                              </div>
                            )}
                            {isCompany && (
                              <div>
                                <h2>3. 참석자 확인</h2>
                                <div>
                                  <ul>
                                    <li>
                                      왼쪽 메뉴의 <span className="emphasisSpan">‘참석자'</span>{" "}
                                      에서 본 평가방의 참여 인원을 확인할 수 있습니다.
                                    </li>
                                  </ul>
                                </div>
                              </div>
                            )}
                          </>
                        )}
                      </div>
                      <div className="contentRight">
                        {isAdmin && (
                          <>
                            <div>
                              <h2>5. 발표시간/ 질의 응답 시간</h2>
                              <div>
                                <ul>
                                  <li>
                                    제안업체의 발표 진행 전 발표 및 질의 응답 시간을 설정해 주세요.
                                  </li>
                                  <li>
                                    발표 진행 시 <span className="emphasisSpan">[시작]</span>,{" "}
                                    <span className="emphasisSpan">[리셋]</span> 버튼으로
                                    조작합니다.
                                  </li>
                                </ul>
                              </div>
                            </div>
                            <div>
                              <h2>6. 평가 점수표 제출 현황</h2>
                              <div>
                                <ul>
                                  <li>평가위원들의 평가 점수표 제출 현황을 확인합니다.</li>
                                </ul>
                              </div>
                            </div>
                            <div>
                              <h2>7. 평가 결과 확인</h2>
                              <div>
                                <ul>
                                  <li>
                                    <span className="emphasisSpan">[확인]</span> 버튼을 클릭하여
                                    제출된 평가점수표를 확인합니다.
                                  </li>
                                </ul>
                              </div>
                            </div>
                            <div>
                              <h2>8 최종점수표 확인 및 평가종료</h2>
                              <div>
                                <ul>
                                  <li>
                                    모든 평가위원의 평가 점수표를 모두 확인 완료 후 버튼을 클릭
                                    하세요.
                                  </li>
                                  <li>최종점수표 확인 및 다운로드 후 평가를 종료합니다.</li>
                                </ul>
                              </div>
                            </div>
                          </>
                        )}

                        {(isCommitter || isCompany) && (
                          <>
                            <div>
                              <h2>4. 발표시간 / 질의 응답 시간</h2>
                              <div>
                                <ul>
                                  <li>제안업체의 발표 및 질의 응답 시간을 확인합니다.</li>
                                </ul>
                              </div>
                            </div>
                            {isCommitter && (
                              <>
                                <div>
                                  <h2>5. 평가 수행</h2>
                                  <div>
                                    <ul>
                                      <li>
                                        <span className="emphasisSpan">[평가하기]</span> 버튼을
                                        클릭하여 제안업체 별 평가를 진행합니다.
                                      </li>
                                    </ul>
                                  </div>
                                </div>
                                <div>
                                  <h2>6. 평가 종료</h2>
                                  <div>
                                    <ul>
                                      <li>
                                        평가담당자의 평가점수표 확인 완료 후 평가가 종료됩니다.
                                      </li>
                                    </ul>
                                  </div>
                                </div>
                              </>
                            )}
                            {isCompany && (
                              <div>
                                <h2>5. 평가 종료</h2>
                                <div>
                                  <ul>
                                    <li>
                                      평가 담당자의 평가 종료 및 퇴장 안내 시 상단의{" "}
                                      <span className="emphasisSpan">[종료]</span> 버튼을 클릭하여
                                      평가를 종료합니다.
                                    </li>
                                  </ul>
                                </div>
                              </div>
                            )}
                          </>
                        )}
                      </div>
                    </div>

                    {/* 평가위원장 
                    <div>
                      <h2>8. 평가 결과 확인</h2>
                      <p>- 1차 제출이 모두 완료되면 [확인]버튼이 활성화 됩니다.</p>
                      <p>- [확인] 버튼을 누르시면 전체 평가점수표를 확인하실 수 있습니다.</p>
                    </div>
                    */}
                    <p className="addInfo">
                      * 좌우 사이드 메뉴의 각 항목에 마우스 포인트를 가져가면 상세 도움말을 확인할
                      수 있습니다.
                    </p>
                  </div>
                  {isAdmin &&
                    props.evaluationRoomInfo?.status === "평가 전" &&
                    !props.evaluationStartCheck && (
                      <div className="evaluationStart">
                        <p className="bottomInfoText">
                          위 내용을 확인 하신 후 아래의 <span>'평가 시작하기'</span> 버튼을
                          눌러주세요.
                          <br />
                          평가 시작하기 버튼을 클릭하면 다음으로 진행됩니다.
                        </p>

                        <button type="button" onClick={props.onEvaluationStartReq}>
                          평가 시작하기 {"->"}
                        </button>
                        {/* {checkAllUserAttend() ? (
                          <button type="button" onClick={props.onEvaluationStartReq}>
                            평가 시작하기 {"->"}
                          </button>
                        ) : (
                          <button type="button" className="block">
                            참석자 대기중..
                          </button>
                        )} */}
                      </div>
                    )}
                  {isCompany && (
                    <button type="button" className="closeBtn" onClick={onCompanyClose}>
                      종료
                    </button>
                  )}
                </div>
              )}
            </>
          )}
          {/* 평가수행 */}
          {props.step === 3 && (
            <div className="evaluate">
              {/* 총 평가표 */}
              <div>
                <EvaluationSumScoreTableComponent
                  evaluationTableData={props.summaryInfo}
                  onEvaluationClick={onEvaluationClick}
                  onMasterEvaluationClick={onMasterEvaluationClick}
                  isAdmin={isAdmin}
                  onMasterEvaluationSubmitCheck={props.onMasterEvaluationSubmitCheck}
                  setSummaryInfoAllOpenCheck={props.setSummaryInfoAllOpenCheck}
                />
              </div>
              {/* 각 제안업체들의 평가표 */}
              {onEvaluationTable && (
                <EvaluationScoreTableComponent
                  onClose={() => setEvaluationTable(false)}
                  tableArray={props.companyEvaluationTable ?? []}
                  tableTitle={props.evaluationTableTitle}
                  tableDivision={props.evaluationTableType as TableDivisionEnumType}
                  titleType=""
                  companyName={selectCompanyInfo}
                  noSave={isAdmin}
                  isAdmin={isAdmin}
                  onSaveEvaluationScore={props.onSaveEvaluationScore}
                />
              )}
              {isCommitter && (
                <>
                  <div className="buttons">
                    <BigButton text="점수제출" onClick={onSave} />
                  </div>
                </>
              )}

              <div className="prevButtons">
                <BigButton
                  text="이전"
                  onClick={() => {
                    props.setOnFileViewer(false);
                    props.setStep(2);
                  }}
                />
              </div>
            </div>
          )}
          {/* 평가 완료 */}
          {((props.step === 4 && !isAdmin) || (props.step === 5 && isAdmin)) && (
            <div className="finish">
              <div>
                <p className="title">모든 평가가 완료되었습니다.</p>
                {isAdmin ? (
                  <>
                    <p className="text">
                      평가방 리스트에서 해당 평가방을 선택하면
                      <br />
                      요약정보와 최종점수표를 다시 확인할 수 있습니다.
                    </p>
                    <p className="title">수고하셨습니다</p>
                  </>
                ) : (
                  <>
                    <p className="text">
                      평가수당 지급을 위해 계좌이체거래약정서를 발급 받으려면
                      <br /> 아래의 버튼을 클릭하여 한국서부발전 계좌등록시스템을 이용할 수
                      있습니다.
                    </p>
                    <p className="title">감사합니다</p>
                  </>
                )}
              </div>
              {!isAdmin && (
                <BigButton
                  text="계좌등록시스템 바로가기"
                  onClick={() => {
                    window.open(process.env.REACT_APP_ACCOUNT_URL as string);
                    window.close();
                    // window.location.replace(process.env.REACT_APP_ACCOUNT_URL as string);
                  }}
                />
              )}
            </div>
          )}
          {props.step === 4 && isAdmin && (
            <div className="finish">
              <div className="finalAssessmentTable">
                <FileViewer
                  url={props.finalEvaluationTable}
                  setWidthOrHeight={props.setWidthOrHeight}
                />
              </div>
              <div className="btnBox">
                <button type="button" onClick={fileDown}>
                  최종 평가점수표 저장
                </button>
                <button type="button" onClick={props.onScoreListDown}>
                  평가위원 평가점수표 저장
                </button>
                <button
                  type="button"
                  onClick={() => {
                    props.onEvaluationFinish();
                  }}
                >
                  평가 종료
                </button>
              </div>
            </div>
          )}
        </div>
      )}
      {props.step === 1 && <div className="cover"></div>}
    </EvaluationRoomStepContainer>
  );
}

const EvaluationRoomStepContainer = styled.div<{ isCompany: boolean }>`
  display: flex;
  flex-direction: column;
  height: 100%;
  /* header */
  & > .headers {
    display: flex;
    &.three {
      & > .header {
        width: calc(100% / 3);
      }
    }
    & > .header {
      width: calc(100% / 4);

      height: 42px;
      padding: 16px 32px;
      position: relative;
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 24px;
      font-weight: 600;
      color: white;
      &.block {
        background-color: #e5e9eb !important;
        color: #a6afc4;
      }
      &:last-child {
        border-right: none;
      }
      & > h3 {
        font-size: 16px;
      }
      & > span {
        font-size: 15px;
      }
      & .arrow {
        position: absolute;
        width: 0;
        height: 0;
        right: -46px;
        z-index: 1;
        border-bottom: 21px solid transparent;
        border-top: 21px solid transparent;
        border-left: 21px solid black;
        border-right: 21px solid transparent;
        &.block {
          border-left: 25px solid #e5e9eb !important;
        }
      }
    }
  }
  & > .headers {
    > div {
      &:nth-child(1) {
        background-color: #7cb1f7;
        & .arrow {
          border-left: 25px solid #7cb1f7;
        }
      }
      &:nth-child(2) {
        background-color: #5499f5;
        & .arrow {
          border-left: 25px solid #5499f5;
        }
      }
      &:nth-child(3) {
        background-color: #2f80ed;
        & .arrow {
          border-left: 25px solid #2f80ed;
        }
      }
      &:nth-child(4) {
        background-color: #1e6ed9;
        & .arrow {
          border-left: 25px solid #1e6ed9;
        }
      }
      &:nth-child(5) {
        background-color: #0b59c1;
        & .arrow {
          border-left: 25px solid #0b59c1;
        }
      }
    }
  }
  & > .comments {
    display: flex;
    color: ${theme.systemColors.bodyLighter};
    font-weight: 500;
    font-size: 15px;
    & > div {
      width: calc(100% / ${(props) => (props.isCompany ? 3 : 4)});
      height: 132px;
      padding: 0px 24px;
      display: flex;
      justify-content: center;
      align-items: center;
    }
  }
  & .selfAuth {
    padding: 24px;
    display: flex;
    flex-direction: column;
    & button {
      width: 100%;
      padding: 8.5px 0px;
      margin-top: 16px;
      text-align: center;
    }
    & .inputSet {
      display: flex;
      align-items: center;
      margin-bottom: 16px;
      > label {
        width: 110px;
        color: #566476;
        font-weight: 500;
      }
      > span {
        width: 100%;
        height: 47px;
        flex: 1;
        display: flex;
        padding-left: 24px;
        align-items: center;
        color: #425061;
        background-color: ${theme.colors.blueGray2};
        border-radius: 5px;
        outline: none;
        border: 1px solid ${theme.colors.blueDeep};
        font-size: 13px;
      }
    }
    & h4 {
      font-size: 16px;
      font-weight: 500;
      color: #566476;
      margin-bottom: 16px;
    }
    & > p {
      font-size: 15px;
      color: ${theme.systemColors.bodyLighter};
    }
    &:last-child {
      button {
        margin-top: 32px;
      }
    }
  }
  & .cover {
    width: calc(100% - calc(100% / ${(props) => (props.isCompany ? 3 : 4)}));
    height: calc(100% - 42px);
    right: 0px;
    bottom: 0px;
    position: absolute;
    background-color: rgba(0, 0, 0, 0.8);
    z-index: 50;
  }
  & > .steps {
    position: relative;
    width: 100%;
    height: 100%;
    display: flex;
    & > div {
      width: calc(100% / ${(props) => (props.isCompany ? 3 : 4)});
    }
    & .info {
      padding: 16px 24px;
      margin-bottom: 48px;
      width: 100%;
      height: 137px;
      gap: 24px;
      display: flex;
      flex-direction: column;
      color: white;
      & > h3 {
        font-weight: 600;
        font-size: 18px;
      }
      & p {
        font-weight: 500;
        font-size: 15px;
      }
      &.shortInfo {
        height: 54px;
        display: flex;
        margin: 0;
      }
    }
    & > .bottomWrap {
      position: absolute;
      width: 1000px;

      bottom: 120px;
      left: 50%;
      gap: 20px;
      transform: translateX(-50%);
      text-align: center;

      & > button {
        margin: 0 auto;
        width: 333px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 8px;
        color: white;

        padding: 16px 0px;
        background-color: ${theme.partnersColors.primary};
        box-shadow: 0px 3px 22px -1px rgba(0, 0, 0, 0.15);
        & path {
          stroke: white;
        }
      }
    }
    & > div:nth-child(1) {
      & .info {
        background-color: #5499f5;
      }
    }
    & > div:nth-child(2) {
      & .info {
        background-color: #2f80ed;
      }
    }
    & > div:nth-child(3) {
      & .info {
        background-color: #1e6ed9;
      }
    }
    & > div:nth-child(4) {
      & .info {
        background-color: #5499f5;
      }
    }
  }
  /* 상세 단계별 내용 */
  & > .contents {
    color: ${theme.colors.body};
    min-height: calc(100% - 42px);
    /* 이전 버튼  */
    & .prevButtons {
      position: absolute;
      /* z-index: 30; */
      top: 69px;
      right: 16px;
      border-radius: 5px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      & > button {
        width: 80px;
        height: 40px;
      }
    }
  }
  .evaluationInfo {
    padding: 40px;
    padding-top: ${(props) => (props.isCompany ? "100px" : "40px")};
    padding-bottom: 0;
    height: 100%;
    position: relative;
    max-width: 1286px;
    margin: 0 auto;
    & > div {
      &:first-child {
        /* padding: 32px; */
        /* width: max-content; */
        /* width: 100%; */
        height: max-content;
        margin: 0 auto;
        padding: 32px 56px;
        display: flex;
        flex-direction: column;
        border: 1px solid ${theme.colors.blueGray1};
        border-radius: 8px;
        color: ${theme.colors.body2};
        font-size: 13px;
        & > div {
          margin-bottom: 12px;
          display: flex;
          flex-direction: column;
          /* gap: 2px; */
        }
        & h1 {
          font-weight: 700;
          font-size: 20px;
          color: ${theme.partnersColors.primary};
          text-align: center;
          margin-bottom: 20px;
          text-decoration: underline;
        }
        & h2 {
          font-size: 15px;
          font-weight: 700;
        }
        & .contentWrap {
          content: "";
          width: 100%;
          height: auto;

          padding: 20px;
          margin-top: 20px;
          display: flex;
          flex-direction: row;
          justify-content: space-between;
          /* align-items: center; */
          & > div {
            width: calc(100% / 2);
            min-height: 340px;
            padding: 10px 34px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
            & > div {
              width: 100%;
              & > h2 {
                margin-bottom: 4px;
              }
              & > div {
                width: 100%;
                height: auto;
                margin-bottom: 20px;
                & > ul {
                  width: 100%;
                  display: inline-block;
                  list-style-type: disc;
                  padding-left: 21px;
                  /* background-color: pink; */
                  & > li {
                    text-indent: 4px;
                    font-size: 0.8rem;
                    & > .emphasisSpan {
                      color: ${theme.systemColors.systemFont};
                      font-weight: 900 !important;
                    }
                  }
                  & > .pointLi {
                    list-style-type: none;
                    color: ${theme.systemColors.closeTimer};
                  }
                }

                & > p {
                  font-size: 12px;
                  color: ${theme.colors.gray};
                }
              }
            }
          }
          & > .contentRight {
            border-left: 1px solid ${theme.colors.blueGray1};
          }
        }
        .subInfo {
          font-size: 16px;
          /* line-height: 173.02%; */
          text-align: center;
          font-weight: 900;
          color: ${theme.colors.red};
          & > span {
            font-size: 14px;
            /* font-weight: bold !important; */
            /* font-weight: 900; */
            color: #333;
          }
        }
        & .addInfo {
          margin-top: 30px;
          color: ${theme.systemColors.closeTimer};
          font-size: 16px;
          font-weight: 900;
          text-align: center;
        }
      }
    }
    & .evaluationStart {
      width: 100%;
      margin-top: 40px;
      display: flex;
      flex-direction: column;
      align-items: center;

      & > button {
        width: 300px;
        height: 48px;
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
        box-shadow: 0px 3px 22px -1px rgba(0, 0, 0, 0.15);
        &.block {
          background-color: ${theme.colors.gray4};
          border: 0;
        }
      }
    }
    & > .closeBtn {
      position: absolute;
      top: 40px;
      right: 40px;
      width: 100px;
      height: 40px;
      background-color: black;
      border-radius: 5px;
      display: flex;
      justify-content: center;
      align-items: center;
      color: #fff;
    }
  }
  /* 평가사전검토 */
  .fileViewier {
    position: relative;
    width: 100%;
    height: 100%;
    & p {
      cursor: pointer;
      margin-bottom: 10px;
    }
  }
  /* 평가수행 */
  .evaluate {
    position: relative;
    max-width: 1286px;
    margin: 0 auto;
    & > div:not(.prevButtons) {
      width: 100%;
      & > section {
        & > div {
          min-height: auto;
          box-shadow: none;
          border-radius: 0px;
        }
      }
    }
    & .buttons {
      /* margin-top: 20px; */
      /* padding-right: 30px; */
      display: flex;
      justify-content: center;
      &.admin {
        margin-top: 24px;
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        & > div {
          display: flex;
          gap: 16px;
          & > button {
            width: 109px;
            padding: 8px 0px;
            text-align: center;
            &:first-child {
              background-color: ${theme.colors.red};
            }
          }
        }
        & > p {
          margin-top: 2px;
          &.red {
            color: ${theme.colors.red};
          }
          &.blue {
            color: ${theme.partnersColors.primary};
          }
        }
      }
    }
    & .prevButtons {
      top: 30px;
      right: 30px;
    }
  }
  /* 평가완료 */
  .finish {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    position: relative;
    & > div {
      width: 676px;
      height: 299px;
      padding: 48px 24px;
      border: 1px solid ${theme.colors.blueGray1};
      border-radius: 18px;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      gap: 32px;
      color: ${theme.colors.body2};
      & > .text {
        text-align: center;
      }
      & > .title {
        font-weight: 700;
        font-size: 24px;
        margin-bottom: 20px;
        color: ${theme.partnersColors.primary};
        &:last-child {
          color: ${theme.colors.body2};
        }
      }
    }
    & > button {
      width: 275px;
      height: 54px;
      margin-top: 108px;
    }

    /* 평가담당자 최종평가점수표 */
    & > .finalAssessmentTable {
      width: 600px;
      height: 830px;
      border: 0;
      border-radius: 0;
      padding: 0;
    }
    & > .btnBox {
      width: 234px;
      height: auto;
      border: 0;
      border-radius: 0;
      position: absolute;
      top: 26px;
      right: 32px;
      justify-content: space-between;
      padding: 0;
      gap: 0;
      & > button {
        padding: 0;
        width: 100%;
        height: 40px;
        border-radius: 5px;
        text-align: center;
        color: #fff;
        background-color: ${theme.partnersColors.primary};
        margin-bottom: 10px;
        &:nth-child(3) {
          background-color: ${theme.colors.red};
        }
      }
    }
  }

  .finalTable {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    position: relative;
    & > h1 {
      text-align: center;
      margin-top: 24px;
    }
    & > button {
      position: absolute;
      top: 30px;
      right: 30px;
      padding: 8.5px 0px;
      width: 234px;
      height: 40px;
      background-color: ${theme.partnersColors.primary};
      color: white;
      text-align: center;
      border-radius: 5px;
    }
  }

  .bottomInfoText {
    border: 2px solid ${theme.colors.gray5};

    padding: 10px;
    border-radius: 8px;
    margin-bottom: 30px;
    color: ${theme.partnersColors.primary};
    font-size: 24px;
    text-align: center;
    & > span {
      font-weight: 900;
    }
  }
`;
