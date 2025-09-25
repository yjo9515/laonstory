import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import styled from "styled-components";
import { queryClient } from "../../..";
import { committerChangePhoneApi } from "../../../api/MyInfoApi";
import { IChangePhone } from "../../../interface/Auth/FormInputInterface";
import { ICommitterChangePhoneData } from "../../../interface/MyInfo/ApiData";

import { alertModalState, contentModalState } from "../../../modules/Client/Modal/Modal";
import { useSendData } from "../../../modules/Server/QueryHook";
import { formInvalid } from "../../../utils/FormInvalid";
import BigButton from "../../Common/Button/BigButton";
import InputSet from "../../Common/Input/InputSet";
import PhoneAuthSet from "../../Common/Input/PhoneAuthSet";

export default function ChangePhoneModal({ type }: { type: string }) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const resetContentModal = useResetRecoilState(contentModalState);

  const { register, handleSubmit, setValue, watch } = useForm<IChangePhone>();

  // committer 전화번호 변경 api
  const committerChangePhone = useSendData<string, ICommitterChangePhoneData>(
    committerChangePhoneApi
  );

  //  ======================= 버튼 클릭 이벤트
  const phoneAuth = () => {
    // 휴대폰 인증 api실행

    //성공 시 phoneCheck true

    setValue("phoneCheck", true);
    setAlertModal({
      isModal: true,
      content: "휴대폰 인증이 완료되었습니다.",
    });
  };

  const onValid: SubmitHandler<IChangePhone> = (formData) => {
    const { phoneCheck, password } = formData;
    if (!phoneCheck) {
      setAlertModal({
        isModal: true,
        content: "휴대폰 인증을 완료해주세요.",
      });
      return;
    }
    // 정보 수정 api 실행
    const data = { password, phone: "01022224765" };
    committerChangePhone.mutate(data, {
      onSuccess() {
        queryClient.invalidateQueries("committerData");
        queryClient.invalidateQueries("committerMyHistory");
        setAlertModal({
          type: "check",
          isModal: true,
          content: "변경이 완료되었습니다.",
          onClick() {
            resetContentModal();
            resetAlertModal();
          },
        });
      },
    });
    // api 성공 시
  };
  const inValid: SubmitErrorHandler<IChangePhone> = (errors) => {
    const inputs = ["password"];
    const currentError = formInvalid(errors, inputs);
    if (currentError) setAlertModal(currentError);
  };

  return (
    <form onSubmit={handleSubmit(onValid, inValid)}>
      <ChangeModalContainer>
        <InputSet
          bold
          placeholder="비밀번호를 입력하세요"
          register={register("password", { required: "비밀번호를 입력해주세요." })}
          type="password"
          label="비밀번호"
        />
        <PhoneAuthSet onClick={phoneAuth} phoneCheck={watch("phoneCheck")} />
      </ChangeModalContainer>
      <div className="buttonContainer">
        <BigButton text="취소" white onClick={resetContentModal} />
        <BigButton submit text="확인" />
      </div>
    </form>
  );
}

export const ChangeModalContainer = styled.div`
  display: flex;
  flex-direction: column;
  gap: 24px;
  .phoneAuth {
    button {
      margin-top: 8px;
    }
  }
`;
