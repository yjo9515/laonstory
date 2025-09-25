import React, { useState, useEffect } from "react";
import { ViewObjectWrapperBox } from "../../../theme/common";
import ListComponent from "../../../components/List/ListComponent/ListComponent";
import { ILogListItem, meta } from "../../../interface/List/ListResponse";
import { columns } from "./ListColumnName";
import { useNavigate } from "react-router";
import { GridCellParams } from "@mui/x-data-grid";
import styled from "styled-components";
import BigInputButton from "../../../components/Common/Button/BigInputButton";
import { useSendData } from "../../../modules/Server/QueryHook";
import queryString from "query-string";
import { postLogPasswordApi, postLogPasswordChangeApi } from "../../../api/MasterApi";
import { alertModalState, IAlertModalDefault, IContentModalDefault } from "../../../modules/Client/Modal/Modal";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import { useLocation } from "react-router";
import SmallButton1 from "../../../components/Common/Button/SmallButton1";
import SearchList from "../../../components/Common/SearchList/SearchList";
import DateInput from "../../../components/Common/Input/DateInput";

interface LogListViewTypes {
  data: ILogListItem[];
  meta?: meta;
  role: string;
  authority: string;
  pageState: { page: number; search: string };
  onPageMove: (page: number) => void;
  cellClick:boolean;
  goInfo: (id: number & string, e?: GridCellParams) => void;
  onSearchContent: (search: string) => void;
  onRefetch: () => void;
  onReflesh: () => void;
  resetDate: (type: string) => void;
  startDate: string;
  endDate: string;
  onStartDate: (startDate:string) => void;
  onEndDate: (endDate:string) => void;
  setContentModal: (data: IContentModalDefault) => void;
  setAlertModal?: (data: IAlertModalDefault) => void;
  resetModal: () => void;
  search: string;  
  onSelectedOption: (type:string) => void;
  selectedOption: string;
  isLoading: boolean;
}

const LogView = (props : LogListViewTypes) => {
    const navigate = useNavigate();
    const location = useLocation();
    const goPosition = (id: number) => {};
    const [passChange, setPassChange] = useState<boolean>(false)    
    const [prevPass, setPrevPass] = useState<string>("")
    const [newPass, setNewPass] = useState<string>("")
    const setAlertModal = useSetRecoilState(alertModalState);      
    const resetAlertModal = useResetRecoilState(alertModalState);
    
    const [isSearched, setIsSearched] = useState(false);
    

    const sendData = useSendData<any, string>(
      postLogPasswordApi
    );    

    const parsed = queryString.parse(location.search);
    const [pageState, setPageState] = useState({
      page: Number(parsed.page) || 0,
  });  

    const sendChangeData = useSendData<any, any>(
      postLogPasswordChangeApi
    );

    const changeConfirm = (prevPass:string, newPass:string) => {             
      sendChangeData.mutate({password : prevPass,newPassword:newPass},{
      onSuccess: (value) => {
        if(value.data.data){
          setAlertModal(
            {
              isModal : true,
              content : value.data.message,
              type: "check",                  
            }                
          )          
          setPassChange(false);
          setPrevPass("");
          setNewPass("");
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
            content : "권한이 없거나 암호가 일치하지 않습니다.",
            type: "check",                  
          }                
        )
      }
    })

  }
  


  useEffect(() => {    
    if (passChange) {            
      setAlertModal({                  
        title: "로그페이지 비밀번호 변경",
        content:                         
        <PasswordBlock>
          <div className="alignWrap" style={{height : '220px'}}>
              
              <div>                                      
              <div style={{ marginTop: "10px" }}>
                <div>이전 비밀번호</div>
                <input type="password"onChange={(e) => {setPrevPass(e.target.value)}} />
              </div>                                                                                                                                                                          
                <div style={{ marginTop: "10px" }}>
                  <div>변경할 비밀번호</div>
                  <input type="password" onChange={(e) => {setNewPass(e.target.value)}} />                    
                </div>
              </div>              
          </div>
          </PasswordBlock>,
        onClick: ()=>changeConfirm(prevPass, newPass),
        type: "logCheck",
        buttonText: "",
        isModal: true,
      })
    }else {
      resetAlertModal()
    }
  }, [passChange, prevPass, newPass]);


  const handleStartDate = (startDate: string) => {
    props.onStartDate(startDate);
    
    const endDate = props.endDate; // 상위에서 받은 값이라고 가정
  
    if (endDate && new Date(startDate) > new Date(endDate)) {
      alert("시작일은 종료일보다 이전이어야 합니다.");
      props.resetDate("start");
    }
  };
  
  const handleEndDate = (endDate: string) => {
    props.onEndDate(endDate);
  
    const startDate = props.startDate;
  
    if (startDate && new Date(startDate) > new Date(endDate)) {
      alert("종료일은 시작일보다 이후여야 합니다.");
      props.resetDate("end");
    }
  };
  

  return (
    <ViewObjectWrapperBox>
        <div style={{display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:'10px'}}>
            <h1 className="viewTitle">감사로그</h1>            
              <div className="dateWrap">
                <DateInput name={"startDate"} id={"startDate"} value={props.startDate} onChange={(e) => handleStartDate(e.target.value)}/>
                ~
                <DateInput name={"endDate"} id={"endDate"} value={props.endDate}  onChange={(e) => handleEndDate(e.target.value)}/>              
              </div>                    
                <SearchList
                onSearch={() => {
                  setIsSearched(true);
                  props.onRefetch();
                }}
                onReflesh={() => {
                  setIsSearched(false);
                  props.onReflesh();
                }}
                searchValue={props.pageState.search}
                onSearchContent={props.onSearchContent}
                search={props.search}
                
              />
              <SmallButton1 text="로그페이지 비밀번호 변경" onClick={()=>{                      
                setPassChange(!passChange);                
                    }}/>
          </div>
          <div className="selectWrap">
                <select value={props.selectedOption} onChange={(e)=>{props.onSelectedOption(e.target.value);}}>
                  <option value="">전체</option>
                  <option value="login">로그인 기록</option>
                </select>
          </div>
        <div className="listWrapper" style={{
            backgroundColor: props.isLoading ? '#f8f9fa' : 'transparent',
            transition: 'background-color 0.3s ease'
        }}>
        {props.isLoading ? (
            <div style={{
                display: 'flex',
                justifyContent: 'center',
                alignItems: 'center',
                height: '400px',
                fontSize: '20px',
                color: '#666',
                flexDirection: 'column'
            }}>
                <div>데이터를 불러오고 있습니다...</div>
            </div>
        ) : (
            <ListComponent
                emptyMessage={
                  (!isSearched && props.data.length === 0 && "등록된 로그가 없습니다.") ||
                  (isSearched && "검색 결과가 없습니다.") ||
                  ""
                }
                columns={columns}
                rows={props.data}
                page={props.pageState.page}
                meta={props.meta}
                goPosition={goPosition}
                goInfo={props.goInfo}
                onPageMove={props.onPageMove}
                pageType="partners"
                cellClick={props.cellClick}
                role="logList"
            />
        )}
        </div>


    </ViewObjectWrapperBox>
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
  }
`;

export default LogView;
