import JoinView from "../../../view/Auth/Join/JoinView";
import Layout from "../../Common/Layout/Layout";

export default function Join() {
  return (
    <Layout
      notSideBar={true}
      notInfo={true}
      fullWidth
      loginWidth
      notHeadTitle
      notBackground
      logoColor
      useFooter
      notBackgroundSystem
      notHeader
    >
      <JoinView />
    </Layout>
  );
}
