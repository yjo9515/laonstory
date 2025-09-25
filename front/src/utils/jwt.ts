import { Buffer } from 'buffer';
import { committerRefreshTokenApi, companyRefreshTokenApi, masterRefreshTokenApi } from '../api/AuthApi';
import { getCookie, setCookie } from './ReactCookie';


export const parseJwt = (token: string) => {
    const base64Payload = token.split('.')[1]; //value 0 -> header, 1 -> payload, 2 -> VERIFY SIGNATURE
    const payload = base64Payload === undefined ? '' : Buffer.from(base64Payload.toString(), 'base64').toString('utf8');
    const result = base64Payload === undefined ? {} : JSON.parse(payload.toString())
    return result;
};



export const refreshJwt = (): {
    isTokenExpired: any;
    refreshToken: any;
} => {
    // const navigate = useNavigate();
    // const companyRefreshToken = useSendData<{}, {}>(companyRefreshTokenApi);
    // const committerRefreshToken = useSendData<{}, {}>(committerRefreshTokenApi);
    // const masterRefreshToken = useSendData<{}, {}>(masterRefreshTokenApi);


    const token = getCookie("token");
    const authority = getCookie("authority");


    const isTokenExpired = () => {
        // const token = getCookie("token");
        // const authority = getCookie("authority");

        // true 일시 만료
        if (!token) return true;
        const parsed = parseJwt(token);
        try {
            const currentTime = Date.now() / 1000;
            return parsed.exp < currentTime;
            // return {
            //     expired: parsed.exp < currentTime,
            //     authority: authority
            // }
        } catch (e) {
            return true;
            // return {
            //     expired: true, // 토큰이 유효하지 않은 경우 만료된 것으로 간주
            //     authority: authority
            // }
        }
    };



    const refreshToken = async () => {
        const isExpired = isTokenExpired();
        if (isExpired) {
            let data;
            switch (authority) {
                case "company":
                    data = await companyRefreshTokenApi();
                    break;
                case "committer":
                    data = await committerRefreshTokenApi();
                    break;
                case "admin":
                    data = await masterRefreshTokenApi();
                    break;
                default: return;
            }

            if (data.data.data.access_token === undefined) {
                console.log(data.data.data);
            } else {
                setCookie("token", data.data.data.access_token);
            }
        }
    }


    return { isTokenExpired, refreshToken}

}


