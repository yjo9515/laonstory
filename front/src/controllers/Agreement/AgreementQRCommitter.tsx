import React, { useEffect, useState } from "react";
import { useParams } from "react-router";
import {
  getAccountQRBlockApi,
  getAccountQRDocsApi,
  getCommitterQrBlockApi,
  getCommitterQrDocsApi,
} from "../../api/MasterApi";
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

function AgreementQRCommitter() {
  const params = useParams();

  const [block, setBlock] = useState<BlockDataType>({
    blockNumber: "",
    transactionId: "",
    createdAt: "",
  });

  const [committers, setCommitters] = useState<CommitterInfo | null>(null);

  const [url, setUrl] = useState("");

  const evaluationRoomId: number = Number(params.evaluationRoomId);

  const committerId: number = Number(params.committerId);

  const getQRPDF = useSendData<any, { evaluationRoomId: number; committerId: number }>(
    getCommitterQrDocsApi
  );

  const getQRBlock = useSendData<BlockDataType, { evaluationRoomId: number; committerId: number }>(
    getCommitterQrBlockApi
  );

  useEffect(() => {
    if (evaluationRoomId && committerId) {
      const data: { evaluationRoomId: number; committerId: number } = {
        evaluationRoomId,
        committerId,
      };

      getQRPDF.mutateAsync(data, {
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
      getQRBlock.mutateAsync(data, {
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

  return <AgreementQRView url={url} block={block} committers={committers} qrScoreType={true} />;
}

export default AgreementQRCommitter;
