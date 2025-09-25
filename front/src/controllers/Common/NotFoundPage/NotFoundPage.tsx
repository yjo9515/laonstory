import { useNavigate } from "react-router";
import { useRecoilValue } from "recoil";
import styled from "styled-components";
import BigButton from "../../../components/Common/Button/BigButton";
import { userState } from "../../../modules/Client/Auth/Auth";
import theme from "../../../theme";
import { setCookie } from "../../../utils/ReactCookie";
import RoleUtils from "../../../utils/RoleUtils";
import Layout from "../Layout/Layout";

interface NotFoundPageTypes {
  prevPage?: boolean;
}

function NotFoundPage(props: NotFoundPageTypes) {
  const navigate = useNavigate();
  const userData = useRecoilValue(userState);

  const goPage = () => {
    if (RoleUtils.getRole(userData.role) === "admin") {
      navigate("/west/system/dashboard", { replace: true });
      return;
    }
    if (RoleUtils.getRole(userData.role) === "user") {
      navigate("/", { replace: true });
      return;
    }

    navigate("/", { replace: true });
  };

  return (
    <NotFoundPageBlock>
      <p>페이지 없음</p>
      <BigButton text="첫 페이지로 이동" onClick={goPage} />
    </NotFoundPageBlock>
  );
}

export default NotFoundPage;

const NotFoundPageBlock = styled.div`
  position: absolute;
  top: 50%;
  left: 50%;
  width: 500px;
  height: 200px;
  transform: translate(-50%, -50%);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  & > p {
    font-size: ${theme.fontType.headline.fontSize};
    font-weight: ${theme.fontType.headline.bold};
    margin-bottom: ${theme.commonMargin.gap1};
  }
`;
