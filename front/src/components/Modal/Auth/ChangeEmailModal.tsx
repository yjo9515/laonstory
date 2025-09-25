import { SubmitHandler, useForm } from "react-hook-form";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import { authEmailApi, authReSendEmailApi, authSendEmailApi } from "../../../api/AuthApi";
import { committerChangeEmailApi, companyChangeEmailApi } from "../../../api/MyInfoApi";
import { IChangeEmail } from "../../../interface/Auth/FormInputInterface";
import { alertModalState, contentModalState } from "../../../modules/Client/Modal/Modal";
import { useSendData } from "../../../modules/Server/QueryHook";
import { Regex } from "../../../utils/RegularExpression";
import BigButton from "../../Common/Button/BigButton";
import InputSet from "../../Common/Input/InputSet";
import { IAuthSendEmailResponse } from "../../../interface/Auth/ApiResponseInterface";
import {
  IAuthEmail,
  IAuthReSendEmail,
  IAuthSendEmail,
} from "../../../interface/Auth/ApiDataInterface";
import { ICommitterChangeEmailData } from "../../../interface/MyInfo/ApiData";
import { MyInfoModalContainer } from "../../../theme/common";
import Form from "../../Common/Container/Form";
import { MyInfoSize } from "./ChangeAdminModal";
import { queryClient } from "../../..";

export default function ChangeEmailModal({ type }: { type: string }) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetContentModal = useResetRecoilState(contentModalState);

  const { register, handleSubmit, watch, setValue } = useForm<IChangeEmail>();

  // 이메일 인증번호 전송 api
  const sendEmailAuth = useSendData<IAuthSendEmailResponse, IAuthSendEmail>(authSendEmailApi);
  // 이메일 인증번호 재전송 api
  const resendEmailAuth = useSendData<IAuthSendEmailResponse, IAuthReSendEmail>(authReSendEmailApi);
  // 이메일 인증번호 인증 api
  const emailAuth = useSendData<string, IAuthEmail>(authEmailApi);
  // committer 이메일 변경 api
  const committerChangeEmail = useSendData<string, ICommitterChangeEmailData>(
    committerChangeEmailApi
  );
  // company 이메일 변경 api
  const companyChangeEmail = useSendData<string, ICommitterChangeEmailData>(companyChangeEmailApi);

  const emailSend = watch("emailSend");

  // 인증메일 전송 버튼 &
  const emailAuthClick = () => {
    // 이메일이 입력되어 있는지 확인
    const email = watch("newEmail");

    if (!watch("newEmail")) {
      setAlertModal({
        isModal: true,
        content: "이메일을 입력하세요.",
      });
      return;
    }
    // 알맞은 형식의 이메일이 들어왔는지 확인
    if (!watch("newEmail").match(Regex.emailRegex)) {
      setAlertModal({
        isModal: true,
        content: "알맞은 형식의 이메일을 입력해주세요.",
      });
      return;
    }

    // 이메일 전송 api 실행
    sendEmailAuth.mutate(
      { email },
      {
        onSuccess(data) {
          const { uuid } = data.data.data;
          setAlertModal({
            isModal: true,
            content: "인증번호가 발송되었습니다.",
          });
          setValue("uuid", uuid);
          setValue("emailSend", true);
        },
      }
    );
  };

  //재전송 클릭 이벤트
  const reSendAuthNumber = () => {
    if (!watch("newEmail")) {
      setAlertModal({
        isModal: true,
        content: "이메일을 입력하세요.",
      });
      return;
    }
    // 알맞은 형식의 이메일이 들어왔는지 확인
    if (!watch("newEmail").match(Regex.emailRegex)) {
      setAlertModal({
        isModal: true,
        content: "알맞은 형식의 이메일을 입력해주세요.",
      });
      return;
    }
    // 이메일 전송 api 실행
    const uuid = watch("uuid");
    const email = watch("newEmail");
    resendEmailAuth.mutate(
      { uuid, email },
      {
        onSuccess() {
          setAlertModal({
            isModal: true,
            content: "인증번호가 발송되었습니다.",
          });
        },
      }
    );
  };
  // 메일 인증 api 실행
  const authEmail = () => {
    // 인증번호가 입력됬는지 확인
    if (!emailSend) {
      setAlertModal({
        isModal: true,
        content: "인증번호 전송을 해주세요.",
      });
      return;
    }

    if (!watch("authNumber")) {
      setAlertModal({
        isModal: true,
        content: "인증번호를 입력하세요.",
      });
      return;
    }
    // api 성공 시에
    const code = watch("authNumber");
    const email = watch("newEmail");
    const uuid = watch("uuid");
    emailAuth.mutate(
      { code, email, uuid },
      {
        onSuccess() {
          setAlertModal({
            isModal: true,
            content: "인증되었습니다.",
          });
          setValue("emailCheck", true);
        },
      }
    );
  };

  const onValid: SubmitHandler<IChangeEmail> = (formData) => {
    const { newEmail, authNumber, emailCheck, uuid } = formData;

    if (!emailCheck) {
      setAlertModal({
        isModal: true,
        content: "이메일 인증을 완료해주세요.",
      });
      return;
    }

    // email 인증번호 확인 api 실행
    if (type === "committer") {
      committerChangeEmail.mutate(
        { email: newEmail, uuid },
        {
          onSuccess() {
            queryClient.invalidateQueries("committerData");
            queryClient.invalidateQueries("committerMyHistory");
            resetContentModal();
            setAlertModal({
              isModal: true,
              content: "변경이 완료되었습니다.",
            });
          },
        }
      );
      return;
    }
    if (type === "company") {
      companyChangeEmail.mutate(
        { email: newEmail, uuid },
        {
          onSuccess() {
            queryClient.invalidateQueries("companyData");
            queryClient.invalidateQueries("companyMyHistory");
            resetContentModal();
            setAlertModal({
              isModal: true,
              content: "변경이 완료되었습니다.",
            });
          },
        }
      );

      return;
    }
  };

  return (
    <MyInfoSize>
      <MyInfoModalContainer>
        <Form onSubmit={handleSubmit(onValid)}>
          <div className="main">
            <div>
              <InputSet
                textCenter
                bold
                placeholder="비밀번호를 입력하세요."
                register={register("password", {})}
                type="text"
                label="비밀번호"
              />
            </div>
            <div className="centerLine"></div>
            <div>
              <InputSet
                column
                textCenter
                bold
                placeholder="변경할 이메일 주소를 입력하세요."
                register={register("newEmail", {
                  onChange() {
                    setValue("emailSend", false);
                    setValue("emailCheck", false);
                  },
                })}
                type="text"
                label="변경할 이메일 주소"
                text={emailSend ? "재전송" : "인증번호 전송"}
                onClick={emailSend ? reSendAuthNumber : emailAuthClick}
              />
              <InputSet
                column
                textCenter
                bold
                placeholder="인증번호를 입력하세요."
                register={register("authNumber")}
                type="text"
                label="인증번호"
                text="인증하기"
                onClick={authEmail}
                success={watch("emailCheck")}
              />
            </div>
          </div>

          <div className="buttonContainer">
            <BigButton white text="취소" onClick={resetContentModal} />
            <BigButton submit text="확인" />
          </div>
        </Form>
      </MyInfoModalContainer>
    </MyInfoSize>
  );
}
