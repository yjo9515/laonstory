# isus_members

Isus project.

## Getting Started

flutter version : 3.29.1
- Domain
    - Api
        - api_service : api 통신을 위한 로직이 담겨있음
        - api_url : server 경로 설정 및 api 경로들이 담겨있음
    - Model : 각 모델클래스들이 담겨있는 폴더,
        - Generated : extension을 이용해 다음 명령어로 생성된 코드들이 들어있음  (dart run build_runner build --delete-conflicting-outputs )
    - Repository : api 로직 접근을 위한 저장소 (도메인 개발)
- Routes : 페이지의 path와 route 설정
- Type
    - Emuns : 필요한 타입 생성
    - Exception : 예외 클래스 정의
- View
    - Widget : 자주쓰는 컴포넌트들 정리해놓은 폴더(dialog, textfield)
    - Binding : getx사용시 각 컨트롤러들의 의존성 주입
- Viewmodel : view에서 호출한 로직을 실행 -> viewmodel에서 앱내 로직과 repository에 있는 로직을 실행후 view에 업데이트 (비즈니스 로직 개발)

## 개발 환경 설정

### 필수 요구사항
- **JDK**: Java 17 이상 (Android 빌드용)
- **FVM**: Flutter 버전 관리 (권장)
- **CocoaPods**: iOS 빌드용

### 초기 설정
```bash
# 의존성 설치
fvm flutter pub get

# 코드 생성 (모델 클래스)
dart run build_runner build --delete-conflicting-outputs

# iOS 의존성 설치
cd ios && pod install --repo-update && cd ..
```

## 주요 기능

### 1. 인증 시스템
- 로그인/로그아웃 기능
- 자동 로그인 (SharedPreferences 사용)
- 관리자 권한별 접근 제어

### 2. 주소록 관리
- 동문 검색 및 필터링
- 대륙별, 국가별 검색
- 전공별, 입학년도별 정렬

### 3. 게시판 시스템
- 동문소식 게시판
- 공지사항 관리
- 댓글 기능

### 4. 다국어 지원
- 한국어/영어 지원
- **라이브러리**: easy_localization
- **번역 파일**: `assets/translations/ko.json`, `assets/translations/en.json`

## 중요 설정 사항

### 1. 관리자 권한 (adminRole)
- **저장 형태**: List<String> (SharedPreferences의 setStringList 사용)
- **처리 방식**: 쉼표로 구분된 문자열을 split 처리
- **예시**: "MGLEP,MIPD,GC" → ["MGLEP", "MIPD", "GC"]
- **관련 파일**: 
  - `login_view_model.dart`
  - `splash_view_model.dart`
  - `SqlLite.dart` (데이터베이스 필터링)

### 2. 로컬 데이터베이스
- **SQLite 사용**: 주소록 데이터 캐싱
- **DB명**: isus.db
- **업데이트 주기**: 7일마다 서버 동기화
- **관련 파일**: `lib/domain/database/SqlLite.dart`

#### 테이블 구조
- **app_state 테이블**
  - key: TEXT PRIMARY KEY
  - value: TEXT

- **user 테이블**
  - idx: INT PRIMARY KEY
  - id: VARCHAR(50)
  - name: VARCHAR(100)
  - name_en: VARCHAR(100)
  - nickname: VARCHAR(100)
  - email: VARCHAR(100)
  - phone: VARCHAR(20)
  - country: VARCHAR(50)
  - country_en: VARCHAR(50)
  - city: VARCHAR(50)
  - city_en: VARCHAR(50)
  - affiliation: VARCHAR(255)
  - dept: VARCHAR(255)
  - position: VARCHAR(100)
  - major: VARCHAR(100)
  - major_en: VARCHAR(100)
  - research_field: VARCHAR(255)
  - admission: VARCHAR(4)
  - birthday: VARCHAR(50)
  - img: VARCHAR(255)
  - ROLE_USER: VARCHAR(50)
  - admin_role: VARCHAR(255)

- **sns 테이블**
  - user_id: INT (FOREIGN KEY)
  - social: VARCHAR(50)
  - url: VARCHAR(255)

### 3. API 통신
- **베이스 URL**: `lib/domain/api/api_url.dart`에서 관리
- **토큰 관리**: SharedPreferences에 저장
- **에러 처리**: ExceptionModel 클래스 사용

## 빌드 및 배포
안드로이드 스튜디오 기준 우측 상단에 테스트 할 기기를 선택 할 수 있습니다.(android/iOS/웹)

- 코드 수정 이후 pubspec.yaml에서 version 및 buildNumber 변경하고 flutter pub get


### Android 빌드
```bash
flutter build apk --release
flutter build appbundle --release (플레이스토어 업로드 용)
```

### iOS 빌드
```bash
flutter build ios --release
```

### Android 배포
```bash

# Release 모드

1. 구글플레이 콘솔 > 프로덕션 > 새 버전 만들기 출시노트 출시명 입력
2. 터미널에서 다음과 같이 명렁어 입력 fvm flutter build appbundle --release
3. 입력후 만들어진 app-release.aab(경로는 build/app/outputs/bundle/release/app-release.aab) 파일을 프로덕션 페이지> appbundle 드롭하기에 넣기
4. 저장 후 출시 > 심사 > 심사 완료되면 관리형 게시이므로 다시 출시 버튼 > 라이브 출시 완료 



```

### iOS 배포
```bash
1. xcode에서 runner > gerneral 탭 > identity와 build settings > flutter_build_name 및 flutter_build_number 에서 
이전 버전과 다른 버전 으로 (업데이트 할 버전으로 명시) 후 xcode 상위 메뉴 에서  product > archive선택
2. 완료되면 archives 창이 뜨는데 버전과 status 확인 후 [distribute app] 클릭 > app store connect 선택후 [distribute] 클릭
3. app store connect페이지에서 ios 앱 항목 오른쪽에 [+ 버튼] 클릭
4. 배포할 앱버전명을 입력 후 생성하기
5. 이 버전에서 업그레이드된 사항 입력 후 하단에 [빌드추가] 버튼 클릭
6. 아까 archives한 앱을 선택후 빌드추가
7. 저장 후 출시 > 심사 > 심사 완료되면 관리형 게시이므로 다시 출시 버튼 > 라이브 출시 완료

```

## 트러블슈팅

### 1. Gradle 빌드 오류
- **원인**: Java 버전 불일치
- **해결**: Java 17 이상 설치 및 JAVA_HOME 설정
```bash
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
```

### 2. CocoaPods 동기화 오류
```bash
cd ios
rm -rf Pods/ .symlinks/ Podfile.lock
pod install --repo-update
cd ..
```

### 3. 앱 설치 서명 오류
```bash
# 기존 앱 삭제 후 재설치
adb uninstall com.laonstory.addressbook
fvm flutter install
```

### 4. 번역 키 누락 오류
- **원인**: 코드에서 사용하는 번역 키가 JSON 파일에 없음
- **해결**: `assets/translations/` 파일에 해당 키 추가



## 개발 시 주의사항

1. **번역 키 사용**: `tr('key_name')` 형태로 사용, 키 누락 시 경고 발생
2. **상태 관리**: GetX 패턴 준수, update() 호출로 UI 갱신
3. **API 에러 처리**: ExceptionModel을 통한 일관된 에러 처리
4. **로컬 데이터**: 7일 주기 자동 동기화, 수동 새로고침 지원

