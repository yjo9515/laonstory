import { AxiosError, AxiosResponse } from "axios";
import { useMutation, UseMutationOptions, useQuery, UseQueryOptions } from "react-query";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import { GlobalResponse } from "../../interface/Response/GlobalResponse";

import { ErrorStatus } from "../../utils/ErrorCode";
import { alertModalState, loadingModalState } from "../Client/Modal/Modal";

import { useLocation, useNavigate } from "react-router";
import { removeCookie } from "../../utils/ReactCookie";
import { refreshJwt } from "../../utils/jwt";

export function useData<TRes, TData>(
  key: [string, TData],
  api: (query: TData) => Promise<AxiosResponse<GlobalResponse<TRes>>>,
  option: UseQueryOptions<
    AxiosResponse<GlobalResponse<TRes>>,
    AxiosError,
    GlobalResponse<TRes>,
    [string, TData]
  > = {}
) {
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const setAlertModal = useSetRecoilState(alertModalState);
  const onLineCheck = window.navigator.onLine;
  const location = useLocation();
  const navigate = useNavigate();

  const { refreshToken } = refreshJwt();

  return useQuery<
    AxiosResponse<GlobalResponse<TRes>>,
    AxiosError,
    GlobalResponse<TRes>,
    [string, TData]
  >(key, async () => {
    await refreshToken();
    const response = await api(key[1] as TData);
    return response;
  }, {
    select(res) {
      return res.data;
    },
    retry: false,
    onError(err: AxiosError) {
      const errorMessage = ErrorStatus(err as AxiosError);
      const onLineCheckMessage = "인터넷 연결을 확인해주세요.";
      resetLoadingModal();
      if(errorMessage === '로그인이 만료되었습니다.'){
        setAlertModal({
          isModal: true,
          content: onLineCheck ? errorMessage : onLineCheckMessage,
          type: 'check',
          onClick: () => {
            removeCookie("token");
            removeCookie("role");
            removeCookie("authority");
            removeCookie("pass");
            if (location.pathname !== "/") navigate(`/`, { replace: true });
            window.location.href = "/";
          }
        });
        return
      }else if (errorMessage === '로그 접근 에러.\n권한 확인 혹은 패스워드를 재입력해주세요.'){
        setAlertModal({
          isModal: true,
          type: 'check',
          content: onLineCheck ? errorMessage : onLineCheckMessage,
          onClick:  () => {
            window.location.reload();
          }
        });
        return
      }      
        setAlertModal({
          isModal: true,
          content: onLineCheck ? errorMessage : onLineCheckMessage,
        });
      
      
    },
    ...option,
  });
}

interface ServerError {
  status: number;
  message: string;
  code?: string;
}


export function useSendData<TData, TVariables>(
  api: (data: TVariables) => Promise<AxiosResponse<GlobalResponse<TData>>>,
  option: UseMutationOptions<AxiosResponse<GlobalResponse<TData>>, AxiosError, TVariables> = {}
) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const setLoadingModal = useSetRecoilState(loadingModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const onLineCheck = window.navigator.onLine;
  const location = useLocation();
  const navigate = useNavigate();

  const { refreshToken } = refreshJwt();


  return useMutation<AxiosResponse<GlobalResponse<TData>>, AxiosError, TVariables>(api, {
    async onMutate() {
      setLoadingModal({
        isButton: false,
        isModal: true,
        type: "default",
      });

      await refreshToken();

    },
    onError(err: AxiosError) {
      const errorMessage = ErrorStatus(err as AxiosError);
      const onLineCheckMessage = "인터넷 연결을 확인해주세요.";
      resetLoadingModal();

      const data = err.response?.data as ServerError;

      if (data.code && data.code === 'lock') {
        setAlertModal({
          isModal: true,
          content: ErrorStatus(err as AxiosError),
          type: 'check',
          onClick: () => {
            navigate('/login/find/password');
          }
        });

        return;
      }
      if(errorMessage === '로그인이 만료되었습니다.'){
        setAlertModal({
          isModal: true,
          content: onLineCheck ? errorMessage : onLineCheckMessage,
          type: 'check',
          onClick: () => {
            removeCookie("token");
            removeCookie("role");
            removeCookie("authority");
            removeCookie("pass");
            if (location.pathname !== "/") navigate(`/`, { replace: true });
            window.location.href = "/";
          }
        });
        return;
      }

      setAlertModal({
        isModal: true,
        content: onLineCheck ? errorMessage : onLineCheckMessage,
      });
    },
    retry: false,
    onSuccess() {
      resetLoadingModal();
    },
    ...option,
  });
}
