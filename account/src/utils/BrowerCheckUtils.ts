/* eslint-disable no-useless-escape */
import { isIE } from "react-device-detect";
import { useLocation, useNavigate } from "react-router";

export const useBrower = () => {
  const navigate = useNavigate();
  const location = useLocation();
  const browerType = () => {
    if (isIE) {
      navigate("/brower-check", { replace: true });
    }
    if (!isIE && location.pathname.includes("/brower-check")) {
      if (process.env.REACT_APP_SOURCE_DISTRIBUTE === "OUTSIDE") {
        navigate("/", { replace: true });
      }
      if (process.env.REACT_APP_SOURCE_DISTRIBUTE === "INTERNAL") {
        navigate("/west", { replace: true });
      }
    }
  };

  return { browerType };
};
