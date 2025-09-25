import { isIE } from "react-device-detect";
import { useNavigate, useLocation } from "react-router";

export const useBrower = () => {
  const navigate = useNavigate();
  const location = useLocation();

  const browerType = () => {
    if (isIE) {
      navigate("/brower-check", { replace: true });
    }
    if (!isIE && location.pathname.includes("/brower-check")) {
      navigate("/", { replace: true });
    }
  };

  return { browerType };
};
