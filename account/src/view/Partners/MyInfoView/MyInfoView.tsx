import Left from "../../../components/MyInfo/Left";
import { ViewObjectWrapperBox } from "../../../theme/common";
import { IMyInfoChangeRes, MyInfoRes } from "../../../interface/MyInfo/MyInfoResponse";

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
    <ViewObjectWrapperBox top>
      <h1 className="viewTitle">내 정보</h1>
      <div className="mainContent">
        <Left
          myInfoData={infoData}
          isButton={isButton}
          role={type}
          myInfoChangeInfoList={changeInfoList}
          onDeleteUser={deleteUser}
          isDetail = {false}
        />
      </div>
    </ViewObjectWrapperBox>
  );
}
