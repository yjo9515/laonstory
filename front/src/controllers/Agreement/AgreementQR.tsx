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
  committerInfo?: CommitterInfo;
};

export interface CommitterInfo {
  success: boolean;
  transactionId: string;
  data: Datum[];
  blockNumber: string;
}

export interface Datum {
  created_at: Date;
  evdata: string;
  evroomid: string;
  evuserid: string;
  updated_at: Date;
}

function AgreementQR() {
  const params = useParams();

  const [block, setBlock] = useState<BlockDataType>({
    blockNumber: "",
    transactionId: "",
    createdAt: "",
  });

  const [committers, setCommitters] = useState<CommitterInfo | null>(null);

  const [url, setUrl] = useState("");

  const evaluationRoomId = params.id;

  const getQRPDF = useSendData<any, string>(getAccountQRDocsApi);

  const getQRBlock = useSendData<BlockDataType, string>(getAccountQRBlockApi);

  useEffect(() => {
    if (evaluationRoomId) {
      getQRPDF.mutateAsync(evaluationRoomId, {
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
      
      getQRBlock.mutateAsync(evaluationRoomId, {
        onSuccess(data) {
          const block = {
            blockNumber: data.data.data.blockNumber,
            transactionId: data.data.data.transactionId,
            createdAt: data.data.data.createdAt,
          };
          setBlock(block);
          setCommitters(data.data.data.committerInfo ?? null);
        },
      });
    }
  }, []);

  return <AgreementQRView url={url} block={block} committers={committers} />;
}

export default AgreementQR;
