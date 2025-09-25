import { useRecoilValue, useSetRecoilState,useResetRecoilState } from "recoil";
import {
  committerMyHistoryApi,
  committerMyInfoApi,
  companyMyHistoryApi,
  companyMyInfoApi,
} from "../../../api/MyInfoApi";
import {
  deleteUserApi
} from "../../../api/AuthApi";
import { IMyInfoChangeRes, MyInfoRes } from "../../../interface/MyInfo/MyInfoResponse";
import { userState } from "../../../modules/Client/Auth/Auth";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import RoleUtils from "../../../utils/RoleUtils";
import MyPageView from "../../../view/Partners/MyInfoView/MyInfoView";
import Layout from "../../Common/Layout/Layout";
import { alertModalState } from "../../../modules/Client/Modal/Modal";
import { useNavigate } from "react-router";
import { useAuth } from "../../../utils/AuthUtils";

export default function MyInfo() {
  const user = useRecoilValue(userState);
  const setAlertModal = useSetRecoilState(alertModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);

  const type = RoleUtils.getClientRole(user.role);
  const navigate = useNavigate();

  // detail api
  const { data: committerData } = useData<MyInfoRes, null>(
    ["committerData", null],
    committerMyInfoApi,
    {
      enabled: type === "committer",
    }
  );
  const { data: companyData } = useData<MyInfoRes, null>(["companyData", null], companyMyInfoApi, {
    enabled: type === "company",
  });
  // 정보변경내역 api
  const { data: committerMyHistoryData } = useData<IMyInfoChangeRes[], null>(
    ["committerMyHistory", null],
    committerMyHistoryApi,
    {
      enabled: type === "committer",
    }
  );
  const { data: companyMyHistoryData } = useData<IMyInfoChangeRes[], null>(
    ["companyMyHistory", null],
    companyMyHistoryApi,
    {
      enabled: type === "company",
    }
  );

  // 회원탈퇴 api
  const userDelete = useSendData<any, any>(
      
    deleteUserApi,    
  );      
  const { logOut } = useAuth();
  const handleDelete = () => {
    setAlertModal({
      isModal: true,
      content: "정말 탈퇴하시겠습니까?",
      onClick() {      
                if(user){
          userDelete.mutate(companyData?.data.companyId, {
            onSuccess: () => {
              resetAlertModal();
              logOut();              

              // setAlertModal(
              //   {
              //     isModal : true,
              //     content : "회원탈퇴가 완료되었습니다.",                  
              //   }                
              // )
            },
            onError: (error) => {
              console.log(error);
              setAlertModal(
                {
                  isModal : true,
                  content : error.message,
                  type: "check",                  
                }                
              )
            },
          });
        } 
      },
    }); 
  };           


  return (
    <Layout notSideBar={type !== "admin"}>
      <MyPageView
        changeInfoList={
          (type === "committer" && committerMyHistoryData?.data) ||
          (type === "company" && companyMyHistoryData?.data) ||
          undefined
        }
        infoData={
          ((type === "committer" && committerData?.data) as MyInfoRes) ||
          ((type === "company" && companyData?.data) as MyInfoRes)
        }
        isButton={true}
        type={type}
        deleteUser={handleDelete}
      />
    </Layout>
  );
}
