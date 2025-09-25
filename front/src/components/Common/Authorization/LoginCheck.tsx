import { useEffect, useState } from "react";
import { useLocation, useNavigate, useParams } from "react-router";
import NotFoundPage from "../../../controllers/Common/NotFoundPage/NotFoundPage";
import { useAuth } from "../../../utils/AuthUtils";
import { getCookie } from "../../../utils/ReactCookie";
import { useIdleTimer } from "react-idle-timer";
import { useSetRecoilState } from "recoil";
import { alertModalState } from "../../../modules/Client/Modal/Modal";
import AlertModal from "../../../components/Modal/AlertModal";

export default function LoginCheck({ children }: { children: JSX.Element }) {
  const navigate = useNavigate();
  const params = useParams();
  const location = useLocation().pathname;
  const paramsType = params.type;
  const { logOut } = useAuth();
  const setAlertModal = useSetRecoilState(alertModalState);

  const role = getCookie("role");
  const token = getCookie("token");
  const pass = getCookie("pass");

  // 타이머 상태 및 IdleTimer 설정
  const [remaining, setRemaining] = useState<number>();
  const { getRemainingTime, reset } = useIdleTimer({
    timeout: 10 * 60 * 1000, // 10분      
    events: [
      "mousemove",
      "keydown",
      "wheel",
      "DOMMouseScroll",
      "mousewheel",
      "mousedown",
      "touchstart",
      "touchmove",
      "MSPointerDown",
      "MSPointerMove",
      "visibilitychange",
    ],
    throttle: 500,
  });

  // 남은 시간 로그 출력 및 세션 만료 처리
  useEffect(() => {
    if (getCookie("token")) {
      const interval = setInterval(() => {
        setRemaining(getRemainingTime());
        // console.log("남은 시간:", getRemainingTime() / 1000, "초");
      }, 1000);

      return () => {                 
        clearInterval(interval)
      };
    }
  });

  // 남은 시간이 0이 되었을 때 세션 만료 처리
  useEffect(() => {
    if (remaining === 0) {
      setAlertModal({
        isModal: true,
        content: "장시간 입력이 없어 로그아웃 처리됩니다.",
      });
      logOut();
    }
  }, [remaining]);

  // 로그인 상태 확인 및 리다이렉트  
  useEffect(() => {
    // 상태에 따라 리다이렉트
    if (getCookie("token")) {
      const role = getCookie("role");
      const pass = getCookie("pass");
      const token = getCookie("token");      
      if ((!role || !pass) && !token ) {
        logOut();
      } else {
        if (role === "admin") {
          if (!location.startsWith("/west/system/")) { 
          navigate(`/west/system/dashboard`, { replace: true });
          }
          // navigate(`/west/system/dashboard`, { replace: true });
        }
        if (role === "user") navigate(`/`, { replace: true });
      }
    }
  }, []);

  // 잘못된 경로일 때 NotFoundPage 렌더링
  if (
    location.includes("join") &&
    paramsType &&
    paramsType !== "company" &&
    paramsType !== "committer"
  )
    return <NotFoundPage />;

  if (
    location.includes("login/find") &&
    paramsType &&
    paramsType !== "password" &&
    paramsType !== "id"
  )
    return <NotFoundPage />;

  return <>{children}</>;
}
