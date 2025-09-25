import { Routes, Route } from "react-router-dom";
import NotFoundPage from "../../controllers/Common/NotFoundPage/NotFoundPage";
import SystemRoute from "./InRoute/SystemRoute";

function SystemAdminRoute() {
  return (
    <Routes>
      <Route path="/system/*" element={<SystemRoute />} />
      <Route path="*" element={<NotFoundPage />} />
    </Routes>
  );
}

export default SystemAdminRoute;
