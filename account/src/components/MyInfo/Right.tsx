import { IMyInfoChangeRes } from "../../interface/MyInfo/MyInfoResponse";
import DateUtils from "../../utils/DateUtils";
import {
  ICertificateFile,
  IEtcFile,
  IIdentityFile,
  IPassbookFile,
} from "../../interface/Master/MasterRes";
import { IFile } from "../../controllers/Partners/Detail/Detail";
import list from "../../assets/Icon/list.svg";
import { Fragment } from "react";

export default function Right({
  agreementFileList,
  myInfoChangeInfoList,
  role,
  onDeleteClick,
  clickFileList,
  title,
}: {
  myInfoChangeInfoList?: IMyInfoChangeRes[];
  role?: string;
  agreementFileList?: [IIdentityFile, IPassbookFile, ICertificateFile, IEtcFile];
  onDeleteClick?: () => void;
  clickFileList?: (file: IFile) => void;
  title: string;
}) {
  const companyFileListName = ["사업자등록증 사본", "통장 사본", "인감증명서 사본", "기타"];
  const personalFileListName = ["신분증 사본", "통장 사본", "기타"];

  return (
    <div className="fileList">
      <div>
        <label>
          {<img src={list} alt="아이콘" />}
          {title}
        </label>
      </div>
      <div className="scroll">
        <div className="scrollBox">
          <div className="tableBox">
            <table>
              <thead>
                {role === "agreement" && (
                  <tr>
                    <th>파일종류</th>
                    <th>파일명</th>
                  </tr>
                )}
                {(role === "personal" || role === "company") && (
                  <tr>
                    <th>번호</th>
                    <th>변경일시</th>
                    <th>내용</th>
                  </tr>
                )}
              </thead>
              <tbody>
                <>
                  {role === "agreement"
                    ? agreementFileList?.map((el, i) => (
                        <Fragment key={i}>
                          {!!el && (
                            <tr>
                              <td>
                                {agreementFileList[2]
                                  ? companyFileListName[i]
                                  : personalFileListName[i]}
                              </td>
                              <td
                                className="file"
                                onClick={
                                  clickFileList &&
                                  (() =>
                                    clickFileList({
                                      path: el?.fileUrl,
                                      name: el?.fileName,
                                    }))
                                }
                              >
                                {el?.fileName}
                              </td>
                            </tr>
                          )}
                        </Fragment>
                      ))
                    : myInfoChangeInfoList?.reverse().map((el, i) => (
                        <tr key={i}>
                          <td>{i + 1}</td>
                          <td>{DateUtils.listDateFormat(el?.changeAt)}</td>
                          <td>{el?.changeType}</td>
                        </tr>
                      ))}
                </>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
}
