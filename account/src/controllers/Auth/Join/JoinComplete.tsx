import JoinCompleteView from "../../../view/Auth/Join/JoinCompleteView";
import Layout from "../../Common/Layout/Layout";

export default function JoinComplete() {
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
      <JoinCompleteView />
    </Layout>
  );
}
