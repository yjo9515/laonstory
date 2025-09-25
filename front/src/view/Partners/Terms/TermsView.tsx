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
    consignment: string;
    security: string;
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
            개인정보 수집 및 이용(제안업체)
          </button>
          <button
            type="button"
            onClick={() => onClick("committer")}
            className={category === "committer" ? "choose" : ""}
          >
            개인정보 수집 및 이용(평가위원)
          </button>          
          <button
            type="button"
            onClick={() => onClick("consignment")}
            className={category === "consignment" ? "choose" : ""}
          >
            {/* 평가위원 위촉 */}
            청렴서약서
          </button>
          <button
            type="button"
            onClick={() => onClick("security")}
            className={category === "security" ? "choose" : ""}
          >
            보안 각서
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
          {category === "committer" && (
            <ReactQuill
              modules={modules}
              // formats={formats}
              className="board"
              value={DOMPurify.sanitize(values.committer)}
              onChange={onChange}
              ref={ref}
            />
          )}
          {category === "consignment" && (
            <ReactQuill
              modules={modules}
              // formats={formats}
              className="board"
              value={DOMPurify.sanitize(values.consignment)}
              onChange={onChange}
              ref={ref}
            />
          )}
          {category === "security" && (
            <ReactQuill
              modules={modules}
              // formats={formats}
              className="board"
              value={DOMPurify.sanitize(values.security)}
              onChange={onChange}
              ref={ref}
            />
          )}
        </BoardContainer>
        <div className="boardButtonContainer">
          <BigButton submit={false} text="저장" onClick={buttonClick} />
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
  font-size: ${theme.fontType.contentTitle1.fontSize};
  font-weight: ${theme.fontType.contentTitle1.bold};
  .choose {
    color: ${theme.partnersColors.primary};
  }
`;
