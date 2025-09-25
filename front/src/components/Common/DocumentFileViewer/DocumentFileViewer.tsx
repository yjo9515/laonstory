import { DocumentViewer } from "react-documents";
// import testPdf from "./../../../assets/testxlsx.xlsx";

const docs = [
  { uri: "https://www.orimi.com/pdf-test.pdf" },
  {
    uri: "https://www.ets.org/Media/Tests/GRE/pdf/gre_research_validity_data.pdf",
  },
  { uri: require("../../../assets/testxlsx.xlsx") }, // Local File
];

function DocumentFileViewer() {
  return (
    <>
      <DocumentViewer
        queryParams="hl=ko"
        url={docs[1].uri}
        viewerUrl={"https://docs.google.com/gview?url=%URL%&embedded=true"}
        viewer={"url"}
        overrideLocalhost="https://react-doc-viewer.firebaseapp.com/"
      ></DocumentViewer>
    </>
  );
}

export default DocumentFileViewer;
