import styled from "styled-components";
import UserInfo from "../../assets/Icon/UserInfo";
import { IFile } from "../../controllers/Partners/Detail/Detail";
import {
  AgreementDetailRes,
  IIdentityFile,
  IPassbookFile,
  LogDetailRes,
  ResponseDataRes,
  UserDetailRes,
} from "../../interface/Master/MasterRes";
import { IMyInfoChangeRes, MyInfoRes } from "../../interface/MyInfo/MyInfoResponse";
import theme from "../../theme";
import { useClicks } from "../../utils/Modals";
import InputSet1 from "../Common/Input/InputSet1";
import Right from "./Right";
import bag from "../../assets/Icon/bag.svg";
import smartPhone from "../../assets/Icon/smartPhone.svg";
import mail from "../../assets/Icon/mail.svg";
import xCircle from "../../assets/Icon/xCircle.svg";
import acceptIcon from "../../assets/Icon/accept.svg";
import { DetailSection } from "../Detail/DetailSection";
import { Inputs } from "../Common/Input/Input";
import { LabelRadioBtn } from "../Common/Button/LabelRadioBtn";
import RoleUtils from "../../utils/RoleUtils";
import { useRecoilValue } from "recoil";
import { userState } from "../../modules/Client/Auth/Auth";
import BigButton from "../Common/Button/BigButton";

import { AiOutlineFieldTime,AiOutlineFieldNumber, AiOutlineDatabase, AiOutlineLink,AiOutlineFileSearch,AiOutlineInfoCircle } from "react-icons/ai";
import { HiOutlineStatusOnline } from "react-icons/hi";
import { FaNetworkWired,FaUserTag,FaPeopleArrows  } from "react-icons/fa";
import { GrContactInfo } from "react-icons/gr";


import { useEffect, useState } from "react";
import { UrlMatching } from "../../utils/UrlMatching";
import DateUtils from "../../utils/DateUtils";


