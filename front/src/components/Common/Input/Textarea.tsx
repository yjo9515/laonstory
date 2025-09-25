import { useEffect, useState } from "react";
import styled from "styled-components";
import theme from "../../../theme";
import Label from "./Label";

interface TextareaSetTypes {
  readOnly: boolean;
  notice: string;

  text?: string;
}

function TextareaSet(props: TextareaSetTypes) {
  const [notice, setNotice] = useState<string>("");

  useEffect(() => {
    setNotice(props.notice);
  }, [props.notice]);

  return (
    <TextareaSetBlock>
      <span>{props.text || "내용"}</span>
      <textarea readOnly={props.readOnly} value={notice}></textarea>
    </TextareaSetBlock>
  );
}

export default TextareaSet;

const TextareaSetBlock = styled.div`
  height: 200px;
  display: flex;
  gap: 30px;
  & > span {
    color: ${theme.colors.body2};
    font-size: 16px;
    font-weight: 700;
    white-space: pre-wrap;
  }
  & > textarea {
    width: 100%;
    height: 100%;
    resize: none;
    flex: 1;
    border: 1px solid ${theme.systemColors.blueDeep};
    padding: ${theme.commonMargin.gap4};
    outline: none;
    font-size: ${theme.fontType.body.fontSize};
    font-weight: ${theme.fontType.body.bold};
    color: ${theme.colors.body};
    border-radius: 5px;
  }
`;
