// p 태그 스크롤 컨테이너 - width와 height가 설정된 컨테이너로 감싸줘야 함
import styled from "styled-components";
import parse from "html-react-parser";

export function ScrollContainer({ text }: { text: string }) {
  return <Scroll>{parse(text)}</Scroll>;
}
const Scroll = styled.div`
  height: 100%;
  overflow-y: scroll;
  padding: 16px 0px 0px 24px;
  border: 1px solid #cbd3e5;
  border-radius: 5px;
  color: #3b3b3b;
  &::-webkit-scrollbar {
    width: 8px;
    background-color: ${(props) => props.theme.colors.gray6};
    border-radius: 55px;
  }
  &::-webkit-scrollbar-thumb {
    width: 8px;
    background-color: ${(props) => props.theme.colors.gray4};
    border-radius: 55px;
  }
`;
