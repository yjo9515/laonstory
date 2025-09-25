/* eslint-disable react-hooks/exhaustive-deps */
import { useEffect, useState } from "react";
import { useBeforeunload } from "react-beforeunload";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import { getTermApi, termApi } from "../../../api/MasterApi";
import { ITerm } from "../../../interface/Master/MasterData";
import { alertModalState } from "../../../modules/Client/Modal/Modal";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import TermsView from "../../../view/Partners/Terms/TermsView";
import Layout from "../../Common/Layout/Layout";

interface termsValues {
  personal: string;
  consignment: string;
  security: string;
  agreement: string;
  [key: string]: string;
}
export type categories = "personal" | "consignment" | "security" | "committer";

export default function Terms() {
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  // 새로고침 시 안내 메세지
  useBeforeunload((event) => {
    event.preventDefault();
  });
  // 약관 설정 카테고리
  const [category, setCategory] = useState<categories>("personal");
  // 약관 설정 값들
  const [values, setValues] = useState<termsValues>({
    personal: "",
    consignment: "",
    security: "",
    agreement: "",
    committer:"",    
  });

  // 약관 수정 api
  const patchTermApi = useSendData(termApi);
  // 약관 전체 가져오기 api
  const getTerm = useData<ITerm, "personal" | "consignment" | "security" | "committer">(
    ["getAllTerms", category],
    getTermApi
  );

  // 서버로부터 받은 값 저장
  useEffect(() => {
    if (getTerm.data) {
      console.log(getTerm);
      setValues((prev) => ({
        ...prev,
        [category]: getTerm.data?.data.content,
      }));
    }
  }, [getTerm.data]);
  // 에디터 onChange 함수
  const onChange = (value: string) => {
    if (category === "personal") setValues((prev) => ({ ...prev, personal: value }));
    if (category === "consignment") setValues((prev) => ({ ...prev, consignment: value }));
    if (category === "security") setValues((prev) => ({ ...prev, security: value }));
    if (category === "committer") setValues((prev) => ({ ...prev, committer: value }));    
  };
  // 카테고리 클릭 이벤트
  const onClick = (category: categories) => {
    setCategory(category);
  };
  // 저장하기 버튼 클릭 이벤트
  const buttonClick = () => {
    if (patchTermApi.isLoading) return;
    setAlertModal({
      isModal: true,
      content: "수정하시겠습니까?",
      onClick() {
        resetAlertModal();
        let data!: ITerm;
        if (category === "personal") {
          data = {
            title: "개인정보 수집 및 이용(제안업체)",
            content: values.personal || "",
            type: "personal",
          };
        }
        if (category === "committer") {
          data = {
            title: "개인정보 수집 및 이용(평가위원)",
            content: values.committer || "",
            type: "committer",
          };
        }
        if (category === "consignment") {
          data = {
            // title: "평가위원 위촉",
            title: "청렴서약서",
            content: values.consignment || "",
            type: "consignment",
          };
        }
        if (category === "security") {
          data = {
            title: "보안 각서",
            content: values.security || "",
            type: "security",
          };
        }

        patchTermApi.mutate(data, {
          onSuccess() {
            setAlertModal({
              isModal: true,
              content: "수정되었습니다.",
            });
          },
        });
      },
    });
  };

  return (
    <Layout>
      <TermsView
        buttonClick={buttonClick}
        category={category}
        values={values}
        onChange={onChange}
        onClick={onClick}
      />
    </Layout>
  );
}
