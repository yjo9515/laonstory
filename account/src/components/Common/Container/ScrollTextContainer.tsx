// p 태그 스크롤 컨테이너 - width와 height가 설정된 컨테이너로 감싸줘야 함
import styled from "styled-components";

export function ScrollTextContainer({ text }: { text: string }) {
  return <Scroll>{text}</Scroll>;
}
const Scroll = styled.p`
  height: 100%;
  overflow-y: scroll;
  padding-right: 8px;
  &::-webkit-scrollbar {
    width: 8px;
    background-color: ${(props) => props.theme.colors.gray6};
    border-radius: 55px;
    left: 8px;
  }
  &::-webkit-scrollbar-thumb {
    width: 8px;
    background-color: ${(props) => props.theme.colors.gray4};
    border-radius: 55px;
  }
`;
