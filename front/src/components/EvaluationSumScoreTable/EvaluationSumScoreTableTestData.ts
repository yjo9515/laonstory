export const TestData = [
  {
    companyList: [
      { id: 1, companyName: "제안업체 1" },
      { id: 2, companyName: "제안업체 2" },
      { id: 3, companyName: "제안업체 3" },
      { id: 4, companyName: "제안업체 4" },
    ],
    list: [
      {
        eluvationId: 1,
        evaluationTitle: "평가항목 1",
        totalScore: 12,
        scoreList: [
          { companyId: 1, companyName: "123", score: 11 },
          { companyId: 2, companyName: "123", score: 12 },
          { companyId: 3, companyName: "123", score: 12 },
          { companyId: 3, companyName: "123", score: 12 },
        ],
      },
      {
        eluvationId: 2,
        evaluationTitle: "평가항목 2",
        totalScore: 13,
        scoreList: [
          { companyId: 1, companyName: "123", score: 11 },
          { companyId: 2, companyName: "123", score: 12 },
          { companyId: 3, companyName: "123", score: 13 },
          { companyId: 3, companyName: "123", score: 13 },
        ],
      },
      {
        eluvationId: 3,
        evaluationTitle: "평가항목 3",
        totalScore: 14,
        scoreList: [
          { companyId: 1, companyName: "123", score: 11 },
          { companyId: 2, companyName: "123", score: 12 },
          { companyId: 3, companyName: "123", score: 13 },
          { companyId: 3, companyName: "123", score: 13 },
        ],
      },
      {
        eluvationId: 4,
        evaluationTitle: "평가항목 4",
        totalScore: 14,
        scoreList: [
          { companyId: 1, companyName: "123", score: 11 },
          { companyId: 2, companyName: "123", score: 12 },
          { companyId: 3, companyName: "123", score: 13 },
          { companyId: 3, companyName: "123", score: 13 },
        ],
      },
    ],
  },
];

export type SumScoreTableType = typeof TestData;
