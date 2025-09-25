import { Routes, Route } from "react-router-dom";
import NotFoundPage from "../../../controllers/Common/NotFoundPage/NotFoundPage";
import AgreementList from "../../../controllers/Partners/Agreement/AgreementList/AgreementList";
import ListDetail from "../../../controllers/Partners/Detail/Detail";
import AdminMyInfo from "../../../controllers/Partners/MyInfo/AdminMyInfo";
import Dashboard from "../../../controllers/Partners/Dashboard/Dashboard";
import LogController from "../../../controllers/Partners/Log/Log";
import Terms from "../../../controllers/Partners/Terms/Terms";
import { useEffect } from "react";
import { setCookie } from "../../../utils/ReactCookie";
import AgreementView from "../../../controllers/Agreement/AgreementView";
import UserList from "../../../controllers/Partners/User/UserList/UserList";
import IssuanceCompletedList from "../../../controllers/Partners/Issuance/IssuanceCompleted/IssuanceCompletedList";
import LoginCheck from "../../../components/Common/Authorization/LoginCheck";

function PartnersRoute({ type }: { type?: string }) {
  useEffect(() => {
    setCookie("type", "partners");
  });

  return (
    <Routes>
      <Route path="/dashboard" element={
  <LoginCheck>
    <Dashboard />
  </LoginCheck>
} />
<Route path="/user" element={
  <LoginCheck>
    <UserList />
  </LoginCheck>
} />
<Route path="/user/:id" element={
  <LoginCheck>
    <ListDetail type="user" />
  </LoginCheck>
} />
<Route path="/agreement" element={
  <LoginCheck>
    <AgreementList />
  </LoginCheck>
} />
<Route path="/agreement/view/:uuid" element={
  <LoginCheck>
    <AgreementView type="admin" />
  </LoginCheck>
} />
<Route path="/agreement/detail" element={
  <LoginCheck>
    <ListDetail type="agreement" />
  </LoginCheck>
} />
<Route path="/issuance" element={
  <LoginCheck>
    <IssuanceCompletedList />
  </LoginCheck>
} />
<Route path="/issuance/view/:uuid" element={
  <LoginCheck>
    <AgreementView type="admin" />
  </LoginCheck>
} />
<Route path="/my-info" element={
  <LoginCheck>
    <AdminMyInfo />
  </LoginCheck>
} />
<Route path="/terms" element={
  <LoginCheck>
    <Terms />
  </LoginCheck>
} />
<Route path="/log" element={
  
    <LogController type="list" />
  
} />
<Route path="/log/:id" element={  
    <LogController type="detail" />
  
} />
<Route path="*" element={<NotFoundPage />} />

    </Routes>
  );
}

export default PartnersRoute;
