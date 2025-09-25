import styled from "styled-components";
import theme from "../../../theme";

import LabelButton from "../Button/LabelButton";

interface IInputSetProps {
  text?: string;
  label?: string;
  type: string;
  onClick?: () => void;
  register?: any;
  placeholder?: string;
  submit?: boolean;
  bold?: boolean;
  children?: React.ReactNode;
  disabled?: boolean;
  value?: string;
  success?: boolean;
  textCenter?: boolean;
  column?: boolean;
}

export default function InputSet({
  text, //버튼에 작성할 텍스트 text가 있으면 버튼이 생김
  onClick, // 버튼 클릭 이벤트
  label, // input label text
  type, // input type
  register,
  placeholder, // placeholder text
  submit = false, // button type
  bold = false, // 라벨 두깨
  children,
  disabled = false, // input disabled
  success,
  textCenter = false,
  column,
}: IInputSetProps) {
  return (
    <InputSetContainer textCenter={textCenter} bold={bold}>
      <div>
        {label && <label>{label}</label>}
        {success && "✔"}
      </div>
      <div className={`inputBox ${column && "column"}`}>
        <input disabled={disabled} type={type} {...register} placeholder={placeholder} />
        {(text || children) && (
          <LabelButton
            children={children}
            submit={submit}
            text={text}
            onClick={onClick || (() => {})}
            fullHeight
          />
        )}
      </div>
    </InputSetContainer>
  );
}

const InputSetContainer = styled.div<{ bold: boolean; textCenter: boolean }>`
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  gap: 16px;
  .inputBox {
    width: 100%;
    height: 100%;
  }
  input {
    width: 100%;
    height: 47px;
    padding-left: 22px;
    background: #ffffff;
    border: 1px solid #cbd3e5;
    border-radius: 5px;
    outline: none;
    font-size: ${theme.fontType.input1.fontSize};
    font-weight: ${theme.fontType.input1.bold};
    &::placeholder {
      color: ${theme.colors.blueGrayDeeper2};
    }
  }
  & > div {
    &:first-child {
      display: flex;
      justify-content: flex-start;
      gap: 10px;
      label {
        width: 100%;
        font-weight: ${theme.fontType.title3.bold};
        font-size: ${theme.fontType.title3.fontSize};
        line-height: 23px;
        color: ${theme.colors.body2};
        text-align: ${(props) => (props.textCenter ? "center" : "left")};
      }
    }
    &:last-child {
      display: flex;
      &.column {
        flex-direction: column;
        align-items: center;
        gap: 10px;
        > button {
          width: 100%;
          height: 47px;
        }
      }
    }
  }
`;
