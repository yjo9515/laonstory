import { useNavigate } from "react-router";
import styled from "styled-components";
import { LandingContainer } from "../../../theme/common";
import Landing from "./../../../assets/landing.jpg";

export default function LandingView() {
  const navigate = useNavigate();

  const ooLink = (type: string) => {
    if (type === "partners") {
      navigate("/login/partners");
    }
    if (type === "system") {
      navigate("/login/system");
    }
  };
  return (
    <LandingContainer>
      <LandingBlock>
        <img src={Landing} alt="" />
        <div>
          <div onClick={() => ooLink("partners")}></div>
          <div onClick={() => ooLink("system")}></div>
        </div>
      </LandingBlock>
      {/* <h1>서비스 선택</h1>
      <p className="subText">
        한국서부발전 온라인 평가 시스템에 오신걸 환영합니다!
        <br />
        아래의 버튼을 눌러 원하시는 서비스를 선택해주세요.
      </p>
      <div className="main">
        <div className="authButtonContainer">
          <Link to="/login/partners">
            <AuthButton
              title="파트너"
              icon={<CommitterIcon />}
              text={<p>회원정보 및 계좌이체거래약정서 확인</p>}
            ></AuthButton>
          </Link>
          <Link to="/login/system">
            <AuthButton
              text={<p>평가 참여 및 제안 발표</p>}
              title="평가시스템"
              icon={<CompanyIcon />}
            ></AuthButton>
          </Link>
        </div>
      </div> */}
    </LandingContainer>
  );
}

const LandingBlock = styled.div`
  width: 100%;
  height: 100%;
  position: relative;
  & > img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  & > div {
    position: absolute;
    top: 0.5%;
    right: 37%;
    /* background-color: pink; */
    opacity: 0.3;
    width: 13.5%;
    height: 30px;
    & > div {
      width: calc(100% / 2);
      height: 100%;
      box-sizing: border-box;
      display: inline-block;
      cursor: pointer;
      /* border: 1px solid red; */
    }
  }
`;
