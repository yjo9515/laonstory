export class GradeTypeCheck {
  isGradeCheck(type?: string) {
    if (type === "QUALITATIVE") return "정성평가";
    if (type === "QUANTITATIVE") return "정량평가";
    if (type === "INFORMATIZATION") return "정보화산업";
    if (type === "BIDDING") return "기타입찰";
    if (!type) return "";
  }
  isSubmitCheck(type: string) {
    if (type === "") return "";
    if (type === "NOT_SUBMIT") return "미제출";
    if (type === "FIRST_SUBMIT") return "제출";
    if (type === "REQUEST_MODIFY") return "수정 요청";
    if (type === "FINAL_SUBMIT") return "완료";
  }
  isSubmitClassNameCheck(type: string) {
    if (type === "") return "";
    if (type === "NOT_SUBMIT") return "";
    if (type === "FIRST_SUBMIT") return "firstSubmit";
    if (type === "REQUEST_MODIFY") return "requestModify";
    if (type === "FINAL_SUBMIT") return "isActive";
  }
}

export default new GradeTypeCheck();
