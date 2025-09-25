import React, {useState, useEffect} from "react";
import { useLocation, useNavigate, useParams } from "react-router";
import Layout from "../../Common/Layout/Layout";
import LogView from "../../../view/Partners/Log/Log";
import RoleUtils from "../../../utils/RoleUtils";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import { userState } from "../../../modules/Client/Auth/Auth";
import { ILogListItem, meta, ILogListDataRes } from "../../../interface/List/ListResponse";
import { ILogListData, ILogSearchData } from "../../../interface/List/ListData";
import { getLogApi, getLogDetailApi, postLogPasswordApi } from "../../../api/MasterApi";
import { GridCellParams } from "@mui/x-data-grid";
import queryString from "query-string";
import { useRecoilState, useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import styled from "styled-components";
import BigInputButton from "../../../components/Common/Button/BigInputButton";
import { alertModalState, contentModalState } from "../../../modules/Client/Modal/Modal";
import Left from "../../../components/MyInfo/Left";
import { ViewObjectWrapperBox } from "../../../theme/common";
import { PageStateType } from "../../../interface/Common/PageStateType";
import { LogDetailRes } from "../../../interface/Master/MasterRes";
import LogDetail from "../../../view/Partners/Log/LogDetail";
import { passCheckState } from "./Passcheck";

const LogDetailController = () => {

    const navigate = useNavigate();
    const location = useLocation();
    const parsed = queryString.parse(location.search);
    const setAlertModal = useSetRecoilState(alertModalState);        
    const setContentModal = useSetRecoilState(contentModalState);
    const resetModal = useResetRecoilState(contentModalState);
    const userData = useRecoilValue(userState);
     const authority = RoleUtils.getClientRole(userData.role);
    const role = RoleUtils.getRole(userData.role);
    const [passCheck, setPassCheck] = useRecoilState(passCheckState); 

    const state = useLocation().state as { id: string; role: string };
    const id = state?.id;                
        
    // useEffect(() => {
    //   if (!state?.id || !state?.role) navigate("/");
    // }, [state?.id, state?.role]);

    // data?.data?.items?.forEach((el, i) => {
    //     const role = RoleUtils.getClientRole(el.role) === "personal" ? "개인" : "법인";
    //     el.name = `${el.name} (${role})`;
    // });

    const { data : logDetail} =  useData<LogDetailRes, string >(
      ["id", id],
      getLogDetailApi,                  
      {enabled: passCheck}
  );          

    useEffect(()=>{      
        if(passCheck){
            console.log("체크완료");            
        }        
    }, [passCheck]);

    
      
    return (
        <Layout>
            <LogDetail
            role="log"
            logData={logDetail?.data}
            />    
        </Layout>
    );
}

export default LogDetailController;
