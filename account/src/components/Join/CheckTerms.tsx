import { UseFormRegister } from "react-hook-form";
import styled from "styled-components";
import { IJoinInput } from "../../interface/Auth/FormInputInterface";
import { ITerm } from "../../interface/Master/MasterData";
import theme from "../../theme";
import BigButton from "../Common/Button/BigButton";
import ScrollSet from "../Common/ScrollSet";

interface ICheckTerms {
  onNextClick: () => void;
  onPrevClick?: () => void;
  type?: string;
  register: UseFormRegister<IJoinInput>;
  terms?: ITerm;
}


export default function CheckTerms({ onPrevClick, type, register, terms }: ICheckTerms) {
  console.log(type)
  return (
    <>
      <AgreeContainer>
        {type === "personal" ? (
          <>
            <ScrollSet
              title="1. 개인정보 수집 및 이용 약관 안내(개인)"
              text={(terms && terms?.content) || ""}
              // agreeText="개인정보 수집 동의서에 동의합니다."
              // register={register("personalAgree", {
              //   required: "약관에 동의 하신 후 다음으로 이동할 수 있습니다.",
              // })}
            />
          </>
        ) : type === "company" ? (
          <>
            <ScrollSet
              title="1. 개인정보 수집 및 이용 약관 안내(사업자 및 법인)"
              text={(terms && terms?.content) || ""}
              // agreeText="개인정보 수집 및 이용 동의서에 동의합니다."
              // register={register("personalAgree", {
              //   required: "약관에 동의 하신 후 다음으로 이동할 수 있습니다.",
              // })}
            />
          </>
        ) : (
          <>
            <ScrollSet
              title="1. 개인정보 수집 및 이용 약관 안내"
              text={(terms && terms?.content) || ""}
              // agreeText="개인정보 수집 및 이용 동의서에 동의합니다."
              // register={register("personalAgree", {
              //   required: "약관에 동의 하신 후 다음으로 이동할 수 있습니다.",
              // })}
            />
          </>
        )}
      </AgreeContainer>
      <ButtonContainer>
        <BigButton text="이전" isPrev onClick={onPrevClick} />
        <BigButton text="다음" submit />
      </ButtonContainer>
    </>
  );
}
const AgreeContainer = styled.div`
  h3 {
    margin-bottom: 20px;
    font-size: ${(props) => props.theme.fontType.subTitle1.fontSize};
    font-weight: ${(props) => props.theme.fontType.subTitle1.bold};
    color: ${theme.colors.body};
  }
  .agreeContainer {
    margin-top: 19px;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 16px;
    color: ${theme.colors.body};
  }
`;
const ButtonContainer = styled.div`
  margin-top: 109px;
  display: flex;
  justify-content: center;
  gap: 24px;
`;
