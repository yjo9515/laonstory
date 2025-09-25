import { Routes, Route } from "react-router-dom";
import Agreement from "../../../controllers/Agreement/Agreement";
import MyInfo from "../../../controllers/Partners/MyInfo/MyInfo";
import NotFoundPage from "../../../controllers/Common/NotFoundPage/NotFoundPage";
import { useEffect } from "react";
import { setCookie } from "../../../utils/ReactCookie";
import AgreementView from "../../../controllers/Agreement/AgreementView";

function PartnersRoute() {
  useEffect(() => {
    setCookie("type", "partners");
  });
  return (
    <Routes>
      <Route path="/my-info" element={<MyInfo />} />
      <Route path="/agreement" element={<Agreement />} />
      <Route path="/agreement/view" element={<AgreementView />} />
      <Route path="*" element={<NotFoundPage />} />
    </Routes>
  );
}

export default PartnersRoute;
