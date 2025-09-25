import { UseFormRegister, UseFormSetValue, UseFormWatch } from "react-hook-form";
import styled from "styled-components";
import UserInfo from "../../assets/Icon/UserInfo";
import BigInputButton from "../../components/Common/Button/BigInputButton";
import { Inputs, LabelRadioBtn } from "../../components/Common/Input/InputSet1";
import ScrollSet from "../../components/Common/ScrollSet";
import { IAgreementInput } from "../../interface/Agreement/AgreementInput";
import theme from "../../theme";
import { ViewObjectWrapperBox } from "../../theme/common";
import { Regex } from "../../utils/RegularExpression";
import phone from "../../assets/Icon/smartphone.svg";
import mail from "../../assets/Icon/mail.svg";
import home from "../../assets/Icon/home.svg";
import money from "../../assets/Icon/money.svg";
import coin from "../../assets/Icon/coin.svg";
import userCheck from "../../assets/Icon/userCheck.svg";
import { useRecoilValue } from "recoil";
import { userState } from "../../modules/Client/Auth/Auth";
import RoleUtils from "../../utils/RoleUtils";
import bagIcon from "../../assets/Icon/bag.svg";
import companyIcon from "../../assets/Icon/company.svg";
import userCheckIcon from "../../assets/Icon/userCheck.svg";
import file from "../../assets/Icon/file.svg";
import MasterSelectModal from "../../components/Modal/Agreement/MasterSelectModal";
import { useEffect, useState } from "react";
import NicePhone from "../../components/Modal/Nice/NicePhone";

