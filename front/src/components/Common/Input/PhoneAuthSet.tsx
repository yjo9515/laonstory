import styled from "styled-components";
import authCheck from "../../../assets/Icon/authCheck.svg";
import theme from "../../../theme";
import NumberUtils from "../../../utils/NumberUtils";

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
          {phoneChange && !phoneCheck && <p>* 변경할 휴대폰번호로 본인인증 해주세요.</p>}
        </label>
      </div>
      {!phoneCheck ? (
        <button type="button" onClick={onClick}>
          휴대폰 인증
        </button>
      ) : (
        <span className="phoneCheck">{NumberUtils.phoneFormat(phoneNumber || "")}</span>
      )}
    </PhoneAuthContainer>
  );
}

const PhoneAuthContainer = styled.div<{ textCenter: boolean }>`
  width: 100%;
  label {
    width: 100%;
    color: ${(props) => props.theme.colors.body2};
    font-weight: ${theme.fontType.title3.bold};
    font-size: ${theme.fontType.title3.fontSize};
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
    p {
      display: block;
      color: ${theme.colors.blueGrayDeeper2};
      font-size: ${theme.fontType.content1.fontSize};
      font-weight: ${theme.fontType.content1.bold};
    }
  }
  button {
    width: 100%;
    height: 47px;
    background: ${theme.systemColors.systemPrimary};
    border-radius: 5px;
    font-weight: ${theme.fontType.subTitle1.bold};
    font-size: ${theme.fontType.subTitle1.fontSize};
    color: #ffffff;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .phoneCheck {
    display: flex;
    justify-content: center;
    align-items: center;
    background: ${theme.colors.blueGray2};
    border: 1px solid ${theme.colors.blueDeep};
    color: ${theme.colors.blueGrayDeeper2};
    font-size: ${theme.fontType.input1.fontSize};
    font-weight: ${theme.fontType.input1.bold};
    line-height: 22px;
    height: 47px;
    border-radius: 5px;
  }
`;
