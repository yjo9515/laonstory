import { useEffect, useState } from "react";
import SideBarView from "../../../view/Common/SideBarView/SideBarView";
import { getCookie } from "../../../utils/ReactCookie";
import { Buffer } from 'buffer';

interface SideBarTypes {
  role: string;
}

function SideBar(props: SideBarTypes) {
  const [systemType, setSystemType] = useState<string>(getCookie("type"));
  const [token, setToken] = useState<string>(getCookie("token"));
  const [empId, setEmpId] = useState<string>("");
  const [authorityType, setAuthorityType] = useState<string>("");


  const parseJwt = (token: string) => {
    const base64Payload = token.split('.')[1]; //value 0 -> header, 1 -> payload, 2 -> VERIFY SIGNATURE
    const payload =
      base64Payload === undefined
        ? ''
        : Buffer.from(base64Payload.toString(), 'base64').toString('utf8');
    const result =
      base64Payload === undefined ? {} : JSON.parse(payload.toString());
    return result;
  };

  
  useEffect(() => {
    setSystemType(getCookie("type"));
  }, [getCookie("type")]);

  useEffect(() => {
    setAuthorityType(getCookie("authority"));
  }, [getCookie("authority")]);

  useEffect(() => {
    setToken(getCookie("token"));
  }, [getCookie("token")]);

  useEffect(() => {
    if(token === undefined) return;
    const parse = parseJwt(token);
    setEmpId(parse.sub);
  }, [token]);


  return <SideBarView role={props.role} systemType={systemType} authorityType={authorityType} empId={empId}/>;
}

export default SideBar;
