import { useState } from "react";
import styled from "styled-components";
import { useData } from "../../../modules/Server/QueryHook";
import theme from "../../../theme";
import BigButton from "../../Common/Button/BigButton";
// import PaginationComponent from "../../Pagination/Pagination";
import Overlay from "../Overlay";
import boxPlusIcon from "./../../../assets/Icon/boxPlus.svg";
import { getEmpApi } from "../../../api/AuthApi";

interface MasterSelectModalInterface {
  onClose: () => void;
  adminName?: string;
  selectAdmin?: (data: string, empId: string) => void;
  role: string;
}

type ChargeListType = {
  email?: string;
  empId: string;
  empYN?: string;
  mobilePhone: string;
  name: string;
  orgCD: string;
  orgNM: string;
  statCD?: string;
  webexToken?: string;
  isAccountant?: boolean;
};

type GetEmpType = {
  name: string;
  type: string;
} | null;

function MasterSelectModal(props: MasterSelectModalInterface) {
  const [chargeList, setChargeList] = useState<ChargeListType[]>([]);

  const data = {
    name: props.adminName ?? "",
    type: props.role === "company" ? "company" : "personal",
  };

  const getEmpData = useData<ChargeListType[], GetEmpType>(
    ["getEmpData", null],
    () => getEmpApi(data),
    {
      enabled: props.adminName ? true : false,
      // refetchOnWindowFocus: false,
      onSuccess(item) {
        setChargeList(item.data);
      },
    }
  );

  const onSelectAdmin = (data: ChargeListType) => {
    const orgNM = data.orgNM ?? "";
    const name = data.name ?? "";
    // const mobilePhone = data.mobilePhone ?? "";

    // let text: string = `${orgNM} | ${name} | ${mobilePhone}`;

    let text: string = `${orgNM} | ${name}`;

    if (props.selectAdmin)
      props.selectAdmin(text, data.empId);
  };

  return (
    <Overlay>
      <MasterSelectModalBlock>
        <h1>검색 결과</h1>
        <span>검색된 담당자를 확인 후 오른쪽의 선택 버튼을 클릭해주세요.</span>
        <div className="searchUser">
          <div>
            <table className="table">
              <thead>
                <tr>
                  <th className="name">부서명</th>
                  <th className="phone">이름</th>
                  {/* <th className="email">연락처</th> */}
                  <th>선택</th>
                </tr>
              </thead>
              <tbody>
                {chargeList.map((data, index) => (
                  <tr key={index} onClick={() => onSelectAdmin(data)}>
                    <td className="name">{data?.orgNM ? data?.orgNM : ""}</td>
                    <td className="phone">{data?.name ? data?.name : ""}</td>
                    {/* <td className="email">
                      {data?.mobilePhone ? NumberUtils.phoneFormat(data?.mobilePhone) : ""}
                    </td> */}
                    <td>
                      <button onClick={() => console.log("")}>
                        <img src={boxPlusIcon} alt="담당자 선택하기" />
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
        <div className="btnWrap">
          <BigButton text="취소" onClick={props.onClose} />
        </div>
      </MasterSelectModalBlock>
    </Overlay>
  );
}

export default MasterSelectModal;

const MasterSelectModalBlock = styled.div`
  width: 832px;
  min-height: 500px;
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
    font-weight: ${theme.fontType.subTitle1.bold};
    font-size: ${theme.fontType.subTitle1.fontSize};
    color: ${theme.colors.body2};
    margin-bottom: 32px;
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
    border: 1px solid ${theme.colors.gray5};
    border-radius: 5px;
    & > div:nth-child(1) {
      width: 100%;
      flex: 1;
    }
  }

  /* 테이블 */
  table {
    width: 100%;
    height: 100%;
    padding: 24px;
    font-size: ${theme.fontType.subTitle3.fontSize};
    font-weight: ${theme.fontType.subTitle3.bold};
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
          /* color: red; */
          display: flex;
          align-items: center;
        }
      }
    }
    .name {
      width: 250px;
    }
    .phone {
      width: 350px;
    }
    .email {
      width: 268px;
    }
  }

  .btnWrap {
    margin-top: 24px;
  }
`;
