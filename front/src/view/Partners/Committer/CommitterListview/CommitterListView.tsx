import { UseFormRegister, UseFormWatch } from "react-hook-form";
import styled from "styled-components";
import { ViewObjectWrapperBox } from "../../../../theme/common";
import SmallButton1 from "../../../../components/Common/Button/SmallButton1";
import SearchList from "../../../../components/Common/SearchList/SearchList";
import ListComponent from "../../../../components/List/ListComponent/ListComponent";
import { columns } from "./ListColumnName";
import {
  IAlertModalDefault,
  IContentModalDefault,
} from "../../../../modules/Client/Modal/Modal";
import theme from "../../../../theme";
import { CommitterAdd } from "../../../../interface/Partners/Committer/CommitterTypes";
import {
  ICommitterListResItem,
  meta,
} from "../../../../interface/List/ListResponse";
import CommitterModal from "../../../../components/Modal/Committer/CommitterModal";
import InputSet1 from "../../../../components/Common/Input/InputSet1";
import { GridCellParams } from "@mui/x-data-grid";
import { IInviteCommitter } from "../../../../interface/Master/MasterData";
import { Regex } from "../../../../utils/RegularExpression";
import {
  ICommitterInvitation,
  IDuplicateUserData,
} from "../../../../interface/Auth/ApiDataInterface";
import { useSendData } from "../../../../modules/Server/QueryHook";
import {
  committerInvitation,
  duplicateUserCheck,
} from "../../../../api/AuthApi";

interface CommitterListViewTypes {
  data: ICommitterListResItem[];
  meta?: meta;
  role: string;
  authority: string;
  pageState: { page: number; search: string };
  onPageMove: (page: number) => void;
  onSearchContent: (search: string) => void;
  onRefetch: () => void;
  onReflesh: () => void;
  setContentModal: (data: IContentModalDefault) => void;
  setAlertModal: (data: IAlertModalDefault) => void;
  resetModal: () => void;
  onInviteCommitter: (data: IInviteCommitter) => void;
  watch: UseFormWatch<CommitterAdd>;
  register: UseFormRegister<CommitterAdd>;
  search: string;
  onCommitterListRefetch: () => void;
  onReset: () => void;
}

function CommitterListView(props: CommitterListViewTypes) {
  const goPosition = (id: number) => {};

  const invitation = useSendData<boolean, ICommitterInvitation>(
    committerInvitation
  );

  // 평가위원 상세
  const goInfo = (id: string, e?: GridCellParams) => {
    props.setContentModal({
      isModal: true,
      title: "평가위원",
      subText: <p>평가위원의 정보를 확인해주세요.</p>,
      content: (
        <CommitterModal
          onCommitterListRefetch={props.onCommitterListRefetch}
          data={e?.row}
        />
      ),
    });
  };

  // 평가위원 등록
  const onAddCommitterModal = () => {
    props.setContentModal({
      isModal: true,
      title: "평가위원 추가",
      subText: (
        <p
          style={{
            textAlign: "center",
            lineHeight: theme.fontType.bodyLineHeight.lineHeight,
          }}
        >
          평가위원의 정보를 입력해주세요.
        </p>
      ),
      content: <CommitterAddInput register={props.register} />,
      buttonText: "저장",
      onClick: () => {
        const email = props.watch("email");
        const phone = props.watch("phone");
        const name = props.watch("name");
        const birth = props.watch("birthday");

        if (String(birth).length !== 8) {
          props.setAlertModal({
            isModal: true,
            type: "error",
            content: "생년월일 8자리를 정확하게 입력해 주세요.",
            title: "생년월일이 올바르게 입력되지 않았습니다.",
          });
        } else {
          if (name && birth && phone) {
            props.onInviteCommitter({
              email,
              phone,
              name,
              birth,
            });
          } else {
            props.setAlertModal({
              isModal: true,
              type: "error",
              content: "추가하려는 평가위원의 정보를 입력해 주세요.",
              title: "입력한 정보가 없습니다.",
            });
          }
        }
      },
      onClose: () => {
        props.onReset();
      },
    });
  };

  // 평가위원 초대
  const onInvitationCommitterModal = () => {
    props.setContentModal({
      isModal: true,
      title: "평가위원 초대",
      subText: (
        <p
          style={{
            textAlign: "center",
            lineHeight: theme.fontType.bodyLineHeight.lineHeight,
          }}
        >
          평가위원의 정보를 입력해주세요.
        </p>
      ),
      content: <CommitterInvitationInput register={props.register} />,
      buttonText: "저장",
      onClick: () => {
        const email = props.watch("email");
        invitation.mutate(
          { email: email },
          {
            // 성공 시 이메일 인증 모달 띄우기
            onSuccess(res) {
              props.resetModal();
              props.setAlertModal({
                isModal: true,
                content: "초대장을 보냈습니다.",
              });
            },
          }
        );
        props.onReset();
      },
      onClose: () => {
        props.onReset();
      },
    });
  };

  return (
    <>
      <CommitterListViewBlock>
        <ViewObjectWrapperBox>
          <h1 className="viewTitle">평가위원 목록</h1>
          <div className="searchBox">
            {props.role === String(process.env.REACT_APP_ROLE_ADMIN) && (
              <div className="btnWrap" style={{ gap: "10px", display: "flex" }}>
                <SmallButton1
                  text="평가위원 초대 +"
                  onClick={onInvitationCommitterModal}
                />
                {/* <SmallButton1
                  text="평가위원 추가 +"
                  onClick={onAddCommitterModal}
                /> */}
              </div>
            )}
            <SearchList
              onSearch={props.onRefetch}
              onReflesh={props.onReflesh}
              searchValue={props.search}
              onSearchContent={props.onSearchContent}
            />
          </div>
          <div className="listWrapper">
            <ListComponent
              columns={columns}
              rows={props.data}
              page={props.pageState.page}
              meta={props.meta}
              goPosition={goPosition}
              goInfo={goInfo}
              onPageMove={props.onPageMove}
              pageType="partners"
              cellClick
            />
          </div>
        </ViewObjectWrapperBox>
      </CommitterListViewBlock>
    </>
  );
}

