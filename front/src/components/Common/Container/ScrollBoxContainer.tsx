import styled from "styled-components";

interface IScrollBoxContainer {
  children: React.ReactNode[] | React.ReactNode;
  hideScroll?: boolean;
}

export default function ScrollBoxContainer({ children, hideScroll = false }: IScrollBoxContainer) {
  return <Scroll hideScroll={hideScroll}>{children}</Scroll>;
}

const Scroll = styled.div<{ hideScroll: boolean }>`
  overflow-y: auto;
  width: 100%;
  height: 100%;
  > * {
    width: 100%;
    height: 100%;
  }
  &::-webkit-scrollbar {
    width: ${(props) => (props.hideScroll ? "0px" : "8px")};
    background-color: ${(props) => props.theme.colors.gray6};
    border-radius: 55px;
    left: 8px;
  }
  &::-webkit-scrollbar-thumb {
    width: ${(props) => (props.hideScroll ? "0px" : "8px")};
    background-color: ${(props) => props.theme.colors.gray4};
    border-radius: 55px;
  }
`;
