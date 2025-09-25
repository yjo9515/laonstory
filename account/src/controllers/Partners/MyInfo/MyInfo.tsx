import { useRecoilValue, useSetRecoilState,useResetRecoilState } from "recoil";
import {
  personalMyHistoryApi,
  personalMyInfoApi,
  companyMyHistoryApi,
  companyMyInfoApi,
} from "../../../api/MyInfoApi";
import { IMyInfoChangeRes, MyInfoRes } from "../../../interface/MyInfo/MyInfoResponse";
import { userState } from "../../../modules/Client/Auth/Auth";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import RoleUtils from "../../../utils/RoleUtils";
import MyPageView from "../../../view/Partners/MyInfoView/MyInfoView";
import Layout from "../../Common/Layout/Layout";
import { personalDeleteUserApi } from "../../../api/AuthApi";
import { IDeleteId } from "../../../interface/Auth/ApiDataInterface";
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
  const { data: personalData } = useData<MyInfoRes, null>(
    ["personalData", null],
    personalMyInfoApi,
    {
      enabled: type === "personal",      
    }
  );
  const { data: companyData } = useData<MyInfoRes, null>(["companyData", null], companyMyInfoApi, {
    enabled: type === "company",
  });
  // 정보변경내역 api
  const { data: personalMyHistoryData } = useData<IMyInfoChangeRes[], null>(
    ["personalMyHistory", null],
    personalMyHistoryApi,
    {
      enabled: type === "personal",
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
  const userDelete = useSendData<any, string>(
    
    personalDeleteUserApi,    
  );      

  const { logOut } = useAuth();
  const handleDelete = () => {

    setAlertModal({
      isModal: true,
      content: "정말 탈퇴하시겠습니까?",
      onClick() {
        // console.log(personalData?.data);
        // if(personalData?.data.id){
        
          userDelete.mutate("", {
            onSuccess: () => {
              console.log("성공");
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
              setAlertModal(
                {
                  isModal : true,
                  content : error.message,
                  type: "check",                  
                }                
              )
            },
          });
        // } 
      },
    });            
  };

  return (
    <Layout notSideBar={type !== "admin"} notHeadTitle useFooter>
      <MyPageView
        changeInfoList={
          (type === "personal" && personalMyHistoryData?.data) ||
          (type === "company" && companyMyHistoryData?.data) ||
          undefined
        }
        infoData={
          ((type === "personal" && personalData?.data) as MyInfoRes) ||
          ((type === "company" && companyData?.data) as MyInfoRes)
        }
        isButton={true}
        type={type}
        deleteUser={handleDelete}
      />
    </Layout>    
  );
}
