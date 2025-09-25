import { useNavigate } from "react-router";
import styled from "styled-components";
import { LandingContainer } from "../../../theme/common";
import SmallButton1 from "../../../components/Common/Button/SmallButton1";


export default function WaitingView() {
  const navigate = useNavigate();

  return (
     <Modal>
        <div className="alignWrap">
          <h2>알림</h2>
          <p>
            현재 평가중 입니다. <br />
            평가완료 후 하단 버튼을 눌러 이전화면으로 돌아가주세요
          </p>
          <SmallButton1 text="돌아가기" onClick={()=>{navigate(-1)}}/>
        </div>
      </Modal> 
  );
}

const Modal = styled.div`
  width : 100%;
  height: 100%;
  
  margin : auto;
  z-index: 9999999999;
  & > .alignWrap {
    margin : auto;
    display: flex;
    justify-content: center;
    flex-direction: column;
    height: 100%;
    background-color: #fff;
    border-radius: 15px;
    padding: 16px;
    & > h2 {
      font-size: 40px;
      line-height: 80px;
      text-align: center;
    }
    & > p {
      font-size: 25px;
      line-height: 40px;
      text-align: center;
    }
    & > button {
        width: 130px;
        margin: 30px auto;
    }
  }
`;