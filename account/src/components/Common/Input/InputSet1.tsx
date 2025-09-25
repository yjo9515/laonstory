import styled from "styled-components";
import theme from "../../../theme";
import InputButton from "../Button/InputButton";
import arrowDown from "../../../assets/Icon/arrowDown.svg";
import { ReactNode } from "react";
import { InputHTMLAttributes } from "react";
import { UseFormRegisterReturn } from "react-hook-form";
import { useSetRecoilState } from "recoil";
import { alertModalState } from "../../../modules/Client/Modal/Modal";

interface IInputSet1 {
  text?: string;
  label?: string;
  isButton?: boolean;
  buttonText?: string;
  isSelect?: boolean;
  selectOption?: ReactNode;
  disabled?: boolean;
  register?: any;
  type?: string;
  placeholder?: string;
  onClick?: () => void;
  value?: string;
  icon?: React.ReactNode;
  inputOnClick?: boolean;
  className?: string;
  readOnly?: boolean;
  autoComplete?: string;
  importantCheck?: boolean;
  maxLength?: number | boolean;
  minLength?: number | boolean;
  heightType? : string | undefined;
  onKeyDown? : (arg0: any) => void;
  onPaste? : (arg0: any) => void;
  onChange? : (arg0: any) => void;
}

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
      {props.labelIcon && props.labelIcon}
      {props.labelText}
      {props.importantCheck && <span className="point">*</span>}
    </LabelContainer>
  );
};
const LabelContainer = styled.label<{ width: number }>`
  width: ${(props) => (props.width ? props.width + "px" : "178px")};
  display: flex;
  align-items: center;
  gap: 16px;
  font-size: 14px;
  font-weight: 500;
  white-space: pre-line;
  & path {
    fill: ${theme.colors.body2};
  }
  & .point {
    margin-top: 6px;
    margin-left: -12px;
    color: #da0043;
  }
`;
// ==================================================================== 기본 입력 인풋
interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  // Input
  type: InputHTMLAttributes<HTMLInputElement>["type"]; //Input Type
  register: UseFormRegisterReturn; // react-hook-form 연결 객체
  placeholder?: string; // placeholder
  readOnly?: boolean;
  inputClick?: () => void;  
}
const Input = (props: InputProps) => {
  return (
    <InputContainer
      {...props}
      onClick={() => {
        if (props.inputClick) props.inputClick();
      }}
      type={props.type}
      placeholder={props.placeholder}
      {...props.register}
      readOnly={props.readOnly}
      className={`${props.readOnly && "nonSelect"} ${props.inputClick && "cursor"}`}
      onKeyDown={(e: any) => {        
        if (e.keyCode === 13) {
          e.preventDefault();
          return;
        }        
      }}
    />
  );
};
const InputContainer = styled.input`
  width: 100%;
  height: 47px;
  padding-left: 18px;
  flex: 1;
  font-size: 12px;
  border-radius: 5px;
  border: 1px solid ${theme.colors.blueDeep};
  &.nonSelect {
    background-color: ${theme.colors.gray6};
    cursor: default;
    &:focus {
      outline: none;
    }
  }
  &.cursor {
    cursor: pointer;
  }
`;
// ===================================================================== 라벨 기본 입력 인풋 세트
interface InputSetProps extends LabelProps, InputProps {
  onClick?: () => void;
  buttonText?: string;
  buttonClick?: () => void;
  readOnly?: boolean;
  inputClick?: () => void;
  importantCheck?: boolean;  
}
const InputSet = (props: InputSetProps) => {
  return (
    <div>
      <Label
        labelText={props.labelText}
        labelIcon={props.labelIcon}
        importantCheck={props.importantCheck}
      />
      <Input
        {...props}
        register={props.register}
        type={props.type}
        placeholder={props.placeholder}
        readOnly={props.readOnly}
        inputClick={props.inputClick}        
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
const ClickInputContainer = styled.div`
  width: 100%;
  height: 47px;
  padding-left: 24px;
  flex: 1;
  font-size: 12px;
  line-height: 47px;
  border-radius: 5px;
  border: 1px solid ${theme.colors.blueDeep};
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
  font-size: 15px;
  line-height: 22px;
  color: white;
  background-color: #438cae;
  border-radius: 5px;
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
        <input
          type="file"
          id={props.register.name}
          {...props.register}
          accept={".jpg, .jpeg, .png, .pdf"}
        />
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
    background-color: #438cae;
    border-radius: 5px;
    cursor: pointer;
  }
`;

/** 라벨 컴포넌트 */
Inputs.Label = Label;
Inputs.Input = Input;
Inputs.InputSet = InputSet;
Inputs.ClickInput = ClickInput;
Inputs.Button = Button;
Inputs.Select = Select;
Inputs.File = File;

export default function InputSet1({
  text,
  label,
  isButton = false,
  buttonText,
  isSelect = false,
  disabled = false,
  register = {},
  selectOption,
  placeholder,
  type,
  onClick,
  icon,
  inputOnClick = false,
  className,
  readOnly,
  autoComplete,
  importantCheck,
  maxLength,
  minLength,
  heightType,  
  onKeyDown,
  onPaste,
  onChange
}: IInputSet1) {
  const setAlertModal = useSetRecoilState(alertModalState);

  return (
    <InputSet1Container disabled={disabled} arrowDown={arrowDown} inputOnClick={inputOnClick} heightType={heightType}>
      <label>
        {icon}
        {label}
        {importantCheck && <span>*</span>}
      </label>
      <div className="inputButtonWrap">
        {isSelect ? (
          <>
            <select {...register}>{selectOption}</select>
          </>
        ) : (
          <>
            {disabled ? (
              <span
                className={`${placeholder ? "placeholder" : ""} ${inputOnClick ? "cursor" : ""} ${
                  className ? className : ""
                }`}
                onClick={inputOnClick ? onClick : () => {}}
              >
                {text}
              </span>
            ) : (
              <input
                {...register}
                type={type}
                placeholder={placeholder}
                readOnly={readOnly}
                autoComplete={autoComplete}
                className={`${readOnly && "nonSelect"}`}
                maxLength={maxLength}
                minLength={minLength}       
                onKeyDown={onKeyDown}        
                onPaste={onPaste} 
                onChange={onChange}
                // onBlur={() => {
                //   if (register.name === "password") {
                //     setAlertModal({
                //       isModal: true,
                //       content: "비밀번호에러",
                //     });
                //   }
                //   if (register.name === "confirmPassword") {
                //   }
                // }}
              />
            )}
            {isButton && (
              <InputButton
                text={buttonText || ""}
                onClick={onClick ? () => onClick() : undefined}
              />
            )}
          </>
        )}
      </div>
    </InputSet1Container>
  );
}

interface LabelRadioBtnInterface extends IInputSet1 {
  component?: ReactNode;
  accept?: string;
  yesText?: string;
  noText?: string;
  guide?: boolean;
}

export const LabelRadioBtn = (props: LabelRadioBtnInterface) => {
  return (
    <InputSet1Container
      disabled={props.disabled ?? false}
      arrowDown={arrowDown}
      inputOnClick={props.inputOnClick ?? false}
    >
      <label>
        {props.icon}
        {props.label}
      </label>
      <div className="inputButtonWrap">
        <label htmlFor="accept1" className={`btn ${props.accept === "yes" && "yes"}`}>
          {props.yesText ? props.yesText : "승인"}
          <input
            {...props.register}
            type={"radio"}
            id="accept1"
            value="yes"
            // style={{ display: "none" }}
          />
        </label>

        <label htmlFor="accept2" className={`btn ${props.accept === "no" && "no"}`}>
          {props.noText ? props.noText : "반려"}
          <input
            {...props.register}
            type={"radio"}
            id="accept2"
            value="no"
            // style={{ display: "none" }}
          />
        </label>
        {props.guide && (
          <div className="guide">
            <p>사업자 구분을 선택해 주세요.</p>
          </div>
        )}
      </div>
    </InputSet1Container>
  );
};

const InputSet1Container = styled.div<{
  disabled: boolean;
  arrowDown: string;
  inputOnClick: boolean;
  heightType? : string;
}>`
  width: 100%;
  ${props => props.heightType == "content" ? `height : fit-content;` : `height : 47px;`}
  display: flex;
  align-items: center;
  .inputButtonWrap {
    flex: 1;
    position: relative;
    width: 100%;
    height: 100%;
    display: flex;
    gap: 16px;
    & > input,
    select,
    .disabledCover,
    span {
      font-size: 14px;
      border-radius: 5px;
      display: block;
      width: 100%;
      padding-left: 24px;
      /* line-height:47px; */
      ${props => props.heightType === "content" ? `line-height : 300%;` :`line-height : 47px;`}
      ${props => props.heightType === "content" && `height : fit-content;`}
      ${props => props.heightType === "content" && `min-height : 47px;`}
      ${props => props.heightType === "content" && `max-height : 200px;`}    
      ${props => props.heightType === "content" && `word-break : break-all;`}
      ${props => props.heightType === "content" && `overflow-y : auto;`}
      flex: 1;
      border: 1px solid #cbd3e5;
      background-color: ${(props) =>
        props.disabled && !props.inputOnClick ? theme.colors.blueGray2 : "white"};
      &.placeholder {
        color: #aab1c1;
        font-size: 14px;
      }
      &.cursor {
        cursor: pointer;
      }
      &.invite {
        color: #2f80ed;
      }
      &.finish {
        color: #6fcf97;
      }
      &.block {
        color: #da0043;
      }
    }
    > img {
      position: absolute;
      display: block;
      width: 24px;
      height: 24px;
      right: 16px;
      top: 12px;
      cursor: pointer;
      z-index: 3;
    }
    & > .guide {
      height: 100%;
      display: flex;
      align-items: center;
      & > p {
        font-size: ${theme.fontType.regular12.fontSize};
        color: #da0043;
      }
    }
  }
  label {
    width: 176px;
    font-weight: 500;
    font-size: 15px;
    color: ${theme.colors.body2};
    display: flex;
    align-items: center;
    gap: 16px;
    white-space: pre-line;

    & > span {
      margin-top: 6px;
      margin-left: -12px;
      color: #da0043;
    }
    & > img,
    svg {
      display: block;
      width: 24px;
      height: 24px;
      > path {
        fill: ${theme.colors.body2};
      }
    }
  }
  input {
    &[type="file"] {
      display: none;
    }
  }
  select {
    background: none;
    -webkit-appearance: none; /* 크롬 화살표 없애기 */
    -moz-appearance: none; /* 파이어폭스 화살표 없애기 */
    appearance: none; /* 화살표 없애기 */
    background: url(${(props) => props.arrowDown}) no-repeat 98% 12px;
    cursor: pointer;
  }

  .btn {
    width: 104px;
    height: 47px;
    border: 1px solid #cbd3e5;
    color: #cbd3e5;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 25px;
    cursor: pointer;
    & > input {
      display: none;
    }
  }
  .yes {
    color: #fff;
    border: 1px solid #6fcf97;
    background-color: #6fcf97;
  }
  .no {
    color: #fff;
    border: 1px solid #da0043;
    background-color: #da0043;
  }
  .nonSelect {
    background-color: ${theme.colors.gray6} !important;
    cursor: default;
    &:focus {
      outline: none;
    }
  }
`;
