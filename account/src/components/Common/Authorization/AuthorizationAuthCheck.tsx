import React from "react";
import { useNavigate } from "react-router";
import NotFoundPage from "../../../controllers/Common/NotFoundPage/NotFoundPage";
import { userState } from "../../../modules/Client/Auth/Auth";
import { useRecoilValue } from "recoil";

/** 라우팅 중간처리 미들웨어 */
const AuthorizationAuthCheck: React.FC<any> = ({
  children,
  criterion,
}: {
  children: React.ReactNode;
  criterion: string;
}) => {
  const userData = useRecoilValue(userState);

  const navigate = useNavigate();

  if (userData.role !== criterion) return <NotFoundPage prevPage={true} />;
  //   토큰이 없결 경우 체크 api 연동시 토큰으로 변경

  return <>{children}</>;
};

export default AuthorizationAuthCheck;
