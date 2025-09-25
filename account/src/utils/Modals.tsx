import { useSetRecoilState } from "recoil";
import ChangeAdminModal from "../components/Modal/Auth/ChangeAdminModal";
import ChangeEmailModal from "../components/Modal/Auth/ChangeEmailModal";
import ChangePasswordModal from "../components/Modal/Auth/ChangePasswordModal";
import ChangePhoneModal from "../components/Modal/Auth/ChangePhoneModal";
import { contentModalState } from "../modules/Client/Modal/Modal";

export const useClicks = (type: string) => {
  const setContentModal = useSetRecoilState(contentModalState);

  return {
    phone() {
      setContentModal({
        isModal: true,
        buttonText: "확인",
        content: <ChangePhoneModal type={type} />,
        subText: "아이디, 비밀번호 입력 후 변경할 전화번호로 본인인증을 진행해주세요.",
        title: "전화번호 변경",
      });
    },
    email() {
      setContentModal({
        isModal: true,
        buttonText: "확인",
        content: <ChangeEmailModal type={type} />,
        subText: "이메일주소를 변경하시려면 비밀번호를 입력하고 이메일을 인증해주세요.",
        title: "이메일 변경",
      });
    },
    password() {
      setContentModal({
        isModal: true,
        buttonText: "확인",
        content: <ChangePasswordModal type={type} />,
        subText: "비밀번호를 변경하시려면 먼저 본인인증을 진행해주세요.",
        title: "비밀번호 변경",
      });
    },
    admin() {
      setContentModal({
        isModal: true,
        buttonText: "확인",
        content: <ChangeAdminModal type={type} />,
        subText: "비밀번호 입력 후 기존 전화번호로 본인인증을 진행해주세요.",
        title: "담당자 정보 변경",
      });
    },
  };
};
