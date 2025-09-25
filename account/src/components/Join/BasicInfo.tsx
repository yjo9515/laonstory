import {
  RegisterOptions,
  UseFormProps,
  UseFormRegister,
  UseFormSetValue,
  UseFormWatch,
} from "react-hook-form";
import styled from "styled-components";
import UserInfo from "../../assets/Icon/UserInfo";
import { IJoinInput } from "../../interface/Auth/FormInputInterface";
import { Regex } from "../../utils/RegularExpression";
import BigButton from "../Common/Button/BigButton";
import InputSet1 from "../Common/Input/InputSet1";
import smartPhoneIcon from "../../assets/Icon/smartphone.svg";
import emailIcon from "../../assets/Icon/mail.svg";
import companyIcon from "../../assets/Icon/bag.svg";
import theme from "../../theme";
import { SyntheticEvent } from "react";
import { useSetRecoilState } from "recoil";
import { alertModalState } from "../../modules/Client/Modal/Modal";

interface IBasicInfo {
  onPrevClick?: () => void;
  register: UseFormRegister<IJoinInput>;
  onClicks: { id: () => void; email: () => void };
  setValue: UseFormSetValue<IJoinInput>;
  watch: UseFormWatch<IJoinInput>;
  type: string;
}

export default function BasicInfo({
  register,
  onPrevClick,
  onClicks,
  setValue,
  watch,
  type,
}: IBasicInfo) {
  const setAlertModal = useSetRecoilState(alertModalState);

  const passwordCheck = (e: string) => {
    if (e.length < 9) {
      setAlertModal({
        isModal: true,
        content: "비밀번호를 영문, 숫자, 특수문자(!,@,#,$,%,?,&,*) 포함 9자리 이상 입력해주세요.",
      });
      return;
    } else if (!Regex.passwordRegex.test(e)) {
      setAlertModal({
        isModal: true,
        content: "비밀번호를 영문, 숫자, 특수문자(!,@,#,$,%,?,&,*) 포함 9자리 이상 입력해주세요.",
      });

      return;
    } else {
      return true;
    }
  };

  const confirmPasswordCheck = (e: string) => {
    if (watch("password") && passwordCheck(watch("password")) && watch("password") !== e) {
      setAlertModal({
        isModal: true,
        content: "비밀번호가 일치하지 않습니다.",
      });
    }
  };
  return (
    <>
      <InputsContainer>
        <p>
          * 기본정보를 입력해주세요.{" "}
          <span>
            ( <span style={{ color: "#DA0043" }}>*</span> 은 필수 입력 항목입니다. )
          </span>
        </p>
        <div>
          <InputSet1
            label="아이디"
            type="text"
            onClick={onClicks.id}
            register={register("id", {
              required: "아이디를 입력하세요.(영문, 숫자 20자리 이내)",
              onChange() {
                setValue("idCheck", false);
              },
            })}
            placeholder="아이디를 입력하세요.(영문, 숫자 20자리 이내)"
            isButton
            buttonText="중복확인"
            icon={<UserInfo />}
            autoComplete="off"
            importantCheck
            maxLength={20}
          />
          <InputSet1
            label="비밀번호"
            type="password"
            register={register("password", {
              required:
                "비밀번호를 입력하세요.(영문, 숫자, 특수문자(!,@,#,$,%,?,&,*) 포함 9자리 이상)",
              onBlur: (e) => passwordCheck(e.target.value),
            })}
            placeholder="비밀번호를 입력하세요.(영문, 숫자, 특수문자(!,@,#,$,%,?,&,*) 포함 9자리 이상)"
            icon={<UserInfo />}
            autoComplete="off"
            importantCheck
          />
          <InputSet1
            type="password"
            register={register("confirmPassword", {
              required: "비밀번호를 한번 더 입력하세요.",
              onBlur: (e) => confirmPasswordCheck(e.target.value),
            })}
            placeholder="비밀번호를 한번 더 입력하세요."
          />
          {type === "company" && (
            <InputSet1
              label="업체명"
              type="text"
              register={register("companyName", {
                required:
                  "업체명을 입력하세요.(사업자등록증에 기재된 업체명으로 한글, 공백 15자 내외)",
              })}
              placeholder="업체명을 입력하세요.(사업자등록증에 기재된 업체명으로 한글, 공백 15자 내외)"
              icon={<img src={companyIcon} alt="업체명 아이콘" />}
              importantCheck
              maxLength={15}
            />
          )}
          {type === "personal" && (
            <InputSet1
              label="이름"
              type="text"
              register={register("name", {
                required: "이름을 입력하세요.",
                // disabled: true,
              })}
              placeholder="이름을 입력하세요."
              icon={<UserInfo />}
              readOnly
              importantCheck
            />
          )}
          {type === "company" && (
            <InputSet1
              label="담당자 이름"
              type="text"
              register={register("name", {
                required: "담당자 이름을 입력하세요.",
              })}
              placeholder="담당자 이름을 입력하세요."
              icon={<UserInfo />}
              readOnly
              importantCheck
            />
          )}
          {type === "personal" && (
            <InputSet1
              label="전화번호"
              type="text"
              register={register("phone", {
                required: "전화번호를 입력하세요.",
                pattern: {
                  value: Regex.phoneRegExp,
                  message: "알맞은 형식의 전화번호를 입력하세요.",
                },
              })}
              placeholder="전화번호를 입력하세요."
              icon={<img src={smartPhoneIcon} alt="전화 아이콘" />}
              readOnly
              importantCheck
            />
          )}
          {type === "company" && (
            <InputSet1
              label="담당자 전화번호"
              type="text"
              register={register("phone", {
                required: "담당자 전화번호를 입력하세요.",
                pattern: {
                  value: Regex.phoneRegExp,
                  message: "알맞은 형식의 담당자 전화번호를 입력하세요.",
                },
              })}
              placeholder="담당자 전화번호를 입력하세요."
              icon={<img src={smartPhoneIcon} alt="전화 아이콘" />}
              readOnly
              importantCheck
            />
          )}
          <InputSet1
            label="이메일"
            type="text"
            register={register("email", {
              required: "이메일을 입력하세요.(확인 가능한 이메일 주소를 입력하세요.)",
              pattern: {
                value: Regex.emailRegex,
                message: "알맞은 형식의 이메일을 입력하세요.",
              },
              onChange() {
                setValue("emailCheck", false);
              },
            })}
            onClick={onClicks.email}
            placeholder="이메일을 입력하세요.(확인 가능한 이메일 주소를 입력하세요.)"
            isButton
            buttonText="인증메일 전송"
            icon={<img src={emailIcon} alt="메일 아이콘" />}
            importantCheck
          />
        </div>
        <p style={{ color: "red" }}>* 가입 후 계좌등록 완료시 계정이 자동으로 삭제되니 이 점 유의하시기 바랍니다.</p>
      </InputsContainer>
      <BigButtonContainer>
        <BigButton isPrev text="이전" white onClick={onPrevClick} />
        <BigButton text="가입" submit />
      </BigButtonContainer>
    </>
  );
}

const InputsContainer = styled.div`
  display: flex;
  justify-content: center;
  flex-direction: column;
  & > p {
    margin-bottom: 32px;
    font-size: ${theme.fontType.medium16.fontSize};
    font-weight: ${theme.fontType.medium16.bold};
    & > span {
      font-weight: 100;
      font-size: 15px;
    }
  }
  & > div {
    width: 100%;
    padding-bottom: 24px;
  }
  & > div > div {
    margin-bottom: 16px;
  }
`;

const BigButtonContainer = styled.div`
  width: 100%;
  margin-top: 0px;
  display: flex;
  justify-content: center;
  gap: 24px;
`;
