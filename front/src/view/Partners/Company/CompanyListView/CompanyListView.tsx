import { ViewObjectWrapperBox } from "../../../../theme/common";
import styled from "styled-components";
import { useNavigate } from "react-router";
import SearchList from "../../../../components/Common/SearchList/SearchList";
import ListComponent from "../../../../components/List/ListComponent/ListComponent";
import { columns } from "./ListColumnName";
import { ICompanyListResItem, meta } from "../../../../interface/List/ListResponse";
import SmallButton1 from "../../../../components/Common/Button/SmallButton1";
import { IAlertModalDefault, IContentModalDefault } from "../../../../modules/Client/Modal/Modal";
import { UseFormRegister, UseFormWatch } from "react-hook-form";
import { CompanyAdd } from "../../../../interface/Partners/Company/CompanyTypes";
import InputSet1 from "../../../../components/Common/Input/InputSet1";
import { Regex } from "../../../../utils/RegularExpression";
import theme from "../../../../theme";
import { IInviteCompany } from "../../../../interface/Master/MasterData";
import { watch } from "fs";
import { getCookie } from "../../../../utils/ReactCookie";
import { default as jwtDecode } from 'jwt-decode';
import { parseJwt } from "../../../../utils/jwt";

interface CompanyListViewTypes {
  data: ICompanyListResItem[];
  meta?: meta;
  role: string;
  authority: string;
  pageState: { page: number; search: string };
  onPageMove: (page: number) => void;
  onSearchContent: (search: string) => void;
  onRefetch: () => void;
  onReflesh: () => void;
  onInviteCompany: (data: IInviteCompany) => void;
  watch: UseFormWatch<CompanyAdd>;
  register: UseFormRegister<CompanyAdd>;
  search: string;
  setContentModal: (data: IContentModalDefault) => void;
  setAlertModal: (data: IAlertModalDefault) => void;
  onReset: () => void;
}

function CompanyListView(props: CompanyListViewTypes) {
  const navigate = useNavigate();

  const goPosition = (id: number) => {
    navigate(`/${props.role}/system/evaluation-room/proceed/${id}`);
  };

  const goInfo = (id: number) => {
    navigate(`/west/system/company/${id}`);
  };

  const onAddCompanyModal = () => {
    props.setContentModal({
      isModal: true,
      title: "제안업체 추가",
      subText: (
        <p
          style={{
            textAlign: "center",
            lineHeight: theme.fontType.bodyLineHeight.lineHeight,
          }}
        >
          제안업체의 정보를 입력해주세요.
        </p>
      ),
      content: <CompanyAddInput register={props.register} />,
      buttonText: "저장",
      onClick: () => {
        const data: CompanyAdd = {
          companyName: props.watch("companyName"),
        };

        if (!data.companyName) {
          props.setAlertModal({
            isModal: true,
            type: "error",
            content: "제안업체 이름을 입력해주세요.",
            title: "필수 입력 사항을 입력해 주세요.",
          });
          return;
        }
        const token = getCookie('token');
        const manager = parseJwt(token).sub;
        data.manager = manager;        
        props.onInviteCompany(data);
      },
      onClose: () => {
        props.onReset();
      },
    });
  };

  return (
    <CompanyListViewBlock>
      <ViewObjectWrapperBox>
        <h1 className="viewTitle">제안업체 목록</h1>
        <div className="searchBox">
          {props.role === String(process.env.REACT_APP_ROLE_ADMIN) && (
            <div className="btnWrap">
              <SmallButton1 text="제안업체 추가 +" onClick={onAddCompanyModal} />
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
            pageType={"partners"}
            cellClick
          />
        </div>
      </ViewObjectWrapperBox>
    </CompanyListViewBlock>
  );
}

export default CompanyListView;

const CompanyListViewBlock = styled.div``;

interface CompanyAddInputTypes {
  register: UseFormRegister<CompanyAdd>;
}

function CompanyAddInput(props: CompanyAddInputTypes) {
  return (
    <CompanyAddInputBlock>
      <InputSet1
        type="text"
        label="업체명"
        placeholder="업체명을 입력해주세요."
        register={props.register("companyName", { required: "업체명을 입력해주세요." })}
      />
      <div className="textBox">
        <p>제안업체가 참여하지 않는 평가에만 사용됩니다.</p>
        <p>* 제안발표가 필요한 제안업체는 회원가입을 통해 직접 가입해야 합니다.</p>
      </div>
      <div className="guide">
        <div>
          <span>{"<안내>"}</span>
          <p>
            * 연락처, 이메일이 표시되지 않는 제안업체는 서부 평가담당자가 등록한 업체이며 실제
            제안업체 이용자가 아닙니다.
          </p>
          <p>* 제안업체가 참여해야 하는 경우 참여할 업체는 회원가입을 진행해야합니다.</p>
          <p>
            * 가입 요청된 제안업체는 서부 평가담당자의 가입 승인 완료 후 참여할 수 있으며 평가방
            개설에 추가할 수 있습니다.
          </p>
        </div>
      </div>
    </CompanyAddInputBlock>
  );
}

const CompanyAddInputBlock = styled.div`
  width: 752px;
  height: 400px;
  margin-top: 64px;
  display: flex;
  flex-direction: column;
  gap: 28px;

  & > .textBox {
    width: 100%;
    min-height: 30px;
    text-align: center;
    & > p {
      margin-bottom: 4px;
      font-size: 14px;
    }
    & > p:nth-child(2) {
      color: ${theme.colors.red};
    }
  }

  & > .guide {
    display: flex;
    justify-content: center;
    & > div {
      width: 650px;
      & > span {
        display: block;
        color: ${theme.colors.red};
        margin-bottom: 4px;
      }
      & > p {
        margin-bottom: 4px;
        font-size: 14px;
        color: ${theme.colors.red};
      }
    }
  }
`;
