import React, { useEffect, useState } from "react";
import styled from "styled-components";
import {
  StepTwoCommitter,
  StepTwoCompany,
} from "../../../../interface/System/EvaluationRoomDetail/EvaluationRoomDetailTypes";
import { Regex } from "../../../../utils/RegularExpression";
import plusList from "../../../../assets/Icon/plusList.svg";
import theme from "../../../../theme";
import deleteIcon from "../../../../assets/Icon/delete.svg";
import Search from "../../../../assets/Icon/Search";
import { DetailSection } from "../../../../components/Detail/DetailSection";
import { InfoList } from "../../../../components/Detail/DetailListTable";
import { Input } from "../../../../components/Common/Input/Input";
import NumberUtils from "../../../../utils/NumberUtils";

interface StepTwoTypes {
  committerList: StepTwoCommitter[];
  companyList: StepTwoCompany[];
  onStepTwoModal: (type: string, isModal: boolean) => void;
  onChange: (e: React.ChangeEvent<HTMLInputElement>, phone: string) => void;
  onCommitterException: (id: string) => void;
  onCompanyException: (id: string) => void;
  onStepTwoSelectData: (array: StepTwoCommitter[]) => void;
  searchedList: StepTwoCommitter[];
  changeName: (name: string) => void;
}

export const StepTwo: React.FC<StepTwoTypes> = (props) => {
  const [addedCommitter, setAddedCommitter] = useState<StepTwoCommitter>({
    id: "",
    birth: "",
    name: "",
    phone: "",
    email: "",
    chairman: false,
  });

  const [showSearchedList, setShowSearchedList] = useState(false);
  const [searchList, setSearchList] = useState<StepTwoCommitter[]>([]);

  useEffect(() => {
    if (props.searchedList.length > 0) {
      setShowSearchedList(true);
      setSearchList(props.searchedList);
    }
  }, [props.searchedList]);

  const resetInputs = () => {
    setAddedCommitter({
      id: "",
      birth: "",
      name: "",
      phone: "",
      email: "",
      chairman: false,
    });
  };

  const onChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value, checked } = e.target;

    let val = value;

    if (name === "name" && val.length >= 2) {
      props.changeName(val);
    }

    if (name === "phone") {
      const regex = /[^0-9]/g;
      val = value.replace(regex, "");
    }

    setAddedCommitter((prev) => ({ ...prev, [name]: name === "chairman" ? checked : val }));
  };

  const addCommitter = () => {
    const { birth, name, phone, email } = addedCommitter;
    if (!birth || !name || !phone) return;
    if (!phone.match(Regex.phoneRegExp)) return;
    if (email && !email.match(Regex.emailRegex)) return;
    props.onStepTwoSelectData([addedCommitter]);
    setSearchList([]);
    resetInputs();
  };

  return (
    <DetailSection>
      <DetailSection.Title>
        3. 참석자 등록 <span>평가에 참여할 평가위원, 제안업체를 등록해주세요.</span>
      </DetailSection.Title>
      <StepTwoBlock>
        {/* 평가위원 영역 */}
        <>
          <InfoList>
            <InfoList.Title>
              {"1) 평가위원 등록"}
              <span>
                평가위원 리스트에 등록된 평가위원은 이름입력 시 검색리스트에서 선택하실 수 있습니다.
                <br />
                연락처는 평가위원의 본인인증에 사용됩니다.
              </span>
            </InfoList.Title>
            <InfoList.Headers>
              <InfoList.Header center w={160} text="이름" />
              <InfoList.Header center w={160} text="생년월일" />
              <InfoList.Header center w={160} text=" 연락처" />
              <InfoList.Header center w={160} text="이메일" />
              <InfoList.Header center w={132} text="" />
              <InfoList.Header center text="리스트에 추가" />
            </InfoList.Headers>
            <div className="searchCommitter">
              <InfoList.Headers>
                <InfoList.Header w={160}>
                  <Input
                    type="text"
                    value={addedCommitter.name}
                    onChange={onChange}
                    name="name"
                    placeholder="이름을 입력하세요"
                    placeholderAlign="center"
                  />
                </InfoList.Header>
                <InfoList.Header center w={160}>
                  <Input
                    type="text"
                    value={addedCommitter.birth}
                    onChange={onChange}
                    name="birth"
                    placeholder="생년월일 8자리를 입력하세요"
                    maxLength={8}
                    minLength={8}
                    placeholderAlign="center"
                  />
                </InfoList.Header>
                <InfoList.Header center w={160}>
                  <Input
                    type="text"
                    value={addedCommitter.phone}
                    onChange={onChange}
                    name="phone"
                    placeholder="숫자만 입력하세요"
                    placeholderAlign="center"
                  />
                </InfoList.Header>
                <InfoList.Header center w={160}>
                  <Input
                    type="text"
                    value={addedCommitter.email}
                    onChange={onChange}
                    name="email"
                    placeholder="이메일을 입력하세요"
                    placeholderAlign="center"
                  />
                </InfoList.Header>
                <InfoList.Header w={132} center>
                  {/* <input
                    type="checkbox"
                    name="chairman"
                    onChange={onChange}
                    checked={addedCommitter.chairman}
                  /> */}
                </InfoList.Header>
                <InfoList.Header center>
                  <button type="button" onClick={addCommitter}>
                    <img src={plusList} alt="리스트 추가 아이콘" />
                  </button>
                </InfoList.Header>
              </InfoList.Headers>
              {showSearchedList && searchList.length > 0 && (
                <div className="searchedList">
                  {searchList.map((data, index) => (
                    <div
                      key={index}
                      onClick={() => {
                        setAddedCommitter({
                          id: data.id,
                          birth: data.birth,
                          name: data.name,
                          phone: data.phone,
                          email: data.email || "",
                        });
                        setShowSearchedList(false);
                      }}
                    >
                      <InfoList.Header text={data.name ?? ""} w={169} />
                      <InfoList.Header text={data.birth ?? ""} w={169} />
                      <InfoList.Header text={NumberUtils.phoneFormat(data.phone ?? "")} w={168} />
                      <InfoList.Header text={data.email ?? ""} w={160} />
                      <InfoList.Header />
                      <InfoList.Header />
                    </div>
                  ))}
                </div>
              )}
            </div>
            <InfoList.Contents>
              {props.committerList.length > 0 ? (
                <>
                  {props.committerList.map((data, index) => (
                    <>
                      <div
                        key={index}
                        onClick={(e) => {
                          setAddedCommitter({
                            id: data.id,
                            birth: data.birth,
                            name: data.name,
                            phone: data.phone,
                            email: data.email || "",
                          });
                        }}
                      >
                        <InfoList.Content>
                          <InfoList.Header text={data.name ?? ""} center w={130} />
                          <InfoList.Header text={data.birth ?? ""} center w={190} />
                          <InfoList.Header
                            text={NumberUtils.phoneFormat(data.phone ?? "")}
                            center
                            w={135}
                          />
                          <InfoList.Header text={data.email ?? ""} center w={190} />
                          <InfoList.Header
                            text={(data.chairman && "평가위원장") || ""}
                            w={95}
                            center
                          />
                          <InfoList.Header w={37} />
                          <InfoList.Header w={120} center>
                            <button
                              onClick={(e) => {
                                e.stopPropagation();
                                props.onCommitterException(data.id);
                                resetInputs();
                              }}
                            >
                              <img src={deleteIcon} alt="삭제 아이콘" />
                            </button>
                          </InfoList.Header>
                        </InfoList.Content>
                      </div>
                    </>
                  ))}
                </>
              ) : (
                <InfoList.NoContentMessage text=" 내용이 없습니다. 검색 후 평가위원을 추가해주세요." />
              )}
            </InfoList.Contents>
          </InfoList>
          <InfoList>
            <InfoList.Title>
              {`2) 제안업체 등록`}
              <span>오른쪽 검색 버튼을 클릭하여 제안업체를 검색, 추가 해주세요.</span>
              <button className="headerBtn" onClick={() => props.onStepTwoModal("company", true)}>
                검색
                <Search />
              </button>
            </InfoList.Title>
            <div className="bot company">
              <table className="companyTable">
                <thead>
                  <tr>
                    <th className="name">업체명</th>
                    <th className="phone">연락처</th>
                    <th className="responsibility">담당자</th>
                    <th className="email">이메일</th>
                    <th className="textCenter">삭제</th>
                  </tr>
                </thead>
                <tbody>
                  {props.companyList.length > 0 ? (
                    <>
                      {props.companyList.map((data, index) => (
                        <tr key={index}>
                          <td className="name">{data.companyName}</td>
                          <td className="phone">{NumberUtils.phoneFormat(data.phone || "")}</td>
                          <td className="responsibility">{data.name}</td>
                          <td className="email">{data.email}</td>
                          <td className="textCenter">
                            <button type="button" onClick={() => props.onCompanyException(data.id)}>
                              <img src={deleteIcon} alt="삭제 아이콘" />
                            </button>
                          </td>
                        </tr>
                      ))}
                    </>
                  ) : (
                    <tr className="guideInfo">
                      <InfoList.NoContentMessage text="내용이 없습니다. 검색 후 제안업체를 추가해주세요." />
                    </tr>
                  )}
                </tbody>
              </table>
            </div>
          </InfoList>
        </>
      </StepTwoBlock>
    </DetailSection>
  );
};

