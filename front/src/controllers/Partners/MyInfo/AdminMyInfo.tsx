import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
import { useRecoilValue, useSetRecoilState } from "recoil";
import { IAdminMyInfo } from "../../../interface/MyInfo/AdminFormInput";
import { userState } from "../../../modules/Client/Auth/Auth";
import { alertModalState } from "../../../modules/Client/Modal/Modal";
import RoleUtils from "../../../utils/RoleUtils";
import AdminMyInfoView from "../../../view/Partners/MyInfoView/AdminMyInfoView";
import Layout from "../../Common/Layout/Layout";

export default function AdminMyInfo() {
  const userData = useRecoilValue(userState);
  const alertModal = useSetRecoilState(alertModalState);

  const { register, handleSubmit } = useForm<IAdminMyInfo>({
    defaultValues: {
      name: userData.name,
      empId: userData.empId,
      phone: userData.phone,
    },
  });

  const onValid: SubmitHandler<IAdminMyInfo> = (formData) => {
    // console.log(formData);
  };
  const inValid: SubmitErrorHandler<IAdminMyInfo> = (err) => {
    alertModal({
      isModal: true,
      content: "모든 값을 입력해주세요.",
    });
  };

  return (
    <Layout>
      <AdminMyInfoView
        register={register}
        onSubmit={handleSubmit(onValid, inValid)}
        type={RoleUtils.getClientRole(userData.role)}
        infoData={userData}
      />
    </Layout>
  );
}
