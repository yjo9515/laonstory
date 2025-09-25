import { useEffect, useState } from "react";
import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
import { useNavigate } from "react-router";
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from "recoil";
import {
  companyAccountApplicationApi,
  companyAccountOwnerCheckApi,
  personalAccountApplicationApi,
  personalAccountOwnerCheckApi,
} from "../../api/AgreementApi";
import { passRequestApi } from "../../api/AuthApi";
import { getTermApi } from "../../api/MasterApi";
import { accountOwnerCheckData } from "../../interface/Agreement/AgreementData";
import { IAgreementInput } from "../../interface/Agreement/AgreementInput";
import { accountOwnerCheckRes } from "../../interface/Agreement/AgreementResponse";
import { ITerm } from "../../interface/Master/MasterData";
import { userState } from "../../modules/Client/Auth/Auth";
import {
  alertModalState,
  contentModalState,
  loadingModalState,
} from "../../modules/Client/Modal/Modal";
import { passPhoneState } from "../../modules/Client/Pass/Pass";
import { useData, useSendData } from "../../modules/Server/QueryHook";
import DaumPost from "../../utils/AddressUtil";
import { checkFileType } from "../../utils/ExceptionUtils";
import { formInvalid } from "../../utils/FormInvalid";
import { PdfEncryptCheck } from "../../utils/PdfEncryptCheck";
import { Regex } from "../../utils/RegularExpression";
import RoleUtils from "../../utils/RoleUtils";
import AgreementView from "../../view/Agreement/AgreementView";

import Layout from "../Common/Layout/Layout";
import { categories } from "../Partners/Terms/Terms";

type AgreementType = {
  name: string;
  phone: string;
  postCode: string;
  address: string;
  empId: string;
};

