// import axios from "api/defaultClient";

class RoleUtils {
  isSystemAdmin(role: string) {
    if (role === process.env.REACT_APP_ROLE_SYSTEM_ADMIN) return true;
    return false;
  }

  isMaster(role: string) {
    if (role === process.env.REACT_APP_ROLE_MASTER) return true;
    return false;
  }

  isCommitter(role: string) {
    if (role === process.env.REACT_APP_ROLE_COMMITTER) return true;
    return false;
  }

  isCompany(role: string) {
    if (role === process.env.REACT_APP_ROLE_COMPANY) return true;
    return false;
  }

  isGuest(role: string) {
    if (role === "GUEST") return true;
    return false;
  }

  // 파트너에 접근 권한이 있을 경우
  isPartners(role: string) {
    if (
      process.env.REACT_APP_ROLE_COMMITTER === role ||
      process.env.REACT_APP_ROLE_COMPANY === role
    )
      return true;
    return false;
  }

  isAuthorityTypeCheck(role: string) {
    this.getClientRole(role);
    if (role === "admin") return "평가담당자";
    if (role === "chairman") return "평가위원장";
    if (role === "committer") return "평가위원";
    if (role === "company") return "제안업체";
  }
  // 평가 시스템은 4가지 권한이 전부 접근 가능

  getRole(role: string) {
    if (
      role === process.env.REACT_APP_ROLE_COMMITTER ||
      role === process.env.REACT_APP_ROLE_COMPANY
    ) {
      return "user";
    }
    if (role === process.env.REACT_APP_ROLE_SYSTEM_ADMIN) return "admin";
    return "";
  }

  getClientRole(role: string) {
    if (role === process.env.REACT_APP_ROLE_COMMITTER) return "committer";
    if (role === process.env.REACT_APP_ROLE_COMPANY) return "company";
    if (role === process.env.REACT_APP_ROLE_SYSTEM_ADMIN) return "admin";
    return "";
  }
}

export default new RoleUtils();
