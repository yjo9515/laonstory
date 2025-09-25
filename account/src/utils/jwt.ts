import { Buffer } from 'buffer';
import { getCookie, setCookie } from './ReactCookie';
import { masterRefreshTokenApi, refreshTokenApi } from '../api/AuthApi';


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

    const token = getCookie("token");
    const role = getCookie("role");


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
            switch (role) {
                case "user":
                    data = await refreshTokenApi();
                    break;
                case "admin":
                    data = await masterRefreshTokenApi();
                    break;
                default: return;
            }

            if (data.data.data.access_token === undefined) {
                console.log(data.data.data);
            } else {
                console.log(data.data.data.access_token);
                await setCookie("token", data.data.data.access_token);
                console.log(getCookie('token'));
            }
        }
    }


    return { isTokenExpired, refreshToken}

}


