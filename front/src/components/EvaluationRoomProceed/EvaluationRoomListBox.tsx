import { Fragment, useEffect, useState } from "react";
import styled from "styled-components";
import {
  AttendeeListTypes,
  EvaluationRoomInfoTypes,
  EvaluationTableStatusInterface,
  ParticipantsListInterface,
} from "../../interface/System/EvaluationRoomProceed/EvaluationRoomProceedTypes";
import theme from "../../theme";
import GradeCheckUtils from "../../utils/GradeCheckUtils";
import WithdrawalIcon from "./../../assets/Icon/withdrawal.svg";
import EvaluationRoomInfoLayout from "./EvaluationRoomInfoLayout/EvaluationRoomInfoLayout";

interface EvaluationRoomListBoxTypes {
  role: string;
  title: string;
  type: string;
  attendeeList?: AttendeeListTypes[];
  onExit?: (id: number) => void;
  selectFile?: string;
  onFileSelect?: (url: string, fileName?: string) => void;
  evaluationRoomInfo?: EvaluationRoomInfoTypes | null;
  selectFocus: (type: string) => void;
  selectFocusType: string;
  focusType: string;
  direction?: string;
  stepReady?: boolean;
  categoryNum?: number;
  committerScoreSubmissionStatus?: EvaluationTableStatusInterface[];
  participantsListInfo?: ParticipantsListInterface[];
  onWithdrawal?: (disableUserId: number) => void;
  evaluationStartCheck?: boolean;
}

type EvaluationRoomListBoxBlockType = {
  type: string;
};

function EvaluationRoomListBox(props: EvaluationRoomListBoxTypes) {
  const [fileSelectNumber, setFileSelectNumber] = useState<string>("");

  const onFileSelect = (url: string, fileName: string) => {
    if (props.onFileSelect) props.onFileSelect(url, fileName);
  };

  useEffect(() => {
    setFileSelectNumber(props.selectFile ?? "");
  }, [props.selectFile]);

  return (
    <EvaluationRoomInfoLayout
      title={props.title}
      selectFocus={props.selectFocus}
      focusType={props.focusType}
      selectFocusType={props.selectFocusType}
      direction={props.direction}
      stepReady={props.stepReady}
      categoryNum={props.categoryNum}
    >
      <EvaluationRoomListBoxBlock type={props.type}>
        {/* {props.type === "attendee" && (
        <div className="title">
          <div>평가위원장</div>
          <div>{props.evaluationRoomInfo?.committerChairMan}</div>
        </div>
      )} */}
        <div className="content">
          {/* <div className={props.type === "grade" ? "grade" : ""}>
            {props.title}
          </div> */}
          {props.type === "attendee" && (
            <div className="attendeeContent">
              {props.participantsListInfo &&
                props.participantsListInfo.map((data, index) => (
                  <Fragment key={index}>
                    {data.committer && !data.company && (
                      <ul>
                        <li className={data.checkIn && data.enable ? "entrance" : "isNonSelect"}>
                          {data.committer.name} {data.committer.isMe && "(본인)"}
                        </li>
                        <li className={data.checkIn && data.enable ? "entrance" : "isNonSelect"}>
                          {!data.checkIn && data.enable ? (
                            <span
                              onClick={() =>
                                data.committer &&
                                props.onWithdrawal &&
                                props.onWithdrawal(Number(data.committer.id))
                              }
                            >
                              {props.role === "admin" && props.evaluationStartCheck && (
                                <>
                                  {/* <img src={WithdrawalIcon} alt="" /> */}
                                  <span className="kick">퇴장</span>
                                </>
                              )}
                            </span>
                          ) : (
                            <></>
                          )}
                        </li>
                      </ul>
                    )}
                    {!data.committer && data.company && (
                      <ul>
                        <li className={data.checkIn && data.enable ? "entrance" : "isNonSelect"}>
                          {data.company.name} {data.company.isMe && "(본인)"}
                        </li>
                        <li className={data.checkIn && data.enable ? "entrance" : "isNonSelect"}>
                          {data.checkIn && data.enable ? (
                            // <span
                            //   onClick={() =>
                            //     props.onWithdrawal &&
                            //     props.onWithdrawal(Number(data.evaluationUserid))
                            //   }
                            // >
                            //   {props.role === "admin" && <img src={WithdrawalIcon} alt="" />}
                            // </span>
                            <></>
                          ) : (
                            <>{"입장 전"}</>
                          )}
                        </li>
                      </ul>
                    )}
                  </Fragment>
                ))}
              {/* {props.attendeeList &&
                props.attendeeList.map((data, index) => (
                  <ul key={index}>
                    {props.role === "admin" && (
                      <li
                        className={`${data.status !== "entrance" && "isNonSelect"} ${
                          data.status === "exit" && "isExit"
                        }`}
                      >
                        {data.name} ({RoleUtils.isAuthorityTypeCheck(data.type)})
                      </li>
                    )}
                    {props.role !== "admin" && (
                      <li
                        className={`${data.status !== "entrance" && "isNonSelect"} ${
                          data.status === "exit" && "isExit"
                        }`}
                      >
                        {RoleUtils.isAuthorityTypeCheck(data.type)} {data.id}
                      </li>
                    )}
                    {props.role === "admin" && (
                      <li
                        className={data.status !== "entrance" ? "isNonSelect" : ""}
                        onClick={() => {
                          if (props.onExit) props.onExit(data.id);
                        }}
                      >
                        {data.status !== "before" ? "퇴장" : "입장 중"}
                      </li>
                    )}
                  </ul>
                ))} */}
            </div>
          )}
          {props.type === "fileList" && (
            <div className="fileListContent">
              {props.evaluationRoomInfo?.evaluationFiles.map((i) => (
                <ul key={i.id}>
                  <li
                    className={`${fileSelectNumber === i.fileUrl && "isSelect"}`}
                    onClick={() => onFileSelect(i.fileUrl, i.fileName)}
                  >
                    {i.fileName}
                  </li>
                </ul>
              ))}
            </div>
          )}
          {props.type === "grade" && (
            <div className="gradeContent">
              {props.committerScoreSubmissionStatus &&
                props.committerScoreSubmissionStatus.map((data, index) => (
                  <Fragment key={index}>
                    <ul>
                      {props.role === "admin" && <li>{data.committer.name}</li>}
                      {/* {props.role !== "admin" && (
                          <li>
                            {RoleUtils.isAuthorityTypeCheck(data.type)} {data.id}
                          </li>
                        )} */}
                      <li
                        className={GradeCheckUtils.isSubmitClassNameCheck(
                          data.evaluationTableStatus ?? ""
                        )}
                      >
                        {GradeCheckUtils.isSubmitCheck(data.evaluationTableStatus ?? "")}
                        {/* {data.evaluationTableStatus} */}
                      </li>
                    </ul>
                  </Fragment>
                ))}
            </div>
          )}
        </div>
      </EvaluationRoomListBoxBlock>
    </EvaluationRoomInfoLayout>
  );
}

