import { UseFormRegister } from "react-hook-form";
import styled from "styled-components";
import { getAllTermApi } from "../../../api/MasterApi";
import { ITerm } from "../../../interface/Master/MasterData";
import { useData } from "../../../modules/Server/QueryHook";
import ScrollSet from "../../Common/ScrollSet";
import { evaluationReadyInput } from "../EvaluationRoomStep";

interface CommitterAgreeProps {
  register: UseFormRegister<evaluationReadyInput>;
  isCommitter: boolean;
  isSignup?: boolean;  
}

export default function CommitterAgree(props: CommitterAgreeProps) {
  const getAllTerm = useData<ITerm[], null>(["getAllTerm", null], getAllTermApi);
  console.log(getAllTerm.data?.data);
  if (props.isSignup) {
    return (
      <CommitterAgreeContainer>
      <ScrollSet
        agreeText="개인정보 수집 및 이용 동의서에 동의합니다."
        register={props.register("agree1")}
        text={getAllTerm.data?.data.find(item => item.type === "committer")?.content || ""}
        title="개인정보 수집 및 이용 동의서"
      />
      </CommitterAgreeContainer>
    )
  }

  return (
    <CommitterAgreeContainer>
      <ScrollSet
        agreeText="개인정보 수집 및 이용 동의서에 동의합니다."
        register={props.register("agree1")}
        text={getAllTerm.data?.data.find(item => item.type === "committer")?.content || ""}
        title="1. 개인정보 수집 및 이용 동의서"
      />
      {props.isCommitter && (
        <>
          <ScrollSet
            // agreeText="평가위원 위촉 동의서에 동의합니다."
            agreeText="평가위원 청렴서약서에 동의합니다."
            register={props.register("agree2")}
            text={getAllTerm.data?.data.find(item => item.type === "consignment")?.content || ""}
            // title="2. 평가위원 위촉 동의서"
            title="2. 평가위원 청렴서약서"
          />
          <ScrollSet
            agreeText="보안각서에 동의합니다."
            register={props.register("agree3")}
            text={getAllTerm.data?.data.find(item => item.type === "security")?.content || ""}
            title="3. 보안각서 동의서"
          />
        </>
      )}
      {!props.isCommitter && (
        <ScrollSet
          agreeText="보안각서에 동의합니다."
          register={props.register("agree3")}
          text={getAllTerm.data?.data.find(item => item.type === "consignment")?.content || ""}
          title="2. 보안각서 동의서"
        />
      )}
    </CommitterAgreeContainer>
  );
}

const CommitterAgreeContainer = styled.div`
  width: 1200px;
  height: 500px;
  overflow-y: auto;
  &::-webkit-scrollbar {
    display: none;
  }
  padding-bottom: 30px;
`;
