
export const UrlMatching: { [key: string]: { [action: string]: string[] } } = {                 
    "/api/evaluation/resource" : {"GET" : ["다운로드","파일 경로"]},    
    "/api/evaluation/evaluation/master" : {"GET" : ["조회","평가방 리스트 불러오기"], "POST" : ["저장","평가방 생성"]},    
    "/api/evaluation/evaluation/master/:id" : {"GET" : ["조회","평가방 정보 불러오기"],"PATCH" : ["수정", "평가방에서 사용된 평가표 수정"] , "DELETE" : ["삭제","평가방 삭제"]},    
    "/api/evaluation/evaluation/start/:id" : {"GET" : ["저장","평가 시작하기"]},    
    "/api/evaluation/evaluation/master/:id/evaluation-table" : {"GET" : ["조회","평가항목표 요약 정보"]},    
    "/api/evaluation/evaluation/master/:id/evaluation-table/:id/:id" : {"GET" : ["조회", "평가위원 평가표 상세 가져오기"]},
    "/api/evaluation/evaluation/master/:id/evaluation-table/:id" : {"PATCH" : ["조회", "평가담당자 보정평가 및 제출 여부 확인"]},
    "/api/evaluation/evaluation/master/polling/:id/evaluation-table" : {"GET" : ["조회", "평가방 평가점수표 정보 가져오기"]},
    "/api/evaluation/evaluation/master/:id/evaluation-user/disable" : {"PATCH" : ["삭제","평가방 평가위원 강퇴처리"]},
    "/api/evaluation/evaluation/master/:id/evaluation-user/committer" : {"PATCH" : ["삭제","평가방 참석자 강퇴처리"]},
    "/api/evaluation/evaluation/master/manuscript/:id" : {"GET" : ["다운로드","평가방 평가위원 평가서 다운로드"]},
    "/api/evaluation/evaluation/master/:id/evaluation-room/finish" : {"PATCH" : ["삭제","평가방 종료"]},
    "/api/evaluation/evaluation/master/:id/evaluation-room-finish/simple" : {"GET" : ["조회", "평가종료된 평가방 요약정보 불러오기"]},
    "/api/evaluation/evaluation/master/:id/evaluation-room/finish/final-score" : {"GET" : ["조회", "평가종료된 평가방 최종평가표 가져오기"]},
    "/api/evaluation/evaluation/master/:id/evaluation-room/time" : {"PATCH" : ["저장", "평가담당자 평가시간 설정"]},
    "/api/evaluation/evaluation/master/:id/evaluation-room/time/start" : {"PATCH" : ["수정","평가 시간 시작하기"]},
    "/api/evaluation/evaluation/master/:id/evaluation-room/time/stop" : {"PATCH" : ["수정", "평가 시간 종료, 리셋하기"]},
    "/api/evaluation/evaluation/user/polling/:id/evaluation-room/time" : {"GET" : ["조회","현재 진행중인 평가시간 가져오기"]},
    "/api/evaluation/evaluation/user/polling/:id/evaluation-room-check" : {"GET" : ["조회","접속중인 참석자 확인"]},
    "/api/evaluation/evaluation/user/polling/:id/evaluation-time-check" : {"GET" : ["조회","평가위원, 제안업체 담당자 설정 시간 가져오기"]},
    "/api/evaluation/evaluation/user/polling/:id/evaluation-room-start-check" : {"GET" : ["조회","평가방 시작여부 확인"]},
    "/api/evaluation/evaluation/committer" : {"GET" : ["조회", "평가방 평가위원 리스트"]},
    "/api/evaluation/evaluation/committer/:id" : {"GET" : ["조회", "평가방 평가위원 정보"]},
    "/api/evaluation/evaluation/committer/:id/evaluation-table" : {"GET" : ["조회","평가위원 평가항목표(평가항목 점수확인표) 요약 정보"],"PATCH" : ["저장", "평가위원 평가점수 제출하기"]},
    "/api/evaluation/evaluation/committer/:id/evaluation-table/:id" : {"GET" : ["조회","평가위원 평가채점표 가져오기"],"POST" : ["저장","평가방 평가위원이 선택한 제안업체 평가표 채점 저장하기"]},    
    "/api/evaluation/evaluation/committer/polling/:id/evaluation-table" : {"GET" : ["조회", "평가위원, 제안업체 평가방 정보 가져오기"]},
    "/api/evaluation/evaluation/committer/polling/:id/evaluation-room-check/in" : {"GET" : ["조회","해당 평가위원이 접속 중인지 체크"]},
    "/api/evaluation/evaluation/committer/polling/:id/evaluation-room-check/out" : {"GET" : ["조회", "해당 평가위원이 평가방에서 나갔을 떄 체크"]},
    "/api/evaluation/evaluation/company" : {"GET" : ["조회","평가방 제안업체 리스트"]},
    "/api/evaluation/evaluation/company/:id" : {"GET" : ["조회", "평가위원 제안업체 정보"]},
    "/api/evaluation/evaluation/company/polling/:id/evaluation-room-check/in" : {"GET" : ["조회", "해당 제안업체가 접속 중인지 체크"]},
    "/api/evaluation/evaluation/company/polling/:id/evaluation-room-check/out" : {"GET" : ["조회", "해당 제안업체가 평가방에서 나갔을 때 체크"]},
    "/api/evaluation/auth/company/signup" : {"POST" : ["저장", "제안업체 회원가입"]},
    "/api/evaluation/auth/username" : {"GET" : ["조회","아이디 중복체크"]},    
    "/api/evaluation/auth/email" : {"GET" : ["조회","이메일 중복체크"]},
    "/api/evaluation/auth/email/code" : {"POST" : ["저장","이메일 인증코드 보내기"]},
    "/api/evaluation/auth/email/code/resend" : {"POST" : ["저장", "이메일 인증코드 재전송"]},
    "/api/evaluation/auth/email/verify" : {"GET" : ["저장", "이메일 인증"]},
    "/api/evaluation/auth/login" : {"POST" : ["저장", "이메일 인증코드 보내기"]},
    "/api/evaluation/auth/committer-login" : {"POST" : ["조회","평가위원 로그인"]},
    "/api/evaluation/auth/logout" : {"POST" : ["삭제", "로그아웃"]},
    "/api/evaluation/auth/login/otp" : {"POST" : ["조회", "admin otp 로그인"]},
    "/api/evaluation/auth/login/fido" : {"POST" : ["조회", "admin 지문 로그인"]},
    "/api/evaluation/auth/login/sso" : {"POST" : ["조회", "sso 로그인"]},
    "/api/evaluation/auth/find" : {"POST" : ["조회", "아이디 찾기"]},
    "/api/evaluation/auth/find/pw" : {"POST" : ["조회","비밀번호 찾기"]},
    "/api/evaluation/auth/oauth/webex" : {"POST" : ["저장", "서부 평가담당자 Webex OAUTH 2.0"]},
    "/api/evaluation/auth/pass" : {"POST" : ["저장", "나이스 본인인증 신청"]},
    "/api/evaluation/auth/pass/dec" : {"POST" : ["저장", "나이스 본인인증 요청"]},
    "/api/evaluation/auth/login/:id" : {"POST" : ["저장", "로그인 2차 전화번호 인증"]},
    "/api/evaluation/auth/committer/refresh" : {"POST" : ["저장","평가위원 토큰 재발급"]},
    "/api/evaluation/auth/company/refresh" : {"POST" : ["저장","제안업체 토큰 재발급"]},
    "/api/evaluation/auth/master/refresh" : {"POST" : ["저장","관리자 토큰 재발급"]},
    "/api/evaluation/auth/duplicate" : {"POST" : ["조회", "유저 중복체크"]},
    "/api/evaluation/auth/committer/invitation" : {"GET" : ["저장", "평가위원 초대"],"POST" : ["저장", "초대 코드로 평가위원 등록 완료"]},
    "/api/evaluation/auth/committer/code" : {"GET" : ["조회","평가위원 초대코드 확인"]},
    "/api/evaluation/auth/emp" : {"GET" : ["조회", "담당자 이름 찾기"]},
    "/api/evaluation/auth/out" : {"POST" : ["삭제", "회원탈퇴"]},
    "/api/evaluation/company/info/phone" : {"PATCH" : ["수정", "제안업체 전화번호 변경"]},
    "/api/evaluation/company/info/email" : {"PATCH" : ["수정", "제안업체 이메일 변경"]},
    "/api/evaluation/company/info/password" : {"PATCH" : ["수정", "제안업체 비밀번호 변경"]},
    "/api/evaluation/company/me" : {"GET" : ["조회", "제안업체 내 정보 조회"]},
    "/api/evaluation/company/me/history" : {"GET" : ["조회", "제안업체 내 정보 변경 내역"]},
    "/api/evaluation/master/committer/list" : {"GET" : ["조회", "평가위원 리스트"]},
    "/api/evaluation/master/committer" : {"GET" : ["조회", "평가위원 리스트 (평가방 개설 모달)"], "POST" : ["저장", "평가위원 생성"]},
    "/api/evaluation/master/committer/:id" : {"PATCH" : ["수정","평가위원 수정"]},
    "/api/evaluation/master/company" : {"GET" : ["조회","제안업체 리스트"], "POST" : ["저장", "제안업체 직접 등록"]},
    "/api/evaluation/master/user/personal/apply/:id" : {"POST" : ["수정", "관리자 USER 가입 요청 승인"]},
    "/api/evaluation/master/user/consignment/apply/:id" : {"POST" : ["수정", "관리자 USER 가입 요청 승인"]},
    "/api/evaluation/master/user/security/apply/:id" : {"POST" : ["수정", "관리자 USER 가입 요청 승인"]},
    "/api/evaluation/master/user/agreement/apply/:id" : {"POST" : ["수정", "관리자 USER 가입 요청 승인"]},
    "/api/evaluation/master/user/company/apply/:id" : {"POST" : ["수정", "관리자 USER 가입 요청 승인"]},
    "/api/evaluation/master/user/committer/apply/:id" : {"POST" : ["수정", "관리자 USER 가입 요청 승인"]},
    "/api/evaluation/master/user/personal/reject/:id" : {"POST" : ["수정", "관리자 USER 가입 요청 반려"]},
    "/api/evaluation/master/user/consignment/reject/:id" : {"POST" : ["수정", "관리자 USER 가입 요청 반려"]},
    "/api/evaluation/master/user/security/reject/:id" : {"POST" : ["수정", "관리자 USER 가입 요청 반려"]},
    "/api/evaluation/master/user/agreement/reject/:id" : {"POST" : ["수정", "관리자 USER 가입 요청 반려"]},
    "/api/evaluation/master/user/company/reject/:id" : {"POST" : ["수정", "관리자 USER 가입 요청 반려"]},
    "/api/evaluation/master/user/committer/reject/:id" : {"POST" : ["수정", "관리자 USER 가입 요청 반려"]},
    "/api/evaluation/master/user/personal/:id" : {"GET" : ["조회", "관리자 USER 상세"]},
    "/api/evaluation/master/user/consignment/:id" : {"GET" : ["조회", "관리자 USER 상세"]},
    "/api/evaluation/master/user/security/:id" : {"GET" : ["조회", "관리자 USER 상세"]},
    "/api/evaluation/master/user/agreement/:id" : {"GET" : ["조회", "관리자 USER 상세"]},
    "/api/evaluation/master/user/company/:id" : {"GET" : ["조회", "관리자 USER 상세"]},
    "/api/evaluation/master/user/committer/:id" : {"GET" : ["조회", "관리자 USER 상세"]},
    "/api/evaluation/master/log" : {"GET" : ["조회","로그 리스트"]},    
    "/api/evaluation/master/log/:id" : {"GET" : ["조회", "로그 리스트 상세"]},
    "/api/evaluation/master/log/check" : {"POST" : ["조회", "로그 리스트 패스워드 체크"]},
    "/api/evaluation/master/log/pass" : {"post" : ["수정", "로그 리스트 패스워드 변경"]},
    "/api/evaluation/dashboard/evaluation" : {"GET" : ["조회", "대시보드 평가현황"] },
    "/api/evaluation/dashboard/partner" : {"GET" : ["조회", "대시보드 파트너가입현황"]},
    "/api/evaluation/dashboard/evaluation/today" : {"GET" : ["조회", "대시보드 금일 평가 리스트"]},
    "/api/evaluation/term" : {"PATCH" : ["수정", "약관 수정"], "GET" : ["조회", "약관 모두 보기"]},    
    "/api/evaluation/term/personal" : {"GET" : ["조회", "약관 하나씩 보기"]},
    "/api/evaluation/term/consignment" : {"GET" : ["조회", "약관 하나씩 보기"]},
    "/api/evaluation/term/security" : {"GET" : ["조회", "약관 하나씩 보기"]},
    "/api/evaluation/term/agreement" : {"GET" : ["조회", "약관 하나씩 보기"]},
    "/api/evaluation/term/company" : {"GET" : ["조회", "약관 하나씩 보기"]},
    "/api/evaluation/term/committer" : {"GET" : ["조회", "약관 하나씩 보기"]},



    "/api/evaluation/webex/oauth-url" : {"GET" : ["저장", "Webex 방 생성 1"]},
    "/api/evaluation/webex/oauth-login" : {"POST" : ["저장", "Webex 방 생성 2"]},
    "/api/evaluation/evaluation-table" : {"POST" : ["저장", "평가항목표 등록"], "GET" : ["조회", "평가표리스트"]},
    "/api/evaluation/evaluation-table/:id" : {"GET" : ["조회", "평가항목표 상세정보"], "PATCH" : ["수정", "평가항목표 수정"], "DELETE" : ["삭제", "평가항목표 삭제"]},
    "/api/evaluation/evaluation-table/evaluation/:id" : {"GET" : ["조회", "평가담당자 평가방 평가표양식 확인"], "PATCH" : ["수정", "평가방에서 사용된 평가표 수정"]},
    "/api/evaluation/final-score/qr/docs" : {"POST" : ["조회", "계좌이체거래약정서 PDF 데이터 불러오기"]},
    "/api/evaluation/final-score/qr/block" : {"POST" : ["조회", "블록체인 데이터 불러오기"]},
    "/api/evaluation/final-score/qr/committer/docs" : {"POST" : ["조회", "평가위원 평가표 - QR CODE PDF 불러오기"]},
    "/api/evaluation/final-score/qr/committer/block" : {"POST" : ["조회", "평가위원 평가표 - QR CODE 블록체인 불러오기"]},
    "/api/evaluation/manual" : {"GET" : ["다운로드", "메뉴얼 다운로드"]},










    









    



















    


};

