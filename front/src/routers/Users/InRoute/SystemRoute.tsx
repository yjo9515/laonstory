import { useEffect } from "react";
import { Routes, Route } from "react-router-dom";
import NotFoundPage from "../../../controllers/Common/NotFoundPage/NotFoundPage";
import MyInfo from "../../../controllers/Partners/MyInfo/MyInfo";
import EvaluationRoom from "../../../controllers/System/EvaluationRoom/EvaluationRoom";
import EvaluationRoomProceed from "../../../controllers/System/EvaluationRoomProceed/EvaluationRoomProceed";
import { setCookie } from "../../../utils/ReactCookie";

function SystemRoute() {
  useEffect(() => {
    setCookie("type", "system");
  });
  return (
    <Routes>
      <Route path="/my-info" element={<MyInfo />} />

      {/* 평가방리스트 */}
      <Route path="/evaluation-room" element={<EvaluationRoom />} />

      {/* 평가방 */}
      <Route path="/evaluation-room/proceed/:id" element={<EvaluationRoomProceed />} />

      {/* 평가표 */}
      {/* <Route path="/evaluation-room/proceed/:id/grade" element={<EvaluationGrade />} /> */}

      {/* 평가종료 */}
      
      <Route path="*" element={<NotFoundPage />} />
    </Routes>
  );
}

export default SystemRoute;
