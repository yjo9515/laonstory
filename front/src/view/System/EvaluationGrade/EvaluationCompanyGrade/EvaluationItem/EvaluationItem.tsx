import React, { useEffect, useState } from "react";

interface EvaluationItemTypes {
  list: EvaluationItemType;
  item: any;
  onGrandChange: (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>,
    group: string,
    type: string,
    allotment: number
  ) => void;
  onGrandOpinion: (
    e: React.ChangeEvent<HTMLTextAreaElement>,
    group: string
  ) => void;
  groupName: string;
  assessmentType: string;
}

type EvaluationItemType = {
  rowSpan: number;
  evaluationName: string;
  totalAllotment: number;
  content: any[];
};

function EvaluationItem(props: EvaluationItemTypes) {
  const [list, setList] = useState<EvaluationItemType>();

  useEffect(() => {
    if (props.list) setList(props.list);
  }, [props.list]);

  return (
    <>
      {list && (
        <>
          {/* 평가의 첫번째 줄 */}
          <tr>
            <td rowSpan={list.rowSpan}>{list.evaluationName}</td>
            <td rowSpan={list.rowSpan} className="minWidth">
              {list.totalAllotment}
            </td>
            <td>{list.content[0].semiName}</td>
            <td className="alignLeft">{list.content[0].content}</td>
            <td className="minWidth">{list.content[0].allotment}</td>
            <td>
              {/* 정성평가 */}
              {props.assessmentType === "QUALITATIVE" && (
                <input
                  name={list.content[0].inputName}
                  value={props.item[`item${1}`]}
                  onChange={(e) =>
                    props.onGrandChange(
                      e,
                      props.groupName,
                      props.assessmentType,
                      list.content[0].allotment
                    )
                  }
                />
              )}
              {/* 정량평가 */}
              {props.assessmentType === "QUANTITATIVE" && (
                <select
                  name={list.content[0].inputName}
                  onChange={(e) =>
                    props.onGrandChange(
                      e,
                      props.groupName,
                      props.assessmentType,
                      list.content[0].allotment
                    )
                  }
                >
                  <option value="">평가등급선택</option>
                  <option value="1">매우우수</option>
                  <option value="2">우수</option>
                  <option value="3">보통</option>
                  <option value="4">미흡</option>
                  <option value="5">매우미흡</option>
                </select>
              )}
            </td>
            {/* 정량평가 */}
            {props.assessmentType === "QUANTITATIVE" && (
              <td rowSpan={list.rowSpan}>
                <textarea
                  name="opinion"
                  onChange={(e) => props.onGrandOpinion(e, props.groupName)}
                ></textarea>
              </td>
            )}
          </tr>

          {/* 평가의 첫번째 줄을 제외한 나머지 줄 */}
          {[...Array(list.content.length - 1)].map((item, index) => (
            <tr key={index}>
              <td>{list.content[index + 1].semiName}</td>
              <td className="alignLeft">{list.content[index + 1].content}</td>
              <td>{list.content[index + 1].allotment}</td>
              <td>
                {/* 정성평가 */}
                {props.assessmentType === "QUALITATIVE" && (
                  <input
                    name={list.content[index + 1].inputName}
                    value={props.item[`item${index + 2}`]}
                    onChange={(e) =>
                      props.onGrandChange(
                        e,
                        props.groupName,
                        props.assessmentType,
                        list.content[index + 1].allotment
                      )
                    }
                  />
                )}
                {/* 정량평가 */}
                {props.assessmentType === "QUANTITATIVE" && (
                  <select
                    name={list.content[index + 1].inputName}
                    onChange={(e) =>
                      props.onGrandChange(
                        e,
                        props.groupName,
                        props.assessmentType,
                        list.content[index + 1].allotment
                      )
                    }
                  >
                    <option value="">평가등급선택</option>
                    <option value="1">매우우수</option>
                    <option value="2">우수</option>
                    <option value="3">보통</option>
                    <option value="4">미흡</option>
                    <option value="5">매우미흡</option>
                  </select>
                )}
              </td>
            </tr>
          ))}
        </>
      )}
    </>
  );
}

export default EvaluationItem;
