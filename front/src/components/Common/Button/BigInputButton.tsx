import styled from "styled-components";

interface IInputButton {
  text: string;
  onClick?: () => void;
  type: "button" | "submit" | "reset" | undefined;
}

export default function BigInputButton({ text, type, onClick }: IInputButton) {
  return (
    <InputButtonContainer onClick={onClick} type={type}>
      {text}
    </InputButtonContainer>
  );
}

const InputButtonContainer = styled.button`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 204px;
  height: 58px;
  background-color: #438cae;
  color: white;
  border-radius: 69px;
  font-weight: 500;
  font-size: 18px;
  line-height: 26px;
`;
