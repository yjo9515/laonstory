import {
  UseFormRegister,
  UseFormSetValue,
  UseFormWatch,
} from "react-hook-form";
import styled from "styled-components";
import UserInfo from "../../assets/Icon/UserInfo";
import { IJoinInput } from "../../interface/Auth/FormInputInterface";
import theme from "../../theme";
import { Regex } from "../../utils/RegularExpression";
import BigButton from "../Common/Button/BigButton";
import InputSet1 from "../Common/Input/InputSet1";
import home from "../../assets/Icon/home.svg";
import bag from "../../assets/Icon/bag.svg";
import smartPhone from "../../assets/Icon/smartPhone.svg";
import mail from "../../assets/Icon/mail.svg";
import { DetailSection } from "../Detail/DetailSection";
import { Inputs } from "../Common/Input/Input";
import MasterSelectModal from "../Modal/Auth/MasterSelectModal";
import React from "react";
import RoleUtils from "../../utils/RoleUtils";
import { useRecoilValue } from "recoil";
import { userState } from "../../modules/Client/Auth/Auth";

interface IBasicInfo {
  onPrevClick?: () => void;
  register: UseFormRegister<IJoinInput>;
  onClicks: { id: () => void; email: () => void };
  setValue: UseFormSetValue<IJoinInput>;
  // onSearch: () => void;
  // selectAdmin: (data: string, empId: string) => void;
  watch: UseFormWatch<IJoinInput>;
}

export default function BasicInfo({
  register,
  onPrevClick,
  onClicks,
  setValue,
  watch,
}: IBasicInfo) {
  const [masterSearchModal, setMasterSearchModal] = React.useState(false);
  const userData = useRecoilValue(userState);
  const role = RoleUtils.getClientRole(userData.role);

  const onMasterSearchClose = () => {
    // setValue('searchAdmin', '11111');
    // setValue("selectAdmin", '11111');

    setMasterSearchModal(false);
  };

  const onSearch = () => {
    const searchText: string = watch("searchAdmin");
    if (searchText.length < 2) return;
    setMasterSearchModal(true);
  };

  const selectAdmin = (data: string, empId: string) => {
    setValue("selectedAdmin", data);
    setValue("selectAdmin", empId);
    setMasterSearchModal(false);
  };

  return (
    <>
      <InputsContainer>
        <DetailSection>
          <DetailSection.Title
            text="1.기본정보 등록"
            message="은 필수 입력 항목입니다."
          />
          <Inputs>
            <Inputs.InputSet
              labelText="아이디"
              labelIcon={<UserInfo />}
              type="text"
              placeholder="아이디를 입력하세요.(영문, 숫자 20자리 이내)"
              buttonText="중복확인"
              buttonClick={onClicks.id}
              register={register("id", {
                required: "아이디를 입력하세요.(영문, 숫자 20자리 이내)",
                onChange() {
                  setValue("idCheck", false);
                },
              })}
              w={160}
              maxLength={20}
              importantCheck
            />
            <Inputs.InputSet
              labelText="비밀번호"
              labelIcon={<img src={home} alt=" 아이콘" />}
              type="password"
              placeholder="비밀번호를 입력하세요.(영문, 숫자, 특수문자 포함 9자리 이상)"
              register={register("password", {
                required:
                  "비밀번호를 입력하세요.(영문, 숫자, 특수문자 포함 9자리 이상)",
              })}
              w={160}
              importantCheck
            />
            <Inputs.InputSet
              labelText=""
              type="password"
              placeholder="비밀번호 확인을 입력하세요."
              register={register("confirmPassword", {
                required: "비밀번호 확인을 입력하세요.",
              })}
              w={160}
            />
            <Inputs.InputSet
              labelText="업체명"
              labelIcon={<img src={bag} alt="아이콘" />}
              placeholder="업체명을 입력하세요.(사업자등록증에 기재된 업체명으로 한글, 공백 15자 내외)"
              type="text"
              register={register("companyName", {
                required:
                  "업체명을 입력하세요.(사업자등록증에 기재된 업체명으로 한글, 공백 15자 내외)",
              })}
              importantCheck
              w={160}
              maxLength={15}
            />
            <Inputs.InputSet
              labelText="담당자 이름"
              labelIcon={<UserInfo />}
              placeholder="담당자 이름을 입력하세요."
              type="text"
              register={register("adminName", {
                required: "담당자 이름을 입력하세요.",
              })}
              importantCheck
              w={160}
              readOnly
            />
            <Inputs.InputSet
              labelText="담당자 전화번호"
              labelIcon={<img src={smartPhone} alt="아이콘" />}
              type="string"
              placeholder="- 없이 담당자 전화번호를 입력하세요."
              register={register("phone", {
                required: "담당자 전화번호를 입력하세요.",
                pattern: {
                  value: Regex.phoneRegExp,
                  message: "알맞은 형식의 담당자 전화번호를 입력하세요.",
                },
              })}
              importantCheck
              w={160}
              readOnly
            />
            <Inputs.InputSet
              labelText="이메일"
              labelIcon={<img src={mail} alt="아이콘" />}
              type="text"
              placeholder="이메일을 입력하세요.(확인 가능한 이메일 주소를 입력하세요.)"
              buttonText="인증메일 전송"
              buttonClick={onClicks.email}
              register={register("email", {
                required:
                  "이메일을 입력하세요.(확인 가능한 이메일 주소를 입력하세요.)",
                pattern: {
                  value: Regex.emailRegex,
                  message: "알맞은 형식의 이메일을 입력하세요.",
                },
                onChange() {
                  setValue("emailCheck", false);
                },
              })}
              importantCheck
              w={160}
            />
            <Inputs.InputSet
              labelText={`서부발전\n담당자 검색`}
              labelIcon={<UserInfo />}
              type="text"
              buttonText="검색"
              buttonClick={onSearch}
              register={register("searchAdmin", {})}
              placeholder="서부 담당자 이름을 입력 후 검색 버튼을 눌러주세요."
              importantCheck
              w={160}
            />
            <Inputs.InputSet
              labelText={`선택한\n서부발전 담당자`}
              labelIcon={<UserInfo />}
              register={register("selectedAdmin", {
                // required: "서부 담당자 이름을 입력 후 검색 버튼을 눌러주세요.",
              })}
              type="text"
              placeholder="담당자를 선택해주세요."
              readOnly
              importantCheck
              w={160}
            />
          </Inputs>
        </DetailSection>
      </InputsContainer>
      <p style={{color : 'red'}}>
        * 가입 후 제안서평가 완료 시 자동으로 회원이 삭제 되오니 이점 유의하시기 바랍니다.
      </p>
      {masterSearchModal && (
        <MasterSelectModal
          onClose={onMasterSearchClose}
          selectAdmin={selectAdmin}
          adminName={watch("searchAdmin")}
          role={role}
        />
      )}
      <BigButtonContainer>
        <BigButton text="이전" white onClick={onPrevClick} />
        <BigButton text="완료" submit />
      </BigButtonContainer>
    </>
  );
}

const InputsContainer = styled.div``;

const BigButtonContainer = styled.div`
  width: 100%;
  margin-top: 32px;
  display: flex;
  justify-content: center;
  gap: 24px;
`;
