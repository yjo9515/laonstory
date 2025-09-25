import styled from "styled-components";

export default function BigButton({
  text,
  white = false,
  submit = false,
  color,
  bgColor,
  onClick,
  w,
}: {
  text: string;
  white?: boolean;
  submit?: boolean;
  bgColor?: string;
  color?: string;
  onClick?: () => void;
  w?: number;
}) {
  return (
    <BigButtonContainer
      type={submit ? "submit" : "button"}
      white={white}
      color={color}
      bgColor={bgColor}
      onClick={onClick}
      w={w}
    >
      {text}
    </BigButtonContainer>
  );
}

const BigButtonContainer = styled.button<{ white: boolean; w?: number; bgColor?: string }>`
  width: ${(props) => (props.w ? props.w + "px" : "188px")};
  height: 54px;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: ${(props) =>
    props.white ? "white" : props.bgColor ? props.bgColor : props.theme.colors.body2};
  color: ${(props) => (props.white ? props.color : "white")};
  font-weight: 500;
  font-size: 15px;
  border: 1px solid ${(props) => props.theme.systemColors.blueDeep};
  border-radius: 8px;
`;
