import { UseFormRegister, UseFormSetValue, UseFormWatch } from "react-hook-form";
import { Link } from "react-router-dom";
import BasicInfoIcon from "../../../assets/Auth/BasicInfoIcon";
import TermsIcon from "../../../assets/Auth/TermsIcon";
import Form from "../../../components/Common/Container/Form";
import Process from "../../../components/Common/Process";
import BasicInfo from "../../../components/Join/BasicInfo";
import CheckTerms from "../../../components/Join/CheckTerms";
import SelfAuth from "../../../components/Join/SelfAuth";
import logoBlue from "../../../assets/Logo/logoBlue.svg";
import { currentProcess } from "../../../controllers/Auth/Join/JoinProcess";
import { IJoinInput } from "../../../interface/Auth/FormInputInterface";
import { ITerm } from "../../../interface/Master/MasterData";
import { JoinContainer, LoginContainer } from "../../../theme/common";
import PhoneAuth from "../../../assets/Auth/PhoneAuth";
import NicePhone from "../../../components/Modal/Nice/NicePhone";
import { watch } from "fs";

interface IJoinProcessView {
  process: currentProcess;
  changeProcess: (process: currentProcess) => void;
  type: string;
  onSubmit: any;
  register: UseFormRegister<IJoinInput>;
  onClikcs: { id: () => void; email: () => void; phone: () => void };
  setValue: UseFormSetValue<IJoinInput>;
  watch: UseFormWatch<IJoinInput>;
  terms?: ITerm;
  passData: string;
  onPassDataReset: () => void;
}

// 프로세스 안내 바 내용
const contents = [
  { text: "본인인증", component: <PhoneAuth /> },
  { text: "약관확인", component: <TermsIcon /> },
  { text: "기본정보 등록", component: <BasicInfoIcon /> },
];
// 프로세스 마다 제목 변경
const titles = {
  1: "휴대폰 본인인증",
  2: "약관확인",
  3: "기본 정보 등록",
};

export default function JoinProcessView({
  process, // 회원가입 단계를 나타내는 number
  changeProcess, // 회원가입 단계를 바꾸는 setState
  type, // 현재 회원가입 유형이 업체인지, 위원인지 알려주는 string
  onSubmit, // form submit 이벤트
  register,
  onClikcs, // inputSet 안에 button click event listener
  setValue, // form 의 값을 수정할 메서드
  watch,
  terms,
  passData,
  onPassDataReset,
}: IJoinProcessView) {
  return (
    <>
      <LoginContainer>
        <div className="header">
          <div className="headerContent">
            <Link to="/">
              <img src={logoBlue} alt="로고" />
            </Link>
          </div>
        </div>
        <JoinContainer>
          <h1>{titles[process]}</h1>
          <div className="process">
            <Process contents={contents} process={process} />
          </div>
          <div className="main">
            <Form onSubmit={onSubmit}>
              {process === 1 && <SelfAuth register={register} onClick={onClikcs.phone} />}
              {process === 2 && (
                <CheckTerms
                  onPrevClick={() => changeProcess(1)}
                  onNextClick={() => changeProcess(3)}
                  type={type}
                  register={register}
                  terms={terms}
                />
              )}
              {process === 3 && (
                <BasicInfo
                  register={register}
                  onPrevClick={() => changeProcess(2)}
                  onClicks={onClikcs}
                  setValue={setValue}
                  watch={watch}
                  type={type}
                />
              )}
            </Form>
          </div>
        </JoinContainer>
      </LoginContainer>
      {passData && <NicePhone passData={passData} onClose={onPassDataReset} />}
    </>
  );
}
