import styled from "styled-components";
import { notice } from "../../controllers/System/EvaluationRoomProceed/EvaluationRoomProceed";
import TextareaSet from "../Common/Input/Textarea";

interface EvaluationRoomNoticeProps {
  readOnly: boolean;
  notice: notice;
  authority: string;
}

export default function EvaluationRoomNotice(props: EvaluationRoomNoticeProps) {
  return (
    <EvaluationRoomNoticeContainer>
      {(props.authority === "admin" || props.authority === "committer") && (
        <TextareaSet
          text={`평가위원\n공지사항`}
          notice={props.notice.committerNoticeContent}
          readOnly={props.readOnly}
        />
      )}
      {(props.authority === "admin" || props.authority === "company") && (
        <TextareaSet
          text={`제안업체\n공지사항`}
          notice={props.notice.companyNoticeContent}
          readOnly={props.readOnly}
        />
      )}
    </EvaluationRoomNoticeContainer>
  );
}

const EvaluationRoomNoticeContainer = styled.div`
  width: 752px;
  > div {
    &:last-child {
      margin-top: 20px;
    }
  }
`;
