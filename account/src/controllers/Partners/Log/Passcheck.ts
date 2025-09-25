import { atom } from "recoil";

export const passCheckState = atom<boolean>({
  key: "passCheckState",
  default: false
});
