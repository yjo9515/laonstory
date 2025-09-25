# 한국서부발전 제안서평가시스템

#### `React` version: 18.2.0

#### `Node.js` version: 18.12.1

# Skill

### 주요 스킬

TypeScript, React, React Hook, React-Router-dom, Axios, Styled-Component, Recoil, React-Query

### 라이브러리

pdf.js, react-pdf-viewer, pdf.worker.js, html-react-parser, react-quill, mui, react-hook-form, lottie-player, React-Cookie

# git push

해당 프로젝트는 git `main` 브런치에 push 하시면 됩니다.

# Package

- 패키지매니저로 `yarn`을 사용하고 있습니다.
- 프로젝트 로컬 실행: `yarn start`
  - 이 프로젝트는 로컬 실행시 실행 포트는 `3002`로 고정입니다.
  - 변경이 필요할 경우 `package.json` 파일의 `scripts`에서 start 실행 명령어를 보시면 `export PORT=3002 && react-scripts start`가 있습니다. 여기서 `PORT`를 원하시는 포트번호로 변경하시면 됩니다.
- 프로젝트 빌드: `yarn build`

# Build 및 배포 시 주의사항

### env

##### `.env.development` 로컬 환경에서 작업 및 테스트 시 사용

##### `.env.production` 빌드 시 이곳에 입력된 정보를 통해 빌드됨

- `REACT_APP_SOURCE_DISTRIBUTE` 값을 통해 내부망 외부망 설정을 합니다. env에 내부망용 외부망용으로 주석이 되어 있습니다.
  - 외부망: OUTSIDE / 내부망: INTERNAL
- `REACT_APP_REFETCH_TIME` 평가방에서 사용되는 리패치 시간입니다. 평가방은 실시간 통신으로 진행되는 것이 아닌 여기에서 지정한 시간마다 api 호출하여 각 서비를 이용하는 유저들과 싱크를 맞춥니다.
- `REACT_APP_PROCEED_TIMER` 평가방에서 타이머를 시작 및 정지 시킬 경우 오차를 줄이기 위해 강제적으로 debounce 처리를 하기 위한 지연 시간입니다.
- `REACT_APP_BASE_URL`, `REACT_APP_RESOURCE_URL` api 호출 url로 내부망, 외부망 구분이 있습니다.

### 빌드 순서

- 배포를 진행할 경우 내부망과 외부망으로 구분하여 두번 빌드를 진행합니다.
- 내부망을 빌드할 경우 외부망과 관련되 정보를 주석해 주시고 외부망을 빌드할경우 내부망을 주석해 주시고 진행해주세요.
- 먼저 내부망으로 빌드를 시작했을 경우 빌드가 완료가 되면 빌드된 파일을 압축해주세요.
- 이후 외부망으로 빌드를 한 뒤 동일하기 압축을 진행합니다.
- 압축된 파일들은 각각 영문명이 존재하며 아래 설명한 규칙으로 압축파일 이름을 변경해주세요.
- 아래 규칙대로 이름을 변경한 압축파일은 슬랙의 `한국서부발전_유지보수` 채널에 올려주시면 됩니다.

##### 빌드 된 파일 이름 규칙

- 내부망 -> iwest-west-block-빌드한 날짜 (ex: iwest-west-block-240111)
- 외부망 -> iwest-int-block-빌드한 날짜 (ex: iwest-int-block-240111)

### 내부망 이슈로 인한 배포 주의

- 현재 리액트의 index.html이 있는 `public` 폴더에는 `animation`폴더와 `pdf.worker.js` 파일이 있습니다.
- 이 두가지는 기존에는 외부통신으로 사용되었던 라이브러리였지만 한국서부발전의 내부망에선 해당 정보를 불러올 수 없기 때문에 별도로 파일을 가지고 있습니다.
- 이미 `public` 폴더에 담겨있기 때문에 빌드를 하게 된다면 무조건 포함이 되지만 혹시라도 누락이 될 경우 `Loading`이나 `Viewer`에서 문제가 발생이 되므로 주의해주세요.

# 폴더 구조

### 구성된 폴더 구성 설명

- `Flux 패턴`을 기준으로 프로젝트가 구성되어 있습니다.
- controllers 당 하나의 페이지를 관리합니다.
- 각 controllers 당 1개의 view 컴포넌트를 가집니다. 이 view는 컴포넌트를 조합하기 위한 전체 페이지로 사용하며 각 화면들을 컨트롤 합니다.
- view 컴포넌트는 여러개의 components 폴더의 컴포넌트들을 가집니다.
- 페이지마다 1개의 controllers 가지고 그 아래 1개의 view를 가지며 그 아래 여러개의 부속 components를 가집니다.

