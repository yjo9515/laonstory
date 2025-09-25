import { UseFormRegister } from "react-hook-form";
import InputSet1 from "../../../components/Common/Input/InputSet1";
import { IUser } from "../../../interface/Auth/AuthInterface";
import { IAdminMyInfo } from "../../../interface/MyInfo/AdminFormInput";
import { ViewObjectWrapperBox } from "../../../theme/common";

export default function AdminMyInfoView({
  register,
  onSubmit,
  infoData,
}: {
  register: UseFormRegister<IAdminMyInfo>;
  onSubmit: any;
  type: string;
  infoData: IUser;
}) {
  return (
    <ViewObjectWrapperBox detail>
      <h1 className="viewTitle">내 정보</h1>
      <div className="mainContent">
        <div className="infoContainer">
          <h2>(1) 기본정보</h2>
          <InputSet1 label="사번" text={infoData?.empId} disabled />
          <InputSet1 label="이름" text={infoData?.name} disabled />
          {/* <InputSet1 label="전화번호" text={infoData?.phone} disabled /> */}
        </div>
      </div>
    </ViewObjectWrapperBox>
  );
}
