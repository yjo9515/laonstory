import React, { useEffect, useState } from "react";
import { useParams } from "react-router";
import { getAccountQRBlockApi, getAccountQRDocsApi } from "../../api/MasterApi";
import { useData, useSendData } from "../../modules/Server/QueryHook";
import AgreementQRView from "../../view/Agreement/AgreementQRView";

type FileType = {
  name: string;
  path: string;
};

export type BlockDataType = {
  blockNumber: string;
  transactionId: string;
  createdAt: string;
};

function AgreementQR() {
  const params = useParams();

  const [block, setBlock] = useState<BlockDataType>({
    blockNumber: "",
    transactionId: "",
    createdAt: "",
  });
  const [url, setUrl] = useState("");

  const uuid = params.uuid;

  const getQRPDF = useSendData<any, string>(getAccountQRDocsApi);

  const getQRBlock = useSendData<BlockDataType, string>(getAccountQRBlockApi);

  useEffect(() => {
    if (uuid) {
      getQRPDF.mutateAsync(uuid, {
        onSuccess(data: any) {
          // pdf 파일 띄워주기 위한 작업
          const file = new Blob([data.data], {
            type: "application/pdf",
          });
          const fileURL = URL.createObjectURL(file);
          setTimeout(() => {
            setUrl(fileURL);
          }, 2000);
        },
      });
      getQRBlock.mutateAsync(uuid, {
        onSuccess(data) {
          setBlock(data.data.data);
        },
      });
    }
  }, []);

  return <AgreementQRView url={url} block={block} uuid={uuid} />;
}

export default AgreementQR;
