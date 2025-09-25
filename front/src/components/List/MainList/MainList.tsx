import React, { useEffect, useState } from "react";
import DataTable, { TableColumn } from "react-data-table-component";
import styled from "styled-components";
import SmallButton1 from "../../Common/Button/SmallButton1";
import theme from "./../../../theme/index";

type DataRow = {
  number: string;
  director: string;
  year: string;
  button?: any;
};

interface ListDataPropsTypes {
  columns?: any[];
  data?: any[];
  goPage?: (id: number) => void;
  goPosition?: (id: number) => void;
}

function MainList(props: ListDataPropsTypes) {
  const [columnState, setColumnState] = useState<any[]>([]);
  const [dataState, setDataState] = useState<any[]>([]);

  useEffect(() => {
    if (props.columns) {
      let list: TableColumn<DataRow>[] = [];
      props.columns.map((i) => {
        let key = i.columnKey;
        list.push({
          name: i.name,
          selector: (row: any) => row[key],
          width: i.width,
        });
      });

      setColumnState(list);
    }
  }, [props.columns]);

  useEffect(() => {
    if (props.data) {
      let item = props.data.map((i) =>
        i.participate
          ? {
              ...i,
              participate: (
                <SmallButton1
                  text="입장"
                  onClick={() => (props.goPosition ? props.goPosition(i.id) : console.log())}
                  white={true}
                />
              ),
            }
          : i
      );
      setDataState(item);
    }
  }, [props.data]);

  const customStyles: any = {
    rows: {
      style: {
        minHeight: "52px", // override the row height
      },
    },
    headCells: {
      style: {
        paddingLeft: "8px", // override the cell padding for head cells
        paddingRight: "8px",
        display: "flex",
        justifyContent: "center",
        fontSize: theme.fontType.body.fontSize,
        fontWeight: theme.fontType.body.bold,
        borderTop: `1px solid ${theme.colors.gray5}`,
        cursor: "pointer",
      },
    },
    cells: {
      style: {
        paddingLeft: "8px", // override the cell padding for data cells
        paddingRight: "8px",
        display: "flex",
        justifyContent: "center",
        fontSize: theme.fontType.body.fontSize,
        fontWeight: theme.fontType.body.bold,
        cursor: "pointer",
      },
    },
  };

  return (
    <MainListBlock>
      {dataState.length > 0 ? (
        <DataTable
          columns={columnState}
          data={dataState}
          onRowClicked={(e) => (props.goPage ? props.goPage(e.id) : console.log(""))}
          customStyles={customStyles}
        />
      ) : (
        <div className="emptyList">해당 리스트가 없습니다.</div>
      )}
    </MainListBlock>
  );
}

export default MainList;

const MainListBlock = styled.div`
  height: 100%;
  .emptyList {
    width: 100%;
    /* height: 400px; */
    color: ${theme.colors.white};
    display: flex;
    justify-content: center;
    align-items: center;
  }
`;
