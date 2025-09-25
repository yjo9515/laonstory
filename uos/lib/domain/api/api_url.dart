const serverUrl =
    // 'http://192.168.0.232:8080/api'; // 로컬
    'http://isushub.uos.ac.kr/api'; // 실서버

// 공통
const versionCheckUrl = '$serverUrl/version'; // 버전 체크
const alertCheckUrl = '$serverUrl/alert'; // 알림 체크

// 유저 API
const loginUrl = '$serverUrl/user/login'; // 로그인
const memberOutUrl = '$serverUrl/user/out'; // 회원탈퇴
const userDetailUrl = '$serverUrl/user/detail'; // 유저 상세 정보 /${id}
const passwordModifyUrl = '$serverUrl/user/pw'; // 유저 비밀번호 변경
const userInfoModifyUrl = '$serverUrl/user/modify'; // 유저 정보 변경

// 주소록 API
const addressListURL = '$serverUrl/user'; // 유저 리스트 : get

// 공지 및 게시판
const noticeUrl = '$serverUrl/notice'; // 공지 리스트 : get, 작성 : post, 수정 : patch, 삭제 : delete

// 게시글 리스트 : get, 작성 : post, 수정 /${id} : patch, 삭제 /${id} : delete
// 댓글 작성 /${board.id}/comment : post // 댓글 수정 /${board.id}/comment/${comment.id} : patch , 삭제 /${board.id}/comment/${comment.id} : delete
const boardUrl = '$serverUrl/board';

// 커뮤니티(SNS)
const communityUrl = '$serverUrl/community'; // 리스트 :get, 상세 /${id} : get, 작성 : post, 수정 /${id} : patch, 삭제 /${id} : delete

// 관리자 전용
const accountResetUrl = '$serverUrl/user/reset'; // ${id} 유저 계정 패스워드 초기화


