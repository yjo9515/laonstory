import { Routes, Route } from "react-router-dom";
import PartnersRoute from "./InRoute/PartnersRoute";

function SystemAdminRoute() {
  return (
    <Routes>
      <Route path="/partners/*" element={<PartnersRoute />} />
    </Routes>
  );
}

export default SystemAdminRoute;