## api

- 각 api 마다 사용목적을 주석으로 달아두었습니다.
- MasterApi.ts 외에 api 파일 중 api 주소에 'master'가 포함된 api들은 평가담당자가 사용하는 api 입니다.

##### `DefaultClient.ts` - 아래의 각 api들 호출 공통코드 ( 공통으로 사용되는 api url 부분이나 토큰 적용 등 )

##### `AuthApi.ts` - 평가위원, 제안업체의 회원가입 및 아이디 찾기, SSO 로그인 등 유저 관련 api

##### `DashboardApi.ts` - 평가담당자 계정 대시보드 화면 관련 api

##### `EvaluationRoomApi.ts` - 평가담당자의 평가방 생성, 수정 및 평가방에서 평가 진행 시 사용하는 api

##### `EvaluationTableApi.ts` - 평가담당자가 평가항목표를 작성할 때 사용하는 api

##### `ListApi.ts` - 평가담당자가 확인하는 평가위원, 제안업체 리스트 api

##### `MasterApi.ts` - 평가담당자만 사용하는 api

##### `MyInfoApi.ts` - 평가위원, 제안업체의 내 정보 관련 api

## assets

- 프로젝트에서 사용한 아이콘 및 이미지 등을 모아둔 폴더 입니다.

## controllers

- controllers 는 주로 react-query를 통해 api를 호출하며 넘겨받은 데이터를 관리합니다.
- controllers 폴더에는 목적없는 XML을 사용하지 않습니다.
- 평가방을 제외한 나머지는 Layout 컴포넌트로 감싸져 있습니다.
- 각 상태값 및 함수들에 주석이 달려 있습니다.

#### Agreement

- 평가가 끝나고 생성되는 서류의 QR코드로 접근하는 페이지의 컨트롤러 폴더 입니다.

#### Auth

- 회원가입, 로그인 관련 페이지의 컨트롤러 폴더 입니다.

#### Common

- 모든 화면에서 공통적으로 사용하는 페이지 파트의 컨트롤러 폴더 입니다.

##### `Layout` - 평가방을 제외한 모든 화면에서 공통적으로 사용하는 부모 컨트롤러 이며 공통적으로 사용하는 Header와 Footer, SideBar를 포함하고 있습니다.

##### `NotFoundPage` - Router에서 처리되지 않았을 경우 보여주는 컨트롤러 입니다.

##### `SideBar` - 사이드바 입니다. 아래 view 컴포넌트에서 권한에 따른 랜더링을 분리하기 위한 구분을 가집니다.

#### Partners

- 대시보드, 내 정보, 약관설정 등의 평가와 관련되지 않은 페이지의 컨트롤러 폴더 입니다.

##### `Committer` - 평가위원 리스트 컨트롤러 입니다.

##### `Company` - 제안업체 리스트 컨트롤러 입니다.

##### `Dashboard` - 대시보드 컨트롤러 입니다.

##### `Detail` - 리스트 화면들의 상세화면 컨트롤러 입니다.

##### `MyInfo` - 내 정보 컨트롤러 입니다.

##### `Terms` - 약관설정에 관련된 컨트롤러 입니다.

#### System

- 평가방, 평가항목표 작성 등 평가와 관련된 페이지의 컨트롤러 폴더 입니다.

##### `CreateWebexRoom` - 백엔드와 호환하여 Webex라는 화상미팅 서비스에서 미팅방 생성을 하기위한 컨트롤러입니다. 별도의 view 컴포넌트를 가지지 않습니다.

##### `EvaluationRoom` - 평가방 리스트를 관리하는 컨트롤러입니다.

##### `EvaluationRoomDetail` - 생성된 평가방의 상세 정보 및 평가방 개설을 하기 위한 컨트롤러 입니다.

##### `EvaluationRoomFinished` - 평가가 종료된 평가방의 정보를 확인하는 컨트롤러 입니다.

##### `EvaluationRoomProceed` - 평가를 진행하는 평가방을 관리하는 컨트롤러 입니다.

##### `EvaluationTable` - 평가항목표 리스트를 관리하는 컨트롤러 입니다.

##### `EvaluationTableDetail` - 평가항목표 상세화면을 관리하는 컨트롤러 입니다.

