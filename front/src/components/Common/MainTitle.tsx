import styled from "styled-components";

export function MainTitle({
  text,
  top = 72,
  center = false,
}: {
  text: string;
  top?: number;
  center?: boolean;
}) {
  return (
    <Title center={center} top={top}>
      {text}
    </Title>
  );
}
const Title = styled.h1<{ top: number; center: boolean }>`
  margin-top: ${(props) => (props.top ? props.top + "px" : "")};
  text-align: ${(props) => (props.center ? "center" : "left")};
  font-size: 20px;
  font-weight: ${(props) => props.theme.fontType.headline.bold};
  color: ${(props) => props.theme.colors.body2};
`;
