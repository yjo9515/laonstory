import React, { useEffect } from "react";
import { useLocation } from "react-router";
import queryString from "query-string";
import { useSendData } from "../../../modules/Server/QueryHook";
import { passDecRequestApi } from "../../../api/AuthApi";
import { alertModalState } from "../../../modules/Client/Modal/Modal";
import { useSetRecoilState } from "recoil";
import { IPassPhoneDataInterface, passPhoneState } from "../../../modules/Client/Pass/Pass";
import CryptoJS from "crypto-js";

export type passType = {
  encData: string;
};

const decrypt = (encryptedText: string) => {
  console.log("encryptedText - ", encryptedText);
  try {
    const ENCRYPTION_KEY = String(process.env.REACT_APP_ENC_KEY);
    const IV = String(process.env.REACT_APP_IV);
    const ciphertext = CryptoJS.enc.Base64.parse(encryptedText); // encryptedText is the text you want to decrypt
    console.log("ENCRYPTION_KEY - ", ENCRYPTION_KEY);
    console.log("IV - ", IV);
    console.log("ciphertext - ", ciphertext);
    //@ts-ignore
    const decipher = CryptoJS.AES.decrypt({ ciphertext }, CryptoJS.enc.Utf8.parse(ENCRYPTION_KEY), {
      iv: CryptoJS.enc.Utf8.parse(IV),
      mode: CryptoJS.mode.CBC,
      padding: CryptoJS.pad.Pkcs7,
    });
    console.log("decipher - ", decipher);

    const decryptedText = decipher.toString(CryptoJS.enc.Utf8);

    console.log("decryptedText - ", decryptedText);

    return decryptedText;
  } catch (e) {
    console.log(e);
    return "";
  }
};

function NiceComplete() {
  const location = useLocation();
  const parsed = queryString.parse(location.search);
  const setAlertModal = useSetRecoilState(alertModalState);

  const passDecRequest = useSendData<IPassPhoneDataInterface, passType>(passDecRequestApi, {
    onSuccess(item) {
      // let { name, birth, mobile } = item.data.data;

      const dd = decrypt(String(item.data.data));
      const resultUserData = JSON.parse(dd);

      const data = {
        name: resultUserData.name,
        birth: resultUserData.birth,
        mobile: resultUserData.mobile,
        encData: String(parsed.EncodeData),
      };

      setTimeout(() => {
        localStorage.setItem("passData", JSON.stringify(data));
        window.close();
      }, 10);
    },
    onError(error) {
      // console.log("error");
    },
  });

  useEffect(() => {
    if (parsed.EncodeData) {
      let data = {
        encData: String(parsed.EncodeData),
      };
      passDecRequest.mutate(data);
    }
  }, []);
  return <div></div>;
}

export default NiceComplete;
