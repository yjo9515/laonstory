import "react-quill/dist/quill.snow.css";
import ReactQuill from "react-quill";
import styled from "styled-components";
import { ViewObjectWrapperBox } from "../../../theme/common";
import theme from "../../../theme";
import BigButton from "../../../components/Common/Button/BigButton";
import { useEffect, useRef } from "react";
import { categories } from "../../../controllers/Partners/Terms/Terms";
import DOMPurify from 'dompurify';

export default function TermsView({
  onChange,
  values,
  category,
  onClick,
  buttonClick,
}: {
  onChange: (value: string) => void;
  values: {
    personal: string;
    personal_account: string;
    [key: string]: string;
  };
  category: categories;
  onClick: (category: categories) => void;
  buttonClick: () => void;
}) {
  const modules = {
    toolbar: [
      [{ header: [1, 2, 3, false] }],
      ["bold", "italic", "underline", "strike", "blockquote"],
      [{ list: "ordered" }, { list: "bullet" }, { indent: "-1" }, { indent: "+1" }],
      ["clean"],
      [{ size: ["small", false, "large", "huge"] }],
    ],
  };

  const ref = useRef<ReactQuill>(null);

  useEffect(() => {
    ref.current?.editor?.root.setAttribute("spellcheck", "false");
  }, []);

  return (
    <ViewObjectWrapperBox>
      <h1 className="viewTitle">약관설정</h1>
      <div className="mainContent">
        <Category>
          <button
            type="button"
            onClick={() => onClick("personal")}
            className={category === "personal" ? "choose" : ""}
          >
            개인정보 수집 및 이용(개인)
          </button>
          <button
            type="button"
            onClick={() => onClick("company")}
            className={category === "company" ? "choose" : ""}
          >
            개인정보 수집 및 이용(사업자 및 법인)
          </button>
          <button
            type="button"
            onClick={() => onClick("personal_account")}
            className={category === "personal_account" ? "choose" : ""}
          >
            개인정보 수집 및 이용(계좌이체거래약정서)
          </button>
        </Category>
        <BoardContainer>
          {category === "personal" && (
            <ReactQuill
              modules={modules}
              // formats={formats}
              className="board"
              value={DOMPurify.sanitize(values.personal)}
              onChange={onChange}
              ref={ref}
            />
          )}
          {category === "company" && (
            <ReactQuill
              modules={modules}
              // formats={formats}
              className="board"
              value={DOMPurify.sanitize(values.company)}
              onChange={onChange}
              ref={ref}
            />
          )}
          {category === "personal_account" && (
            <ReactQuill
              modules={modules}
              // formats={formats}
              className="board"
              value={DOMPurify.sanitize(values.personal_account)}
              onChange={onChange}
              ref={ref}
            />
          )}
        </BoardContainer>
        <div className="boardButtonContainer">
          <BigButton submit={false} text="저장하기" onClick={buttonClick} />
        </div>
      </div>
    </ViewObjectWrapperBox>
  );
}

const BoardContainer = styled.div`
  .board {
    height: 400px;
    * {
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
    }
  }
`;
const Category = styled.div`
  width: 100%;
  height: 25px;
  margin-bottom: 10px;
  display: flex;
  align-items: center;
  gap: 20px;
  color: ${theme.colors.gray3};
  .choose {
    color: ${theme.partnersColors.primary};
  }
`;
