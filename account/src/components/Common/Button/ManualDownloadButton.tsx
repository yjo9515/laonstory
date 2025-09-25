import axios from "./../../../api/DefaultClient";
import styled from "styled-components";
import fileDownloadIcon from "./../../../assets/Icon/fileDownloadIcon.svg";
import theme from "../../../theme";

function ManualDownloadButton({ type }: { type?: "user" | "admin" }) {
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

  const goMenualPlayer = () => {
    window.open(
      "http://wtube.iwest.co.kr//contents/contentsView.do?contentsId=2281&categorySeq=15",
      "_blank"
    );
  };

  return (
    <>
      {type === "admin" && (
        <ManualBlock>
          <ManualDownloadButtonBlock onClick={goMenualPlayer}>
            <button>
              <span>동영상 메뉴얼 바로가기</span>
              <span>{/* <img src={fileDownloadIcon} alt="" /> */}</span>
            </button>
          </ManualDownloadButtonBlock>
          <ManualDownloadButtonBlock onClick={onDownload}>
            <button>
              <span>이용 매뉴얼 다운로드</span>
              <span>
                <img src={fileDownloadIcon} alt="" />
              </span>
            </button>
          </ManualDownloadButtonBlock>
        </ManualBlock>
      )}
      {type === "user" && (
        <ManualDownloadButtonBlock2 onClick={onDownload}>
          <button>
            <span>이용 매뉴얼 다운로드</span>
            <span>
              <img src={fileDownloadIcon} alt="" />
            </span>
          </button>
        </ManualDownloadButtonBlock2>
      )}
    </>
  );
}

export default ManualDownloadButton;

const ManualBlock = styled.div`
  width: 100%;
  height: 60px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
`;

const ManualDownloadButtonBlock = styled.div`
  width: 100%;
  padding-bottom: 5px;
  height: auto;
  cursor: pointer;
  border-bottom: 1px solid ${theme.colors.gray5};

  & > button {
    display: flex;
    justify-content: flex-start;
    align-items: center;

    & > span:first-child {
      color: #12166d;
      font-weight: 700;
      /* margin-right: 3px; */
      font-size: 14px;
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

const ManualDownloadButtonBlock2 = styled.div`
  width: 100%;
  padding-bottom: 5px;
  height: auto;
  cursor: pointer;

  & > button {
    display: flex;
    justify-content: flex-start;
    align-items: center;

    & > span:first-child {
      color: #12166d;
      font-weight: 700;
      /* margin-right: 3px; */
      font-size: 14px;
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
