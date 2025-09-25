import { SubmitHandler, useForm } from "react-hook-form";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import { alertModalState, contentModalState } from "../../../modules/Client/Modal/Modal";
import { MyInfoModalContainer } from "../../../theme/common";
import InputButton from "../../Common/Button/InputButton";
import Form from "../../Common/Container/Form";
import { Inputs } from "../../Common/Input/InputSet1";
import bag from "../../../assets/Icon/bag.svg";
import UserInfo from "../../../assets/Icon/UserInfo";
import styled from "styled-components";
import { useEffect, useState } from "react";
import SmallButton1 from "../../Common/Button/SmallButton1";
import MasterSelectModal from "./MasterSelectModal";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import { getMasterInfoEmpApi, patchEmpApi } from "../../../api/AgreementApi";

interface AdminInfoChangeInterface {
  uuid: string;
  masterEmpId: string;
  refetch?: () => void;
  role: string;
}

type IAdminInput = {
  admin: string;
  department: string;
  selectAdmin: string;
  empId: string;
};

type ChargeChangeType = {
  empId: string;
  uuid: string;
  type: string;
};

type MasterEmpDataResType = {
  empId: string;
  mobilePhone: string;
  name: string;
  orgNM: string;
};
type MasterInfoEmpReqType = {
  masterId: string;
  type: string;
};

export default function AdminInfoChange(props: AdminInfoChangeInterface) {
  const resetContentModal = useResetRecoilState(contentModalState);
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);

  const [masterSearchModal, setMasterSearchModal] = useState(false);
  const [masterData, setMasterData] = useState<MasterEmpDataResType>({
    empId: "",
    mobilePhone: "",
    name: "",
    orgNM: "",
  });

  const { register, handleSubmit, setValue, watch } = useForm<IAdminInput>({});

  const patchEmpData = useSendData<any, ChargeChangeType>(patchEmpApi);

  const masterItem = {
    masterId: props.masterEmpId,
    type: props.role === "company" ? "company" : "personal",
  };

  const masterEmpData = useData<MasterEmpDataResType, MasterInfoEmpReqType>(
    ["masterEmpData", null],
    () => getMasterInfoEmpApi(masterItem),
    {
      enabled: props.masterEmpId ? true : false,
      onSuccess(item) {
        setMasterData(item.data);
      },
    }
  );

  const onValid: SubmitHandler<IAdminInput> = (formData) => {
    const { selectAdmin, empId } = formData;

    // 값 있는지 확인
    if (!selectAdmin || !empId) {
      setAlertModal({
        isModal: true,
        content: "변경하실 담당자를 선택해주세요.",
      });
      return;
    }

    // 통과시 api 연결
    let data = {
      empId,
      uuid: props.uuid,
      type: props.role === "company" ? "company" : "personal",
    };

    patchEmpData.mutate(data);

    // 성공시
    if (props.refetch) props.refetch();
    resetContentModal();
    setAlertModal({
      isModal: true,
      content: "변경이 완료 되었습니다.",
      onClick: () => {
        if (props.refetch) props.refetch();
      },
      type: "check",
      isLoading: true,
    });
  };

  // useEffect(() => {
  //   setValue("selectAdmin", "정보기술처/ICT운영실 | 장승규 | 041-400-1941");
  // }, []);

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
    setValue("empId", empId);
    setMasterSearchModal(false);
  };

  return (
    <>
      <AdminInfoChangeContainer>
        <Form onSubmit={handleSubmit(onValid)}>
          <div className="main">
            <div>
              <span>기존 선택 담당자</span>
              <div className="info">
                <span>{masterData.orgNM ?? ""}</span>
                <span>{masterData.name ?? ""}</span>
                <span>{masterData.mobilePhone ?? ""}</span>
              </div>
            </div>
            <div className="centerLine"></div>
            <div>
              <span>부서 및 담당자 변경</span>
              <Inputs>
                <div className="inputGroup">
                  <Inputs.Label
                    w={134}
                    labelText="담당자 검색"
                    labelIcon={<img src={bag} alt="아이콘" />}
                  />
                  <div className="inputItem">
                    <Inputs.Input
                      type={"text"}
                      register={register("admin")}
                      placeholder="담당자 이름을 입력 후 검색해주세요."
                    />
                    <SmallButton1 text="검색" onClick={onSearch} />
                  </div>
                </div>
                <div>
                  <Inputs.Label w={134} labelText="선택한 담당자" labelIcon={<UserInfo />} />
                  <Inputs.Input type={"text"} register={register("selectAdmin")} readOnly />
                </div>
              </Inputs>
            </div>
          </div>
          <div className="buttonContainer">
            <InputButton text="취소" cancel onClick={resetContentModal} />
            <InputButton text="변경" submit />
          </div>
        </Form>
      </AdminInfoChangeContainer>
      {masterSearchModal && (
        <MasterSelectModal
          onClose={onMasterSearchClose}
          selectAdmin={selectAdmin}
          adminName={watch("admin")}
          role={props.role}
        />
      )}
    </>
  );
}

const AdminInfoChangeContainer = styled(MyInfoModalContainer)`
  width: 900px;
  .main {
    align-items: flex-start;
    justify-content: space-between;
    flex-direction: row;
    display: flex;
    & > div {
      padding: 20px 0px;
      justify-content: flex-start;
      & > span {
        font-size: 14px;
      }
      & .info {
        display: flex;
        flex-direction: column;
        & > span {
          font-weight: 800;
          font-size: 18px;
          margin-bottom: 2px;
        }
      }
      & > div {
        height: 160px;
        display: flex;
        align-items: center;
        justify-content: center;
      }
    }
  }
  .inputItem {
    display: flex;
    flex: 1;
    gap: 12px;
  }
  .inputGroup {
    width: 100%;
  }
`;
