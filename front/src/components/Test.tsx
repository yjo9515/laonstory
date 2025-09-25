import styled from "styled-components";

interface IDataItem {
  tag: string;
  title: string;
  contents: IDataItemContents[];
  child: IDataItem[];
  score: number;
}

interface IDataItemContents {
  content: string;
  score: number;
}

// const data = [
//   {
//     tag: "평가항목",
//     title: "기술능력평가",
//     content: [],
//     child: [
//       {
//         tag: "구분",
//         title: "비계량평가",
//         content: [],
//         child: [
//           {
//             tag: "세부평가항목",
//             title: "표현력",
//             content: ["발생 가능한 안전문제 환기 및 예방효과"],
//           },
//           {
//             tag: "세부평가항목",
//             title: "표현력",
//             content: ["영상효과(그래픽)등의 기술 정도"],
//           },
//         ],
//       },
//       {
//         tag: "구분",
//         title: "계량평가",
//         content: [],
//         child: [
//           {
//             tag: "세부평가항목",
//             title: "수행력",
//             content: ["전담 수행 인력의 전문성 및 경력"],
//           },
//           {
//             tag: "세부평가항목",
//             title: "신인도",
//             content: ["사회적 가치 실천"],
//           },
//         ],
//       },
//     ],
//   },
//   {
//     tag: "평가항목",
//     title: "입찰가격평가",
//     content: ["계약부서 평가"],
//   },
// ];

let data: IDataItem[] = [];

export default function Test() {
  return (
    <TestContainer>
      <table>
        <thead>
          <tr>
            <th>분류명</th>
            <th>평가항목 및 세부평가항목</th>
            <th>평가내용</th>
            <th>배점</th>
          </tr>
        </thead>
        {/* 대 */}
        {data?.map((el) => (
          <tbody>
            <tr>
              <td className="big">{el?.tag}</td>
              <td>{el.title}</td>
              <td></td>
              <td></td>
            </tr>
            {/* 대의 자식 (중) */}
            {el?.child?.map((el) => (
              <>
                <tr>
                  <td className="middle">{el?.tag}</td>
                  <td>{el.title}</td>
                  <td></td>
                  <td></td>
                </tr>
                {/* 중의 자식 (소) */}
                {el?.child?.map((el) => (
                  <>
                    <tr>
                      <td className="">{el?.tag}</td>
                      <td>{el.title}</td>
                      <td></td>
                      <td></td>
                    </tr>
                    {/* 평가 내용 */}
                    {el?.contents?.map((el) => (
                      <>
                        <tr>
                          <td className="content">평가내용</td>
                          <td></td>
                          <td>{el?.content}</td>
                          <td></td>
                        </tr>
                      </>
                    ))}
                  </>
                ))}
                {/* 중의 내용 */}
                {el?.contents?.map((el) => (
                  <>
                    <tr>
                      <td className="content">평가내용</td>
                      <td></td>
                      <td>{el?.content}</td>
                      <td></td>
                    </tr>
                  </>
                ))}
              </>
            ))}
            {/* 대의 내용 */}
            {el?.contents?.map((el) => (
              <tr>
                <td className="content">평가내용</td>
                <td></td>
                <td>{el?.content}</td>
                <td></td>
              </tr>
            ))}
          </tbody>
        ))}
      </table>
    </TestContainer>
  );
}

const TestContainer = styled.div`
  table {
    width: 1100px;
    border: 1px solid black;
    td {
      width: 300px;
      border: 1px solid black;
      height: 40px;
      text-align: center;
      line-height: 40px;
    }
    .big {
      font-size: 30px;
      font-weight: 600;
    }
    .middle {
      font-size: 25px;
      font-weight: 500;
    }
    .content {
      font-size: 15px;
      font-weight: 300;
    }
  }
`;
