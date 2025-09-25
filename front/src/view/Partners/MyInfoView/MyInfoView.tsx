import Left from "../../../components/MyInfo/Left";
import { ViewObjectWrapperBox } from "../../../theme/common";
import { IMyInfoChangeRes, MyInfoRes } from "../../../interface/MyInfo/MyInfoResponse";
import styled from "styled-components";

export default function MyInfoView({
  isButton = true,
  infoData,
  changeInfoList,
  type,
  deleteUser
}: {
  isButton?: boolean;
  infoData?: MyInfoRes;
  changeInfoList?: IMyInfoChangeRes[];
  type: string;
  deleteUser : any;
}) {
  return (
    <MyInfoBlock>
      <ViewObjectWrapperBox>
        <h1 className="viewTitle">내 정보</h1>
        <div className="mainContent">
          <Left
            myInfoData={infoData}
            isButton={isButton}
            type={type}
            myInfoChangeInfoList={changeInfoList}
            onDeleteUser={deleteUser}
          />
        </div>
      </ViewObjectWrapperBox>
    </MyInfoBlock>
  );
}

const MyInfoBlock = styled.div`
  margin-bottom: 130px;
`;
