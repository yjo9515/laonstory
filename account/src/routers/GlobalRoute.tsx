import { Routes, Route } from "react-router-dom";
import Join from "../controllers/Auth/Join/Join";
import JoinComplete from "../controllers/Auth/Join/JoinComplete";
import JoinProcess from "../controllers/Auth/Join/JoinProcess";
import AdminRoute from "./Admin/AdminRoute";
import UserRoute from "./Users/UserRoute";
import LoginFind from "../controllers/Auth/Login/LoginFind";
import LoginPhone from "../controllers/Auth/Login/LoginPhone";
import NotFoundPage from "../controllers/Common/NotFoundPage/NotFoundPage";
import Authorization from "../components/Common/Authorization/Authorization";
import LoginCheck from "../components/Common/Authorization/LoginCheck";
import Login from "../controllers/Auth/Login/Login";
import NiceComplete from "../components/Modal/Nice/NiceComplete";
import NicePhone from "../components/Modal/Nice/NicePhone";
import AgreementQR from "../controllers/Agreement/AgreementQR";
import NotUseBrower from "../controllers/Common/NotFoundPage/NotUseBrower";
import LoginFailInternalView from "../view/Auth/Login/LoginFailInternalView";

function GlobalRoute() {
  return (
    <Routes>
      {process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL" && (
        <Route
          path="/west"
          element={
            <LoginCheck>
              <Login type="admin" />
            </LoginCheck>
          }
        />
      )}
      {/* <Route
        path="/west"
        element={
          <LoginCheck>
            <Login type="admin" />
          </LoginCheck>
        }
      /> */}

      {process.env.REACT_APP_SOURCE_DISTRIBUTE === "OUTSIDE" && (
        <Route
          path="/"
          element={
            <LoginCheck>
              <Login type="user" />
            </LoginCheck>
          }
        />
      )}
      {/* <Route
        path="/"
        element={
          <LoginCheck>
            <Login type="user" />
          </LoginCheck>
        }
      /> */}
      <Route
        path="/service-guide"
        element={
          <LoginCheck>
            <Login type="user" route={"service"} />
          </LoginCheck>
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
            <Join />
          </LoginCheck>
        }
      />
      <Route
        path="/join/:type"
        element={
          <LoginCheck>
            <JoinProcess />
          </LoginCheck>
        }
      />
      {/* 본인인증 서비스 완료시 리다이렉트 페이지 */}
      <Route path="/pass" element={<NiceComplete />} />

      <Route
        path="/join/complete"
        element={
          <LoginCheck>
            <JoinComplete />
          </LoginCheck>
        }
      />

      {/* 라우팅 구분 - 담당자일 경우 */}
      {process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL" && (
        <>
          <Route path="/west/login/fail" element={<LoginFailInternalView />} />
          <Route
            path="/west/*"
            element={
              <Authorization criterionRole={process.env.REACT_APP_ROLE_ADMIN}>
                <AdminRoute />
              </Authorization>
            }
          />
        </>
      )}

      {/* <Route
        path="/west/*"
        element={
          <Authorization criterionRole={process.env.REACT_APP_ROLE_ADMIN}>
            <AdminRoute />
          </Authorization>
        }
      /> */}

      {/* 라우팅 구분 - 이용자일 경우 */}
      {process.env.REACT_APP_SOURCE_DISTRIBUTE === "OUTSIDE" && (
        <Route
          path="/user/*"
          element={
            <Authorization criterionRole={process.env.REACT_APP_ROLE_USER}>
              <UserRoute />
            </Authorization>
          }
        />
      )}
      {/* <Route
        path="/user/*"
        element={
          <Authorization criterionRole={process.env.REACT_APP_ROLE_USER}>
            <UserRoute />
          </Authorization>
        }
      /> */}

      <Route path="/agreement/qr/:uuid" element={<AgreementQR />} />

      <Route path="/brower-check" element={<NotUseBrower />} />
      <Route path="*" element={<NotFoundPage />} />
    </Routes>
  );
}

export default GlobalRoute;
