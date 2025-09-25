import React from "react";
import styled from "styled-components";
import theme from "../../../theme";
import ReflashIcon from "../../../assets/Icon/reflash.svg";
import Search from "../../../assets/Icon/Search";

interface SearchListTypes {
  onSubmit?: any;
  onSearch: () => void;
  onReflesh: () => void;
  searchValue: string;
  onSearchContent: (search: string) => void;
  placeholder?: string;
  search?: string;
}

function SearchList(props: SearchListTypes) {
  return (
    <SearchListBlock
      onSubmit={(e) => {
        e.preventDefault();
        props.onSearch();
      }}
    >
      <div className="reflash" onClick={props.onReflesh}>
        <img src={ReflashIcon} alt="" />
      </div>
      <div className="search">
        <input
          type="text"
          name="search"
          value={props.search}
          onChange={(e) => props.onSearchContent(e.target.value)}
          placeholder={props.placeholder || "검색해주세요."}
        />
        <div className="searchIcon" onClick={props.onSearch}>
          <Search />
        </div>
      </div>
      {/* <SmallButton1 text="검색" onClick={props.onSearch} /> */}
    </SearchListBlock>
  );
}

export default SearchList;

const SearchListBlock = styled.form`
  width: 480px;
  height: 40px;
  overflow: hidden;
  display: flex;
  justify-content: space-between;
  align-items: center;
  & > .reflash {
    width: 40px;
    height: 100%;
    background-color: ${theme.colors.blueGray2};
    margin-right: ${theme.commonMargin.gap4};
    border-radius: ${theme.commonInput.radius};
    cursor: pointer;
    color: #fff;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  & > .search {
    flex: 1;
    height: 100%;
    position: relative;
    & > input {
      width: 100%;
      height: 100%;
      border: ${theme.commonInput.border};
      border-radius: ${theme.commonInput.radius};
      padding-left: ${theme.commonInput.paddingLeft};
      font-size: ${theme.fontType.input1.fontSize};
      font-weight: ${theme.fontType.input1.bold};
      &::placeholder {
        color: ${theme.commonInput.placeholderColor};
      }
    }
    & > .searchIcon {
      position: absolute;
      top: 50%;
      right: 14px;
      transform: translateY(-50%);
      cursor: pointer;
    }
  }
`;
