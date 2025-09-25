import React, { HTMLProps, useEffect, useState } from "react";
import styled from "styled-components";
import { useCallback } from "react";
import theme from "./../../theme/index";

interface PagingProps extends Omit<HTMLProps<HTMLDivElement>, "to"> {
  listAction: (page: number) => void;
  itemsCountPerPage: number;
  activePage: number | undefined | null;
  size?: number;
}

const PaginationComponent: React.FC<PagingProps> = ({
  listAction,
  itemsCountPerPage,
  activePage,
  size,
}) => {
  const [currentPageNum, setCurrentPageNum] = useState<number | null>(1);
  const [pageList, setPageList] = useState<Array<number> | null>(null);
  const [maxPage, setMaxPage] = useState<number>(0);

  useEffect(() => {
    setCurrentPageNum(activePage!);
    const curPage = Math.floor((currentPageNum! - 1) / 10) * 10;
    const curPages: Array<number> = [];
    for (let i = curPage; i <= curPage + 9; i++) {
      curPages.push(i + 1);
    }

    if (JSON.stringify(pageList) !== JSON.stringify(curPages)) {
      setPageList(curPages);
    }
    const max = Math.ceil(itemsCountPerPage || 0 / 10);
    setMaxPage(max);
  }, [activePage, currentPageNum, pageList, itemsCountPerPage]);

  const pageMove = useCallback(
    (page: number) => {
      if (page < 1) return;

      if (page <= maxPage) listAction(page);
      if (page > maxPage) listAction(maxPage);
    },
    [listAction, maxPage]
  );

  return (
    <PagingBlock>
      <div className="pagingWrapper">
        <div className={currentPageNum! <= 10 ? "leftBtn off" : "leftBtn on"}>
          <div
            className="oneArrow"
            onClick={() => {
              pageMove(currentPageNum! - 10);
            }}
          >
            {"<<"}
          </div>
        </div>
        <div className={currentPageNum! <= 1 ? "leftBtn off" : "leftBtn on"}>
          <div
            className="oneArrow"
            onClick={() => {
              pageMove(currentPageNum! - 1);
            }}
          >
            {"<"}
          </div>
        </div>
        <div className="centerNum">
          {pageList?.map((val: number, index) => (
            <React.Fragment key={index}>
              {val <= (maxPage > 1 ? maxPage : 1) && (
                <div
                  className={val === currentPageNum ? "onNumber" : ""}
                  onClick={() => pageMove(val)}
                >
                  {val}
                </div>
              )}
            </React.Fragment>
          ))}
        </div>
        <div className={currentPageNum! >= maxPage ? "rightBtn off" : "rightBtn on"}>
          <div
            className="oneArrow"
            onClick={() => {
              pageMove(currentPageNum! + 1);
            }}
          >
            {">"}
          </div>
        </div>
        <div className={currentPageNum! >= maxPage ? "rightBtn off" : "rightBtn on"}>
          <div
            className="oneArrow"
            onClick={() => {
              pageMove(currentPageNum! + 10);
            }}
          >
            {">>"}
          </div>
        </div>
      </div>
    </PagingBlock>
  );
};

export default PaginationComponent;

const PagingBlock = styled.div`
  display: flex;
  justify-content: space-between;
  .pagingInfoNumber {
    color: #999;
    font-size: 14px;
  }
  .pagingWrapper {
    width: auto;
    height: 36px;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    & > div {
      height: 100%;
      display: inline-block;
    }
    & > .leftBtn,
    .rightBtn {
      width: 25px;
      text-align: center;
      line-height: 36px;
      font-size: 14px;
      color: ${theme.colors.gray3};
      & > div {
        width: 100%;
        height: 100%;
      }
    }
    & > .off {
      opacity: 0.3;
      color: #333;
    }
    & > .on:hover {
      background-color: #eee;
      cursor: pointer;
    }
    & > .centerNum {
      width: auto;
      display: flex;
      justify-content: center;
      align-items: center;

      & > div {
        padding: 0.5rem 0.7rem;
        cursor: pointer;
        box-sizing: border-box;
        color: ${theme.colors.gray3};
        font-size: ${theme.fontType.pagenation.fontSize};
        font-weight: ${theme.fontType.pagenation.bold};
      }
      & > div:hover {
        background-color: rgba(200, 200, 200, 0.3);
      }
      & > .onNumber {
        color: ${theme.partnersColors.primary};
        font-size: ${theme.fontType.pagenationBold.fontSize};
        font-weight: ${theme.fontType.pagenationBold.bold};
      }
    }
  }
`;
