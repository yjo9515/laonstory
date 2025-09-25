import React, { useRef } from "react";
import styled from "styled-components";
import axios from "axios";

function NiceCheck() {
  let action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/service.cb";

  const ref = useRef<HTMLFormElement | null>(null);

  const test = (e: any) => {
    // console.log(e);
    // e.preventDefault();

    axios
      .get(`http://192.168.100.118:3002/nice/encrypt/data`, {
        withCredentials: true,
      })
      .then((res) => {
        // console.log(res);
      })
      .catch((err) => {
        // console.log(err);
      });
  };

  // 휴대폰 인증 버튼 클릭시 실행되는 함수, NICE 표준창 호출
  const onClickCertify = async () => {
    const { form }: any = document;
    const left = window.screen.width / 2 - 500 / 2;
    const top = window.screen.height / 2 - 800 / 2;
    const option = `status=no, menubar=no, toolbar=no, resizable=no, width=500, height=600, left=${left}, top=${top}`;

    let returnUrl = `http://192.168.100.118:3002/nice/decrypt/data`;
    let redirectUrl = `http://192.168.100.118:3002/join`;

    // 위에서 언급했던 token api가 요청 데이터를 암호화한 후 표준창 호출에 필요한 데이터를 응답해준다.
    const res = await axios.post("https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb", {
      params: {
        returnUrl,
        redirectUrl,
      },
    });

    if (form && res.data) {
      const { enc_data, integrity_value, token_version_id } = res.data;
      window.open("", "nicePopup", option);

      form.target = "nicePopup";
      form.enc_data.value = enc_data;
      form.token_version_id.value = token_version_id;
      form.integrity_value.value = integrity_value;
      form.submit();
    }
  };

  return (
    <NiceCheckBlock>
      <form
        name="form"
        id="form"
        action="https://nice.checkplus.co.kr/CheckPlusSafeModel/service.cb"
      >
        <input type="hidden" id="m" name="m" value="service" />
        <input type="hidden" id="token_version_id" name="token_version_id" value="" />
        <input type="hidden" id="enc_data" name="enc_data" />
        <input type="hidden" id="integrity_value" name="integrity_value" />
      </form>

      <button onClick={onClickCertify}> 휴대폰 인증 </button>
    </NiceCheckBlock>
  );
}

export default NiceCheck;

const NiceCheckBlock = styled.div`
  width: 500px;
  height: 1000px;
  position: absolute;
  z-index: 100;
`;
