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

  isPersonal(role: string) {
    if (role === process.env.REACT_APP_ROLE_PERSONAL) return true;
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

  isAccountant(role: boolean | undefined) {
    if (role === true) return true;
    return false;
  }

  // 파트너에 접근 권한이 있을 경우
  isPartners(role: string) {
    if (process.env.REACT_APP_ROLE_PERSONAL === role || process.env.REACT_APP_ROLE_COMPANY === role)
      return true;
    return false;
  }

  isAuthorityTypeCheck(role: string) {
    this.getClientRole(role);
    if (role === "admin") return "서부 담당자";
    if (role === "personal") return "이용자";
    if (role === "company") return "법인";
  }
  // 계좌등록 시스템은 4가지 권한이 전부 접근 가능

  getRole(role: string) {
    if (
      role === process.env.REACT_APP_ROLE_PERSONAL ||
      role === process.env.REACT_APP_ROLE_COMPANY
    ) {
      return "user";
    }
    if (role === process.env.REACT_APP_ROLE_SYSTEM_ADMIN) return "admin";
    return "";
  }

  getClientRole(role: string) {
    if (role === process.env.REACT_APP_ROLE_PERSONAL) return "personal";
    if (role === process.env.REACT_APP_ROLE_COMPANY) return "company";
    if (role === process.env.REACT_APP_ROLE_SYSTEM_ADMIN) return "admin";
    if (role === "agreement") return "agreement";
    if (role === "userAgreement") return "userAgreement";
    return "";
  }
}

export default new RoleUtils();
