import { useEffect, useState } from "react";
import { useLocation, useNavigate, useParams } from "react-router";
import NotFoundPage from "../../../controllers/Common/NotFoundPage/NotFoundPage";
import { useAuth } from "../../../utils/AuthUtils";
import { getCookie } from "../../../utils/ReactCookie";
import { useSetRecoilState } from "recoil";
import { alertModalState } from "../../../modules/Client/Modal/Modal";
import { useIdleTimer } from "react-idle-timer";

export default function LoginCheck({ children }: { children: JSX.Element }) {
  const navigate = useNavigate();
  const params = useParams();
  const location = useLocation().pathname;
  const paramsType = params.type;
  const setAlertModal = useSetRecoilState(alertModalState);
  const { logOut } = useAuth();  
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
      const currentRemaining = getRemainingTime();
      setRemaining(currentRemaining);
      // console.log("남은 시간:", currentRemaining / 1000, "초");
      
      // remaining이 0이 되면 타이머 중지
      if (currentRemaining === 0) {
        clearInterval(interval);
      }
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
      type: "check",
      onClick: ()=>{
        logOut(); 
      }
    });    
    
  }
}, [remaining]);

// // 로그인 상태 확인 및 리다이렉트  
// useEffect(() => {
//   // 상태에 따라 리다이렉트
//   if (getCookie("token")) {
//     const role = getCookie("role");
//     const pass = getCookie("pass");
//     const token = getCookie("token");

//     if ((!role || !pass) && !token) {
//       logOut();
//     } else {
//       if (role === "admin") {
//         navigate(`/west/system/dashboard`, { replace: true });
//       }
//       if (role === "user") navigate(`/`, { replace: true });
//     }
//   }
// }, []);
  // 로그인 상태에서 접근 시 리다이렉트
  useEffect(() => {
    // 상태에 따라 리다이렉트
    if (getCookie("token")) {
      const role = getCookie("role");
      const pass = getCookie("pass");
      const token = getCookie("token");

      if ((!role || !pass) && !token){
        // console.log("로그아웃 3");
        logOut();
      }else{        
        if (role === "admin") {
          if (!location.startsWith("/west/partners/")) { 
            navigate(`/west/partners/dashboard`, { replace: true });
            }
          // navigate(`/west/partners/dashboard`, { replace: true });          
  
        }
  
        if (role === "user") navigate(`/`, { replace: true });
      }
            
    }
  }, []);
  if (
    location.includes("join") &&
    paramsType &&
    paramsType !== "company" &&
    paramsType !== "personal"
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
