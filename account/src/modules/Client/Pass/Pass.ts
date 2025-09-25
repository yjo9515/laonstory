import React from "react";
import { atom } from "recoil";

export interface IPassPhoneDataInterface {
  name: string;
  birth: string;
  mobile: string;
}

export const passPhoneDataDefault = {
  name: "",
  birth: "",
  mobile: "",
};

export const passPhoneState = atom({
  key: "passPhoneState",
  default: passPhoneDataDefault as IPassPhoneDataInterface,
});