export default function AgreementView({
  register,
  setValue,
  onSubmit,
  onClicks,
  watch,
  term,
  passData,
  onChange,
  onPassDataReset,
  custumError
}: {
  register: UseFormRegister<IAgreementInput>;
  setValue: UseFormSetValue<IAgreementInput>;
  onSubmit: any;
  onClicks: {
    accountClick: () => void;
    phone: () => void;
    search: () => void;
  };
  watch: UseFormWatch<IAgreementInput>;
  term: string;
  passData: string;
  onChange: (name: string, value: string) => void;
  onPassDataReset: () => void;
  custumError: string | null;
}) {
  const userData = useRecoilValue(userState);
  const role = RoleUtils.getClientRole(userData.role);

  const [masterSearchModal, setMasterSearchModal] = useState(false);

  const onMasterSearchClose = () => {
    setMasterSearchModal(false);
  };

  const onSearch = () => {
    const searchText: string = watch("admin");
    if (searchText.length < 2) return;
    setMasterSearchModal(true);
  };

  const selectAdmin = (data: string, empId: string) => {
    setValue("selectAdmin", data);
    onChange("empId", empId);
    setMasterSearchModal(false);
  };

  return (
    <>
      <ViewObjectWrapperBox detail top>
        <h1 className="viewTitle">계좌이체거래약정서 발급 신청</h1>
        <form
          onSubmit={(e: any) => {            
            e.preventDefault();
            if (e.code === "Enter") return alert("!");
            onSubmit();
          }}
        >
          <div className="mainContent">
            <AgreementContainer>
              <div className="infoContainer">
                <ScrollSet
                  title="1. 개인정보 수집 및 이용 약관 안내"
                  text={term}
                  // agreeText="개인정보 수집 및 이용 동의서에 동의합니다."
                  // register={register("check1", {
                  //   required: "개인정보 수집 및 이용 동의서를 동의해주세요.",
                  // })}
                />
              </div>
              <div className="infoContainer">
                <h2>
                  2. 기본 정보 입력{" "}
                  <span>
                    ( <span style={{ color: "#DA0043" }}>*</span> 은 필수 입력 항목입니다. )
                  </span>
                </h2>
                <Inputs>
                  {role === "company" && (
                    <>
                      <Inputs.InputSet
                        labelText="업체명"
                        labelIcon={<img src={companyIcon} alt="업체명 아이콘" />}
                        register={register("companyName", {
                          required: "업체명을 입력하세요.(한글, 공백 포함 15자 이내)",
                        })}
                        placeholder="업체명을 입력해주세요.(한글, 공백 포함 15자 이내)"
                        type="text"
                        importantCheck
                        maxLength={15}
                      />
                    </>
                  )}

                  {role === "company" ? (
                    <>
                      <Inputs.InputSet
                        labelText="대표자 성명"
                        labelIcon={<UserInfo />}
                        register={register("name", {
                          required: "대표자 성명을 입력하세요.(한글 17자 이내) 한명의 대표자만 입력하세요.",
                          // pattern : {
                          //   value: /^[a-zA-Z가-힣]{0,3}$/,
                          //   message: "대표자를 2명 입력할 경우 계좌등록에 문제가 발생할 수 있습니다. 대표자는 1명만 입력해주세요.",
                          // }
                        })}
                        placeholder="대표자 성명을 입력하세요.(한글 17자 이내) 한명의 대표자만 입력하세요."
                        type="text"
                        importantCheck
                        maxLength={17}
                      />
                      {custumError && 
                        <span style={{ color: "red" }}>{custumError}</span>
                      }
                    </>
                  ) : (
                    <Inputs.InputSet
                      labelText="이름"
                      labelIcon={<UserInfo />}
                      register={register("name1", {
                        required:
                          "본인인증 버튼을 눌러주세요. 본인인증 완료 후 이름이 자동으로 입력됩니다.",
                      })}
                      type="text"
                      readOnly
                      placeholder="본인인증 버튼을 눌러주세요. 본인인증 완료 후 이름이 자동으로 입력됩니다."
                      importantCheck
                    />
                  )}

                  {role === "company" && (
                    <>
                      <Inputs.InputSet
                        labelIcon={<img src={companyIcon} alt="사업자등록번호 아이콘" />}
                        labelText="사업자등록번호"
                        register={register("companyNum", {
                          required: "사업자등록번호를 입력하세요.(숫자 10자리 이내)",                          
                          // maxLength: {
                          //   value: 10,
                          //   message: "알맞은 형식의 사업자등록번호를 입력하세요.",
                          // },
                        })}
                        type="text"
                        // maxLength={10}
                        placeholder="사업자등록번호를 입력하세요.(숫자 10자리 이내)"
                        importantCheck
                      />
                      <LabelRadioBtn
                        icon={<img src={companyIcon} alt="사업자등록번호 아이콘" />}
                        label="구분"
                        yesText="법인사업자"
                        noText="개인사업자"
                        register={register("corporateType")}
                        accept={watch("corporateType")}
                        guide
                      />

                      {watch("corporateType") && (
                        <>
                          {watch("corporateType") === "yes" && (
                            <Inputs.InputSet
                              labelText="법인등록번호"
                              labelIcon={<img src={companyIcon} alt="아이콘" />}
                              register={register("corporateNumber", {
                                required: "법인등록번호를 입력하세요.(숫자 18자리 이내)",
                              })}
                              placeholder="법인등록번호를 입력하세요.(숫자 18자리 이내)"
                              type="text"
                              maxLength={18}
                              importantCheck
                            />
                          )}
                          {watch("corporateType") === "no" && (
                            <Inputs.InputSet
                              labelText="생년월일"
                              labelIcon={<UserInfo />}
                              register={register("companyBirthNum", {
                                required: "계좌 명의자의 생년월일을 입력하세요.(숫자 6자리)",
                              })}
                              type="text"
                              placeholder="계좌 명의자의 생년월일을 입력하세요.(숫자 6자리)"
                              maxLength={6}
                              importantCheck
                            />
                          )}
                        </>
                      )}

                      <Inputs.InputSet
                        labelText="업태"
                        labelIcon={<img src={companyIcon} alt="아이콘" />}
                        register={register("businessConditions", {
                          required: "사업의 업태를 입력하세요.(한글 15자리 이내)",
                        })}
                        maxLength={15}
                        placeholder="사업의 업태를 입력하세요.(한글 15자리 이내)"
                        type="text"
                        importantCheck
                      />
                      <Inputs.InputSet
                        labelText="업종"
                        labelIcon={<img src={companyIcon} alt="아이콘" />}
                        register={register("businessType", {
                          required: "사업의 업종을 입력하세요.(한글 15자리 이내)",
                        })}
                        maxLength={15}
                        placeholder="사업의 업종을 입력하세요.(한글 15자리 이내)"
                        type="text"
                        importantCheck
                      />
                      <Inputs.InputSet
                        labelText="담당자 이름"
                        labelIcon={<img src={userCheckIcon} alt="아이콘" />}
                        register={register("mangerName", {
                          required:
                            "본인인증 버튼을 눌러주세요. 본인인증 완료 후 담당자 이름이 자동으로 입력됩니다.",
                          disabled: true,
                        })}
                        placeholder="본인인증 버튼을 눌러주세요. 본인인증 완료 후 담당자 이름이 자동으로 입력됩니다."
                        type="text"
                        importantCheck
                      />
                    </>
                  )}
                  {role === "personal" && (
                    <Inputs.InputSet
                      labelText="생년월일"
                      labelIcon={<UserInfo />}
                      register={register("registerNum1", {
                        required: "생년월일 6자리를 입력하세요.",
                      })}
                      type="text"
                      placeholder="본인인증 버튼을 눌러주세요. 본인인증 완료 후 생년월일이 자동으로 입력됩니다."
                      readOnly
                      maxLength={6}
                      importantCheck
                    />
                  )}
                  <Inputs.InputSet
                    labelText={role === "company" ? "담당자 전화번호" : "전화번호"}
                    labelIcon={<img src={phone} alt="아이콘" />}
                    register={register("phone", {
                      required: `${
                        role === "company" ? "담당자 전화번호" : "전화번호"
                      }를 입력하세요`,
                      pattern: {
                        value: Regex.phoneRegExp,
                        message: `본인인증 버튼을 눌러주세요. 본인인증 완료 후 ${
                          role === "company" ? "담당자" : ""
                        } 전화번호가 자동으로 입력됩니다.`,
                      },
                    })}
                    readOnly
                    placeholder={`본인인증 버튼을 눌러주세요. 본인인증 완료 후 ${
                      role === "company" ? "담당자 " : ""
                    }전화번호가 자동으로 입력됩니다.`}
                    type="text"
                    buttonText="본인인증"
                    buttonClick={onClicks.phone}
                    importantCheck
                  />

                  <Inputs.InputSet
                    labelText="이메일"
                    labelIcon={<img src={mail} alt="아이콘" />}
                    register={register("email", {
                      required: "이메일을 입력하세요.(확인 가능한 이메일 주소를 입력하세요.)",
                    })}
                    type="text"
                    placeholder="이메일을 입력하세요.(확인 가능한 이메일 주소를 입력하세요.)"
                    importantCheck
                  />
                  {/* <div>
                    <Inputs.Label labelText="주소" labelIcon={<img src={home} alt="아이콘" />} />
                    <Inputs.ClickInput
                      onClick={onClicks.search}
                      text={watch("address") ? watch("address") : "주소를 입력하세요."}
                    />
                    <Inputs.Button text="검색" onClick={onClicks.search} />
                  </div> */}
                  <Inputs.InputSet
                    type="text"
                    labelIcon={<img src={home} alt="아이콘" />}
                    labelText="주소"
                    buttonText="검색"
                    register={register("address", {
                      required: "주소를 선택해주세요.",
                    })}
                    placeholder="주소를 선택해주세요."
                    buttonClick={onClicks.search}
                    inputClick={onClicks.search}
                    readOnly
                    importantCheck
                  />
                  <div className="smallGap">
                    <Inputs.Label labelText="" />
                    <Inputs.Input
                      register={register("fullAddress", { required: "상세주소를 입력하세요." })}
                      type="text"
                      placeholder="상세주소를 입력하세요."
                    />
                  </div>
                  <Inputs.InputSet
                    labelText="우편번호"
                    labelIcon={<img src={mail} alt="아이콘" />}
                    register={register("postCode1")}
                    type="text"
                    placeholder="주소를 선택하시면 자동으로 입력됩니다."
                    readOnly
                    importantCheck
                  />
                </Inputs>
              </div>
              <div className="infoContainer">
                <h2>3. 계좌 이체 거래은행</h2>
                <Inputs>
                  <div>
                    <Inputs.Label
                      labelText="은행명"
                      labelIcon={<img src={money} alt="아이콘" />}
                      importantCheck
                    />
                    <Inputs.Select
                      register={register("bankCode", {
                        required: "은행명을 선택하세요.",
                        onChange() {
                          setValue("accountCheck", false);
                        },
                      })}
                    >
                      <option value="">은행명을 선택하세요.</option>
                      <option value="002-산업은행">산업은행</option>
                      <option value="003-기업은행">기업은행</option>
                      <option value="004-국민은행">국민은행</option>
                      <option value="007-수협">수협</option>
                      <option value="011-농협">농협</option>
                      <option value="020-우리은행">우리은행</option>
                      <option value="023-SC제일은행">SC제일은행</option>
                      <option value="027-한국씨티은행">한국씨티은행</option>
                      <option value="031-대구은행">대구은행</option>
                      <option value="032-부산은행">부산은행</option>
                      <option value="034-광주은행">광주은행</option>
                      <option value="035-제주은행">제주은행</option>
                      <option value="037-전북은행">전북은행</option>
                      <option value="039-경남은행">경남은행</option>
                      <option value="045-새마을금고">새마을금고</option>
                      <option value="048-신협">신협</option>
                      <option value="071-우체국">우체국</option>
                      <option value="081-하나은행">하나은행</option>
                      <option value="088-신한은행">신한은행</option>
                    </Inputs.Select>
                  </div>
                  <Inputs.InputSet
                    labelIcon={<img src={coin} alt="아이콘" />}
                    labelText="계좌번호"
                    register={register("account", {
                      required: "계좌번호를 입력하세요.(숫자 18자리 이내)",
                      onChange() {
                        setValue("accountCheck", false);
                      },
                    })}
                    placeholder="계좌번호를 입력하세요.(숫자 18자리 이내)"
                    type="text"
                    importantCheck
                    maxLength={18}
                  />
                  <Inputs.InputSet
                    labelText="예금주"
                    labelIcon={<img src={userCheck} alt="아이콘" />}
                    placeholder="예금주를 입력하세요.(정확한 예금주 이름으로 입력해주세요.)"
                    register={register("accountName", {
                      required: "예금주를 입력하세요.(정확한 예금주 이름으로 입력해주세요.)",
                      onChange() {
                        setValue("accountCheck", false);
                      },
                    })}
                    type="text"
                    buttonText="유효성 검사"
                    buttonClick={onClicks.accountClick}
                    importantCheck
                  />
                </Inputs>
              </div>
              <div className="infoContainer">
                <h2>4. 파일 업로드</h2>
                <div className="uploadInfo">
                  <h3>
                    계좌이체 거래 약정서 발급을 위해 아래의 파일을 업로드 해주세요.(* pdf, png, jpg,
                    jpeg 파일을 사용해주세요.)
                  </h3>
                  <p className="pdf-guide">
                    A4 세로 사이즈(210*297mm)로 스캔된 파일의 사용을 권장합니다.
                  </p>
                  <p className="fileList">
                    {role === "company" && (
                      <>
                        <span>* 사업자등록증 사본</span>
                        <span>* 인감증명서 사본</span>
                      </>
                    )}
                    {role === "personal" && <span>* 신분증 사본</span>}
                    <span>* 통장 사본</span>
                  </p>
                  <div className="fileList">
                    <p>서부 담당자가 전체 내용을 확인할 수 있도록 원본파일을 업로드해주세요. </p>
                    <p>서부 담당자가 내용 확인 후 삭제 처리 합니다.</p>
                  </div>
                </div>
                <Inputs>
                  {role === "company" && (
                    <>
                      <div>
                        <Inputs.Label
                          labelText="사업자등록증 사본"
                          labelIcon={<img src={file} alt="아이콘" />}
                          importantCheck
                        />
                        <Inputs.File
                          text={
                            watch("BusinessRegistration") &&
                            watch("BusinessRegistration").length !== 0
                              ? watch("BusinessRegistration")[0]?.name
                              : "사업자등록증 사본을 업로드해주세요."
                          }
                          register={register("BusinessRegistration")}
                        />
                      </div>
                      <div>
                        <Inputs.Label
                          labelText="인감증명서 사본"
                          labelIcon={<img src={file} alt="아이콘" />}
                          importantCheck
                        />
                        <Inputs.File
                          text={
                            watch("certificateFile") && watch("certificateFile").length !== 0
                              ? watch("certificateFile")[0]?.name
                              : "인감증명서 사본을 업로드해주세요."
                          }
                          register={register("certificateFile")}
                        />
                      </div>
                    </>
                  )}
                  {role === "personal" && (
                    <div>
                      <Inputs.Label
                        labelText="신분증 사본"
                        labelIcon={<img src={file} alt="아이콘" />}
                        importantCheck
                      />
                      <Inputs.File
                        text={
                          watch("IDFile") && watch("IDFile").length !== 0
                            ? watch("IDFile")[0]?.name
                            : "신분증 사본을 업로드해주세요."
                        }
                        register={register("IDFile", {
                          required: "신분증 사본을 업로드해주세요.",
                        })}
                      />
                    </div>
                  )}
                  <div>
                    <Inputs.Label
                      labelText="통장사본"
                      labelIcon={<img src={file} alt="아이콘" />}
                      importantCheck
                    />
                    <Inputs.File
                      text={
                        watch("bankBook") && watch("bankBook").length !== 0
                          ? watch("bankBook")[0]?.name
                          : "이용하실 계좌의 통장사본을 업로드해주세요."
                      }
                      register={register("bankBook", {
                        required: "이용하실 계좌의 통장사본을 업로드해주세요.",
                      })}
                    />
                  </div>
                  <div>
                    <Inputs.Label
                      labelText="기타파일"
                      labelIcon={<img src={file} alt="아이콘" />}
                    />
                    <Inputs.File
                      text={
                        watch("etcFile") && watch("etcFile").length !== 0
                          ? watch("etcFile")[0]?.name
                          : "기타 파일을 업로드해주세요."
                      }
                      register={register("etcFile")}
                    />
                  </div>
                </Inputs>
              </div>
              <div className="infoContainer">
                <h2>5. 담당자 선택</h2>
                <Inputs>
                  <Inputs.InputSet
                    labelText="담당자 검색"
                    labelIcon={<UserInfo />}
                    type="text"
                    buttonText="검색"
                    buttonClick={onSearch}
                    register={register("admin", {})}
                    placeholder="서부 담당자 이름을 입력 후 검색 버튼을 눌러주세요."
                    importantCheck
                  />
                  <Inputs.InputSet
                    labelText="선택한 담당자"
                    labelIcon={<UserInfo />}
                    register={register("selectAdmin", {
                      required: "서부 담당자 이름을 입력 후 검색 버튼을 눌러주세요.",
                    })}
                    type="text"
                    placeholder="담당자를 선택해주세요."
                    readOnly
                    importantCheck
                  />
                </Inputs>
              </div>
            </AgreementContainer>
          </div>
          <div className="buttonContainer">
            <BigInputButton text="발급 요청" type="submit" />
          </div>
        </form>
      </ViewObjectWrapperBox>
      {masterSearchModal && (
        <MasterSelectModal
          onClose={onMasterSearchClose}
          adminName={watch("admin")}
          selectAdmin={selectAdmin}
          role={role}
        />
      )}
      {passData && <NicePhone passData={passData} onClose={onPassDataReset} />}
    </>
  );
}

const AgreementContainer = styled.div`
  .account {
    & > div:last-child {
      margin-top: -8px;
    }
  }
  .infoContainer {
    & > h2 {
      & > span {
        color: ${theme.colors.gray3};
      }
    }
  }

  .registerNum {
    display: flex;

    & > .registerNumInputs {
      width: 100%;
      display: flex;
      align-items: center;
      gap: 10px;
      input {
        height: 47px;
        border-radius: 5px;
        display: block;
        width: 100%;
        padding-left: 24px;
        line-height: 47px;
        flex: 1;
        border: 1px solid #cbd3e5;
      }
    }
  }
  .uploadInfo {
    display: flex;
    flex-direction: column;
    gap: 24px;
    color: ${theme.colors.body};
    p {
      font-weight: 400;
      font-size: 14px;
      line-height: 20px;
    }
    .pdf-guide {
      color: #af0808;
      line-height: 0;
    }
    > h3 {
      font-weight: 400;
      font-size: 14px;
      line-height: 20px;
    }
    .fileList {
      display: flex;
      flex-direction: column;
      gap: 16px;

      margin-top: 8px;
      &:last-child {
        margin-bottom: 16px;
      }
    }
  }
`;
