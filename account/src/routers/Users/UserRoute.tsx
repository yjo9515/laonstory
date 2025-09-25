import { Routes, Route } from "react-router-dom";
import PartnersRoute from "./InRoute/PartnersRoute";

function UserRoute() {
  return (
    <Routes>
      <Route path="/partners/*" element={<PartnersRoute />} />
    </Routes>
  );
}

export default UserRoute;
