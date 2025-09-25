import styled from "styled-components";
import theme from "../../../theme";

export default function BigButton({
  text,
  white = false,
  submit = false,
  onClick,
  isPrev = false,
  background = ""
}: {
  text: string;
  white?: boolean;
  submit?: boolean;
  onClick?: () => void;
  isPrev?: boolean;
  background? : string;
}) {
  return (
    <BigButtonContainer
      isPrev={isPrev}
      type={submit ? "submit" : "button"}
      white={white}
      onClick={onClick}
      className={`${isPrev && "prev"}`}
      background={background}
    >
      {text}
    </BigButtonContainer>
  );
}

const BigButtonContainer = styled.button<{ white: boolean; isPrev: boolean; background : string; }>`
  width: 204px;
  height: 58px;
  background: ${props => props.background ? props.background : theme.colors.peacok};
  border-radius: 64px;
  font-weight: 700;
  font-size: ${theme.fontType.medium16.fontSize};
  font-weight: ${theme.fontType.medium16.bold};
  color: #ffffff;
  text-align: center;
  &.prev {
    background-color: #fff;
    border: 1px solid ${theme.colors.peacok};
    color: ${theme.colors.peacok};
  }
`;
