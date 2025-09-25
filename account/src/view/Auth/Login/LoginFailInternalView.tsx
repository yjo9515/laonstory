import styled from "styled-components";

export default function LoginFailInternalView() {
  return (
    <LoginFailInternalViewBlock>
      <div className="wrapper">
        <h1>계좌등록시스템 페이지에 연결할 수 없습니다.</h1>
        <ul>
          <li>• 인터넷 연결을 확인해주세요.</li>
          <li>{`• 문제가 지속될 경우 담당 부서로 문의해 주세요. (담당 부서: ICT총괄실)`}</li>
        </ul>
      </div>
    </LoginFailInternalViewBlock>
  );
}

const LoginFailInternalViewBlock = styled.div`
  width: 100%;
  height: 100vh;
  display: flex;

  justify-content: center;
  align-items: center;
  & > .wrapper {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
    & > h1 {
      color: #5c87e8;
      font-size: 40px;
    }
    & > ul {
      font-size: 20px;
      margin-top: 50px;
      padding-left: 30px;
    }
  }
`;
