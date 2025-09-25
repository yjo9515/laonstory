import { SubmitErrorHandler, SubmitHandler, useForm, UseFormSetValue } from "react-hook-form";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import { authEmailApi, authReSendEmailApi } from "../../../api/AuthApi";
import { IAuthEmail, IAuthReSendEmail } from "../../../interface/Auth/ApiDataInterface";
import {
  IAuthReSendEmailResponse,
  IAuthSendEmailResponse,
} from "../../../interface/Auth/ApiResponseInterface";
import { IJoinInput } from "../../../interface/Auth/FormInputInterface";
import { alertModalState, contentModalState } from "../../../modules/Client/Modal/Modal";
import { useSendData } from "../../../modules/Server/QueryHook";
import { MyInfoModalContainer } from "../../../theme/common";
import BigButton from "../../Common/Button/BigButton";
import InputButton from "../../Common/Button/InputButton";
import Form from "../../Common/Container/Form";
import InputSet from "../../Common/Input/InputSet";

interface EmailModalInput {
  emailAuthCode: string;
  emailCheck: boolean;
  uuid: string;
}

// 회원가입 - 이메일 인증 용 모달
export default function AuthEmailModal({
  setValue,
  email,
  uuid,
}: {
  setValue?: UseFormSetValue<IJoinInput>;
  email: string;
  uuid: string;
}) {
  const resetContentModal = useResetRecoilState(contentModalState);
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);

  const authEmail = useSendData<IAuthSendEmailResponse, IAuthEmail>(authEmailApi);
  const authResendEmail = useSendData<IAuthReSendEmailResponse, IAuthReSendEmail>(
    authReSendEmailApi
  );

  const {
    register,
    handleSubmit,
    setValue: emailModalSetValue,
    watch,
  } = useForm<EmailModalInput>({});

  const reSendClick = () => {
    // 이메일 재전송 api 연결
    authResendEmail.mutate(
      { email, uuid },
      {
        onSuccess(res) {
          const {
            data: { data },
          } = res;
          emailModalSetValue("uuid", data.uuid);
        },
      }
    );
  };

  const onValid: SubmitHandler<EmailModalInput> = (formData) => {
    const { emailAuthCode } = formData;

    let data = { uuid, email, code: emailAuthCode };
    // 재전송 시에 받은 새로운 uuid 확인
    if (watch("uuid")) data.uuid = watch("uuid");

    // 이메일 인증 api 연결 =========================================================== API 연결
    authEmail.mutate(data, {
      onSuccess() {
        if (setValue) setValue("emailCheck", true);
        emailModalSetValue("emailCheck", true);
        setAlertModal({
          type: "check",
          isModal: true,
          content: "이메일 인증이 완료되었습니다.",
          onClick() {
            resetContentModal();
            resetAlertModal();
          },
        });
      },
    });
  };
  const invalid: SubmitErrorHandler<EmailModalInput> = (error) => {
    if (error.emailAuthCode?.message && error.emailAuthCode?.type === "required") {
      setAlertModal({
        isModal: true,
        content: "인증번호가 입력되지 않았습니다.",
      });
    }
  };
  return (
    <MyInfoModalContainer>
      <Form onSubmit={handleSubmit(onValid, invalid)}>
        <div className="main" style={{ gap: 0 }}>
          <InputSet
            column
            label="인증번호"
            textCenter
            placeholder="인증번호를 입력하세요."
            type="string"
            // text="재전송"
            register={register("emailAuthCode", {
              required: "인증번호를 입력하세요.",
            })}
            onClick={reSendClick}
          />
          <span>
            <span>
              <p onClick={reSendClick}>재전송</p>
            </span>
          </span>
        </div>
        <div className="buttonContainer">
          <InputButton text="취소" onClick={resetContentModal} />
          <InputButton text="인증" submit />
        </div>
      </Form>
    </MyInfoModalContainer>
  );
}
