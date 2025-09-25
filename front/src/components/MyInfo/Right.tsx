import { IMyInfoChangeRes } from "../../interface/MyInfo/MyInfoResponse";
import DateUtils from "../../utils/DateUtils";
import { IIdentityFile, IPassbookFile } from "../../interface/Master/MasterRes";
import { IFile } from "../../controllers/Partners/Detail/Detail";
import list from "../../assets/Icon/list.svg";
import { Inputs } from "../Common/Input/Input";

export default function Right({
  agreementFileList,
  myInfoChangeInfoList,
  type,
  onDeleteClick,
  clickFileList,
  title,
}: {
  myInfoChangeInfoList?: IMyInfoChangeRes[];
  type?: string;
  agreementFileList?: [IIdentityFile, IPassbookFile];
  onDeleteClick?: () => void;
  clickFileList?: (file: IFile) => void;
  title: string;
}) {
  return (
    <div className="fileList">
      <Inputs.Label labelText={title} labelIcon={<img src={list} alt="리스트 아이콘" />} w={202} />
      <div className="scroll">
        <div className="scrollBox">
          <div className="tableBox">
            <table>
              <thead>
                {type === "agreement" ? (
                  <tr>
                    <th>파일종류</th>
                    <th>파일명</th>
                    <th></th>
                  </tr>
                ) : (
                  <tr>
                    <th className="num">번호</th>
                    <th className="date">변경일자</th>
                    <th>변경내용</th>
                  </tr>
                )}
              </thead>
              <tbody>
                <>
                  {type === "agreement"
                    ? agreementFileList?.map((el, i) => (
                        <tr key={i}>
                          <td>{i === 0 ? "신분증 사본" : "통장사본"}</td>
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
                          <td className="deleteBtn" onClick={onDeleteClick}>
                            X
                          </td>
                        </tr>
                      ))
                    : myInfoChangeInfoList?.reverse().map((el, i) => (
                        <tr key={i}>
                          <td>{i + 1}</td>
                          <td>{DateUtils.boardDateFormat(el?.changeAt)}</td>
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
