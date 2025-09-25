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
import {useRecoilState, useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import styled from "styled-components";
import BigInputButton from "../../../components/Common/Button/BigInputButton";
import { alertModalState, contentModalState } from "../../../modules/Client/Modal/Modal";
import Left from "../../../components/MyInfo/Left";
import { ViewObjectWrapperBox } from "../../../theme/common";
import { PageStateType } from "../../../interface/Common/PageStateType";
import { LogDetailRes } from "../../../interface/Master/MasterRes";
import LogDetail from "../../../view/Partners/Log/LogDetail";
import { passCheckState } from "./Passcheck";
import { set } from "lodash";

const LogController = ({type} : {type: string}) => {

    const navigate = useNavigate();
    const location = useLocation();
    const parsed = queryString.parse(location.search);
    const setAlertModal = useSetRecoilState(alertModalState);        
    const setContentModal = useSetRecoilState(contentModalState);
    const resetModal = useResetRecoilState(contentModalState);
    const userData = useRecoilValue(userState);
     const authority = RoleUtils.getClientRole(userData.role);
    const role = RoleUtils.getRole(userData.role);
    const [passCheck, setPassCheck] = useState<boolean>(false);    
    const [onDetail, setOnDetal] = useState<boolean>(true);
    const state = useLocation().state as { id: string; role: string };
    const id = state?.id;
    const [logPass, setLogPass] = useState<string>("")
    const [search, setSearch] = useState("");    
    const [startDate, setStartDate] = useState("");    
    const [endDate, setEndDate] = useState("");   
    const [selectedOption, setSelectedOption] = useState(""); 
    
    const [pageState, setPageState] = useState<PageStateType>({
        page: Number(parsed.page) || 0,
        search: (parsed.search as string) || "",
        startDate : (parsed.startDate as string) || "",
        endDate: (parsed.endDate as string) || "",
        type: selectedOption || "",
    });

    const { data, refetch, isLoading } =  useData<ILogListDataRes, ILogSearchData>(
        ["personalList", pageState],
        getLogApi,
        {enabled : passCheck}
    ); 
    const {param} = useParams();    

    // data?.data?.items?.forEach((el, i) => {
    //     const role = RoleUtils.getClientRole(el.role) === "personal" ? "개인" : "법인";
    //     el.name = `${el.name} (${role})`;
    // });
  
    
    useEffect(() => {           
      if (parsed && (pageState.page !== undefined || pageState.search || pageState.startDate || pageState.endDate || pageState.type)) {
        navigate(`/west/partners/log?page=${pageState.page}&query=${pageState.search}&startDate=${pageState.startDate}&endDate=${pageState.endDate}&type=${pageState.type}`);        
      }
    }, [pageState]);


    useEffect(()=>{
        if(passCheck){            
            refetch();
            setPageState({ page: 0, search: "", startDate:"", endDate: "", type:""});
            setSearch("");
            setStartDate("");
            setEndDate("");
            setSelectedOption("");
        }
    }, [passCheck]);


    const onSelectedOption = (type:string) => {
      setSelectedOption(type);
    }

    const resetDate = (type: string) => {
      if(type === "start"){
        setStartDate("");
      }else if(type === "end"){
        setEndDate("");
      }
    }
    
    const onPageMove = (page: number) => {      
        setPageState({ ...pageState, page });
        // navigate(`/west/partners/log?page=${page}`);
        navigate(`/west/partners/log?page=${page}&query=${pageState.search}&startDate=${pageState.startDate}&endDate=${pageState.endDate}&type=${pageState.type}`);
    };

    const onSearchContent = (search: string) => {
      setSearch(search);
    };

    const onStartDate = (startDate: string)=>{
      setStartDate(startDate);      
    }
    const onEndDate = (endDate: string)=>{
      setEndDate(endDate);      
    }

    const onRefetch = () => {      
      setPageState({ page: 0, search, startDate, endDate, type:selectedOption });      
    };

    const onReflesh = () => {
        setPageState({ page: 0, search: "", startDate:"", endDate: "", type:""});
        setSearch("");
        setStartDate("");
        setEndDate("");
        setSelectedOption("");
    };

    const sendData = useSendData<any, string>(
        postLogPasswordApi
      );    

      useEffect(()=>{      
        if(passCheck){
          setPageState(prev => ({
            ...prev,
            startDate: startDate,
            endDate:endDate,
            type: selectedOption
          }));
          
          refetch();          
        }              
      }, [selectedOption])

    const passConfirm = () => {
        // console.log(process.env.REACT_APP_LOG_PASSWORD)
        // if(process.env.REACT_APP_LOG_PASSWORD === logPass){
        //     // navigate("/west/partners/log")
        //     setPassCheck(true)
        // }else{
        //     navigate("/west/partners/dashboard")
        // }

        //todo : 셋팅만 나중에 연결              
      sendData.mutate(logPass,{
        onSuccess: (value) => {
          
          if(value.data.data){
            setPassCheck(true);
          }else{
            setAlertModal(
              {
                isModal : true,
                content : "권한이 없거나 암호가 일치하지 않습니다.",
                type: "check",                  
              }                
            )  
          }
          
        },
        onError: (error) => {
          // navigate("/west/partners/dashboard")
          setAlertModal(
            {
              isModal : true,
              content : "에러가 발생했습니다. 관리자에게 문의하세요",
              type: "check",                  
            }                
          )
        }
      })

    }
    const cancelPass = () => {
        navigate("/west/partners/dashboard")
    }

    const { data : logDetail} =  useData<LogDetailRes, string >(
      ["id", id],
      getLogDetailApi,                  
      {enabled: passCheck && type == "detail"}
  );          

    const goInfo = (id: number, e?: GridCellParams) => {      
      navigate(`/west/partners/log/${id}`, { state: { role: e?.row?.role, id } });          
      // setLogDetail(e?.row);
  };
    return (
        <Layout>
            {passCheck && type == "list" ? <LogView

                data={data?.data.items ?? []}
                meta={data?.data.meta }
                role={role}
                authority={authority}
                onPageMove={onPageMove}
                onRefetch={onRefetch}
                onReflesh={onReflesh}
                goInfo={goInfo}
                resetDate={resetDate}
                startDate={startDate}
                endDate={endDate}
                onStartDate={onStartDate}
                onEndDate={onEndDate}
                onSearchContent={onSearchContent}
                setContentModal={setContentModal}
                setAlertModal={setAlertModal}
                resetModal={resetModal}
                search={search}
                pageState={pageState}
                cellClick={onDetail}                                
                selectedOption={selectedOption}
                onSelectedOption={onSelectedOption}
                isLoading={isLoading}
            /> 
            : 
            passCheck && type == "detail" ?
            <ViewObjectWrapperBox detail>
              <h1 className="viewTitle">감사로그 상세</h1>
              <div className="mainContent">
                <Left
                  role="log"
                  logData={logDetail?.data}
                />
              </div>                
            </ViewObjectWrapperBox>            
            :
            <PasswordBlock>
            <div className="alignWrap">
                <h2>로그페이지 접근확인</h2>
                <div>
                <input type="password" value={logPass} onChange={(e) => {setLogPass(e.target.value)}} />
                </div>
                <div className="btnWrap">
                <BigInputButton 
                    text={`확인`}
                    type="button"
                    onClick={passConfirm}
                />
                <BigInputButton 
                    text={`취소`} 
                    type="reset"
                    onClick={cancelPass}
                />
                </div>
            </div>
            </PasswordBlock>        
            }            
        </Layout>
    );
}

const DetailBlock = styled.div``;

const PasswordBlock = styled.div`
  position: fixed;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  margin : auto;
  background-color: rgba(0,0,0,0.3);
  z-index: 999999999999;
  & > .alignWrap {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    margin : auto;
    background-color: #fff;
    border-radius: 10px;
    width: 320px;
    
    height: 240px;
    padding: 16px;
    & > h2 {
      font-size: 18px;
      line-height: 40px;
      text-align: center;
    }
    & > div {
      margin-top: 20px;
      & input {
        width: 100%;
        height: 40px;
        border-radius: 5px;
        border: 1px solid #ccc;
        text-indent: 10px;
      }
    }
    & > .btnWrap {
      display: flex;
      justify-content: center;
      & > button {
        width: 80px;
        height: 40px;
        margin : 0 10px;
        text-align: center;
      }
    }
    & > .btnbottom {
      display: flex;
      justify-content: center;      
    }
  }
`;

export default LogController;
