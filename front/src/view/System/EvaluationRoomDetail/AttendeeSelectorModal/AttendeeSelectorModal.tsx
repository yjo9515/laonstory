import { useEffect, useState } from "react";
import styled from "styled-components";
import { useSetRecoilState } from "recoil";
import BigButton from "../../../../components/Common/Button/BigButton";
import SearchList from "../../../../components/Common/SearchList/SearchList";
import Overlay from "../../../../components/Modal/Overlay";
import PaginationComponent from "../../../../components/Pagination/Pagination";
import { PageStateType } from "../../../../interface/Common/PageStateType";
import { pageInfo } from "../../../../interface/Response/GlobalResponse";
import {
  StepTwoCommitter,
  StepTwoCompany,
  StepTwoSearchModal,
} from "../../../../interface/System/EvaluationRoomDetail/EvaluationRoomDetailTypes";
import theme from "../../../../theme";
import { footerZIndexControl } from "../../../../modules/Client/Modal/Modal";
import boxPlusIcon from "../../../../assets/Icon/boxPlus.svg";
import boxMinusIcon from "../../../../assets/Icon/boxMinus.svg";
import NumberUtils from "../../../../utils/NumberUtils";

interface AttendeeSelectorModalTypes {
  stepTwoCommitter: StepTwoCommitter[];
  stepTwoCompany: StepTwoCompany[];
  onStepTwoSelectData: (array: StepTwoCommitter[]) => void;
  onStepTwoCompanySelectData: (array: StepTwoCompany[]) => void;
  onStepTwoModalClose: () => void;
  onPageMove: (page: number) => void;
  onSearch: () => void;
  onReflesh: () => void;
  onSearchChange: (search: string) => void;
  onSearchRefetch: () => void;
  state: PageStateType;
  stepTwoSearchModal: StepTwoSearchModal;
  committerList: StepTwoCommitter[];
  companyList: StepTwoCompany[];
  pageInfo?: number;
}