- `EvaluationTableDetail`에서 평가항목표를 작성을 하는 api는 가지고 있지 않습니다.
- 평가항목표 작성화면은 평가방 개설 화면에서도 사용하기 떄문에 `EvaluationTableComponent` 컴포넌트에서 관리하고 있습니다.

## view

- 1개의 컨트롤러당 1개의 view를 가집니다.
- view에서 리스트를 관리하는 컴포넌트들은 모두 `ListComponent`라는 components 폴더 안에 `List`라는 폴더의 컴포넌트를 사용합니다.
- 리스트를 관리하는 view 컴포넌트 폴더 안에는 `ListColumnName.ts`라는 폴더가 존재하며 해당 파일은 리스트의 column을 설정합니다.
- ListColumnName.ts 안에는 `columns`라는 배열을 export하고 있으며 그 안의 객체는 아래의 구조를 따릅니다.
  - headerName: 화면에 출력하는 한글 컬럼명입니다.
  - field: 데이터를 구분할 키값입니다. 백엔드에서 받은 데이터의 키값과 동일하게 세팅하시면 됩니다.
  - width: 컬럼의 간격을 조절하는 수치며 단위는 px이나 숫자만 입력합니다. 고정이 아닌 유동적으로 둘 경의 width를 포함시키지 않습니다.
- `ListComponent`에서는 `@mui/x-data-grid`라이브러리로 리스트 표를 작성하며 `columns`데이터와 `rows`데이터를 해당 라이브러리에 맞게 변환합니다.
- `columns`데이터는 ListColumnName.ts의 데이터이며 `rows`는 백엔드에서 받은 데이터 입니다.
- `columns`세팅에선 ListColumnName.ts의 데이터를 세팅하면서 버튼의 필요에 따라 추가 field를 반영합니다. `renderCell`이라는 메소드를 통해 버튼을 생성하며 해당 메소드의 인자값을 통해 rows의 각 데이터의 정보를 받아옵니다.
- `rows`세팅에선 반영할 데이터를 정리하며 설정한 키값에 포맷변경이나 조건을 설정할 경우 지정할 수 있습니다. 복잡한 코드는 아니기 때문에 보시면 바로 사용하실 수 있습니다.

#### Agreement

- 평가가 끝나고 생성되는 서류의 QR코드로 접근하는 페이지 화면을 구성하는 view 컴포넌트 입니다.

#### Auth

- 회원가입, 로그인 관련 페이지의 화면을 구성하는 view 컴포넌트 입니다.

##### `Join` - 회원가입 화면입니다.

##### `Login` - 아이디 찾기, 비밀번호 찾기 화면입니다. 기존 로그인 화면은 아래 Common 폴더의 LandingView 폴더를 사용합니다.

#### Common

##### `FooterView` - footer 화면입니다. Layout 컨트롤러에서 사용합니다.

##### `HeaderView` - header 화면입니다. Layout 컨트롤러에서 사용합니다.

##### `LandingView` - 로그인 화면에서 사용하는 화면입니다. (기획변경 및 개발상의 이슈로 로그인과 평가위원,제안업체의 평가방리스트등의 기능이 한 화면으로 통합되었습니다.)

##### `SideBarView` - 사이드바 입니다. (현재는 평가담당자 화면에서만 사용하고 있습니다.)

#### Partners

- 대시보드, 내 정보, 약관설정 등의 평가와 관련되지 않은 페이지 view 컴포넌트 입니다.

##### `Committer` - 평가위원 리스트 view 컴포넌트 입니다.

##### `Company` - 제안업체 리스트 view 컴포넌트 입니다.

##### `Dashboard` - 대시보드 view 컴포넌트 입니다.

##### `Detail` - 리스트 화면들의 상세화면 view 컴포넌트 입니다.

##### `MyInfo` - 내 정보 view 컴포넌트 입니다.

##### `Terms` - 약관설정에 관련된 view 컴포넌트 입니다.

#### System

- 평가방, 평가항목표 작성 등 평가와 관련된 페이지의 view 컴포넌트 폴더 입니다.

##### `EvaluationGrade` - 기획변경 전 평가방에서 사용하는 평가항목표 화면입니다. 현재는 사용하지 않습니다.

##### `EvaluationRoom` - 평가방 리스트를 관리하는 view 컴포넌트 입니다.

##### `EvaluationRoomDetail` - 생성된 평가방의 상세 정보 및 평가방 개설을 하기 위한 view 컴포넌트 입니다.

