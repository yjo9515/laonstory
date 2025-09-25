import axios from "axios";
import React, { useEffect, useRef } from "react";

interface NicePhoneInterface {
  passData?: string;
  onClose?: () => void;
}

function NicePhone(props: NicePhoneInterface) {
  window.name = "Parent_window";

  let ref = useRef<HTMLFormElement | null>(null);

  function fnPopup() {
    window.open(
      "",
      "popupChk",
      "width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no"
    );
    if (ref) {
      ref.current!.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
      ref.current!.target = "popupChk";
      ref.current!.submit();
    }
  }

  useEffect(() => {
    fnPopup();
    setTimeout(() => {
      if (props.onClose) props.onClose();
    }, 100);
  }, []);

  return (
    <form name="form_chk" method="post" ref={ref}>
      <input type="hidden" name="m" value="checkplusSerivce" />
      <input type="hidden" name="EncodeData" value={String(props.passData)} />
      {/* <a href="javascript:fnPopup();"> CheckPlus 안심본인인증 Click</a> */}
    </form>
  );
}

export default NicePhone;
