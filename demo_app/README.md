# 린넨서울 (LinenSeoul) 데모 앱

린넨 관리 시스템을 위한 Android 데모 애플리케이션입니다. RFID/UHF 태그를 활용한 린넨 추적 및 관리 솔루션을 제공합니다.

## 🏗️ 프로젝트 구조

```
demo_app/
├── app/                           # 메인 안드로이드 애플리케이션
│   ├── src/main/java/com/laonstory/
│   │   ├── data/                  # 데이터 레이어
│   │   │   ├── model/             # 데이터 모델 클래스
│   │   │   └── repository/        # 데이터 저장소
│   │   └── linenseoul/
│   │       ├── adapter/           # RecyclerView 어댑터
│   │       ├── domain/            # API 클라이언트
│   │       ├── presentation/      # MVP 패턴 UI 레이어
│   │       └── util/              # 유틸리티 클래스
│   └── src/main/res/             # 리소스 파일
└── ModuleAPI/                    # UHF/RFID 모듈 API 라이브러리
    ├── src/main/java/com/xlzn/hcpda/  # UHF 리더 API
    └── src/main/jni/             # C/C++ 네이티브 라이브러리
```

## 📱 주요 기능

### 1. 사용자 인증
- 로그인/로그아웃
- 역할 기반 권한 관리 (관리자, 브랜드, 지점, 세탁공장, 배송업체)
- 토큰 기반 인증

### 2. TAG 관리
- **TAG 등록**: 새로운 RFID 태그 등록
- **TAG 수정**: 기존 태그 정보 수정
- **TAG 폐기**: 태그 삭제 및 폐기 처리
- **TAG 조회**: 태그 정보 검색 및 조회

### 3. 세탁 관리
- **세탁 신청**: 린넨 세탁 요청
- **세탁 완료**: 세탁 완료 처리
- **세탁공장 입고/출고**: 공장 입출고 관리
- **배송 관리**: 린넨 배송 추적

### 4. 사용자 관리
- 사용자 등록/변경/삭제
- 부서별 사용자 관리
- 사용자별 TAG 할당

### 5. UHF/RFID 스캐닝
- PDA를 통한 RFID 태그 스캔
- 신호 세기 조절 (4단계)
- 자동/수동 스캔 모드

## 🛠️ 기술 스택

### Android 애플리케이션
- **언어**: Java
- **최소 SDK**: 21 (Android 5.0)
- **타겟 SDK**: 30 (Android 11)
- **아키텍처**: MVP (Model-View-Presenter)
- **빌드 도구**: Gradle

### 라이브러리 & 의존성
```gradle
dependencies {
    // Android 기본 라이브러리
    implementation 'androidx.appcompat:appcompat:1.2.0'
    implementation 'com.google.android.material:material:1.3.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'

    // 라이프사이클 및 아키텍처
    implementation 'androidx.lifecycle:lifecycle-extensions:2.2.0'

    // 네트워킹
    implementation 'com.squareup.retrofit2:retrofit:2.9.0'
    implementation 'com.squareup.retrofit2:converter-gson:2.1.0'

    // 뷰 바인딩
    buildFeatures {
        viewBinding = true
        dataBinding = true
    }

    // UHF 모듈
    implementation project(path: ':ModuleAPI')
}
```

### UHF/RFID 모듈
- **UHF 리더**: SLR 시리즈 지원
- **프로토콜**: UHF EPC Gen2
- **네이티브 라이브러리**: C/C++ (JNI)
- **시리얼 통신**: RS232/UART

## 🚀 빌드 및 실행

### 요구사항
- Android Studio 4.0+
- Android SDK 30
- NDK 21.1.6352462
- Gradle 6.5+

### 빌드 단계
1. **프로젝트 클론**
   ```bash
   git clone https://github.com/laonstoryinc/linenrux.git
   cd linenrux/demo_app
   ```

2. **Android Studio에서 프로젝트 열기**
   - Android Studio 실행
   - "Open an existing Android Studio project" 선택
   - `demo_app` 폴더 선택

3. **의존성 동기화**
   ```bash
   ./gradlew build
   ```

4. **앱 실행**
   - 디바이스 또는 에뮬레이터 연결
   - Run 버튼 클릭 또는 `./gradlew installDebug`

## 📋 사용자 역할 및 권한

| 역할 | 권한 | 기능 |
|------|------|------|
| **관리자** (ROLE_MASTER_ADMIN) | 전체 관리 | 모든 기능 접근 가능 |
| **브랜드** (ROLE_MASTER) | 브랜드 관리 | TAG 관리, 세탁 관리 |
| **지점** (ROLE_FRANCHISE) | 지점 운영 | TAG 등록, 세탁 신청 |
| **세탁공장** (ROLE_FACTORY) | 공장 운영 | 입고/출고 관리 |
| **배송업체** (ROLE_DRIVER) | 배송 관리 | 배송 상태 업데이트 |

## 🔧 설정

### UHF 신호 세기 설정
앱에서 4단계 신호 세기를 지원합니다:
- **1단계** (150): 스캔 범위 20~30cm
- **2단계** (200): 스캔 범위 40~50cm
- **3단계** (250): 스캔 범위 60~70cm
- **4단계** (300): 스캔 범위 70~80cm

**권장사항**: 30~50cm 범위에서 스캔을 권장하며, 금속 물체 주변에서는 간섭이 발생할 수 있습니다.

## 📱 주요 화면

### 1. 로그인 화면
- 사용자 인증
- 계정 전환 기능
- 자동 로그인

### 2. 메인 메뉴
- 역할별 메뉴 표시
- TAG 관리 기능
- 세탁 관리 기능

### 3. TAG 관리 화면
- TAG 스캔 및 등록
- 품목명 입력
- 지점별 TAG 조회

### 4. 세탁 관리 화면
- 세탁 신청/완료 처리
- 공장 입고/출고 관리
- 배송 상태 추적

## 🔒 보안 고려사항

- 토큰 기반 인증 시스템
- HTTPS 통신 (단, `usesCleartextTraffic="true"` 설정됨)
- 사용자 권한별 기능 제한
- 키스토어 파일은 버전 관리에서 제외

## 📞 지원 및 연락처

- **개발사**: CLEANKOREA INC.
- **앱명**: 린넨서울
- **패키지명**: com.laonstory.linenseoul

## 📄 라이선스

Copyright ⓒ CLEANKOREA INC. All Rights Reserved.