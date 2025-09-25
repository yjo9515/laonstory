import React, { useState, useEffect } from "react";
import { useLocation, useNavigate } from "react-router";
import Layout from '../../Common/Layout/Layout';
import LogView from "../../../view/System/Log/Log";
import RoleUtils from "../../../utils/RoleUtils";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
import { userState } from "../../../modules/Client/Auth/Auth";
import { ILogListItem, meta, ILogListDataRes } from "../../../interface/List/ListResponse";
import { ILogListData, ILogSearchData } from "../../../interface/Master/MasterData";
import { getLogApi, getLogDetailApi, postLogPasswordApi } from "../../../api/MasterApi";

import queryString from "query-string";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import AlertModal from "../../../components/Modal/AlertModal";
import { alertModalState, contentModalState } from "../../../modules/Client/Modal/Modal";
import styled from "styled-components";
import BigInputButton from "../../../components/Common/Button/BigInputButton";
import { GridCellParams } from "@mui/x-data-grid";
import { ViewObjectWrapperBox } from "../../../theme/common";
import Left from "../../../components/MyInfo/Left";
import { LogDetailRes } from "../../../interface/Master/MasterRes";
import { PageStateType } from "../../../interface/Common/PageStateType";


const LogController = ({type} : {type: string}) => {

    const navigate = useNavigate();
    const location = useLocation();
    const parsed = queryString.parse(location.search);
    const alertModal = useRecoilValue(alertModalState);
    const resetAlertModal = useResetRecoilState(alertModalState);
    const setAlertModal = useSetRecoilState(alertModalState);        
    const setContentModal = useSetRecoilState(contentModalState);
    const resetModal = useResetRecoilState(contentModalState);
    const state = useLocation().state as { id: string; role: string };
    const id = state?.id;
    const userData = useRecoilValue(userState);
    const authority = RoleUtils.getClientRole(userData.role);
    const role = RoleUtils.getRole(userData.role);
    const [passCheck, setPassCheck] = useState<boolean>(false)
    const [logPass, setLogPass] = useState<string>("")
    const [search, setSearch] = useState((parsed.query as string) || "");    
    const [startDate, setStartDate] = useState((parsed.startDate as string) || "");    
    const [endDate, setEndDate] = useState((parsed.endDate as string) || "");   
    const [onDetail, setOnDetal] = useState<boolean>(true);
    const [selectedOption, setSelectedOption] = useState((parsed.type as string) || "");


    const [pageState, setPageState] = useState<PageStateType>({
        page: Number(parsed.page) || 0,
        search: search,
        startDate: startDate,
        endDate: endDate,
        type: selectedOption,
    });

    const { data, refetch, isLoading } = useData<ILogListDataRes, ILogSearchData>(
        ["logList", pageState],
        getLogApi,        
        { enabled: passCheck } 
    );

    useEffect(() => {            
      if (parsed && (pageState.page !== undefined || pageState.search || pageState.startDate || pageState.endDate || pageState.type)) {
        navigate(`/west/system/log?page=${pageState.page}&query=${pageState.search}&startDate=${pageState.startDate}&endDate=${pageState.endDate}&type=${pageState.type}`);}      
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

    const onPageMove = (page: number) => {        
        setPageState({ ...pageState, page });
        navigate(`/west/system/log?page=${page}&query=${pageState.search}&startDate=${pageState.startDate}&endDate=${pageState.endDate}&type=${pageState.type}`);
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

    const onSearchContent = (search: string) => {
      setSearch(search);
    };

    const onReflesh = () => {      
      setPageState({ page: 0, search: "", startDate:"", endDate: "", type:""});
      setSearch("");
      setStartDate("");
      setEndDate("");
      setSelectedOption("");
    };

    const resetDate = (type: string) => {
      if(type === "start"){
        setStartDate("");
      }else if(type === "end"){
        setEndDate("");
      }
    }
    

    const onSelectedOption = (type:string) => {
      setSelectedOption(type);
    }

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

    const sendData = useSendData<any, string>(
        postLogPasswordApi
      );

    const passConfirm = (password:string) => {      
        // console.log(process.env.REACT_APP_LOG_PASSWORD)
        // if(process.env.REACT_APP_LOG_PASSWORD === logPass){
        //     // navigate("/west/partners/log")
        //     setPassCheck(true)
        // }else{
        //     navigate("/west/partners/dashboard")
        // }

        //todo : 셋팅만 나중에 연결     
      if(!password || logPass.trim() === "") {alert("비밀번호를 입력해주세요."); return;}
      sendData.mutate(password,{
        onSuccess: (value) => {          
          if(value.data.data){
            setPassCheck(true);            
          }else{
            setAlertModal(
              {
                isModal : true,
                content : "권한이 없거나 암호가 일치하지 않습니다.",
                type: "check", 
                onClick: ()=>{                                    
                  setLogPass("");
                  setPassCheck(false);
                }                 
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
              onClick: ()=>{
                setLogPass("");
                  setPassCheck(false);
              }                         
            }                
          )
        }
      })

    }
    const cancelPass = () => {
        navigate("/west/system/dashboard")
    }

    const { data : logDetail} =  useData<LogDetailRes, string >(
      ["id", id],
      getLogDetailApi,                  
      {enabled: passCheck && type == "detail"}
  );  

    const goInfo = (id: number, e?: GridCellParams) => {      
      navigate(`/west/system/log/${id}`, { state: { role: e?.row?.role, id } });                  
      // setLogDetail(e?.row);
      // console.log(e?.row);
  };


  const PasswordInput = ({ logPass, setLogPass }: { logPass: string; setLogPass: (v: string) => void })  => (
    <PasswordBlock>
      <div className="alignWrap">
        <div>
          <input
            type="password"
            value={logPass}
            // onChange={(e) => {
            //   setLogPass(e.target.value);
            //   console.log(e.target.value);
            //   console.log(logPass);
            // }}
          />
        </div>
      </div>
    </PasswordBlock>
  );

  useEffect(() => {
    console.log(passCheck);
    if (!passCheck) {            
      setAlertModal({                  
        title: "로그페이지 접근확인",
        content:                         
        <PasswordBlock>
          <div className="alignWrap">
            <div>
              <input                
                type="password"            
                onChange={(e) => {              
                  setLogPass(e.target.value);              
                }}
              />
            </div>
          </div>
        </PasswordBlock>,
        onClick: ()=>passConfirm(logPass),
        type: "logCheck",
        buttonText: "",
        isModal: true,
      })
    }else {
      resetAlertModal()
    }
  }, [logPass,passCheck]); // passCheck가 false로 바뀔 때만 실행됨  
    
    return (
        <Layout>
            {passCheck && type == "list" ? <LogView
                data= { data?.data.items ?? [] }
                meta = { data?.data.meta }
                role = { role }
                authority = { authority }
                onPageMove = { onPageMove }
                onRefetch = { onRefetch }
                onReflesh = { onReflesh }
                resetDate={resetDate}
                startDate={startDate}
                endDate={endDate}
                onStartDate={onStartDate}
                onEndDate={onEndDate}
                pageState = { pageState }
                goInfo={goInfo}
                cellClick={onDetail}          
                onSearchContent={onSearchContent}
                setContentModal={setContentModal}
                setAlertModal={setAlertModal}
                resetModal={resetModal}
                search={search}                
                selectedOption={selectedOption}
                onSelectedOption={onSelectedOption}
                isLoading={isLoading}
            /> :
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
          : <div></div>
            // <PasswordBlock>
            // <div className="alignWrap">
                // <h2>로그페이지 접근확인</h2>
                // <div>
                // <input type="password" value={logPass} onChange={(e) => {setLogPass(e.target.value)}} />
                // </div>
                // <div className="btnWrap">
                // <BigInputButton 
                //     text={`확인`}
                //     type="button"
                //     onClick={passConfirm}
                // />
                // <BigInputButton 
                //     text={`취소`}
                //     type="reset"
                //     onClick={cancelPass}
                // />
                // </div>
            // </div>
            // </PasswordBlock>     
            // (
            //   <>
            //     {setAlertModal({
                  
            //       title: "안내",
            //       content:       <><h2>로그페이지 접근확인</h2><div>
            //         <input type="password" value={logPass} onChange={(e) => { setLogPass(e.target.value); } } />
            //       </div><div className="btnWrap">
            //           <BigInputButton
            //             text={`확인`}
            //             type="button"
            //             onClick={passConfirm} />
            //           <BigInputButton
            //             text={`취소`}
            //             type="reset"
            //             onClick={cancelPass} />
            //         </div></>,
            //       onClick: undefined,
            //       type: undefined,
            //       buttonText: "",
            //       isModal: false,
            //     })}
            //     <div /> {/* ReactElement를 반환하기 위해 더미 엘리먼트라도 필요함 */}
            //   </>
            // )  
            }
        </Layout>
    );
}
const PasswordBlock = styled.div`
  /* position: fixed;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  margin : auto;
  background-color: rgba(0,0,0,0.3);
  z-index: 999999999999; */
  & > .alignWrap {
    /* position: absolute; */
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    margin : auto;
    background-color: #fff;
    border-radius: 10px;
    width: 320px;
    
    /* height: 240px; */
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