export default EvaluationRoomListBox;

const EvaluationRoomListBoxBlock = styled.div<EvaluationRoomListBoxBlockType>`
  width: 100%;
  height: auto;

  & > .title {
    width: 100%;
    height: 48px;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    margin-bottom: ${theme.commonMargin.gap4};
    & > div {
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
      border: 1px solid ${theme.partnersColors.primary};
      box-sizing: border-box;
      font-size: ${theme.fontType.subTitle3.fontSize};
    }
    /* & > div:nth-child(1) {
      width: 104px;
      background-color: ${theme.partnersColors.primary};
      color: ${theme.colors.white};
    } */
    & > div:nth-child(1) {
      flex: 1;
    }
  }
  & > .content {
    width: 100%;
    height: auto;
    border: 1px solid ${theme.colors.gray4};
    border-radius: ${theme.commonRadius.radius1};
    overflow: hidden;
    box-sizing: border-box;
    /* & > div:nth-child(1) {
      width: 100%;
      height: 48px;
      background-color: ${theme.partnersColors.primary};
      color: ${theme.colors.white};
      font-size: ${theme.fontType.subTitle3.fontSize};
      display: flex;
      justify-content: center;
      align-items: center;
    } */

    & > div:nth-child(1) {
      padding: ${theme.commonMargin.gap4};
      width: 100%;
      /* height: ${(props) =>
        props.type === "attendee"
          ? "250px"
          : props.type === "grade"
          ? "183px"
          : props.type === "fileList"
          ? "220px"
          : ""}; */
      height: 100px;
      overflow-y: auto;
      &::-webkit-scrollbar {
        display: none;
      }
      & > ul {
        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: ${theme.commonMargin.gap4};
        & > li {
          cursor: default;
          font-size: 12px;
          & > span {
            & > .kick {
              color: #fff;
              cursor: pointer;
              /* border: 1px solid black; */
              padding: 2px 4px;
              border-radius: 4px;
              background-color: ${theme.systemColors.closeTimer};
            }
          }
        }
        & > li:nth-child(2) {
          width: 40px;
          text-align: right;
          color: ${theme.partnersColors.primary};
          cursor: pointer;
        }
      }
    }

    & > div.fileListContent {
      & > ul {
        & > li {
          cursor: pointer;
        }
      }
    }

    & > div.grade {
      padding: 0 ${theme.commonMargin.gap4};
      /* display: flex;
      justify-content: space-between;
      align-items: center; */
    }

    & > div.gradeContent {
      & > ul {
        & > li:nth-child(2) {
          width: auto;
          cursor: default;
          color: ${theme.colors.gray4};
        }
        & > li.isActive {
          color: ${theme.partnersColors.primary};
        }
        & > li.firstSubmit {
          color: ${theme.colors.green};
        }
        & > li.requestModify {
          color: ${theme.systemColors.closeTimer};
        }
      }
    }
  }
  .isNonSelect {
    color: ${theme.colors.gray4} !important;
    cursor: default !important;
  }
  .isExit {
    text-decoration: line-through;
  }
  .isSelect {
    color: ${theme.partnersColors.primary};
    font-weight: ${theme.fontType.body.bold};
  }
`;
