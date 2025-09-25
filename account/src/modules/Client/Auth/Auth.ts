import { atom, DefaultValue } from "recoil";
import { ISSOLogin, IUser } from "../../../interface/Auth/AuthInterface";

const userDefault = {
  id: "",
  // 공통 회원 정보
  username: "", // 아이디 (admin 제와)
  name: "", // 이름 or // 담당자 이름
  email: "", // 이메일
  phone: "", // 전화번호 or //담당자 전화번호
  role: "", //세부권환
  // company
  companyName: "", // 업체명
  // personal
  bank: "",
  accountName: "",
  accountNumber: "",
  // admin
  companyNumber: "", //사번
};

const localStorageEffect = (key: string) => {
  return ({ setSelf, onSet }: any) => {
    const savedValue = sessionStorage.getItem(key);
    if (savedValue != null) {
      setSelf(JSON.parse(savedValue));
    }
    onSet((newValue: string, _: DefaultValue, isReset: boolean) => {
      isReset
        ? sessionStorage.removeItem(key)
        : sessionStorage.setItem(key, JSON.stringify(newValue));
    });
  };
};

export const userState = atom({
  key: "authState",
  default: userDefault as IUser,
  effects: [localStorageEffect("user")],
});

const ssoLoginCheckDefault = {
  ssoCheck: false,
  logoutCheck: false,
};

export const ssoLoginCheckState = atom({
  key: "ssoLoginCheck",
  default: ssoLoginCheckDefault as ISSOLogin,
});
