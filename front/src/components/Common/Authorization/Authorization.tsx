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
  //   토큰이 없결 경우 체크 api 연동시 토큰으로 변경

  // if (!getCookie("token")) return <NotFoundPage />;

  if (!getCookie("token")) {
    navigate("/", { replace: true });
    return <></>;
  }

  if (getCookie("role") !== String(criterionRole)) return <NotFoundPage />;

  return <>{children}</>;
};

export default Authorization;
