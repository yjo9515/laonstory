import axios from "axios";
import { getCookie } from "../utils/ReactCookie";

const baseURL: string = process.env.REACT_APP_BASE_URL ?? "";
// // const testUrl = "https://6304b2d594b8c58fd7231b16.mockapi.io/api";

// const DefaultClient = axios.create({
//   baseURL,
// });

// const token = getCookie("token");
// DefaultClient.defaults.headers.common["Authorization"] = "Bearer " + token;

const DefaultClient = axios.create({
  baseURL,
});

DefaultClient.interceptors.request.use(
  (config) => {
    config.headers = config.headers || {};
    const token = getCookie('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  // (error) => {
  //   return Promise.reject(error);
  // }
);


export default DefaultClient;
