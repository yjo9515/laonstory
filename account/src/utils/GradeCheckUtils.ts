export class GradeTypeCheck {
  isGradeCheck(type?: string) {
    if (type === "QUALITATIVE") return "정성평가";
    if (type === "QUANTITATIVE") return "정량평가";
    if (type === "INFORMATIZATION") return "정보화산업";
    if (type === "BIDDING") return "기타입찰";
    if (!type) return "";
  }
  isSubmitCheck(type: string) {
    if (type === "submission") return "제출";
    if (type === "notSubmitted") return "미제출";
  }
}

export default new GradeTypeCheck();
