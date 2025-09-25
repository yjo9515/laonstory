import styled from "styled-components";

interface IInputButton {
  text: string;
  onClick?: () => void;
  type: "button" | "submit" | "reset" | undefined;
}

export default function BigInputButton({ text, type, onClick }: IInputButton) {
  return (
    <InputButtonContainer type={type} onClick={onClick}>
      {text}
    </InputButtonContainer>
  );
}

const InputButtonContainer = styled.button`
  width: 204px;
  height: 58px;
  display: flex;
  justify-content: center;
  align-items: center;
  color: white;
  font-weight: 500;
  font-size: 18px;
  line-height: 26px;
  background: #0a4763;
  border-radius: 64px;
`;
