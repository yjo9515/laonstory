import { AxiosError } from "axios";

interface ServerError {
  status: number;
  message: string;
}

export function ErrorStatus(error: AxiosError) {
  console.log("에러 상태",error.toJSON.toString)
  const data = error.response?.data as ServerError;
  let errorMessage;
  if (data) errorMessage = data.message;
  else errorMessage = "알 수 없는 오류입니다.";

  // switch (status) {
  //   case 400:
  //     message = "잘못된 요청입니다.";
  //     break;
  //   case 401:
  //     message = "토큰이 없거나 인증에 실패했습니다.";
  //     break;
  //   case 403:
  //     message = "접근할 수 있는 권한이 없습니다.";
  //     break;
  //   case 404:
  //     message = "요청한 리소스를 찾을 수 없습니다.";
  //     break;
  //   case 405:
  //     message = "올바른 메소드가 아닙니다.";
  //     break;
  //   case 500:
  //     message = "서버와의 통신 중 오류가 발생했습니다.";
  //     break;
  //   case 503:
  //     message = "서버가 요청을 처리할 수 없습니다.";
  //     break;
  //   default:
  //     break;
  // }

  return errorMessage;
}