- AttendeeSelectorModal - 평가방 개설, 수정 시 평가위원, 제안업체를 선택하기 위한 부분 컴포넌트 입니다.
- StepComponent - 평가방 개설, 수정에서 사용되는 항목별 작성 화면입니다. 기획 초기에 스탭별 진행으로 구분했었으나 변경되어 하나의 스크롤페이지로 사용합니다.

##### `EvaluationRoomFinished` - 평가가 종료된 평가방의 정보를 확인하는 view 컴포넌트 입니다.

##### `EvaluationRoomProceed` - 평가를 진행하는 평가방을 관리하는 view 컴포넌트 입니다.

- 평가방은 해당 view를 가지고 있는 컨트롤러에서 step을 숫자로 관리합니다.
  - 평가담당자: step1 평가 시작 전, step2 제안 발표 및 평가 진행, step3 평가위원 점수 확인, step4 평가종료
  - 평가위원: step1 평가 시작 전, step2 제안 발표 및 평가 진행, step3 점수 채점, step4 평가종료
  - 제안업체: step1 평가 시작 전, step2 제안 발표 및 평가 진행, step3 평가종료 (제안업체는 발표 후 바로 퇴장이기 때문에 step3에서 평가가 종료됩니다.)

##### `EvaluationTable` - 평가항목표 리스트를 관리하는 view 컴포넌트 입니다.

##### `EvaluationTableDetail` - 평가항목표 상세화면을 관리하는 view 컴포넌트 입니다. 해당 view 컴포넌트는 공용으로 사용하는 평가항목표 작성테이블 컴포넌트만 가집니다.

## components

- view 에서 사용하는 부분, 공용 컴포넌트들을 구성하는 폴더입니다.
- 여기에 담긴 폴더들은 폴더명이 사용목적으로 구성되어 있으므로 주요 프로세스를 가진 폴더들만 설명합니다.

#### Common

- button, input 등의 컴포넌트 관리 폴더 입니다.

##### `Authorization` - 라우팅 시 토큰 유무 및 권한을 체크합니다. Route 폴더에서 사용합니다.

##### `Loading` - 로딩 아이콘을 모아놓은 파일입니다.

- `lottie-player` 라이브러리를 사용하며 내부망에서 동작해야되기 때문에 `assets`폴더에 최상단의 public 폴더의 animation 폴더에 json 파일 형태로 가지고 있습니다.

#### EvaluationRoomProceed - 평가방 진행에 사용되는 프로세스들의 부속 컴포넌트들 폴더 입니다.

#### EvaluationScoreTable - 평가방에서 평가위원이 채점을 하기위한 평가항목표 채점 화면입니다. 평가항목표 작성 구조에서 `table`태그로 활용 가능하도록 컨버팅하여 사용합니다.

- 아래 후술할 작성화면에서 사용하는 구조를 단순배열로 변경합니다.
- 조금 복잡한 프로세스인 만큼 각 함수 및 프로세스 진행단계 마다 주석으로 메모해 두었습니다.

#### EvaluationSumScoreTable - 평가방에서 평가담당자가 평가위원의 채점을 간략하게 보는 점수 합산표입니다.

#### EvaluationTable - 평가항목표 작성 컴포넌트 입니다.

- 복잡해 보이지만 생각보다 단순한 프로세스를 가지고 있습니다.
- 작성에서 사용하는 구분값의 규칙입니다.
  - 대분류-중분류-소분류 ex: 0-1-0
  - 대분류는 앞자리 하나의 숫자만 가집니다.
  - 중분류는 자신이 속한 대분류 아래 두번째를 포함한 값을 가집니다. ex: 0-0, 0-1, 1-0 ...
  - 소분류는 자신이 속한 대분류 아래 중분류 아래 세번째 자리 숫자를 포함한 값을 가집니다. ex: 0-0-0, 0-0-1, 0-1-0...
  - 각 분류들을 추가할 때에는 자신이 속한 분류에서 갯수 + 1을 한 값으로 추가 됩니다. ex: 0-0-0에서 소분류 추가히 0-0-1로 값을 가집니다.
  - 수정 및 삭제를 진행할 떄도 해당 값들을 구분하여 아래 구조에서 데이터를 지칭하여 사용합니다.
- 평가항목표 채점 화면과 동일하게 모든 함수와 프로세스에 주석을 메모해 두었습니다.

