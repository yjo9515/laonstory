import styled from "styled-components";
import UserInfo from "../../assets/Icon/UserInfo";
import { IFile } from "../../controllers/Partners/Detail/Detail";
import {
  AgreementDetailRes,
  ICertificateFile,
  IEtcFile,
  IIdentityFile,
  IPassbookFile,
  LogDetailRes,
  UserDetailRes,
} from "../../interface/Master/MasterRes";
import { IMyInfoChangeRes, MyInfoRes } from "../../interface/MyInfo/MyInfoResponse";
import theme from "../../theme";
import DateUtils from "../../utils/DateUtils";
import { useClicks } from "../../utils/Modals";
import Right from "./Right";
import InputSet1, { LabelRadioBtn } from "../Common/Input/InputSet1";
import phone from "../../assets/Icon/smartphone.svg";
import mail from "../../assets/Icon/mail.svg";
import home from "../../assets/Icon/home.svg";
import bag from "../../assets/Icon/bag.svg";
import company from "../../assets/Icon/company.svg";
import UserAgreementList from "./UserAgreementList";
import { useRecoilValue } from "recoil";
import { userState } from "../../modules/Client/Auth/Auth";
import RoleUtils from "../../utils/RoleUtils";
import money from "../../assets/Icon/money.svg";
import coin from "../../assets/Icon/coin.svg";
import calendar from "../../assets/Icon/calendar.svg";
import { adjustmentAccountMap, paymentMap, methodMap, wtCodeMap } from "./additionalInformation";
import BigButton from "../Common/Button/BigButton";
import { useSendData } from "../../modules/Server/QueryHook";
import { personalDeleteUserApi } from "../../api/AuthApi";

import { AiOutlineFieldTime,AiOutlineFieldNumber, AiOutlineDatabase, AiOutlineLink,AiOutlineFileSearch, AiOutlineInfoCircle} from "react-icons/ai";
import { HiOutlineStatusOnline } from "react-icons/hi";
import { FaNetworkWired,FaUserTag,FaPeopleArrows  } from "react-icons/fa";
import { GrContactInfo } from "react-icons/gr";

import { useEffect, useState } from "react";
import { UrlMatching } from "../../utils/UrlMatching";


