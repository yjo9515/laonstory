import { AxiosError } from "axios";
import { useMutation } from "react-query";
import { useSetRecoilState } from "recoil";
import {
  authEmailApi,
  authSendEmailApi,
  duplicateEmail,
  duplicateIdCheck,
} from "../../../api/AuthApi";
import { IAuthSendEmailResponse } from "../../../interface/Auth/ApiResponseInterface";
import { alertModalState } from "../../Client/Modal/Modal";

// // 평가의원 회원가입
// export const PersonalSignupModule = () => {
//   const setAlertModal = useSetRecoilState(alertModalState);
//   return useMutation(personalSignup, {
//     onError() {
//       setAlertModal({
//         isModal: true,
//         content: "오류가 발생했습니다.",
//       });
//     },
//   });
// };
// // 법인 회원가입
// export const CompanySignupModule = () => {
//   const setAlertModal = useSetRecoilState(alertModalState);
//   return useMutation(companySignup, {
//     onError() {
//       setAlertModal({
//         isModal: true,
//         content: "오류가 발생했습니다.",
//       });
//     },
//   });
// };
// 아이디 중복체크
export const DuplicateIdModule = () => {
  const setAlertModal = useSetRecoilState(alertModalState);
  return useMutation(duplicateIdCheck, {
    onError(error: AxiosError) {
      setAlertModal({
        isModal: true,
        content: error.message,
      });
    },
  });
};
// 이메일 중복체크
export const DuplicateEmailModule = () => {
  const setAlertModal = useSetRecoilState(alertModalState);
  return useMutation(duplicateEmail, {
    onError() {
      setAlertModal({
        isModal: true,
        content: "오류가 발생했습니다.",
      });
    },
  });
};

//  이메일 인증코드 보내기
export const AuthSendEmailModule = () => {
  const setAlertModal = useSetRecoilState(alertModalState);
  return useMutation(authSendEmailApi, {
    onError() {
      setAlertModal({
        isModal: true,
        content: "오류가 발생했습니다.",
      });
    },
  });
};
//  이메일 인증
export const AuthEmailModule = () => {
  const setAlertModal = useSetRecoilState(alertModalState);
  return useMutation(authEmailApi, {
    onError() {
      setAlertModal({
        isModal: true,
        content: "오류가 발생했습니다.",
      });
    },
  });
};
