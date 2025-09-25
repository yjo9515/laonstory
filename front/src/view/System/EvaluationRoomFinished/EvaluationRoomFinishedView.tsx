import { useResetRecoilState, useSetRecoilState } from "recoil";
import styled from "styled-components";
import BigButton from "../../../components/Common/Button/BigButton";
import SmallButton1 from "../../../components/Common/Button/SmallButton1";
import { InfoList } from "../../../components/Detail/DetailListTable";
import { DetailSection } from "../../../components/Detail/DetailSection";
import EvaluationScoreTableComponent from "../../../components/EvaluationScoreTable/EvaluationScoreTableComponent";
import FileViewer from "../../../components/Viewer/FileViewer";
import { EvaluationRoomFinishSimpleReqInterface } from "../../../interface/System/EvaluationRoomProceed/EvaluationRoomProceedTypes";
import { TableArrayItemType } from "../../../interface/System/EvaluationTable/EvaluationTableTypes";
import { contentModalState } from "../../../modules/Client/Modal/Modal";

import theme from "../../../theme";
import { ViewObjectWrapperBox } from "../../../theme/common";
import NumberUtils from "../../../utils/NumberUtils";

interface EvaluationRoomFinishedViewTypes {
  evaluationSimpleData: EvaluationRoomFinishSimpleReqInterface | null;
  fileData: any | null;
  scoreFileData: any | null;
  evaluationTableInfo: TableArrayItemType[] | null;
  goBack: () => void;
}

