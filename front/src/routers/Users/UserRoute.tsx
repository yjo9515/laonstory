import { Routes, Route } from "react-router-dom";
import SystemRoute from "./InRoute/SystemRoute";

function UserRoute() {
  return (
    <Routes>
      <Route path="/system/*" element={<SystemRoute />} />
    </Routes>
  );
}

export default UserRoute;