const StepTwoBlock = styled.div`
  .searchCommitter {
    position: relative;
  }
  .searchedList {
    width: 100%;
    padding: 7px 10px;
    position: absolute;
    left: 0px;
    z-index: 30;
    background-color: white;
    border: 1px solid #edeff4;
    box-shadow: 10px 11px 16px 8px rgba(53, 88, 122, 0.1);
    border-radius: 5px;

    & > div {
      padding-left: 12px;
      height: 40px;
      display: flex;
      align-items: center;
      font-size: 13px;
      border-bottom: 1px solid ${theme.colors.blueGray2};
      cursor: pointer;
      &:hover {
        background-color: #f8faff;
      }
      &:last-child {
        border-bottom: none;
      }
    }
  }
  & .company {
    border: 1px solid ${theme.systemColors.blueDeep};
    border-radius: 5px;
  }
  & .companyTable {
    width: 100%;
    & > thead {
      width: 100%;
      & > tr {
        border-bottom: 1px solid ${theme.systemColors.blueDeep};
      }
    }
    & > tbody {
      position: relative;
      height: 179px;
      display: block;
      overflow-y: scroll;
      -ms-overflow-style: none; /* IE and Edge */
      scrollbar-width: none; /* Firefox */
      &::-webkit-scrollbar {
        display: none !important;
      }
      & > tr {
        height: 40px;
        padding: 0px 24px;
        & > td {
          height: 40px;
          display: flex;
          align-items: center;
          padding-left: 9px;
          & > button {
            height: 24px;
          }
        }
      }
    }
    & tr {
      width: 100%;
      display: flex;
      padding: 24px 24px;
      width: 100%;
      & > th {
        height: 19px;
        padding-left: 8px;
        border-left: 1px solid ${theme.colors.blueGray1};
        text-align: left;
      }
      & .name,
      & .phone,
      & .responsibility {
        width: 172px;
      }
      & .email {
        width: 350px;
      }
    }
  }
  & .guideInfo {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    justify-content: center;
    color: ${theme.systemColors.bodyLighter};
  }

  .textCenter {
    text-align: center;
    vertical-align: center;
  }
`;
