# 평택시민의료생협 조합원 관리 프로젝트 (Flutter Frontend)

평택시민의료생협 조합원 관리 프로젝트 정리 문서
1. 프로젝트 파일
- Git laonstoryinc 계정으로 접속합니다.
  https://github.com/laonstoryinc/union_management/tree/main/front 관리자 페이지 / 사용자 앱
  https://github.com/laonstoryinc/union_management/tree/main/backend 서버
2. 프로젝트 설명 및 구조
   DDD 구조로 다른 프로젝트와 살짝 다른 구조를 채택하여 개발했습니다.
   각 페이지마다 디렉토리가 있으며, 내부에 bloc, ui, widget, repository로 구현합니다.

## 1. 프로젝트 개요
Flutter 기반의 평택시민의료생협 조합원 관리 시스템 프론트엔드입니다.
관리자 웹페이지와 사용자 모바일 앱이 통합된 멀티플랫폼 애플리케이션입니다.

## 2. 기술 스택
- **Framework**: Flutter 3.0.2+
- **State Management**: BLoC Pattern (flutter_bloc 8.1.1)
- **Architecture**: DDD (Domain Driven Design)
- **HTTP Client**: http 0.13.5
- **Storage**: flutter_secure_storage, shared_preferences
- **UI Components**: Material Design + Custom Components
- **Charts**: fl_chart 0.61.0
- **Firebase**: Core, Messaging, Analytics, Crashlytics, Performance

## 3. 프로젝트 구조
```
lib/
├── admin/              # 관리자 페이지
│   ├── dashboard/      # 대시보드
│   ├── user/          # 사용자 관리
│   ├── event/         # 이벤트 관리
│   ├── pay/           # 결제 관리
│   ├── settings/      # 설정
│   └── widget/        # 공통 위젯
├── user/              # 사용자 앱
├── alert/             # 알림
├── book/              # 도서
├── common/            # 공통 컴포넌트
└── core/              # 코어 기능
```

각 모듈은 다음 구조를 따릅니다:
- `bloc/` - 상태 관리 (BLoC 패턴)
- `model/` - 데이터 모델
- `repository/` - 데이터 레이어
- `ui/` - UI 페이지
- `widget/` - 재사용 위젯

## 4. 주요 기능
### 관리자 기능
- 대시보드 및 통계
- 조합원 관리 (등록, 수정, 삭제)
- 이벤트 및 공지사항 관리
- 결제 관리
- 포인트 시스템
- 설정 관리

### 사용자 기능
- 조합원 가입 및 로그인
- 개인정보 관리
- 이벤트 참여
- 알림 수신
- 포인트 적립/사용

## 5. 개발 환경 설정
```bash
# Flutter 설치 확인
flutter doctor

# 의존성 설치
flutter pub get

# 코드 생성 (필요시)
dart run build_runner build --delete-conflicting-outputs

# 실행
flutter run
```

## 6. 빌드 및 배포
안드로이드 스튜디오 기준 우측 상단에 테스트 할 기기를 선택 할 수 있습니다.(android/iOS/웹)

- 코드 수정 이후 pubspec.yaml에서 version 및 buildNumber 변경하고 flutter pub get

## 7. 계정정보
평택 조합원 계정정보(기영님꺼)
Id : 01048136286
Pw : 980201
관리자 계정정보
Id : ptsm4123
Pw : Ptsm1203#

### Android 빌드
```bash
flutter build apk --release
flutter build appbundle --release (플레이스토어 업로드 용)
```

### iOS 빌드
```bash
flutter build ios --release
```

### Web 빌드
```bash
flutter build web --release
```

### Android 배포

1. 구글플레이 콘솔 > 프로덕션 > 새 버전 만들기 출시노트 출시명 입력
2. 터미널에서 다음과 같이 명렁어 입력 fvm flutter build appbundle --release
3. 입력후 만들어진 app-release.aab(경로는 build/app/outputs/bundle/release/app-release.aab) 파일을 프로덕션 페이지> appbundle 드롭하기에 넣기
4. 저장 후 출시 > 심사 > 심사 완료되면 관리형 게시이므로 다시 출시 버튼 > 라이브 출시 완료 


### iOS 배포

1. xcode에서 runner > gerneral 탭 > identity와 build settings > flutter_build_name 및 flutter_build_number 에서 
이전 버전과 다른 버전 으로 (업데이트 할 버전으로 명시) 후 xcode 상위 메뉴 에서  product > archive선택
2. 완료되면 archives 창이 뜨는데 버전과 status 확인 후 [distribute app] 클릭 > app store connect 선택후 [distribute] 클릭
3. app store connect페이지에서 ios 앱 항목 오른쪽에 [+ 버튼] 클릭
4. 배포할 앱버전명을 입력 후 생성하기
5. 이 버전에서 업그레이드된 사항 입력 후 하단에 [빌드추가] 버튼 클릭
6. 아까 archives한 앱을 선택후 빌드추가
7. 저장 후 출시 > 심사 > 심사 완료되면 관리형 게시이므로 다시 출시 버튼 > 라이브 출시 완료

```

## 7. 환경 설정
- `.env` 파일에 환경변수 설정 필요 (배포 및 빌드시 필요한 키값들이 들어가있습니다)
- Firebase 설정 파일 필요 (google-services.json, GoogleService-Info.plist)

## 8. 앱 스토어 정보
- **iOS**: App Store Connect (laonstoryinc@icloud.com)
- **Android**: Google Play Console (apps@laonstory.com)

## 9. 버전 정보
- **현재 버전**: 0.9.0+16
- **Flutter SDK**: 3.0.2+
- **Dart SDK**: 3.0.2+

## 10. 주요 의존성
- **상태 관리**: flutter_bloc, equatable
- **네트워킹**: http, json_annotation
- **UI**: responsive_framework, cached_network_image
- **Firebase**: 푸시 알림, 분석, 크래시 리포트
- **보안**: flutter_secure_storage, encrypt

## 11. 개발 현황
- ✅ 개발 완료
- ✅ 실제 서비스 운영 중
- 🔄 추가 기능 개발 대기
