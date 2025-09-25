type EvaluationItemType = {
  rowSpan: number;
  evaluationName: string;
  totalAllotment: number;
  content: any[];
};

/** 평가항목 1 - 전략 및 방법론 */
export const evaluationItem1: EvaluationItemType = {
  rowSpan: 2,
  evaluationName: "전략 및 방법론",
  totalAllotment: 14,
  content: [
    {
      semiName: "사업이해도",
      content:
        "주변 환경 분석과 업무내용 파악을 통한 사업의 벼경 및 목표의 이해 여부\n사업의 배경 및 목표와 제시한 사업방향 및 전력과의 연관성 여부",
      allotment: 6,
      inputName: "item1",
    },
    {
      semiName: "추진전략",
      content:
        "문제해결을 위한 위험요소 분석의 적정성 및 구체성\n문제해결을 위해 검토하고 있는 대안의 창의성 및 적정성\n논리적 근거를 기반으로 검증 가능하도록 제시되었는지의 여부",
      allotment: 8,
      inputName: "item2",
    },
  ],
};

/** 평가항목 2 - 기술 및 기능 */
export const evaluationItem2: EvaluationItemType = {
  rowSpan: 5,
  evaluationName: "기술 및 기능",
  totalAllotment: 26,
  content: [
    {
      semiName: "시스템 요구사항",
      content:
        "도입되는 장비 및 시스템의 요구 규격을 충족시키는 장비를 제안하며 향후 확장성이 있는지를 평가한다.",
      allotment: 6,
      inputName: "item1",
    },
    {
      semiName: "기능요구사항(클라우드 플랫폼 HW 기능)",
      content:
        "시스템 구축을 위한 기능 구현 방법이 구체적이고 안정적으로 제시하고 있는지를 평가한다.(클라우드 플랫폼 HW 기능)",
      allotment: 5,
      inputName: "item2",
    },
    {
      semiName: "기능요구사항(클라우드 플랫폼 SW 기능)",
      content:
        "시스템 구축을 위한 기능 구현 방법이 구체적이고 안정적으로 제시하고 있는지를 평가한다.(클라우드 플랫폼 SW 기능)",
      allotment: 5,
      inputName: "item3",
    },
    {
      semiName: "기능요구사항(빅데이터 플랫폼 HW 기능)",
      content:
        "시스템 구축을 위한 기능 구현 방법이 구체적이고 안정적으로 제시하고 있는지를 평가한다.(빅데이터 플랫폼 HW 기능)",
      allotment: 5,
      inputName: "item4",
    },
    {
      semiName: "기능요구사항(빅데이터 플랫폼 HW 기능)",
      content:
        "시스템 구축을 위한 기능 구현 방법이 구체적이고 안정적으로 제시하고 있는지를 평가한다.(빅데이터 플랫폼 HW 기능)",
      allotment: 5,
      inputName: "item5",
    },
  ],
};

/** 평가항목 3 - 성능 및 품질 */
export const evaluationItem3: EvaluationItemType = {
  rowSpan: 2,
  evaluationName: "성능 및 품질",
  totalAllotment: 10,
  content: [
    {
      semiName: "인터페이스 요구사항(표준 인터페이스 변환 연계)",
      content:
        "설비 설정, 제어 등 제안요청서에서 제시하는 인터페이스 요구사항을 만족하는지를 평가한다.(표준 인터페이스 변환 연계)",
      allotment: 5,
      inputName: "item1",
    },
    {
      semiName: "인터페이스 요구사항(DMZ 구간 데이터 연계)",
      content:
        "설비 설정, 제어 등 제안요청서에서 제시하는 인터페이스 요구사항을 만족하는지를 평가한다.(DMZ 구간 데이터 연계)",
      allotment: 5,
      inputName: "item2",
    },
  ],
};

/** 평가항목 4 - 프로젝트 관리 */
export const evaluationItem4: EvaluationItemType = {
  rowSpan: 2,
  evaluationName: "프로젝트 관리",
  totalAllotment: 6,
  content: [
    {
      semiName: "사업관리",
      content:
        "사업수행조직, 업무분장, 공정별 세부일정\n계획, 위험관리방안, 자원관리방안 평가",
      allotment: 3,
      inputName: "item1",
    },
    {
      semiName: "일정계획",
      content: "일정 계획의 구체성 등 평가",
      allotment: 3,
      inputName: "item2",
    },
  ],
};

/** 평가항목 5 - 프로젝트 지원 */
export const evaluationItem5: EvaluationItemType = {
  rowSpan: 2,
  evaluationName: "프로젝트 지원",
  totalAllotment: 6,
  content: [
    {
      semiName: "하자보증",
      content:
        "하자보수 계획, 조직, 절차, 범위 및 기간에 대하여 구체적으로 제시되었는지를 평가한다.",
      allotment: 3,
      inputName: "item1",
    },
    {
      semiName: "기술지원 및 교육훈련",
      content:
        "장애처리 등 기술지원에 대한 계획, 조직, 범위에 대하여 구체적으로 제시되었는지를 평가한다.\n교육훈련 방법, 내용, 일정, 교육훈련 조직 등이 상세하게 지시되었는지를 평가한다.",
      allotment: 3,
      inputName: "item2",
    },
  ],
};

/** 평가항목 6 - 하도급계약 */
export const evaluationItem6: EvaluationItemType = {
  rowSpan: 1,
  evaluationName: "하도급계약",
  totalAllotment: 5,
  content: [
    {
      semiName: "하도급계약적정성",
      content: `"소프트웨어산업진흥법령"에 따라 입찰 시 제출한 소프트웨어사업 하도급 계획서에서 하도급에 참가하는 자의 하도급 금액 비율, 하도급 계약금액 비율이 본 사업의 규모, 목적 및 특성 등을 고려하여 적정한지를 평가한다.\n\n 다만, 하도급을 하지 않는 경우 또는 하도급 금액 비율이 100분의 10이하이면서 "하도급공정화에 관한 법률"제3조의2에 따른 소프트웨어사업 표준하도급계약서를 활용할 계획이 있는 자는 최고등급을 부여한다.`,
      allotment: 5,
      inputName: "item1",
    },
  ],
};