```TypeScript
# 대분류, 중분류, 소분류 인터페이스
export type TableArrayItemType = {
  id?: number; // 대분류 or 중분류 or 소분류 아이디
  title: string; // 질문 내용
  content: TableContentItem[]; // 점수를 채점할 소분류 배열
  sub: TableArrayItemType[]; // 중분류를 담을 배열, 데이터는 이 구조와 동일
  criteria?: string; // 최소 점수를 지정하는 값이었으나 현재는 사용하지 않습니다. 소스코드 상에서도 사용되는 부분은 주석처리 되어 있습니다.
};

# 채점항목 인터페이스
export type TableContentItem = {
  id?: number; // 평가내용 아이디
  content: string; // 평가내용 질문
  score: string; // 해당 평가내용의 배점 가능한 점수
  isSuitable?: boolean; // 점수가 적합한지 부적합한지 기준, true: 적합, false: 부적합
  inputScore: number; // 평가에서 평가위원이 입력할 점수
};
```

#### Modal

- 제안서평가시스템에서 알람, 로딩 등의 모든 모달화면에 사용되는 프로세스 컴포넌트 입니다.

##### `Auth` - 이메일 발송, 비밀번호 변경 등 유저와 관련된 모달들 입니다.

##### `Committer` - 평가담당자가 평가위원 리스트에서 위원 항목 선택시 보여주는 상세 화면입니다.

##### `Nice` - 나이스 인증 요청, 승인 프로세스 입니다.

##### `AlertModal.tsx` - 전역에서 사용되는 alert 모달 화면입니다. recoil에서 상태관리를 진행합니다.

##### `ContentModal.tsx` - 전역에서 사용되는 컨텐츠를 담은 모달 화면입니다. recoil에서 상태관리를 진행합니다.

##### `LoadingModal.tsx` - 로딩시 사용되는 모달 화면입니다. recoil에서 상태관리를 진행합니다.

- LoadingModal.tsx 모달은 components -> Common -> Loading 폴더에 있는 데이터를 가져와서 사용합니다.

##### `Overlay.tsx` - 모든 모달 화면의 투명도 있는 검정 배경이 되는 컴포넌트 입니다.

#### Pagination

- 페이지네이션 컴포넌트 입니다. 현재는 `@mui/x-data-grid`라이브러리로 인해 평가방 개설 화면에서만 사용합니다.

#### Viewer

- PDF 파일 뷰어입니다.

## interface

- 제안서 평가시스템에서 사용되는 타입선언 인터페이스 입니다.
- 백엔드와 데이터를 주고 받는 구조를 미리 인터페이스로 선언한 내용이며 폴더구성은 controller 폴더와 동일합니다.

## modules

#### Client

- 서버 통신과 관계없이 클라이언트 단에서 사용되는 상태관리를 사용합니다.
- `Recoil`을 통해 상태관리를 진행합니다.
- 자주 사용되는 상태관리는 `Modal` 입니다.

#### Server

- api 호출시 사용되는 상태관리 입니다.
- `React-Query`를 사용합니다.
- api 호출 시 마다 공통으로 사용되는 부분들 및 타입 지정을 간소화 하기 위해 Hook으로 분리했습니다.
- 서부발전 이후 프로젝트에 공용으로 사용되고 있으며 필요에 따라 추가 구성을 합니다.
- 인자를 받는 부분에 타입 설정은 꼭 필요한 상황이 생기지 않은 이상 건들 필요는 없습니다.
- 주로 api 호출 실패 및 에러를 캐치했을 경우 모달을 띄우거나 로딩 모달을 띄우는 등 공통적으로 사용되는 부분들만 주로 변경될 것 입니다.
- `React-Query`가 크게 변경되지 않은 이상 그대로 쓰셔도 무방하다고 생각됩니다.

## routers

- 라우터를 모아놓은 폴더입니다.

#### GlobalRoute.tsx

- 글로벌 라우터로 권한 관계 없이 사용되는 라우터 입니다.

#### Admin

- 평가담당자가 사용하는 화면의 라우터 입니다. 평가위원, 제안업체 권한으로는 해당 라우터를 사용할 수 없습니다.

#### Users

- 평가위원, 제안업체가 사용하는 화면의 라우터입니다. 평가담당자의 권한으로는 해당 라우터를 사용할 수 없습니다.

## theme

- css 공통 스타일을 모아놓은 폴더입니다.
- 기본적으로 styled-component를 사용합니다.
- `index.ts` 는 디자이너가 설정한 값들을 고정으로 세팅해둔 파일입니다.
- 대부분 index.ts 폴더 안에서 스타일을 가지고 오지만 기획 변경 및 css 이슈로 직접 지정한 스타일도 소량 존재합니다.
- 해당 폴더 안에서 `index.ts`외의 폴더는 건드실 필요 없는 공통으로 사용하는 스타일입니다.