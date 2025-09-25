import { useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import styled from "styled-components";
import { queryClient } from "../../..";
import { deleteCommitterApi, modifyCommitterApi } from "../../../api/MasterApi";
import { IInviteCommitter } from "../../../interface/Master/MasterData";
import {
  alertModalState,
  contentModalState,
  loadingModalState,
} from "../../../modules/Client/Modal/Modal";
import { useSendData } from "../../../modules/Server/QueryHook";
import theme from "../../../theme";
import { Regex } from "../../../utils/RegularExpression";
import BigButton from "../../Common/Button/BigButton";
import Form from "../../Common/Container/Form";
import InputSet1 from "../../Common/Input/InputSet1";

interface ICommitterModalProps {
  data: IInviteCommitter;
  onCommitterListRefetch: () => void;
}

export default function CommitterModal(props: ICommitterModalProps) {
  const [modify, setModify] = useState(false);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const resetContentModal = useResetRecoilState(contentModalState);
  const alertModal = useSetRecoilState(alertModalState);
  const { register, setValue, getValues } = useForm<IInviteCommitter>();
  useEffect(() => {
    if (modify) {
      setValue("name", props?.data?.name);
      setValue("email", props?.data?.email || "");
      setValue("phone", props?.data?.phone);
      setValue("birth", props?.data?.birth);
    }
  }, [modify]);

  // 평가위원 수정 api
  const modifyCommitter = useSendData(modifyCommitterApi);
  // 평가위원 삭제 api
  const deleteCommitter = useSendData(deleteCommitterApi, {
    onSuccess() {
      resetLoadingModal();
      resetContentModal();
      alertModal({
        isModal: true,
        content: "평가위원이 삭제되었습니다.",
      });
      props.onCommitterListRefetch();
    },
  });

  const deleteCommitterClick = () => {
    alertModal({
      isModal: true,
      content: `평가위원 삭제 시 모든 평가위원 정보가 삭제됩니다.\n정말로 삭제하시겠습니까?`,
      onClick() {
        deleteCommitter.mutate(props.data.id as string);
      },
    });
  };

  const onValid = () => {
    const formData = getValues();
    const { name, email, phone, birth } = formData;

    if (String(birth).length !== 8) {
      alertModal({
        isModal: true,
        type: "error",
        content: "생년월일 8자리를 정확하게 입력해 주세요.",
        title: "생년월일이 올바르게 입력되지 않았습니다.",
      });
    }

    if (!name || !phone || !birth) {
      alertModal({ isModal: true, content: "값을 모두 입력해주세요." });
      return;
    }
    const data = { name, email, phone, birth, id: props.data.id };
    modifyCommitter.mutate(data, {
      onSuccess() {
        queryClient.invalidateQueries(["committerList"]);
        resetContentModal();
        alertModal({ isModal: true, content: "입력하신 정보로 평가위원 정보가 변경되었습니다." });
      },
    });
  };

  return (
    <CommitterModalContainer>
      <Form>
        <InputSet1
          register={register("name", { required: "이름을 입력하세요." })}
          placeholder="이름을 입력해 주세요."
          label="이름"
          disabled={!modify}
          text={props?.data?.name}
        />
        <InputSet1
          register={register("birth", {
            required: "생년월일을 입력해 주세요. (ex: 20220101)",
            pattern: { value: Regex.numberRegex, message: "숫자만 입력해주세요. (ex: 20220101)" },
          })}
          placeholder="생년월일을 입력하세요."
          label="생년월일"
          disabled={!modify}
          text={props?.data?.birth}
        />
        <InputSet1
          register={register("phone", {
            required: "숫자만 입력해 주세요.(ex: 01012345678)",
            pattern: {
              value: Regex.phoneRegExp,
              message: "알맞은 형식의 휴대폰 번호를 입력하세요.",
            },
          })}
          placeholder="휴대폰 번호를 입력해 주세요."
          label="휴대폰"
          disabled={!modify}
          text={props?.data?.phone}
        />
        <InputSet1
          register={register("email", {
            required: "이메일을 입력해 주세요.",
            pattern: { value: Regex.emailRegex, message: "알맞은 형식의 이메일을 입력해 주세요." },
          })}
          placeholder="이메일을 입력해 주세요."
          label={modify ? "이메일(선택)" : "이메일"}
          disabled={!modify}
          text={props?.data?.email}
        />

        <InputSet1
          label="등록일시"
          disabled
          placeholder={props?.data?.createdAt}
          text={props?.data?.createdAt}
        />

        <div className="buttonContainer">
          <BigButton
            white
            text={modify ? "취소" : "닫기"}
            onClick={modify ? () => setModify(false) : resetContentModal}
          />
          {modify ? (
            <BigButton text="저장" onClick={onValid} />
          ) : (
            <BigButton
              text="수정"
              onClick={() => (!modify ? setModify((prev) => true) : undefined)}
            />
          )}
        </div>
      </Form>
      {/* <button className="deleteBtn" type="button" onClick={deleteCommitterClick}>
        <span>삭제</span>
      </button> */}
    </CommitterModalContainer>
  );
}

const CommitterModalContainer = styled.div`
  width: 752px;
  padding-top: 64px;
  position: relative;
  & > .deleteBtn {
    position: absolute;
    text-decoration: underline;
    color: ${theme.colors.body2};
    right: 0px;
    bottom: 0px;
  }
  & > form {
    display: flex;
    flex-direction: column;
    width: 100%;
    gap: 28px;
    & > div {
      width: 100%;
      display: flex;
      align-items: center;
      font-size: 20px;
      & > label {
        width: 110px;
      }
      &.buttonContainer {
        margin-top: 20px;
        justify-content: center;
        gap: 32px;
      }
    }
  }
`;
