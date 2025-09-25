/* eslint-disable react-hooks/exhaustive-deps */
import { useEffect, useState } from "react";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
//  View
import JoinProcessView from "../../../view/Auth/Join/JoinProcessView";
import Layout from "../../Common/Layout/Layout";
// 모달
import { alertModalState, contentModalState } from "../../../modules/Client/Modal/Modal";
import EmailAuthModal from "../../../components/Modal/Auth/AuthEmailModal";
// interface
import { IJoinInput } from "../../../interface/Auth/FormInputInterface";
import { IAuthSendEmailResponse } from "../../../interface/Auth/ApiResponseInterface";
import {
  IAuthSendEmail,
  ICompanySignup,
  IDuplicateEmailData,
  IDuplicateUserData,
} from "../../../interface/Auth/ApiDataInterface";
// util
import { Regex } from "../../../utils/RegularExpression";
import { useData, useSendData } from "../../../modules/Server/QueryHook";
// api
import {
  authSendEmailApi,
  companySignupApi,
  duplicateEmail,
  duplicateIdCheck,
  duplicateUserCheck,
  passRequestApi,
} from "../../../api/AuthApi";
import { useNavigate } from "react-router-dom";
import { getAllTermApi } from "../../../api/MasterApi";
import { ITerm } from "../../../interface/Master/MasterData";
import { passPhoneState } from "../../../modules/Client/Pass/Pass";

// 회원가입 과정 페이지
export type currentProcess = 1 | 2 | 3;

