import styled from "styled-components";
import theme from "../../../theme";
import InputButton from "../Button/InputButton";

interface IInputSet1 {
  text?: string;
  label?: string;
  isButton?: boolean;
  buttonText?: string;
  isSelect?: boolean;
  selectOption?: { text: string; value: string }[];
  disabled?: boolean;
  register?: any;
  type?: string;
  placeholder?: string;
  onClick?: () => void;
  value?: string;
  icon?: React.ReactNode;
  readOnly?: boolean;
  heightType?: string | undefined;
}

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
  value,
  icon,
  readOnly = false,
  heightType
}: IInputSet1) {
  return (
    <InputSet1Container disabled={disabled} heightType={heightType}>
      <label>
        {icon}
        {label}
      </label>
      <div className="inputButtonWrap">
        {isSelect ? (
          <>
            <select {...register}>
              {selectOption?.map((el, i) => (
                <option key={el.value} value={el.value}>
                  {el.text}
                </option>
              ))}
            </select>
          </>
        ) : (
          <>
            {disabled ? (
              <span className={placeholder ? "placeholder" : ""}>{text}</span>
            ) : (
              <input {...register} type={type} placeholder={placeholder} readOnly={readOnly} />
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

const InputSet1Container = styled.div<{ disabled: boolean; heightType?: string; }>`
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
      border-radius: 5px;
      display: block;
      width: 100%;
      padding-left: 24px;
      flex: 1;

      ${props => props.heightType === "content" ? `line-height : 300%;` :`line-height : 47px;`}
      ${props => props.heightType === "content" && `height : fit-content;`}
      ${props => props.heightType === "content" && `min-height : 47px;`}
      ${props => props.heightType === "content" && `max-height : 200px;`}    
      ${props => props.heightType === "content" && `word-break : break-all;`}
      ${props => props.heightType === "content" && `overflow-y : auto;`}
      background-color: ${(props) => (props.disabled ? theme.colors.blueGray2 : "white")};
      border: 1px solid #cbd3e5;
      &.placeholder {
        color: #aab1c1;
        font-size: 14px;
      }
    }
  }
  label {
    width: 176px;
    font-weight: 700;
    font-size: 16px;
    color: ${theme.colors.body2};
    display: flex;
    align-items: center;
    gap: 16px;
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
`;
