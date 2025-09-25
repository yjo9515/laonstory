import React from "react";
import { atom } from "recoil";

// Alert Modal State
export interface IAlertModalDefault {
  isModal: boolean;
  title?: string;
  content: string | React.ReactNode;
  onClick?: () => void;
  type?: string;
  isLoading?: boolean;
  isBlock?: boolean;
  buttonText?: string;
}

export const alertModalDefault = {
  title: "안내",
  content: "",
  onClick: undefined,
  type: undefined,
  isModal: false,
  isLoading: false,
  isBlock: false,
  buttonText: "",
};

export const alertModalState = atom({
  key: "alertModalState",
  default: alertModalDefault as IAlertModalDefault,
});

// Content Modal State

export interface IContentModalDefault {
  isModal: boolean;
  title: string;
  subText: string | React.ReactNode;
  onClick?: () => void;
  content: React.ReactNode;
  buttonText?: string;
  type?: string;
}

export const contentModalDefault = {
  title: "",
  subText: "",
  onClick: undefined,
  isModal: false,
  content: null,
  buttonText: "",
  type: "",
};

export const contentModalState = atom({
  key: "contentModalState",
  default: contentModalDefault as IContentModalDefault,
});

// loading Modal

export interface ILoadingModalDefault {
  isModal: boolean;
  isButton: boolean;
  subText?: string | React.ReactNode;
  onClick?: () => void;
  buttonText?: string;
  isFinger?: boolean;
  isBlockChain?: boolean;
}

export const loadingModalDefault = {
  onClick: undefined,
  subText: "",
  isModal: false,
  isButton: false,
  buttonText: "",
  isFinger: false,
  isBlockChain: false,
};

export const loadingModalState = atom({
  key: "loadingModalState",
  default: loadingModalDefault as ILoadingModalDefault,
});

export const sideBarCover = atom({
  key: "sideBarCover",
  default: false,
});
