import React, { useEffect, useState } from "react";
import { Routes, Route } from "react-router-dom";
import NotFoundPage from "../../../controllers/Common/NotFoundPage/NotFoundPage";
import CommitterList from "../../../controllers/Partners/Committer/CommitterList/CommitterList";
import EvaluationRoom from "../../../controllers/System/EvaluationRoom/EvaluationRoom";
import EvaluationRoomDetail from "../../../controllers/System/EvaluationRoomDetail/EvaluationRoomDetail";
import EvaluationRoomProceed from "../../../controllers/System/EvaluationRoomProceed/EvaluationRoomProceed";

import Detail from "../../../controllers/Partners/Detail/Detail";
import CompanyList from "../../../controllers/Partners/Company/CompanyList/CompanyList";
import Dashboard from "../../../controllers/Partners/Dashboard/Dashboard";
import { useAuth } from "../../../utils/AuthUtils";
import { setCookie } from "../../../utils/ReactCookie";
import AdminMyInfo from "../../../controllers/Partners/MyInfo/AdminMyInfo";
import Terms from "../../../controllers/Partners/Terms/Terms";
import CreateWebexRoom from "../../../controllers/System/CreateWebexRoom/CreateWebexRoom";
import CreateWebexRoomResult from "../../../controllers/System/CreateWebexRoom/CreateWebexRoomResult";
import EvaluationTable from "../../../controllers/System/EvaluationTable/EvaluationTable";
import EvaluationTableDetail from "../../../controllers/System/EvaluationTableDetail/EvaluationTableDetail";
import EvaluationRoomFinished from "../../../controllers/System/EvaluationRoomFinished/EvaluationRoomFinished";
import LogController from "../../../controllers/System/Log/Log";
import { useIdleTimer } from "react-idle-timer";
import { useSetRecoilState } from "recoil";
import { alertModalState } from "../../../modules/Client/Modal/Modal";
import LoginCheck from "../../../components/Common/Authorization/LoginCheck";
function SystemRoute() {
//   const [remaining, setRemaining] = useState<number>();
//   const { logOut } = useAuth();

//   const setAlertModal = useSetRecoilState(alertModalState);  

//   const { getRemainingTime, reset } = useIdleTimer({
//     timeout: 10 * 60 * 1000, // 10분
//     events: [
//       "mousemove",
//       "keydown",
//       "wheel",
//       "DOMMouseScroll",
//       "mousewheel",
//       "mousedown",
//       "touchstart",
//       "touchmove",
//       "MSPointerDown",
//       "MSPointerMove",
//       "visibilitychange",
//     ],
//     throttle: 500,
//   });

//   // 남은 시간 로그 출력 및 세션 만료 처리
//   useEffect(() => {
          
//       const interval = setInterval(() => {
//         setRemaining(getRemainingTime());
//         // console.log("남은 시간:", getRemainingTime() / 1000, "초");
//       }, 1000);

//       return () => {
//         clearInterval(interval)
//       };    
//   });
// // 남은 시간이 0이 되었을 때 세션 만료 처리
// useEffect(() => {
//   if (remaining === 0) {
//     setAlertModal({
//       isModal: true,
//       content: "장시간 입력이 없어 로그아웃 처리됩니다.",
//       onClick: (()=>logOut()),
//       type: "check"
//     });    
//   }
// }, [remaining]);

  useEffect(() => {
    setCookie("type", "system");
  });
  return (
    <Routes>
      {/* 평가방리스트 */}
      <Route path="/evaluation-room" element={
        <LoginCheck>
          <EvaluationRoom />
        </LoginCheck>} />
      
        <Route path="/dashboard" element={
          <LoginCheck>
            <Dashboard />
          </LoginCheck>   
          } />
         
      <Route path="/committer" element={
        <LoginCheck>
          <CommitterList />
        </LoginCheck>
        } />
      <Route path="/committer/:id" element={
        <LoginCheck>
          <Detail type="committer" />          
        </LoginCheck>} />
        <Route path="/company" element={<LoginCheck><CompanyList /></LoginCheck>} />
        <Route path="/company/:id" element={<LoginCheck><Detail type="company" /></LoginCheck>} />

        {/* 내정보 */}
        <Route path="/my-info" element={<LoginCheck><AdminMyInfo /></LoginCheck>} />

        {/* 약관설정 */}
        <Route path="/terms" element={<LoginCheck><Terms /></LoginCheck>} />

        {/* 취급중인 정보 주체 */}
        <Route path="/information-subject" element={<LoginCheck><Terms /></LoginCheck>} />

        {/* 평가방 개설 */}
        <Route path="/evaluation-room/add" element={<LoginCheck><EvaluationRoomDetail type="add" /></LoginCheck>} />

        {/* 평가방 수정 */}
        <Route path="/evaluation-room/:id" element={<LoginCheck><EvaluationRoomDetail type="modify" /></LoginCheck>} />

        {/* 평가방 */}
        <Route path="/evaluation-room/proceed/:id" element={<EvaluationRoomProceed />} />

        {/* 평가 완료 평가방 담당자 페이지 */}
        <Route path="/evaluation-room/finished/:id" element={<EvaluationRoomFinished />} />

        {/* 평가항목표 */}
        <Route path="/evaluation-table" element={<LoginCheck><EvaluationTable /></LoginCheck>} />
        <Route path="/evaluation-table/add" element={<LoginCheck><EvaluationTableDetail /></LoginCheck>} />
        <Route path="/evaluation-table/:id" element={<LoginCheck><EvaluationTableDetail /></LoginCheck>} />
        <Route path="/evaluation-table/:id/templete" element={<LoginCheck><EvaluationTableDetail /></LoginCheck>} />

        {/* Webex 연동 */}
        <Route path="/webex/oauth" element={<CreateWebexRoom />} />
        <Route path="/webex/oauth/result" element={<CreateWebexRoomResult />} />

        {/* 위임자 상세 페이지 */}
        <Route path="/committer/:id" element={<LoginCheck><Detail type="committer" /></LoginCheck>} />

      <Route path="/log" element={<LogController type="list"/>} />
      <Route path="/log/:id" element={<LogController type="detail"/>} />

      <Route path="*" element={<NotFoundPage />} />
    </Routes>
  );
}

export default SystemRoute;
