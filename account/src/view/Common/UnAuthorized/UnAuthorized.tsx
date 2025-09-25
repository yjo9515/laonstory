// import Button from "components/common/Button";
import React from "react";
// import { useHistory } from "react-router";
import styled from "styled-components";

interface UnAuthorizedProps {
  title: string;
}

const UnAuthorized: React.FC<UnAuthorizedProps> = ({ title }) => {
  // const history = useHistory(); // 히스토리는 더이상 사용 안함 다른 메소드로 사용
  return (
    <UnAuthorizedBlock>
      <div>
        <h1>{title}</h1>
        {/* <Button
          theme={ThemeColor.primary}
          buttonSize="l"
          onClick={() => history.push("/")}
        >
          돌아가기
        </Button> */}
      </div>
    </UnAuthorizedBlock>
  );
};

export default UnAuthorized;

const UnAuthorizedBlock = styled.div`
  width: 100vw;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  & > div {
    text-align: center;
    h1 {
      margin-bottom: 2rem;
    }
  }
`;
