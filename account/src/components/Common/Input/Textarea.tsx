import React, { useEffect, useState } from "react";
import styled from "styled-components";
import theme from "../../../theme";

interface TextareaSetTypes {
  readOnly: boolean;
  notice: string;
  onChange: (value: string) => void;
}

function TextareaSet(props: TextareaSetTypes) {
  const [notice, setNotice] = useState<string>("");

  useEffect(() => {
    props.onChange(notice);
  }, [notice]);

  useEffect(() => {
    setNotice(props.notice);
  }, [props.notice]);

  return (
    <TextareaSetBlock>
      <p>내용</p>
      <textarea
        readOnly={props.readOnly}
        onChange={(e) => setNotice(e.target.value)}
        value={notice}
      ></textarea>
    </TextareaSetBlock>
  );
}

export default TextareaSet;

const TextareaSetBlock = styled.div`
  & > p {
    margin-bottom: ${theme.commonMargin.gap4};
  }
  & > textarea {
    width: 100%;
    resize: none;
    height: 200px;
    border: 1px solid ${theme.colors.gray4};
    padding: ${theme.commonMargin.gap4};
  }
`;