export default function JoinProcess() {
  // 예외처리 모달을 띄우기 위한 atom
  const setAlertModal = useSetRecoilState(alertModalState);
  // 폼 모달을 띄우기 위한 atom
  const setContentModal = useSetRecoilState(contentModalState);
  // 회원가입 과정을 구분하기 위한 state
  const [process, setProcesses] = useState<currentProcess>(1);
  // 단계 번호를 받아 설정
  const changeProcess = (process: currentProcess) => {
    setProcesses(process);
  };
  const navigate = useNavigate();

  const {
    register, // input 과 연결해주는 객체
    handleSubmit, // onSubmit event 예외처리 통과시와 예외처리 발생 시 를 컨트롤 가능
    setValue, // input의 값을 설정 가능한 메서드
    watch, // 실시간으로 input의 값을 확인하는 메서드
  } = useForm<IJoinInput>();

  // pass 정보
  const [passData, setPassData] = useState<string>("");
  const passPhoneData = useRecoilValue(passPhoneState);
  const setPassPhoneData = useSetRecoilState(passPhoneState);
  const resetPassPhoneData = useResetRecoilState(passPhoneState);

  // ===================================================== api
  // 약정 모두 가져오기
  const getAllTerms = useData<ITerm[], null>(["getAllTerms", null], getAllTermApi);  
  // 제안업체 회원가입
  const companySignup = useSendData<string, ICompanySignup>(companySignupApi);
  // 이메일 인증코드 보내기
  const SendAuthEmail = useSendData<IAuthSendEmailResponse, IAuthSendEmail>(authSendEmailApi);
  // 아이디 중복확인
  const username = watch("id");
  const idCheck = useData<string, { username: string } | null>(
    ["duplicateIdCheck", { username }],
    duplicateIdCheck,
    {
      enabled: false,
      retry: false,
    }
  );

  // 유저 중복확인
  const userCheck = useSendData<boolean, IDuplicateUserData >(duplicateUserCheck);

  // 이메일 중복확인
  const email = watch("email");
  const emailCheck = useData<string, IDuplicateEmailData | null>(
    ["duplicateIdCheck", null],
    () => duplicateEmail({ email }),
    {
      enabled: false,
      retry: false,
      onSuccess() {
        SendAuthEmail.mutate(
          { email },
          {
            // 성공 시 이메일 인증 모달 띄우기
            onSuccess(res) {              
              const {
                data: { data },
              } = res;
              setValue("emailUUID", data.uuid);
              setContentModal({
                isModal: true,
                title: "이메일 인증",
                subText: "이메일에 전송된 인증번호를 입력해주세요.",
                content: <EmailAuthModal email={email} uuid={data.uuid} setValue={setValue} />,
                buttonText: "인증",
              });
            },
          }
        );
      },
    }
  );

  // ======================================================================
  //----------------------- 회원가입 부분 ------------------------
  // 휴대폰 인증 요청하기
  const getPass = useData<string, null>(
    ["getPass", null],
    () => passRequestApi(String(window.location.origin) + "/pass"),
    {
      enabled: false,
      onSuccess(item) {
        setPassData(item.data);
      },
    }
  );

  const onPassDataReset = () => {
    setPassData("");
  };

  const calculateAge = (birth: string) => {
    // 생년월일 문자열을 Date 객체로 변환
    const year = parseInt(birth.substring(0, 4));
    const month = parseInt(birth.substring(4, 6)) - 1; // 월은 0부터 시작하므로 1을 빼줌
    const day = parseInt(birth.substring(6, 8));
  
    const birthdate = new Date(year, month, day);
    const today = new Date();
  
    let age = today.getFullYear() - birthdate.getFullYear();
    const monthDifference = today.getMonth() - birthdate.getMonth();
  
    // 생일이 지났는지 여부를 확인하여 나이를 조정
    if (monthDifference < 0 || (monthDifference === 0 && today.getDate() < birthdate.getDate())) {
      age--;
    }
  
    return age;
  }
  
  useEffect(() => {
    const listener = (event: StorageEvent) => {
      const pass = event.storageArea?.getItem("passData");
      if (pass) {
        const data = JSON.parse(pass);
        setPassPhoneData({
          name: data.name,
          birth: data.birth,
          mobile: data.mobile,
        });

        setPassData("");
      }
    };

    window.addEventListener("storage", listener);

    return () => {
      window.removeEventListener("storage", listener);
      localStorage.removeItem("passData");
    };
  }, []);

  useEffect(() => {
    if (passPhoneData.name && passPhoneData.birth && passPhoneData.mobile) {
      
      userCheck.mutate(
        { name: passPhoneData.name, phone: passPhoneData.mobile },
        {
          // 성공 시 이메일 인증 모달 띄우기
          onSuccess(res) {
            const {
              data: { data },
            } = res;
            
            if(data){
              setPassPhoneData({
                name: '',
                birth: '',
                mobile: '',
                });
              setAlertModal({
                isModal: true,
                content: "이미 가입된 유저입니다.",
              });
              return;
            }
            
          },
        }
      );
      if(calculateAge(passPhoneData.birth) < 14){
        setPassPhoneData({
        name: '',
        birth: '',
        mobile: '',
        });
        setAlertModal({
          isModal: true,
          content: "만14세 미만 아동은 가입이 불가능합니다.",
        });
      }else{
        setAlertModal({
          isModal: true,
          content: "본인 인증이 완료되었습니다.",
          type: "check",
          onClick() {
            setProcesses(2);
          },
        });
        setTimeout(() => {
          setValue("adminName", passPhoneData.name);
          setValue("phone", passPhoneData.mobile);
        }, 10);
      }
    }
    return () => {
      resetPassPhoneData();
    };
  }, [passPhoneData]);

  // input 옆에 있는 버튼 클릭 이벤트
  const onClikcs = {
    /** 본인인증 버튼 클릭 이벤트 */
    phone() {
      getPass.refetch();
      // const phoneCheck = watch("phoneCheck");
      // console.log(phoneCheck);
      // if (!phoneCheck) {
      //   setAlertModal({
      //     isModal: true,
      //     content: "본인인증을 완료해주세요.",
      //   });
      //   return;
      // }

      // 휴대폰 인증 api 성공시
      // setValue("phoneCheck", true);
      // setAlertModal({
      //   isModal: true,
      //   type: "check",
      //   content: `본인인증이 완료되었습니다. \n확인을 누르시면 다음으로 이동합니다.`,
      //   onClick() {
      //     setProcesses(2);
      //   },
      // });
    },

    /** id 중복확인 클릭 이벤트 */
    id: function () {
      // api가 실행 중이면 return
      if (idCheck.status === "loading") {
        return;
      }

      const id = watch("id");
      // 입력값이 있는 지 확인
      if (!id) {
        setAlertModal({
          isModal: true,
          content: "아이디를 입력하세요.",
        });
        return;
      }

      // api 연결 =========================================================== API 연결
      idCheck.refetch();
      // 연결 후 성공이면

      if (idCheck.status === "success" || idCheck.status === "idle") {
        setValue("idCheck", true);
        setAlertModal({
          isModal: true,
          content: "사용 가능한 아이디입니다.",
        });
        return;
      }
      // api 실핼 후 중복된 아이디이면
      // if (idCheck.status === "error") {
      //   setAlertModal({
      //     isModal: true,
      //     content: `이미 사용 중인 아이디입니다.\n다른 아이디를 사용해주세요.`,
      //   });
      //   return;
      // }
    },

    /** 이메일 인증 클릭 이벤트 */
    email: async function () {
      console.log(emailCheck.status)
      if (emailCheck.status === "loading") {
        return;
      }

      const email = watch("email");
      // 이메일 인증이 완료되었으면 return
      if (watch("emailCheck")) {
        setAlertModal({
          isModal: true,
          content: "인증이 완료되었습니다.",
        });
        return;
      }

      // 이메일 값이 있는 지 확인
      if (!email) {
        setAlertModal({
          isModal: true,
          content: "이메일을 입력하세요.(확인 가능한 이메일 주소를 입력하세요.)",
        });
        return;
      }
      // 알맞은 형식의 email을 사용했는지 확인
      if (!email.match(Regex.emailRegex)) {
        setAlertModal({
          isModal: true,
          content: "알맞은 형식의 이메일을 입력해주세요.",
        });
        return;
      }
      // 이메일 중복  api 실행
      emailCheck.refetch();
    },
  };

  // submit 이벤트 시에 register에 설정한 모든 validation에 통과하면 실행될 onSubmit 함수
  const onValid: SubmitHandler<IJoinInput> = (formData) => {
    if (companySignup.status === "loading") return;
    // 예외처리 용 변수
    const { infoAgree, idCheck, emailCheck, password, confirmPassword, selectAdmin } = formData;

    // 1. 약관 동의에 확인 했는지 확인하는 예외처리
    if (process === 2) {
      // 약관동이가 있을 . 시체크
      // if (infoAgree) {
      //   setProcesses(3);
      //   return;
      // }
      setProcesses(3);
        return;
    }
    // 2. id 중복확인 검사 및 검사 완료 체크
    if (!idCheck) {
      setAlertModal({
        isModal: true,
        content: "아이디 중복확인을 해주세요.",
      });
      return;
    }
    // 3. 비밀번호 , 비밀번호 확인 같은지 검사
    if (password.length < 9) {
      setAlertModal({
        isModal: true,
        content: "비밀번호를 영문, 숫자, 특수문자 포함 9자리 이상 입력해주세요.",
      });
      return;
    }
    if (!Regex.passwordRegex.test(password)) {
      setAlertModal({
        isModal: true,
        content: "비밀번호를 영문, 숫자, 특수문자 포함 9자리 이상 입력해주세요.",
      });
      return;
    }
    if (password !== confirmPassword) {
      setAlertModal({
        isModal: true,
        content: "비밀번호가 같지 않습니다.",
      });
      return;
    }

    // 4. 인증메일 인증 통과했는지 검사
    if (!emailCheck) {
      setAlertModal({
        isModal: true,
        content: "이메일 인증을 해주세요.",
      });
      return;
    }

    if (selectAdmin === undefined) {
      setAlertModal({
        isModal: true,
        content: "담당자를 선택해주세요.",
      });
      return;
    }

    // 회원가입 api 연결 =========================================================== API 연결
    const { id, phone, email, companyName, adminName, emailUUID } = formData;
    let companyData: ICompanySignup;
    // 제안업체 일 때

    companyData = {
      username: id,
      password,
      name: adminName,
      phone,
      email,
      emailUUID,
      companyName: companyName,
      manager: selectAdmin
    };

    companySignup.mutate(companyData, {
      onSuccess() {
        navigate("/join/complete");
      },
    });
  };
  //submit event 시에 예외가 발생하면 실행 될 함수 (submit event가 실행되지 않음)
  const inValid: SubmitErrorHandler<IJoinInput> = (error) => {
    console.log(error)
    if (error) {
      // 예외처리를 input의 순서대로 하기 위한 반복문
      const inputs = [
        "infoAgree",
        "secretAgree",
        "id",
        "password",
        "confirmPassword",
        "companyName",
        "adminName",
        "name",
        "phone",
        "email",
        "searchAdmin",
        "selectAdmin"
      ];
      for (let i = 0; i < inputs.length; i++) {
        const currentError = error[inputs[i]];
        if (currentError?.message) {
          setAlertModal({
            isModal: true,
            content: currentError.message,
          });
          break;
        }
      }
      return;
    }
  };

  return (
    <Layout
      notSideBar={true}
      notInfo={true}
      fullWidth
      loginWidth
      notHeadTitle
      notBackground
      logoColor
      notBackgroundSystem
      notHeader
    >
      <JoinProcessView
        process={process}
        changeProcess={changeProcess}
        onSubmit={handleSubmit(onValid, inValid)}
        register={register}
        onClikcs={onClikcs}
        setValue={setValue}
        terms={getAllTerms.data?.data}
        passData={passData}
        onPassDataReset={onPassDataReset}
        watch={watch}
      />
    </Layout>
  );
}