export default function EvaluationRoomFinishedView(props: EvaluationRoomFinishedViewTypes) {
  const contentModal = useSetRecoilState(contentModalState);
  const resetContentModal = useResetRecoilState(contentModalState);

  const onSocreModal = () => {
    if (!props.fileData) return;

    contentModal({
      isModal: true,
      title: "최종평가점수표",
      subText: "",
      content: (
        <div style={{ width: "800px", height: "550px" }}>
          <FileViewer url={props.fileData} />
        </div>
      ),
      buttonText: "저장",
      onClick: () => {
        fileDown();
      },
    });
  };

  const onCommitterScoreModal = () => {
    // if (!props.scoreFileData) return;

    contentModal({
      isModal: true,
      title: "최종평가서",
      subText: "",
      content: (
        <div style={{ width: "800px", height: "550px" }}>
          <FileViewer url={props.scoreFileData} />
        </div>
      ),
      buttonText: "저장",
      onClick: () => {
        scoreFileDown();
      },
    });
  };

  const onTableModal = () => {
    if (!props.evaluationTableInfo) return;
    contentModal({
      isModal: true,
      title: "",
      subText: "",
      type: "s",
      content: (
        <div style={{ width: "800px", height: "550px" }}>
          <EvaluationScoreTableComponent
            tableArray={props.evaluationTableInfo}
            tableTitle={props.evaluationSimpleData?.usedEvaluationTable.title ?? ""}
            titleType="확인하기"
            onClose={() => resetContentModal()}
            onlyView
            noSave
          />
        </div>
      ),
    });
  };

  const fileDown = () => {
    let data = props.fileData;
    let project = props.evaluationSimpleData;

    const anchorElement = document.createElement("a");
    document.body.appendChild(anchorElement);
    anchorElement.download = `${project?.projectName ?? ""}_최종평가점수표_${
      project?.projectName ?? ""
    }`; // a tag에 download 속성을 줘서 클릭할 때 다운로드가 일어날 수 있도록 하기
    anchorElement.href = data; // href에 url 달아주기

    anchorElement.click(); // 코드 상으로 클릭을 해줘서 다운로드를 트리거

    document.body.removeChild(anchorElement);
  };

  const scoreFileDown = () => {
    let data = props.scoreFileData;
    let project = props.evaluationSimpleData;

    const anchorElement = document.createElement("a");
    document.body.appendChild(anchorElement);
    anchorElement.download = `${project?.projectName ?? ""}_최종평가서_${
      project?.projectName ?? ""
    }`; // a tag에 download 속성을 줘서 클릭할 때 다운로드가 일어날 수 있도록 하기
    anchorElement.href = data; // href에 url 달아주기

    anchorElement.click(); // 코드 상으로 클릭을 해줘서 다운로드를 트리거

    document.body.removeChild(anchorElement);
  };

  return (
    <>
      <EvaluationRoomFinishedViewBlock>
        <ViewObjectWrapperBox>
          <h1 className="viewTitle">평가 완료 정보</h1>
          <div className="content">
            <DetailSection>
              <DetailSection.Title text="1. 기본정보" />
              <div>
                <DetailSection.InfoSet labelText="사업명">
                  <span>{props.evaluationSimpleData?.projectName ?? ""}</span>
                </DetailSection.InfoSet>
                <DetailSection.InfoSet labelText="사업명">
                  <span>{props.evaluationSimpleData?.evaluationDateTime ?? ""}</span>
                </DetailSection.InfoSet>
                <DetailSection.InfoSet labelText="서부 평가담당자">
                  <span>{props.evaluationSimpleData?.master ?? ""}</span>
                </DetailSection.InfoSet>
              </div>
            </DetailSection>
            <DetailSection>
              <DetailSection.Title>
                <>
                  2. 평가항목표
                  <span>평가항목표 이름 클릭 시 사용된 평가항목표를 보실 수 있습니다.</span>
                </>
              </DetailSection.Title>
              <div>
                <DetailSection.InfoBlock
                  text={props.evaluationSimpleData?.usedEvaluationTable.title ?? ""}
                  onClick={onTableModal}
                />
              </div>
            </DetailSection>
            {/* <DetailSection>
              <DetailSection.Title>
                3. 참석자 목록 <span>평가에 참여한 평가위원, 제안업체를 확인하실 수 있습니다.</span>
              </DetailSection.Title>
              <div>
                <InfoList>
                  <InfoList.Title>{`1) 평가위원`}</InfoList.Title>
                  <InfoList.Headers>
                    <InfoList.Header center w={150}>
                      이름
                    </InfoList.Header>
                    <InfoList.Header center w={150}>
                      생년월일
                    </InfoList.Header>
                    <InfoList.Header center w={150}>
                      연락처
                    </InfoList.Header>
                    <InfoList.Header center w={200}>
                      이메일
                    </InfoList.Header>
                    <InfoList.Header center w={180}>
                      평가위원장 여부
                    </InfoList.Header>
                  </InfoList.Headers>
                  <InfoList.Contents>
                    {props.evaluationSimpleData?.committers.map((el, i) => (
                      <InfoList.Content>
                        <InfoList.Header w={120} center>
                          {el.committer?.name}
                        </InfoList.Header>
                        <InfoList.Header w={175} center>
                          {el.committer?.birth}
                        </InfoList.Header>
                        <InfoList.Header w={135} center>
                          {NumberUtils.phoneFormat(el.committer?.phone || "")}
                        </InfoList.Header>
                        <InfoList.Header w={220} center>
                          {el.committer?.email}
                        </InfoList.Header>
                        <InfoList.Header w={150} center>
                          {el.isChairman ? "평가위원장" : "-"}
                        </InfoList.Header>
                      </InfoList.Content>
                    ))}
                  </InfoList.Contents>
                </InfoList>
                <InfoList>
                  <InfoList.Title>{`2) 평가위원`}</InfoList.Title>
                  <InfoList.Headers>
                    <InfoList.Header w={150} center>
                      이름
                    </InfoList.Header>
                    <InfoList.Header w={150} center>
                      생년월일
                    </InfoList.Header>
                    <InfoList.Header w={150} center>
                      연락처
                    </InfoList.Header>
                    <InfoList.Header w={200} center>
                      이메일
                    </InfoList.Header>
                    <InfoList.Header w={180} center></InfoList.Header>
                  </InfoList.Headers>
                  <InfoList.Contents>
                    {props.evaluationSimpleData?.companyList.map((el, i) => (
                      <InfoList.Content>
                        <InfoList.Header w={120} center>
                          {el?.companyName}
                        </InfoList.Header>
                        <InfoList.Header w={175} center>
                          {el?.name}
                        </InfoList.Header>
                        <InfoList.Header w={135} center>
                          {NumberUtils.phoneFormat(el?.phone || "")}
                        </InfoList.Header>
                        <InfoList.Header w={220} center>
                          {el?.email}
                        </InfoList.Header>
                        <InfoList.Header w={150} center></InfoList.Header>
                      </InfoList.Content>
                    ))}
                  </InfoList.Contents>
                </InfoList>
              </div>
            </DetailSection> */}
            <DetailSection>
              <DetailSection.Title>
                <>
                  3. 최종평가점수표
                  <span>
                    최종평가점수표 이름 클릭 시 블록체인에 저장된 최종점수표를 보실 수 있습니다.
                  </span>
                </>
              </DetailSection.Title>
              <div>
                {/* <DetailSection.InfoBlock text="블록체인 기반 제안서 평가 및 디지털증명 시스템 구축 최종 평가 점수표" /> */}
                <div className="finalScoreDown">
                  <SmallButton1 text="최종 평가점수표" onClick={onSocreModal} />
                  <SmallButton1 text="평가위원 평가점수표" onClick={onCommitterScoreModal} />
                </div>
              </div>
            </DetailSection>
          </div>
          <div className="buttons">
            <BigButton text="확인" onClick={props.goBack} />
          </div>
        </ViewObjectWrapperBox>
      </EvaluationRoomFinishedViewBlock>
    </>
  );
}
const EvaluationRoomFinishedViewBlock = styled.div`
  padding-bottom: ${theme.commonMargin.gap1};
  margin-bottom: 60px;
  .content {
    width: 100%;
    margin-top: 40px;
  }
  .buttons {
    margin-top: 160px;
    display: flex;
    justify-content: center;
  }
  .finalScoreDown {
    /* margin-top: 10px; */
    margin-left: 3px;
    & > button:first-child {
      margin-right: 10px;
    }
  }
`;
