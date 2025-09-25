import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router";
import { useResetRecoilState } from "recoil";
import { createWebexRoomResultApi } from "../../../api/EvaluationRoomApi";
import { WebexReqType } from "../../../interface/System/EvaluationRoomDetail/EvaluationRoomDetailTypes";
import { loadingModalState } from "../../../modules/Client/Modal/Modal";
import { useSendData } from "../../../modules/Server/QueryHook";

function CreateWebexRoomResult() {
  const location = useLocation();
  const navigate = useNavigate();

  const resetLoadingModal = useResetRecoilState(loadingModalState);

  const webexRoom = useSendData<string, WebexReqType>(createWebexRoomResultApi, {
    onSuccess: () => {
      resetLoadingModal();
      navigate("/west/system/evaluation-room");
    },
  });

  const URLSearch = new URLSearchParams(location.search);

  const [status, setStatus] = useState<WebexReqType>({
    code: "NTdmNTZiYzktNjk5ZC00ODM5LTkwM2QtNmI1NzRkOGIwZjgxM2M1NDlhYzgtZTNi_P0A1_e77bdb70-5835-4193-b328-1a7e84839fa8",
    state: "set_state_here",
  });

  useEffect(() => {
    setStatus({
      code: URLSearch.get("code") ?? "",
      state: URLSearch.get("state") ?? "",
    });
  }, []);

  useEffect(() => {
    if (status.code && status.state) {
      webexRoom.mutate(status);
    }
  }, [status]);

  return <></>;
}

export default CreateWebexRoomResult;