export default function Left({
  isButton = true,
  logData,
  detailData,
  myInfoData,
  role,
  isAdminDetail,
  register = {},
  accept,
  agreementData,
  agreementFileList,
  myInfoChangeInfoList,
  onDeleteClick,
  onDeleteUser,
  clickFileList,
  id,
  isDetail,
}: {
  isAdminDetail?: boolean;
  isButton?: boolean;
  detailData?: UserDetailRes;
  logData?: LogDetailRes;
  myInfoData?: MyInfoRes;
  register?: any;
  accept?: string;
  agreementData?: AgreementDetailRes;
  myInfoChangeInfoList?: IMyInfoChangeRes[];
  role?: string;
  agreementFileList?: [IIdentityFile, IPassbookFile, ICertificateFile, IEtcFile];
  onDeleteClick?: () => void;
  onDeleteUser?: () => void;
  clickFileList?: (file: IFile) => void;
  id?: string;
  isDetail?: boolean;
}) {
  const onClicks = useClicks(role || "");
  const userData = useRecoilValue(userState);  
  const detailRole = RoleUtils.getClientRole(userData.role);
  // const goInfo = (id: string, e) => {};
  const companyAgreement = agreementData?.manager;

  const [value, setValue] = useState('');  

  const isCompany = () => {
    if (
      detailRole === "company" ||
      myInfoData?.companyName ||
      detailData?.companyName ||
      agreementData?.manager
    )
      return true;
    return false;
  };

  // 조정계정 순서정렬 - entries 에선 강제로 숫자로 순서정렬함
  const adjustmentAccountMapFn = () => {
    let data: string[] = [];
    let array: any[] = [];

    Object.entries(adjustmentAccountMap).map((d) => {
      if (d[0].includes("21002900")) {
        data = d;
      } else {
        array.push(d);
      }
    });

    array.unshift(data);

    return { array };
  };  
  // 회원탈퇴 api
  const userDelete = useSendData<any, string>(
    
    personalDeleteUserApi,    
  );      

  const handleDelete = () => {
    console.log("Delete user initiated");
    // console.log(personalData?.data.id);
    // if(personalData?.data.id){
    //   userDelete.mutate(personalData.data.id, {
    //     onSuccess: () => {
    //       console.log("User deleted successfully");
    //     },
    //     onError: (error) => {
    //       console.error("Error while deleting user", error);
    //     },
    //   });
    // }    
  };  
  
  const deepParseJSON = (data: any): any => {
    // try {      
    //   return typeof data === "string" ? deepParseJSON(JSON.parse(data)) : data;
    // } catch (error) {
    //   return data;
    // }
    try {
      if (typeof data === "string") {
        
        if (
          data.startsWith("{") ||
          data.startsWith("[") ||
          data.startsWith('"')
        ) {
          const parsed = JSON.parse(data);
          return deepParseJSON(parsed);
        } else {
          return data; // 순수 문자열은 그대로 반환
        }        
      } else if (typeof data === "object" && data !== null) {
        const result: any = Array.isArray(data) ? [] : {};
        for (const key in data) {
          result[key] = deepParseJSON(data[key]);
        }
        return result;
      } else {
        return data;
      }
    } catch (error) {
      console.log(error);
      return data;
    }
  };

  const checkData = (data: any): any => {
    try {
      const parsed = deepParseJSON(data);
  
      // 1. items 배열 안에 response가 있을 경우
      if (parsed?.data?.items?.[0]?.response) {
        return deepParseJSON(parsed.data.items[0].response);
      }
  
      // 2. 그냥 data.response 가 있는 경우
      if (parsed?.data?.response) {
        return deepParseJSON(parsed.data.response);
      }
  
      // 3. 아무것도 없으면 전체 반환
      return parsed;
    } catch (error) {
      console.log(error);
      return data;
    }
  }
  
  const parseJSON = (data: any) : any => {
    try{
      return JSON.parse(data);
    }catch (error){      
      return {};
    }
  }      
  return (    
    <LeftBox>
      {role === "log" && logData != null && (        
        <>
          <div className="infoContainer">
            <InputSet1
              icon={<UserInfo />}
              label="번호"
              text={logData?.id}
              disabled
            />            
            <InputSet1
              icon={<AiOutlineFieldNumber />}
              label="관리자 사번"
              text={logData?.master}
              disabled
            />
            <InputSet1
              icon={<FaUserTag />}
              label="관리자 이름"
              text={parseJSON(logData?.user).name}
              disabled
            />
            <InputSet1     
              icon={<AiOutlineInfoCircle/>}         
              label="유저 정보"
              text={parseJSON(logData?.user).role}              
              disabled
            />
            <InputSet1
              icon={< GrContactInfo/>}
              label="개인 정보"
              text={logData?.infoCount ?? ""}
              disabled
            />
            <InputSet1     
              icon={<FaPeopleArrows/>}         
              label="주체 정보"
              text={
                logData?.who?.personal?.name ?
                logData?.who?.personal?.name
                : logData?.who?.company?.name ? 
                logData?.who?.company?.name
                // :Array.isArray(logData?.who) ?logData?.who.filter((name: any, index: any) => name.indexOf(name) === index).join(",") : ""}              
                :logData?.who?.join(", ")}    
              disabled
            />
            <InputSet1     
              icon={<AiOutlineDatabase/>}         
              label="행위 정보"
              text={ UrlMatching[
                logData?.url
                .replace(/\?.*$/, "") // 쿼리 제거
                .replace(
                  /\/([0-9]+|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})(?=\/|$)/g,
                  "/:id"
                ) ?? ""]?.[logData?.action ?? ""]?.[0] ?? logData?.action}              
              disabled
            />
            <InputSet1              
              label="URL 정보"
              // text={UrlMatching[logData?.url.replace(/\/\d+/g, "/:id") ?? ""] || logData?.url}
              icon={<AiOutlineLink/>}
              text={ UrlMatching[
                logData?.url
                .replace(/\?.*$/, "") // 쿼리 제거
                .replace(
                  /\/([0-9]+|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})(?=\/|$)/g,
                  "/:id"
                )
                 ?? ""]?.[logData?.action ?? ""]?.[1] ?? logData?.url}              
              disabled
            />
            <InputSet1                          
              label="응답코드"
              icon={<FaNetworkWired/>}
              text={logData?.statusCode.toString()}
              disabled
            />
            <InputSet1              
              label="사용자 IP"
              icon={<HiOutlineStatusOnline/>}
              text={logData?.ip}
              disabled
            />            
            <InputSet1              
              label="응답내역"
              icon={<AiOutlineFileSearch/>}
              // text={checkData(logData?.response)}
              text={logData?.response ? JSON.stringify(checkData(logData?.response))  : ""}
              heightType="content"
              disabled
            />
            <InputSet1
              icon={<AiOutlineFieldTime />}
              label="발생일시"
              text={DateUtils.dateFormat(logData?.createdAt)}
              disabled
            />            
          </div>
        </>
      )

      }

      {role !== "agreement" && role !== "log" && (
        <>
          <div className="infoContainer">
            <h2>(1) 기본정보</h2>
            <InputSet1
              icon={<UserInfo />}
              label="아이디"
              text={myInfoData?.id || detailData?.id}
              disabled
            />
            {isCompany() && (
              <InputSet1
                icon={<img src={company} alt="아이콘" />}
                label="업체명"
                text={myInfoData?.companyName || detailData?.companyName}
                disabled
              />
            )}
            {isCompany() && (
              <InputSet1
                icon={<UserInfo />}
                label="담당자 이름"
                text={myInfoData?.name || detailData?.name}
                disabled
              />
            )}
            {isCompany() && (
              <InputSet1
                icon={<img src={phone} alt="아이콘" />}
                label="담당자 전화번호"
                text={myInfoData?.phone || detailData?.phone}
                disabled
                isButton={isButton}
                buttonText="담당자 정보변경"
                onClick={onClicks.admin}
              />
            )}
            {!isCompany() && (
              <InputSet1
                icon={<UserInfo />}
                label="이름"
                text={myInfoData?.name || detailData?.name}
                disabled
              />
            )}
            {!isCompany() && (
              <InputSet1
                icon={<img src={phone} alt="아이콘" />}
                label="전화번호"
                text={myInfoData?.phone || detailData?.phone}
                isButton={isButton}
                buttonText="전화번호 변경"
                onClick={onClicks.phone}
                disabled
              />
            )}
            <InputSet1
              icon={<img src={mail} alt="아이콘" />}
              label="이메일"
              text={myInfoData?.email || detailData?.email}
              isButton={isButton}
              buttonText="이메일주소 변경"
              onClick={onClicks.email}
              disabled
            />
            {!isAdminDetail && (
              <InputSet1
                icon={<UserInfo />}
                label="비밀번호"
                text="************"
                isButton={isButton}
                buttonText="비밀번호 변경"
                onClick={onClicks.password}
                disabled
              />
            )}
          </div>
          {role !== "userAgreement" && (
            <div className="infoContainer">
              <h2>(2) 정보변경내역</h2>
              <Right
                title="정보변경내역"
                agreementFileList={agreementFileList}
                myInfoChangeInfoList={myInfoChangeInfoList}
                role={role}
                onDeleteClick={onDeleteClick}
                clickFileList={clickFileList}
              />
            </div>
          )}
          {role === "userAgreement" && (
            <div className="infoContainer">
              <UserAgreementList id={id} />
            </div>
          )}
        </>
      )}
      {role === "agreement" && (
        <>
          {companyAgreement ? (
            <div className="infoContainer">
              <h2>(1) 기본정보</h2>
              <InputSet1
                icon={<img src={company} alt="아이콘" />}
                text={agreementData?.name || ""}
                label="업체명"
                disabled
              />
              <InputSet1
                icon={<UserInfo />}
                text={agreementData?.contractor || ""}
                label="대표자 이름"
                disabled
              />
              <InputSet1
                icon={<UserInfo />}
                text={agreementData?.idNumber || ""}
                label="사업자등록번호"
                disabled
              />
              <InputSet1
                icon={<UserInfo />}
                text={agreementData?.manager || ""}
                label="담당자 이름"
                disabled
              />
              <InputSet1
                icon={<img src={phone} alt="아이콘" />}
                text={agreementData?.phone || ""}
                label="담당자 전화번호"
                disabled
              />
              <InputSet1
                icon={<img src={mail} alt="아이콘" />}
                text={agreementData?.email || ""}
                label="이메일"
                disabled
              />
              <InputSet1
                icon={<img src={home} alt="아이콘" />}
                text={agreementData?.address || ""}
                label="주소"
                disabled
              />
              <InputSet1
                icon={<img src={company} alt="아이콘" />}
                text={agreementData?.businessType || ""}
                label="업태"
                disabled
              />
              <InputSet1
                icon={<img src={company} alt="아이콘" />}
                text={agreementData?.businessConditions || ""}
                label="업종"
                disabled
              />
            </div>
          ) : (
            <div className="infoContainer">
              <h2>(1) 기본정보</h2>
              <InputSet1
                icon={<UserInfo />}
                text={agreementData?.userId || ""}
                label="아이디"
                disabled
              />

              {!isCompany() && (
                <>
                  <InputSet1
                    icon={<UserInfo />}
                    text={agreementData?.name || ""}
                    label="이름"
                    disabled
                  />
                  <InputSet1
                    icon={<UserInfo />}
                    text={agreementData?.idNumber || ""}
                    label="생년월일"
                    disabled
                  />
                </>
              )}
              {isCompany() && (
                <>
                  <InputSet1
                    icon={<img src={bag} alt="아이콘" />}
                    text={agreementData?.name || ""}
                    label="업체명"
                    disabled
                  />
                  <InputSet1
                    icon={<UserInfo />}
                    text={agreementData?.name || ""}
                    label="대표자 성명"
                    disabled
                  />
                  <InputSet1
                    icon={<img src={company} alt="아이콘" />}
                    text={agreementData?.idNumber || ""}
                    label="사업자등록번호"
                    disabled
                  />
                  <InputSet1
                    icon={<img src={company} alt="아이콘" />}
                    text={agreementData?.idNumber || ""}
                    label="법인등록번호"
                    disabled
                  />
                  <InputSet1
                    icon={<img src={company} alt="아이콘" />}
                    text={agreementData?.idNumber || ""}
                    label="업태"
                    disabled
                  />
                  <InputSet1
                    icon={<img src={company} alt="아이콘" />}
                    text={agreementData?.idNumber || ""}
                    label="업종"
                    disabled
                  />
                </>
              )}
              {!isCompany() && (
                <InputSet1
                  icon={<img src={phone} alt="아이콘" />}
                  text={agreementData?.phone || ""}
                  label="전화번호"
                  disabled
                />
              )}
              {isCompany() && (
                <>
                  <InputSet1
                    icon={<UserInfo />}
                    text={agreementData?.phone || ""}
                    label="담당자 이름"
                    disabled
                  />
                  <InputSet1
                    icon={<img src={phone} alt="아이콘" />}
                    text={agreementData?.phone || ""}
                    label="담당자 전화번호"
                    disabled
                  />
                </>
              )}
              <InputSet1
                icon={<img src={mail} alt="아이콘" />}
                text={agreementData?.email || ""}
                label="이메일"
                disabled
              />
              <InputSet1
                icon={<img src={home} alt="아이콘" />}
                text={agreementData?.address || ""}
                label="주소"
                disabled
              />
              <InputSet1
                icon={<img src={mail} alt="아이콘" />}
                text={agreementData?.postCode || ""}
                label="우편번호"
                disabled
              />
            </div>
          )}

          <div className="infoContainer">
            <h2>(2) 계좌이체 거래은행 정보</h2>
            <InputSet1
              icon={<img src={money} alt="" />}
              text={agreementData?.accountBank || ""}
              label="은행명"
              disabled
            />
            <InputSet1
              icon={<img src={coin} alt="" />}
              text={agreementData?.accountNumber || ""}
              label="계좌번호"
              disabled
            />
            <InputSet1
              icon={<UserInfo />}
              text={agreementData?.accountName || ""}
              label="예금주"
              disabled
            />
            <InputSet1
              icon={<img src={calendar} alt="" />}
              text={DateUtils.dateToFormat(agreementData?.createdAt, "YYYY-MM-DD HH:mm") || ""}
              label="신청일시"
              disabled
            />
            {/* <InputSet1
              icon={<UserInfo />}
              text={agreementData?.name || ""}
              label="담당자 정보"
              disabled
            /> */}
          </div>
          <div className="infoContainer">
            <h2>(3) 담당자 추가 정보 입력</h2>
            {!isCompany() && (
              <InputSet1
                icon={<UserInfo />}
                text={agreementData?.phone || ""}
                label={`신청인\n주민등록번호`}
                register={register("residentRegistrationNumber", {
                  require:
                    "아래 첨부파일의 신분증 사본을 확인 후 주민등록번호를 입력하세요.(숫자 16자리 이내)",
                })}
                placeholder="아래 첨부파일의 신분증 사본을 확인 후 주민등록번호를 입력하세요.(숫자 16자리 이내)"
                importantCheck
                maxLength={16}
                onKeyDown={(e) => {
                  const allowedKeys = [
                    'Backspace', 'Delete', 'ArrowLeft', 'ArrowRight', 'Tab', 'Enter'
                  ];
                
                  if (allowedKeys.includes(e.key)) {
                    return; // 제어 키는 허용
                  }
                  const regex = /[-!@#$%^&*()_+=~[\]{}|;':",./<>?]/g;
                  
                  if (regex.test(e.key)) {
                    e.preventDefault();
                  }
                }}
                onChange={
                  (e) => {   
                    const regex = /[-!@#$%^&*()_+=~[\]{}|;':",./<>?]/g;                 
                    const cleanValue = e.target.value.replace(regex, '');
                    setValue(cleanValue);
                  }
                }
                value={value}
                onPaste={(e)=>{
                  const regex = /[-!@#$%^&*()_+=~[\]{}|;':",./<>?]/g;
                  const pasted = e.clipboardData.getData('Text');                  
                  if (regex.test(pasted)) {
                    e.preventDefault(); // 붙여넣기 방지
                  }
                }}
                
              />
            )}
            <InputSet1
              icon={<img src={money} alt="" />}
              label="조정계정"
              isSelect
              selectOption={
                <>
                  <option value="">조정계정을 선택해주세요.</option>
                  {adjustmentAccountMapFn().array.map((item, index) => (
                    <option key={index} value={item[0]}>
                      {index === 0 && "*"} {item[0]} : {item[1]}
                    </option>
                  ))}
                </>
              }
              importantCheck
              register={register("adjustmentAccount", { require: "조정계정을 선택해주세요." })}
            />
            <InputSet1
              icon={<img src={money} alt="" />}
              label="지급조건"
              isSelect
              selectOption={
                <>
                  <option value="">지급조건을 선택해주세요.</option>
                  {Object.entries(paymentMap).map((item, index) => (
                    <option key={index} value={item[0]}>
                      {index === 0 && "*"} {item[0]} : {item[1]}
                    </option>
                  ))}
                </>
              }
              register={register("payment")}
              importantCheck
            />
            <InputSet1
              icon={<img src={money} alt="" />}
              label="지급방법"
              isSelect
              selectOption={
                <>
                  <option value="">지급방법을 선택해주세요.</option>
                  {Object.entries(methodMap).map((item, index) => (
                    <option key={index} value={item[0]}>
                      {index === 0 && "*"} {item[0]} : {item[1]}
                    </option>
                  ))}
                </>
              }
              register={register("method")}
              importantCheck
            />
            {!isCompany() && (
              <InputSet1
                icon={<img src={money} alt="" />}
                label="원천세코드"
                isSelect
                selectOption={
                  <>
                    <option value="">원천세코드를 선택해주세요.</option>
                    {Object.entries(wtCodeMap).map((item, index) => (
                      <option key={index} value={item[0]}>
                        {item[0]} : {item[1]}
                      </option>
                    ))}
                  </>
                }
                register={register("wtCode")}
                importantCheck
              />
            )}
          </div>
          <div className="infoContainer">
            <h2>(4) 첨부파일 확인 및 승인여부 결정</h2>
            <Right
              title="첨부파일"
              agreementFileList={agreementFileList}
              myInfoChangeInfoList={myInfoChangeInfoList}
              role={role}
              onDeleteClick={onDeleteClick}
              clickFileList={clickFileList}
            />
            <LabelRadioBtn label="승인 여부" register={register("accept")} accept={accept} />
            {accept === "no" && (
              <InputSet1
                label="반려사유"
                placeholder="반려사유를 입력해주세요."
                register={register("reason", { required: "반려사유를 입력해주세요." })}
              />
            )}
            {/* {agreementData?.status === "발급완료" && (
              <>
                <InputSet1
                  className={agreementData?.status === "발급완료" ? "finish" : "invite"}
                  disabled
                  label="승인여부"
                  text={agreementData?.status}
                />
              </>
            )}
            {agreementData?.status === "반려" && (
              <>
                <InputSet1
                  className="block"
                  disabled
                  label="승인여부"
                  text={agreementData?.status}
                />
                <InputSet1 disabled text={agreementData?.rejectReason} label="반려사유" />
              </>
            )}
            {agreementData?.status === "요청중" && (
              <>
                <InputSet1
                  label="승인여부"
                  isSelect
                  selectOption={
                    <>
                      <option value="">승인여부를 선택해주세요.</option>
                      <option value="yes">승인</option>
                      <option value="no">반려</option>
                    </>
                  }
                  register={register("accept")}
                />
               
            
              </>
            )} */}
          </div>          
        </>
      )}
      <div className="infoContainer" style={{
        justifyContent : 'center',
        flexDirection : 'row'        
      }}>
        { (role === 'company' || role === 'personal') && !isDetail && (
              <BigButton              
              text="탈퇴하기"
              background={"red"}
              onClick={
                // () => {
                  // handleDelete()
                  onDeleteUser
                // }
              }
              />
            )}                               
          </div>
        
    </LeftBox>
  );
}

const LeftBox = styled.div`
  display: flex;
  flex-direction: column;
  .underline {
    text-decoration: underline;
  }
  .fileList {
    display: flex;
    align-items: flex-start;
    & > div {
      &:first-child {
        width: 176px;
        & > label {
          font-weight: 700;
          font-size: 15px;
          color: ${theme.colors.body2};
          display: flex;
          align-items: center;
          gap: 16px;
          white-space: nowrap !important;
          & > img,
          svg {
            display: block;
            width: 24px;
            height: 24px;
            > path {
              fill: ${theme.colors.body2};
            }
          }
        }
      }
    }

    & .scroll {
      width: 941px;
      height: auto;
      padding: 16px 8px 16px 16px;
      border-radius: 5px;
      border: 1px solid #cbd3e5;
      background-color: #fff;
      white-space: nowrap;
      flex: 1;
      & .tableBox {
        padding-right: 16px;
      }
      & > .scrollBox {
        /* overflow-y: auto;
        overflow-x: auto; */
        width: 100%;
        height: 100%;
        &::-webkit-scrollbar {
          width: 8px;
          background-color: ${(props) => props.theme.colors.gray6};
          border-radius: 55px;
          left: 8px;
          height: 8px;
        }
        &::-webkit-scrollbar-thumb {
          width: 8px;
          height: 8px;
          background-color: ${(props) => props.theme.colors.gray4};
          border-radius: 55px;
        }
      }
    }
    & table {
      width: 100%;
      font-size: 14px;
      thead {
        border-bottom: 1px solid ${theme.colors.blueGray1};
      }
      td {
        text-align: center;
        border-bottom: 1px solid ${theme.colors.blueGray1};
        height: 50px;
        line-height: 50px;

        &:first-child {
          width: 120px;
          text-align: center;
        }
        &.file {
          width: 500px;
          overflow: hidden;
          text-overflow: ellipsis;

          color: #0202b3;
          &:hover {
            text-decoration: underline;
            cursor: pointer;
          }
        }
        &.deleteBtn {
          cursor: pointer;
          width: 50px;
        }
      }
      th {
        padding: 15px 0px;
        &:first-child {
          text-align: center;
        }
      }
    }
  }
`;

