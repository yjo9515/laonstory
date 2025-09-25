import { UseFormRegister } from "react-hook-form";
import styled from "styled-components";
import SmartPhone from "../../assets/Auth/SmartPhone";
import { IJoinInput } from "../../interface/Auth/FormInputInterface";
import theme from "../../theme";
import AuthButton from "../Common/Button/AuthButton";

interface IProcessComponentProps {
  register: UseFormRegister<IJoinInput>;
  onClick: () => void;
}

export default function SelfAuth({ onClick }: IProcessComponentProps) {
  return (
    <InfoTextContainer>
      <div className="authButtonContainer">
        <AuthButton
          onClick={onClick}
          icon={<SmartPhone />}
          title="휴대폰 인증"
          text={<p>본인인증을 진행하시려면 클릭해주세요.</p>}
        />
      </div>
      <div className="info">
        <p>
          - 본인명의로 가입한 휴대전화번호만 인증 가능하며, 본인 명의의 휴대전화번호가 아닌 경우
          인증이 제한될 수 있습니다.
        </p>
        <p>
          - 해당 서비스의 본인인증(한국서부발전 계좌등록시스템)은 한국신용평가정보(주)의 본인인증
          서비스를 통해 이루어집니다.
          <br />- 본인인증에 대한 문의가 있으신 분은 한국신용평가정보(주) 본인인증 콜센터로 문의
          주시기 바랍니다.
        </p>
      </div>
    </InfoTextContainer>
  );
}

const InfoTextContainer = styled.div`
  font-size: ${(props) => props.theme.fontType.body.fontSize};
  display: flex;
  flex-direction: column;
  align-items: center;
  & > .authButtonContainer {
  }
  & > .info {
    margin-top: 32px;
    & > p {
      margin: 0 auto;
      letter-spacing: 0.03em;
      color: ${theme.colors.blueGrayDeeper2};
      font-size: ${theme.fontType.content1.fontSize};
    }
  }
`;
