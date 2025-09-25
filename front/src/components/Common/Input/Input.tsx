import styled from "styled-components";
import theme from "../../../theme";
import arrowDown from "../../../assets/Icon/arrowDown.svg";
import { ReactNode } from "react";
import { InputHTMLAttributes } from "react";
import { UseFormRegisterReturn } from "react-hook-form";

// =================================================================== 인풋 관련 컴포넌트 컨테이너
/** 인풋 관련 컴포넌트 컨테이너 컴포넌트 */
export const Inputs = ({ children }: { children: ReactNode }) => {
  return <InputsContainer>{children}</InputsContainer>;
};
const InputsContainer = styled.div`
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  gap: 16px;
  & > div {
    width: 100%;
    display: flex;
    align-items: center;
    &:last-child {
    }
    & > p {
      height: 47px;
      line-height: 47px;
      font-size: ${theme.fontType.content1.fontSize};
      font-weight: ${theme.fontType.content1.bold};
      color: ${theme.systemColors.bodyLighter};
    }
  }
  & .smallGap {
    margin-top: -8px;
  }
`;
// =================================================================== 라벨
interface LabelProps {
  // Label
  labelText: string; // 라벨 문구
  labelIcon?: ReactNode; // 라벨에 들어갈 아이콘
  w?: number;
  importantCheck?: boolean;
}
/** 라벨 컴포넌트 */
const Label = (props: LabelProps) => {
  return (
    <LabelContainer width={props.w || 0}>
      {props.labelIcon && <span>{props.labelIcon}</span>}
      {props.labelText}
      {props.importantCheck && <span className="point">*</span>}
    </LabelContainer>
  );
};
const LabelContainer = styled.label<{ width: number }>`
  width: ${(props) => (props.width ? props.width + "px" : "144px")};
  display: flex;
  align-items: center;
  gap: 16px;
  font-size: ${theme.fontType.contentTitle1.fontSize};
  font-weight: ${theme.fontType.contentTitle1.bold};
  white-space: pre-wrap;
  & > span {
    width: 24px;
    display: flex;
    justify-content: center;
  }
  & path {
    fill: ${theme.colors.body2};
  }
  & .point {
    margin-top: 6px;
    margin-left: -18px;
    color: #da0043;
  }
`;
// ==================================================================== 기본 입력 인풋
interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  // Input
  type: InputHTMLAttributes<HTMLInputElement>["type"]; //Input Type
  register?: UseFormRegisterReturn; // react-hook-form 연결 객체
  placeholder?: string; // placeholder
  maxLength?: number;
  readOnly?: boolean;
  placeholderAlign?: string;
}
export const Input = (props: InputProps) => {
  return (
    <InputContainer
      {...props}
      type={props.type}
      placeholder={props.placeholder}
      {...props.register}
      maxLength={props.maxLength}
      readOnly={props.readOnly}
      className={`${props.readOnly && "nonSelect"} ${
        props.placeholderAlign ? "placeholderAlign" : ""
      }`}
    />
  );
};
const InputContainer = styled.input`
  width: 100%;
  height: 47px;
  padding-left: 24px;
  flex: 1;
  font-size: ${theme.fontType.content2.fontSize};
  font-weight: ${theme.fontType.content2.bold};
  border-radius: 5px;
  line-height: 47px;
  border: 1px solid ${theme.colors.blueDeep};
  &.nonSelect {
    background-color: ${theme.colors.gray6} !important;
    cursor: default;
    &:focus {
      outline: none;
    }
  }
  &.placeholderAlign {
    padding-left: 12px !important;
  }
`;
// ===================================================================== 라벨 기본 입력 인풋 세트
interface InputSetProps extends LabelProps, InputProps {
  onClick?: () => void;
  buttonText?: string;
  buttonClick?: () => void;
}
const InputSet = (props: InputSetProps) => {
  return (
    <div>
      <Label
        labelText={props.labelText}
        labelIcon={props.labelIcon}
        w={props.w}
        importantCheck={props.importantCheck}
      />
      <Input
        {...props}
        register={props.register}
        type={props.type}
        placeholder={props.placeholder}
      />
      {props.buttonText && props.buttonClick && (
        <Button onClick={props.buttonClick} text={props.buttonText} />
      )}
    </div>
  );
};
// ===================================================================== 클릭 이벤트로 값을 바꾸는 인풋
interface ClickInputProps {
  text: string;
  onClick: () => void;
}
export const ClickInput = (props: ClickInputProps) => {
  return <ClickInputContainer onClick={props.onClick}>{props.text}</ClickInputContainer>;
};
const ClickInputContainer = styled(InputContainer).attrs({
  as: "div",
})`
  display: inline-block;
  cursor: pointer;
`;
// ======================================================================= 인풋 버튼
interface ButtonProps {
  text: string;
  onClick: () => void;
}
const Button = (props: ButtonProps) => {
  return (
    <ButtonContainer type="button" onClick={props.onClick}>
      {props.text}
    </ButtonContainer>
  );
};
const ButtonContainer = styled.button`
  width: 167px;
  height: 47px;
  margin-left: 16px;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: ${theme.fontType.subTitle1.fontSize};
  font-weight: ${theme.fontType.subTitle1.bold};
  color: white;
  background-color: #12166d;
  border-radius: 67px;
`;
// ======================================================================= select
interface SelectProps {
  children: ReactNode;
  register: UseFormRegisterReturn;
}
const Select = (props: SelectProps) => {
  return (
    <SelectContainer {...props.register} arrowDown={arrowDown}>
      {props.children}
    </SelectContainer>
  );
};
const SelectContainer = styled.select<{ arrowDown: string }>`
  width: 100%;
  height: 47px;
  padding-left: 24px;
  flex: 1;
  font-size: 12px;
  line-height: 47px;
  border-radius: 5px;
  border: 1px solid ${theme.colors.blueDeep};
  cursor: pointer;
  background: none;
  -webkit-appearance: none; /* 크롬 화살표 없애기 */
  -moz-appearance: none; /* 파이어폭스 화살표 없애기 */
  appearance: none; /* 화살표 없애기 */
  background: url(${(props) => props.arrowDown}) no-repeat 98% 12px;
  cursor: pointer;
`;
// ======================================================================= file Input
interface FileProps {
  register: UseFormRegisterReturn;
  text: string;
}
const File = (props: FileProps) => {
  return (
    <FileContainer>
      <label className="inputLabel" htmlFor={props.register.name}>
        <span>{props.text}</span>
        <input type="file" id={props.register.name} {...props.register} />
      </label>
      <label className="buttonLabel" htmlFor={props.register.name}>
        파일 업로드
      </label>
    </FileContainer>
  );
};
const FileContainer = styled.div`
  width: 100%;
  display: flex;
  flex: 1;
  & > .inputLabel {
    width: 100%;
    height: 47px;
    flex: 1;
    padding-left: 24px;
    font-size: 12px;
    line-height: 47px;
    border-radius: 5px;
    border: 1px solid ${theme.colors.blueDeep};
    cursor: pointer;
    & > input {
      display: none;
    }
  }
  & > .buttonLabel {
    width: 167px;
    height: 47px;
    margin-left: 16px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 15px;
    line-height: 22px;
    color: white;
    background-color: #12166d;
    border-radius: 5px;
    cursor: pointer;
  }
`;
//======================================================================= Detail Info
interface DetailInfoProps {
  text: string;
}
const DetailInfo = (props: DetailInfoProps) => {
  return <DetailInfoContainer>{props.text}</DetailInfoContainer>;
};
const DetailInfoContainer = styled(ClickInputContainer)`
  background-color: ${theme.colors.blueGray2};
  cursor: default;
`;
//======================================================================= Detail Info
interface DetailInfoSetProps extends LabelProps, DetailInfoProps {
  buttonText?: string;
  buttonClick?: () => void;
}
const DetailInfoSet = (props: DetailInfoSetProps) => {
  return (
    <div>
      <Label labelText={props.labelText} labelIcon={props.labelIcon} w={props.w} />
      <DetailInfo text={props.text} />
      {props.buttonText && props.buttonClick && (
        <Button onClick={props.buttonClick} text={props.buttonText} />
      )}
    </div>
  );
};
/** 라벨 컴포넌트 */
Inputs.Label = Label;
Inputs.Input = Input;
Inputs.InputSet = InputSet;
Inputs.ClickInput = ClickInput;
Inputs.Button = Button;
Inputs.Select = Select;
Inputs.File = File;
Inputs.DetailInfo = DetailInfo;
Inputs.DetailInfoSet = DetailInfoSet;
