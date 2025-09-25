import { useNavigate } from "react-router";
import { getCookie } from "../../../utils/ReactCookie";
import NotFoundPage from "../../../controllers/Common/NotFoundPage/NotFoundPage";

/** 라우팅 중간처리 미들웨어 */
const Authorization = ({
  children,
  criterionRole,
}: {
  children: JSX.Element;
  criterionRole?: string;
}) => {
  const navigate = useNavigate();

  if (getCookie("role") !== String(criterionRole)) return <NotFoundPage />;

  return <>{children}</>;
};

export default Authorization;