export default CommitterListView;

const CommitterListViewBlock = styled.div``;

export interface CommitterAddInputTypes {
  register: UseFormRegister<CommitterAdd>;
}

export function CommitterAddInput(props: CommitterAddInputTypes) {
  return (
    <CommitterAddInputBlock>
      <InputSet1
        type="text"
        label="이름"
        placeholder="이름을 입력해 주세요."
        register={props.register("name", { required: "이름을 입력해주세요." })}
      />
      <InputSet1
        type="text"
        label="생년월일"
        placeholder="생년월일을 입력해 주세요. (ex: 20220101)"
        register={props.register("birthday", {
          required: "생년월일을 입력해주세요.",
          pattern: {
            value: Regex.numberRegex,
            message: "숫자만 입력해주세요.",
          },
        })}
      />
      <InputSet1
        type="text"
        label="휴대폰 번호"
        placeholder="숫자만 입력해 주세요.(ex: 01012345678)"
        register={props.register("phone", {
          required: "휴대폰 번호를 입력해 주세요.",
          pattern: {
            value: Regex.phoneRegExp,
            message: "알맞은 형식의 휴대폰 번호를 숫자만 입력하세요.",
          },
        })}
      />
      <InputSet1
        type="text"
        label="이메일(선택)"
        placeholder="이메일을 입력해 주세요."
        register={props.register("email", {
          required: "이메일을 입력해 주세요.",
          pattern: {
            value: Regex.emailRegex,
            message: "알맞은 형식의 이메일을 입력하세요.",
          },
        })}
      />
    </CommitterAddInputBlock>
  );
}

function CommitterInvitationInput(props: CommitterAddInputTypes) {
  return (
    <CommitterAddInputBlock>
      <InputSet1
        type="text"
        label="이메일"
        placeholder="이메일을 입력해 주세요."
        register={props.register("email", {
          required: "이메일을 입력해 주세요.",
          pattern: {
            value: Regex.emailRegex,
            message: "알맞은 형식의 이메일을 입력하세요.",
          },
        })}
      />
    </CommitterAddInputBlock>
  );
}

const CommitterAddInputBlock = styled.div`
  width: 752px;
  height: 320px;
  margin-top: 64px;
  display: flex;
  flex-direction: column;
  gap: 28px;
`;
