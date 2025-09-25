import { Routes, Route } from "react-router-dom";
import JoinComplete from "../controllers/Auth/Join/JoinComplete";
import JoinProcess from "../controllers/Auth/Join/JoinProcess";
import AdminRoute from "./Admin/AdminRoute";
import UserRoute from "./Users/UserRoute";
import Login from "../controllers/Auth/Login/Login";
import LoginFind from "../controllers/Auth/Login/LoginFind";
import LoginPhone from "../controllers/Auth/Login/LoginPhone";
import NotFoundPage from "../controllers/Common/NotFoundPage/NotFoundPage";
import Authorization from "../components/Common/Authorization/Authorization";
import LoginCheck from "../components/Common/Authorization/LoginCheck";
import Test from "../components/Test";
import NiceComplete from "../components/Modal/Nice/NiceComplete";
import AgreementQR from "../controllers/Agreement/AgreementQR";
import NotUseBrower from "../controllers/Common/NotFoundPage/NotUseBrower";
import AgreementQRCommitter from "../controllers/Agreement/AgreementQRCommitter";
import WaitingView from "../view/Common/WaitingView/WaitingView";

function GlobalRoute() {
  return (
    <Routes>
      <Route
        path="/"
        element={
          <LoginCheck>
            <Login />
          </LoginCheck>
        }
      />
      <Route
        path="/waiting"
        element={
          <WaitingView/>
        }
      />
      <Route
        path="/login/find/:type"
        element={
          <LoginCheck>
            <LoginFind />
          </LoginCheck>
        }
      />
      <Route
        path="/login/change-phone"
        element={
          <LoginCheck>
            <LoginPhone />
          </LoginCheck>
        }
      />
      {/* join */}
      <Route
        path="/join"
        element={
          <LoginCheck>
            <JoinProcess />
          </LoginCheck>
        }
      />
      <Route
        path="/join/complete"
        element={
          <LoginCheck>
            <JoinComplete />
          </LoginCheck>
        }
      />

      {/* 본인인증 서비스 완료시 리다이렉트 페이지 */}
      <Route path="/pass" element={<NiceComplete />} />

      <Route
        path="/west/*"
        element={
          <Authorization criterionRole={process.env.REACT_APP_ROLE_ADMIN}>
            <AdminRoute />
          </Authorization>
        }
      />
      <Route
        path="/user/*"
        element={
          <Authorization criterionRole={process.env.REACT_APP_ROLE_USER}>
            <UserRoute />
          </Authorization>
        }
      />

      <Route path="/agreement/qr/:id" element={<AgreementQR />} />

      <Route
        path="/agreement/qr/committer/:evaluationRoomId/:committerId"
        element={<AgreementQRCommitter />}
      />

      <Route path="/brower-check" element={<NotUseBrower />} />

      {/* <Route path="/invitation" element={<NotUseBrower />} /> */}


      <Route path="*" element={<NotFoundPage />} />
    </Routes>
  );
}

export default GlobalRoute;
