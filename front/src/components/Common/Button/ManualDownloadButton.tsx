import axios from "./../../../api/DefaultClient";
import styled from "styled-components";
import fileDownloadIcon from "./../../../assets/Icon/fileDownloadIcon.svg";

function ManualDownloadButton() {
  const onDownload = () => {
    axios
      .get(`manual`, {
        responseType: "blob",
      })
      .then((data) => {
        const fileURL = URL.createObjectURL(data.data);
        const a = document.createElement("a");
        a.href = fileURL;
        a.download = decodeURIComponent(data.headers["content-disposition"].split("UTF-8''")[1]);
        a.click();
        a.remove();
        URL.revokeObjectURL(fileURL);
      })
      .catch((e) => {
        console.log(e);
      });
  };

  return (
    <ManualDownloadButtonBlock onClick={onDownload}>
      <button>
        <span>이용 매뉴얼 다운로드</span>
        <span>
          <img src={fileDownloadIcon} alt="" />
        </span>
      </button>
    </ManualDownloadButtonBlock>
  );
}

export default ManualDownloadButton;

const ManualDownloadButtonBlock = styled.div`
  width: 100%;
  height: auto;
  cursor: pointer;
  display: flex;
  justify-content: center;

  & > button {
    display: flex;
    justify-content: flex-start;
    align-items: center;

    & > span:first-child {
      color: #12166d;
      font-weight: 700;
      margin-right: 3px;
      font-size: 16px;
    }
    & > span:last-child {
      position: relative;
      & > img {
        position: absolute;
        top: -10px;
        width: 20px;
      }
    }
  }
`;
