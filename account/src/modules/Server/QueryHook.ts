import { AxiosError, AxiosResponse } from "axios";
import { useMutation, UseMutationOptions, useQuery, UseQueryOptions } from "react-query";
import { useLocation, useNavigate } from "react-router";
import { useResetRecoilState, useSetRecoilState } from "recoil";
import { logoutApi } from "../../api/AuthApi";
import { GlobalResponse } from "../../interface/Response/GlobalResponse";

import { ErrorStatus } from "../../utils/ErrorCode";
import { removeCookie } from "../../utils/ReactCookie";
import { userState } from "../Client/Auth/Auth";
import { alertModalState, loadingModalState } from "../Client/Modal/Modal";
import { refreshJwt } from "../../utils/jwt";

/**
 *
 * @type < 리스폰 받을 정보, 리퀘스트 던질 정보 >
 * @param key [ 해당 리스폰 값을 담을 키값, 리퀘스트 요청값 ]
 * @param api 요청할 api
 * @param option 리액트 쿼리 옵션
 * @returns
 */
export function useData<TData, T2>(
  key: [string, T2 | null],
  api: (query: T2 | null) => Promise<AxiosResponse<GlobalResponse<TData>>>,
  option: UseQueryOptions<
    AxiosResponse<GlobalResponse<TData>>,
    AxiosError,
    GlobalResponse<TData>,
    [string, T2 | null]
  > = {}
) {
  const setAlertModal = useSetRecoilState(alertModalState);
  const logout = useMutation<{}, {}>(logoutApi);
  const navigate = useNavigate();
  const resetUserData = useResetRecoilState(userState);
  const location = useLocation();
  const { refreshToken } = refreshJwt();
  const onLineCheck = window.navigator.onLine;

  return useQuery<
    AxiosResponse<GlobalResponse<TData>>,
    AxiosError,
    GlobalResponse<TData>,
    [string, T2 | null]
  >(key, async() => {
    await refreshToken();
    const response = api(key[1] ? key[1] : null);    
    // console.log(location.pathname);
    // console.log(api);
    // console.log((await response).data);
    return response;
  }, {
    select(res) {
      return res.data;
    },
    retry: false,
    onError(err: AxiosError) {
      const errorMessage = ErrorStatus(err as AxiosError);
      const onLineCheckMessage = "인터넷 연결을 확인해주세요.";

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
      }else if  (errorMessage === '로그 접근 에러.\n권한 확인 혹은 패스워드를 재입력해주세요.'){
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
      const status: number = (err.response?.data as { statusCode: number }).statusCode;
      if (status === 401) {
        // console.log("로그아웃 4");
        console.log(errorMessage);
        // logout.mutate(undefined, {
        //   onSuccess() {
        //     removeCookie("token");
        //     removeCookie("role");
        //     removeCookie("authority");
        //     sessionStorage.removeItem("user");
        //     resetUserData();
        //     if (location.pathname !== "/") navigate(`/`, { replace: true });
        //     window.location.href = "/";
        //   },
        //   onError() {},
        // });
      } else if (status === 403){
        setAlertModal({
          isModal: true,
          content: ErrorStatus(err as AxiosError),
          type:"check",
          onClick() {
            navigate('-1');
          },
        });
      } else {
        setAlertModal({
          isModal: true,
          content: ErrorStatus(err as AxiosError),
        });
      }
    },
    ...option,
  });
}

interface ServerError {
  status: number;
  message: string;
  code?: string;
}

/**
 * @type < 리스폰 받을 정보, 리퀘스트 던질 정보 >
 * @param api 요청 api
 * @param option 리액트 쿼리 옵션
 * @returns
 */
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
      await refreshToken();
      
      setLoadingModal({
        isButton: false,
        isModal: true,
      });
    },
    onError(err: AxiosError) {
      const errorMessage = ErrorStatus(err as AxiosError);
      const onLineCheckMessage = "인터넷 연결을 확인해주세요.";
      resetLoadingModal();


      const data = err.response?.data as ServerError;

      if(data.code && data.code === 'lock') {
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
        content: ErrorStatus(err as AxiosError),
      });
    },
    onSuccess() {
      resetLoadingModal();
    },
    retry: false,

    ...option,
  });
}
