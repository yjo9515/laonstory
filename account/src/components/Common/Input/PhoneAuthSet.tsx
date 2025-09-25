import styled from "styled-components";
import theme from "../../../theme";
import authCheck from "../../../assets/Icon/authCheck.svg";

export default function PhoneAuthSet({
  onClick,
  phoneChange = false,
  phoneCheck = false,
  textCenter = false,
  phoneNumber,
  label,
}: {
  onClick: () => void;
  phoneChange?: boolean;
  phoneCheck?: boolean;
  textCenter?: boolean;
  phoneNumber?: string;
  label?: string;
}) {
  return (
    <PhoneAuthContainer textCenter={textCenter}>
      <div>
        <label>
          {label ? label : "휴대폰 번호"}
          {phoneCheck ? <img src={authCheck} alt="본인인증 확인 이미지" /> : ""}
        </label>
        {phoneChange && !phoneCheck && <p>* 변경할 휴대폰번호로 본인인증 해주세요.</p>}
      </div>
      <button type="button" onClick={onClick} className={phoneCheck ? "phoneCheck" : ""}>
        {phoneCheck
          ? phoneNumber?.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`)
          : "휴대폰 인증"}
      </button>
    </PhoneAuthContainer>
  );
}

const PhoneAuthContainer = styled.div<{ textCenter: boolean }>`
  width: 100%;
  label {
    width: 100%;
    color: ${(props) => props.theme.colors.body2};
    font-weight: 700;
    font-size: 16px;
    line-height: 23px;
    display: flex;
    justify-content: ${(props) => (props.textCenter ? "center" : "flex-start")};
    gap: 8px;
  }
  div:first-child {
    display: flex;
    align-items: center;
    gap: 5px;
    margin-bottom: 16px;
    > p {
      width: 400px;
      display: block;
      color: ${theme.colors.blueGrayDeeper2};
      font-size: 12px;
      text-align: right;
    }
  }
  button {
    width: 100%;
    height: 47px;
    background: #4289df;
    border-radius: 5px;
    font-weight: 400;
    font-size: 13px;
    color: #ffffff;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .phoneCheck {
    background: ${theme.colors.blueGray2};
    border: 1px solid ${theme.colors.blueDeep};
    color: ${theme.colors.blueGrayDeeper2};
    font-weight: 500;
    font-size: 15px;
    line-height: 22px;
  }
`;