function AttendeeSelectorModal(props: AttendeeSelectorModalTypes) {
  const [selectList, setSelectList] = useState<StepTwoCommitter[]>([]);
  const [selectCompanyList, setSelectCompanyList] = useState<StepTwoCompany[]>([]);
  const setFooterZIndexControl = useSetRecoilState(footerZIndexControl);

  // 모달이 열릴 때 footer z-index를 0으로 설정
  useEffect(() => {
    setFooterZIndexControl(true);

    // 컴포넌트가 언마운트될 때 footer z-index를 원래대로 복원
    return () => {
      setFooterZIndexControl(false);
    };
  }, [setFooterZIndexControl]);

  //  선택한 평가위원 정보가 있을 경우
  useEffect(() => {
    if (props.stepTwoCommitter.length > 0) setSelectList(props.stepTwoCommitter);
  }, [props.stepTwoCommitter]);

  //  선택한 제안업체 정보가 있을 경우
  useEffect(() => {
    if (props.stepTwoCompany.length > 0) setSelectCompanyList(props.stepTwoCompany);
  }, [props.stepTwoCompany]);

  //   제안업체 선택
  const onCompanySelect = (data: StepTwoCompany) => {
    const array: StepTwoCompany[] = [...selectCompanyList];

    if (array.find((i) => i.id === data.id)) return;
    array.push(data);

    setSelectCompanyList(array);
  };

  //   제안업체 선택한 데이터 제외
  const onCompanyException = (id: string) => {
    let array: StepTwoCompany[] = [...selectCompanyList];

    let item = array.filter((i) => i.id !== id);

    setSelectCompanyList(item);
  };

  const onConfirmation = () => {
    if (props.stepTwoSearchModal.type === "committer") props.onStepTwoSelectData(selectList);
    if (props.stepTwoSearchModal.type === "company") {
      props.onStepTwoCompanySelectData(selectCompanyList);
    }
    props.onStepTwoModalClose();
  };

  return (
    <Overlay>
      <AttendeeSelectorModalBlock>
        <div className="SearchModal">
          <h1>{props.stepTwoSearchModal.type === "committer" ? "평가위원" : "제안업체"} 검색</h1>
          <div className="guide">
            <div>
              <p>
                * 연락처, 이메일이 표시되지 않는 제안업체는 서부 평가담당자가 등록한 업체이며 실제
                제안업체 이용자가 아닙니다.
              </p>
              <p>* 제안업체가 참여해야 하는 경우 참여할 업체는 회원가입을 진행해야합니다.</p>
              <p>
                * 가입 요청된 제안업체는 서부 평가담당자의 가입 승인 완료 후 참여할 수 있으며 평가방
                개설에 추가할 수 있습니다.
              </p>
            </div>
          </div>
          <SearchList
            onReflesh={props.onReflesh}
            onSearch={props.onSearchRefetch}
            searchValue={props.state.search}
            onSearchContent={props.onSearchChange}
          />
          <div className="searchUser">
            <div>
              <table className="table">
                <thead>
                  <tr>
                    <th className="name">업체명</th>
                    <th className="phone">연락처</th>
                    <th className="email">이메일</th>
                    <th>선택</th>
                  </tr>
                </thead>
                <tbody>
                  {props.companyList.map((data, index) => (
                    <tr key={index}>
                      <td className="name">{data?.companyName}</td>
                      <td className="phone">{NumberUtils.phoneFormat(data?.phone)}</td>
                      <td className="email">{data?.email}</td>
                      <td
                        className={
                          selectCompanyList.find((i) => i?.id === data?.id) ? "isSelect" : ""
                        }
                      >
                        <button onClick={() => onCompanySelect(data)}>
                          <img src={boxPlusIcon} alt="더하기 아이콘" />
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
          <PaginationComponent
            listAction={props.onPageMove}
            itemsCountPerPage={Number(props.pageInfo)}
            activePage={props.state.page + 1}
          />
          <div className="selectUser">
            <div>
              <table className="table">
                <thead>
                  <tr>
                    <th className="name">업체명</th>
                    <th className="email">이메일</th>
                    <th>삭제</th>
                  </tr>
                </thead>
                <tbody>
                  {selectCompanyList.map((data, index) => (
                    <tr key={index}>
                      <td className="name">{data.companyName}</td>
                      <td className="email">{data.email}</td>
                      <td>
                        <button onClick={() => onCompanyException(data.id)}>
                          <img src={boxMinusIcon} alt="빼기 아이콘" />
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
          <div className="btnBox">
            <BigButton
              text="닫기"
              white={true}
              onClick={() => {
                props.onStepTwoModalClose();
                props.onSearchChange("");
                props.onReflesh();
              }}
            />
            <BigButton text="저장" onClick={onConfirmation} />
          </div>
        </div>
      </AttendeeSelectorModalBlock>
    </Overlay>
  );
}

export default AttendeeSelectorModal;

const AttendeeSelectorModalBlock = styled.div`
  .SearchModal {
    width: 832px;
    padding: 40px;
    padding-top: 56px;
    background-color: ${theme.colors.white};
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-direction: column;
    border-radius: 22px;

    & > h1 {
      text-align: center;
      font-weight: ${theme.fontType.title2.bold};
      font-size: ${theme.fontType.title2.fontSize};
      color: ${theme.colors.body2};
      margin-bottom: 16px;
    }
    & > .guide {
      width: 100%;
      display: flex;
      justify-content: flex-start;
      margin-bottom: 16px;

      & > div {
        width: 650px;
        & > p {
          margin-bottom: 4px;
          font-size: 14px;
          color: ${theme.colors.red};
        }
      }
    }
    & > form {
      width: 100%;
    }
    /* 테이블 */
    table {
      width: 100%;
      height: 100%;
      padding: 24px;
      font-size: ${theme.fontType.subTitle1.fontSize};
      font-weight: ${theme.fontType.subTitle1.bold};
      & > thead {
        & > tr {
          width: 100%;
          padding: 0px 8px;
          padding-bottom: 9px;
          border-bottom: 1px solid ${theme.colors.blueGray2};
          display: flex;
          & > th {
            padding-left: 8px;
            border-left: 1px solid ${theme.colors.blueGray1};
            text-align: start;
          }
        }
      }
      & > tbody {
        height: 100%;
        display: block;
        overflow: scroll;
        -ms-overflow-style: none; /* IE and Edge */
        scrollbar-width: none; /* Firefox */
        &::-webkit-scrollbar {
          display: none !important;
        }
        & > tr {
          display: flex;
          padding-left: 16px;
          margin-top: 14px;
          & > td {
            height: 24px;
            color: ${theme.systemColors.bodyLighter};
            display: flex;
            align-items: center;
          }
        }
      }
      .name {
        width: 186px;
      }
      .phone {
        width: 202px;
      }
      .email {
        width: 268px;
      }
    }

    & > .searchUser {
      width: 100%;
      height: 250px;
      padding: 16px;
      margin-top: 24px;
      margin-bottom: 8px;
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      align-items: center;
      border: 1px solid ${theme.systemColors.blueDeep};
      border-radius: 5px;
      & > div:nth-child(1) {
        width: 100%;
        flex: 1;
      }
    }
    & > .selectUser {
      width: 100%;
      margin-top: 20px;
      & > p {
        margin-bottom: 12px;
        font-weight: 700;
        font-size: 16px;
        color: ${theme.colors.body2};
      }
      & > div {
        width: 100%;
        height: 178px;
        padding: 16px;
        border: 1px solid ${theme.systemColors.blueDeep};
        border-radius: 5px;
        overflow-y: auto;
      }
      .email {
        width: 470px;
      }
    }

    & > .btnBox {
      margin-top: 50px;
      display: flex;
      & > button:last-child {
        margin-left: 32px;
      }
    }
  }
  .isSelect {
    & img {
      opacity: 0.4;
    }
  }
`;