export default function Left({
  isButton = true,
  logData,
  detailData,
  myInfoData,
  type,
  isAdminDetail,
  register,
  accept,
  agreementData,
  agreementFileList,
  myInfoChangeInfoList,
  onDeleteClick,
  onDeleteUser,
  clickFileList,
  role
}: {
  isAdminDetail?: boolean;
  isButton?: boolean;
  logData?: LogDetailRes;
  role?: string;
  detailData?: UserDetailRes;
  myInfoData?: MyInfoRes;
  register?: any;
  accept?: string;
  agreementData?: AgreementDetailRes;
  myInfoChangeInfoList?: IMyInfoChangeRes[];
  type?: string;
  agreementFileList?: [IIdentityFile, IPassbookFile];
  onDeleteClick?: () => void;
  onDeleteUser?: () => void;
  clickFileList?: (file: IFile) => void;
}) {
  const onClicks = useClicks(type || "");
  const userData = useRecoilValue(userState);
  const detailRole = RoleUtils.getClientRole(userData.role);  
  
  // const parsedData = JSON.parse(JSON.parse(logData?.response || ""));          
  // console.log(parsedData.data);
  // console.log(parsedData.statusCode);
  // console.log(parsedData.message);  
  // console.log(parsedData.data.items[0].response);
  
  const deepParseJSON = (data: any): any => {
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
      {role === "log" && logData != null &&(
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
              icon={< AiOutlineInfoCircle/>}
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
              text={UrlMatching[
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
              icon={<AiOutlineLink/>}
              heightType="content"
              // text={ UrlMatching[
              //   logData?.url
              //   .replace(/\/\d+/g, "/:id")                
              //   .replace(/\?.*$/,"")
              //   .replace(/\/(personal|consignment|security|agreement|company|committer)/g, "/:type") ?? ""]?.[logData?.action ?? ""][1] || logData?.url}              
              text={ UrlMatching[
                logData?.url
                .replace(/\?.*$/, "") // 쿼리 제거
                .replace(
                  /\/([0-9]+|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})(?=\/|$)/g,
                  "/:id"
                ) ?? ""]?.[logData?.action ?? ""]?.[1] ?? logData?.url}              
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
              // text={JSON.parse(JSON.parse(JSON.parse(logData?.response)).data.items[0].response) || "데이터가 존재하지 않습니다."}              
              // text={JSON.parse(deepParseJSON(logData.response)?.data.items[0].response || "데이터가 존재하지 않습니다.")}              
              text={logData.response ? JSON.stringify(checkData(logData.response))  : ""}
              heightType="content"
              disabled
            />
            <InputSet1
              icon={<AiOutlineFieldTime />}
              label="발생일시"
              // text={DateUtils.listDateFormat(logData?.createdAt ?? "데이터가 존재하지 않습니다.")}
              text={DateUtils.dateFormat(logData.createdAt)}
              disabled
            />            
          </div>
        </>
      )

      }

      {role !== "log" && (
        <>
        <DetailSection>
        <DetailSection.Title>1. 기본정보</DetailSection.Title>
        <Inputs>
          <Inputs.DetailInfoSet
            labelText="아이디"
            text={myInfoData?.id || detailData?.id || ""}
            labelIcon={<UserInfo />}
            w={202}
          />
          <Inputs.DetailInfoSet
            labelText="업체명"
            labelIcon={<img src={bag} alt=" 아이콘" />}
            text={myInfoData?.companyName || detailData?.companyName || ""}
            w={202}
          />
          <Inputs.DetailInfoSet
            labelText="담당자 이름"
            labelIcon={<UserInfo />}
            text={myInfoData?.name || detailData?.name || ""}
            w={202}
          />
          <Inputs.DetailInfoSet
            labelText="담당자 전화번호"
            labelIcon={<img src={smartPhone} alt=" 아이콘" />}
            text={myInfoData?.phone || detailData?.phone || ""}
            buttonText="담당자 번호 변경"
            buttonClick={isButton ? onClicks.admin : undefined}
            w={202}
          />
          <Inputs.DetailInfoSet
            labelText="이메일"
            labelIcon={<img src={mail} alt=" 아이콘" />}
            text={myInfoData?.email || detailData?.email || ""}
            buttonText="이메일 주소 변경"
            buttonClick={isButton ? onClicks.email : undefined}
            w={202}
          />
          {!isAdminDetail && (
            <Inputs.DetailInfoSet
              labelText="비밀번호"
              labelIcon={<UserInfo />}
              text="************"
              buttonText="비밀번호 변경"
              buttonClick={isButton ? onClicks.password : undefined}
              w={202}
            />
          )}
          {isAdminDetail && detailData?.adminVerify === "심사대기" && (
            <>
              <div>
                <Inputs.Label
                  labelText="승인여부"
                  labelIcon={<img src={acceptIcon} alt=" 아이콘" />}
                  w={202}
                />
                {/* <Inputs.Select register={register("accept")}>
                  <option value="">승인여부를 선택하세요.</option>
                  <option value="yes">승1인</option>
                  <option value="no">반려</option>
                </Inputs.Select> */}
                <LabelRadioBtn
                  icon={<img src={acceptIcon} alt=" 아이콘" />}
                  label="승인 여부"
                  register={register("accept")}
                  accept={accept}
                />
              </div>
              {accept === "no" && (
                <Inputs.InputSet
                  labelIcon={<img src={xCircle} alt=" 아이콘" />}
                  labelText="반려사유"
                  placeholder="반려사유를 입력해주세요."
                  type="text"
                  register={register("reason", { required: "반려사유를 입력해주세요." })}
                  w={202}
                />
              )}
            </>
          )}
          {isAdminDetail && detailData?.adminVerify === "반려" && (
            <>
              <Inputs.DetailInfoSet
                labelIcon={<img src={acceptIcon} alt=" 아이콘" />}
                labelText="승인여부"
                text="반려"
                w={202}
              />
              <Inputs.DetailInfoSet
                labelIcon={<img src={xCircle} alt=" 아이콘" />}
                labelText="반려사유"
                text={detailData?.rejectReason || ""}
                w={202}
              />
            </>
          )}
        </Inputs>
      </DetailSection>
      <DetailSection>
        <DetailSection.Title>2. 정보변경내역 확인</DetailSection.Title>
        <Right
          title="정보변경내역"
          agreementFileList={agreementFileList}
          myInfoChangeInfoList={myInfoChangeInfoList}
          type={type}
          onDeleteClick={onDeleteClick}
          clickFileList={clickFileList}
        />
      </DetailSection>
      <div className="infoContainer" style={{
        justifyContent : 'center',
        flexDirection : 'row'        
      }}>
        { (detailRole === "company")&& (
              <BigButton              
              text="탈퇴하기"              
              onClick={
                // () => {
                  // handleDelete()
                  onDeleteUser
                // }
              }
              />
            )}                               
          </div>
        </>
          )}
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
    width: 100%;
    display: flex;
    justify-content: flex-start;
    & > label {
      margin-top: 15px;
      align-self: flex-start;
    }
    & .tableBox {
      padding-right: 16px;
    }
    & .scroll {
      width: 941px;
      height: 216px;
      padding: 16px 8px 16px 16px;
      flex: 1;
      border-radius: 5px;
      border: 1px solid #cbd3e5;
      background-color: #fff;
      white-space: nowrap;
      & > .scrollBox {
        overflow-y: auto;
        overflow-x: auto;
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
      font-size: ${theme.fontType.subTitle1.fontSize};
      font-weight: ${theme.fontType.subTitle1.bold};
      thead {
        border-bottom: 1px solid ${theme.colors.blueGray1};
      }
      td {
        height: 50px;
        text-align: center;
        border-bottom: 1px solid ${theme.colors.blueGray1};
        line-height: 50px;
        color: ${theme.colors.body};
        &:first-child {
          width: 120px;
          padding-left: 24px;
          text-align: left;
        }
        &.file {
          width: 500px;
          overflow: hidden;
          text-overflow: ellipsis;

          &:hover {
            text-decoration: underline;
            cursor: pointer;
          }
        }
        &.deleteBtn {
          cursor: pointer;
        }
      }
      th {
        padding-bottom: 15px;
        color: ${theme.colors.body2};
        &.num {
          width: 100px;
        }
        &.date {
          width: 250px;
        }
      }
    }
  }
`;