export default function Agreement({ type }: { type?: string }) {
  const { register, setValue, handleSubmit, watch, getValues, formState: { errors } } = useForm<IAgreementInput>({
    defaultValues: {},
  });
  const setAlertModal = useSetRecoilState(alertModalState);
  const contentModal = useSetRecoilState(contentModalState);
  const loadingModal = useSetRecoilState(loadingModalState);
  const resetLoadingModal = useResetRecoilState(loadingModalState);
  const resetAlertModal = useResetRecoilState(alertModalState);
  const passPhoneData = useRecoilValue(passPhoneState);
  const setPassPhoneData = useSetRecoilState(passPhoneState);
  const navigate = useNavigate();
  const userData = useRecoilValue(userState);
  const role = RoleUtils.getClientRole(userData.role);

  // api 연결 loading state
  const [isLoading, setIsLoading] = useState(false);

  const [passData, setPassData] = useState<string>("");

  const [agreementData, setAgreementData] = useState<AgreementType>({
    name: "",
    phone: "",
    postCode: "",
    address: "",
    empId: "",
  });

  const [custumError, setCustumError] = useState<string | null>(null);

  const onChange = (name: string, value: string) => {
    setAgreementData((prev) => ({ ...prev, [name]: value }));
  };

  // ==================================== API==========================================
  // 약관 가져오기
  const agreementTerm = useData<ITerm, categories>(
    ["agreementTerm", "personal_account"],
    getTermApi
  );

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

  useEffect(() => {
    if (role === "company") {
      setValue("companyName", userData.companyName ?? "");
    }
  }, []);

  useEffect(() => {
    const listener = (event: StorageEvent) => {
      const pass = event.storageArea?.getItem("passData");
      if (pass) {
        const data = JSON.parse(pass);

        if (role === "company") setValue("mangerName", data.name);
        if (role === "personal") setValue("name1", data.name);
        setValue("phone", data.mobile);

        onChange("name", data.name);
        onChange("phone", data.mobile);

        let birth = String(data.birth);
        setValue("birth", birth.slice(2, birth.length));
        if (role === "personal") setValue("registerNum1", birth.slice(2, birth.length));
        setValue("phoneCheck", true);

        setTimeout(() => {
          setAlertModal({
            isModal: true,
            content: "본인 인증이 완료되었습니다.",
          });

          setPassData("");
        }, 10);
      }
    };

    window.addEventListener("storage", listener);

    return () => {
      window.removeEventListener("storage", listener);
      localStorage.removeItem("passData");
    };
  }, []);

  // 개인 계좌 소유주 확인 api
  const personalAccountOwnerCheck = useSendData<accountOwnerCheckRes, accountOwnerCheckData>(
    personalAccountOwnerCheckApi
  );
  // 법인 계좌 소유주 확인 api
  const companyAccountOwnerCheck = useSendData<accountOwnerCheckRes, accountOwnerCheckData>(
    companyAccountOwnerCheckApi
  );
  // 개인 계좌이체거래약정서 발급 신청 api
  const personalAccountApplication = useSendData<string, FormData>(personalAccountApplicationApi, {
    onMutate() {
      loadingModal({
        isButton: false,
        isModal: true,
        isBlockChain: true,
      });
    },
    onSuccess() {
      setTimeout(() => {
        resetLoadingModal();
        setAlertModal({
          isModal: true,
          content: `발급 요청이 완료되었습니다.\n결과는 메일로 안내드리겠습니다.`,
          onClick() {
            navigate("/");
          },
          type: "check",
        });
      }, 4000);
    },
  });
  // 법인 계좌이체거래약정서 발급 신청 api
  const companyAccountApplication = useSendData<string, FormData>(companyAccountApplicationApi, {
    onMutate() {
      loadingModal({
        isButton: false,
        isModal: true,
        isBlockChain: true,
      });
    },
    onSuccess() {
      setTimeout(() => {
        resetLoadingModal();
        setAlertModal({
          isModal: true,
          content: `발급 요청이 완료되었습니다.\n결과는 메일로 안내드리겠습니다.`,
          onClick() {
            navigate("/");
          },
          type: "check",
        });
      }, 4000);
    },
  });

  // 최종 발급 이벤트
  const application = (data: FormData) => {
    if (isLoading) return;
    setIsLoading(() => true);
    resetAlertModal();
    if (role === "personal") {
      personalAccountApplication.mutateAsync(data);
      setIsLoading(false);
    }
    if (role === "company") {
      companyAccountApplication.mutateAsync(data);
      setIsLoading(false);
    }
  };

  // =====================================================FORM======================
  /** 폼 클릭 이벤트 */
  const onClicks = {
    /* 본인인증 클릭 */
    phone() {
      getPass.refetch();
      //본인인증 api 연결
      // setValue("phoneCheck", true);
      // setAlertModal({
      //   isModal: true,
      //   content: "인증되었습니다.",
      // });
    },

    /** 검색 api */
    search() {
      const getAddress = (
        code: string,
        address: string,
        latLng: {
          longitude: string;
          latitude: string;
        }
      ) => {
        setValue("postCode1", code);
        setValue("postCode", code);
        setValue("address", address);

        onChange("address", address);
        onChange("postCode", code);
      };
      contentModal({
        isModal: true,
        content: <DaumPost fn={getAddress} />,
        subText: "",
        title: "",
        type: "cancel",
      });
    },

    /**유효성 검증 */
    accountClick() {
      const formData = getValues();

      const corporateType = watch("corporateType");

      const { bankCode, registerNum1, account, accountName, companyNum, birth, companyBirthNum } =
        getValues();

      if ((corporateType === "no" || role === "personal") && !birth) {
        setAlertModal({
          isModal: true,
          content: "생년월일을 입력하세요.",
        });
        return;
      }

      if ((corporateType === "yes" || role === "company") && !companyNum) {
        setAlertModal({
          isModal: true,
          content: "사업자등록번호를 입력하세요.",
        });
        return;
      }

      if(role === "company"){
  // 사업자등록번호 자릿수 및 유효성 검사
  if(!/^\d{10}$/.test(companyNum.replace(/-/g,""))){
    return setAlertModal({ isModal: true, content: "사업자등록번호는 10자리여야 합니다. 다시 확인해 주세요."});
  }else{
    const data = companyNum.replace(/-/g,"");
    const multipleList = [1,3,7,1,3,7,1,3,5];
    let sum = 0;

    for(var i =0; i< multipleList.length; i++){
      sum += parseInt(data[i], 10) * multipleList[i];
    }

    sum += Math.floor(parseInt(data[8], 10) * 5 / 10);

    const remainder = (10 - (sum % 10)) % 10;      
    if(remainder !== parseInt(data[9], 10)){        
      return setAlertModal({ isModal: true, content: "유효하지 않은 사업자등록번호입니다. 다시 확인해 주세요"});
    }      
  }  
      }

      
      if (!accountName) {
        setAlertModal({
          isModal: true,
          content: "예금주를 입력하세요.",
        });
        return;
      }
      if (!account) {
        setAlertModal({
          isModal: true,
          content: "계좌번호를 입력하세요.",
        });
        return;
      }

      const test = /^[0-9]*$/;

      if (account && !test.test(account)) {
        setAlertModal({
          isModal: true,
          content: "계좌번호는 숫자만 입력하세요.",
        });
        return;
      }

      const regex = /[^0-9]/g;

      // 유효성 검증 api
      const data: accountOwnerCheckData = {
        bankCode: bankCode.split("-")[0],
        bankName: bankCode.split("-")[1],
        accountName,
        accountNo: account.replaceAll(regex, ""),
        birth: "",
      };

      // console.log(data);

      if (role === "personal") {
        data.birth = birth;
      }

      if (role === "company") {
        if (corporateType === "yes") data.birth = companyNum.replace(/-/g,"");
        if (corporateType === "no") data.birth = companyBirthNum;
      }

      if (corporateType) {
        data.gbn = corporateType === "yes" ? "2" : "1";
      }

      if (role === "personal") {
        personalAccountOwnerCheck.mutate(data, {
          onSuccess(data) {
            setValue("accountCheck", true);
            setValue("accountId", data.data.data.id);
            setAlertModal({
              isModal: true,
              content: "계좌 유효성 검사 완료",
            });
          },
        });
      }
      if (role === "company") {
        companyAccountOwnerCheck.mutate(data, {
          onSuccess(data) {
            setValue("accountCheck", true);
            setValue("accountId", data.data.data.id);
            setAlertModal({
              isModal: true,
              content: "계좌 유효성 검사 완료",
            });
          },
        });
      }
    },
  };

  const onValid: SubmitHandler<IAgreementInput> = (formData) => {
    if (isLoading) return;

    const {
      phoneCheck,
      accountCheck,
      accountName,
      account,
      registerNum1,
      businessConditions,
      businessType,
      corporateNumber,
      corporateType,
      companyBirthNum,
      postCode,
      postCode1,
      address,
      fullAddress,
      name,
      name1,
      phone,
      email,
      birth,
      companyNum,
      bankBook,
      IDFile,
      certificateFile,
      BusinessRegistration,
      etcFile,
      bankCode,
      accountId,
      mangerName,
      companyName,
      department,
      admin,
      selectAdmin,
    } = formData;

    if (!phoneCheck) {
      setAlertModal({
        isModal: true,
        content: "본인인증을 완료해주세요.",
      });
      return;
    }

    if (!accountCheck) {
      setAlertModal({
        isModal: true,
        content: "유효성 검사를 완료해주세요.",
      });
      return;
    }

    if (role === "personal" && checkFileType([bankBook, IDFile])) {
      setAlertModal({
        isModal: true,
        content: "알맞은 형식의 파일을 입력해주세요.",
      });
      return;
    }

    if (role === "company" && checkFileType([bankBook, BusinessRegistration, certificateFile])) {
      setAlertModal({
        isModal: true,
        content: "알맞은 형식의 파일을 입력해주세요.",
      });
      return;
    }

    const test = /^[0-9]*$/;
    const onlyTemp = /^[a-zA-Z0-9 가-힣]*$/;


    if (account && !test.test(account)) {
      setAlertModal({
        isModal: true,
        content: "계좌번호는 숫자만 입력하세요.",
      });
      return;
    }

    if(companyName && !onlyTemp.test(companyName)){
      setAlertModal({
        isModal: true,
        content: "업체명에 특수문자를 포함할 수 없습니다.",
      });
      return;
    }

    if(name && !onlyTemp.test(name)){
      setAlertModal({
        isModal: true,
        content: "대표자 성명에 특수문자를 포함할 수 없습니다.",
      });
      return;
    }

    if(companyNum && !test.test(companyNum)) {
      setAlertModal({
        isModal: true,
        content: "사업자 숫자만 입력하세요.",
      });
      return;
    }

    if(corporateNumber && !test.test(corporateNumber)){
      setAlertModal({
        isModal: true,
        content: "법인등록번호 숫자만 입력하세요.",
      });
      return;
    }

    if(fullAddress && !onlyTemp.test(fullAddress)){
      setAlertModal({
        isModal: true,
        content: "상세주소에 특수문자를 포함할 수 없습니다.",
      });
      return;
    }

    if(businessConditions && !onlyTemp.test(businessConditions)) {
      setAlertModal({
        isModal: true,
        content: "업태는 특수문자를 포함할 수 없습니다.",
      });
      return;
    }

    if(businessType && !onlyTemp.test(businessType)){
      setAlertModal({
        isModal: true,
        content: "업종는 특수문자를 포함할 수 없습니다.",
      });
      return;
    }

    if (!selectAdmin) {
      setAlertModal({
        isModal: true,
        content: "담당자를 선택해주세요.",
      });
      return;
    }

    const regex = /[^0-9]/g;

    const data = new FormData();
    data.append("passbookFile", bankBook[0]);
    data.append("accountName", accountName);
    data.append("accountNumber", account.replaceAll(regex, ""));
    data.append("accountBank", bankCode.split("-")[1]);

    if (etcFile) {
      data.append("etcFile", etcFile[0]);
    }
    // 담당자 , 부서명
    // data.append("department", department);
    data.append("masterEmpId", agreementData.empId);
    // 개인
    if (role === "personal") {
      data.append("identityFile", IDFile[0]);
      data.append("idNumber", birth.replaceAll(regex, ""));
      data.append("name", agreementData.name);
      data.append("residentRegistrationNumber", registerNum1.replaceAll(regex, ""));
    }
    // 업체
    if (role === "company") {
      data.append("identityFile", BusinessRegistration[0]);
      data.append("idNumber", companyNum.replace(/-/g,""));
      data.append("businessType", businessType);
      data.append("businessConditions", businessConditions);
      data.append("certificateFile", certificateFile[0]);
      data.append("name", companyName);
      data.append("representative", name);
      data.append("manager", agreementData.name);

      if (corporateType === "yes") {
        data.append("corporateNumber", corporateNumber.replaceAll(regex, ""));
      }
      if (corporateType === "no") {
        data.append("corporateNumber", "");
        data.append("personalBusinessBirth", companyBirthNum.replaceAll(regex, ""));
      }
    }
    data.append("postCode", agreementData.postCode);
    data.append("address", `${agreementData.address} ${fullAddress}`);
    data.append("phone", agreementData.phone);
    data.append("email", email);
    data.append("accountVerifyToken", accountId);
    data.append("accountBankCode", bankCode.split("-")[0]);

    // 발급 여부 물어보는 모달
    setAlertModal({
      isModal: true,
      content: "발급 신청을 진행하시겠습니까?",
      onClick: () => application(data),
    });
  };
  const inValid: SubmitErrorHandler<IAgreementInput> = (err) => {
    const inputs = [
      "check1", //동의
      "companyName", //상호
      "name", // 이름
      "name1",
      "companyNum", // 사업자 번호
      "registerNum1", //주민번호
      "mangerName", //담당자 이름
      "phone", //전화번호
      "phoneCheck", // 본인인증
      "email", //이메일
      "postCode",
      "address", //주소
      "fullAddress", // 풀 주소
      // "bank", //은행
      "bankCode", // 은행명
      "account", //계좌번호
      "accountName", // 예금주
      "accountCheck", //계좌 검증
      "BusinessRegistration", // 사업자등록증
      "certificateFile", // 인감증명서
      "etcFile",
      "IDFile", //신분증 사본
      "bankBook", // 통장사본
      "department", // 부서명
      "admin", // 담당자
      "selectAdmin", // t
    ];

    if (err) {
      setAlertModal(
        formInvalid(err, inputs) as {
          isModal: boolean;
          content: string;
        }
      );
    }
  };

  useEffect(() => {
    if (watch("department")) {
      // console.log(String(watch("department")));
    }
  }, [watch("department")]);

  useEffect(() => {
    if (watch("name")) {
      const patten = /^[a-zA-Z가-힣]{0,3}$/;      
      if (!patten.test(String(watch("name")))) {
        setCustumError("대표자 성명은 1명만 입력하셔야 하며 2명 이상 입력 시 계좌발급이 불가하여 다시 발급을 진행하야 합니다.");
      }else{
        setCustumError(null);
      }      
    }
  }, [watch("name")]);

  // useEffect(() => {
  //   if (watch("IDFile") && watch("IDFile").length > 0) {
  //     console.log(PdfEncryptCheck(watch("IDFile")));
  //     // if (PdfEncryptCheck(watch("IDFile"))) {
  //     //   alert("암호됨");
  //     // }
  //   }
  // }, [watch("IDFile")]);

  return (
    <Layout notSideBar={type !== "admin"} notHeadTitle useFooter>
      <>
        {type !== "admin" && (
          <AgreementView
            register={register}
            setValue={setValue}
            onSubmit={handleSubmit(onValid, inValid)}
            onClicks={onClicks}
            watch={watch}
            term={agreementTerm.data?.data?.content || ""}
            passData={passData}
            onChange={onChange}
            onPassDataReset={onPassDataReset}
            custumError={custumError}
          />
        )}

        <></>
      </>
    </Layout>
  );
}
