import React, { useEffect, useState } from 'react';
import axios from 'axios';

interface jsonData {
    isEmail? : boolean,
    isPhone? : boolean,
    isName? : boolean,
    isCompanyName? : boolean
    
}

class masking {
     config:jsonData = {
        isEmail : false,
        isPhone : false,
        isName : false,
        isCompanyName : false,
     };

    async fetchConfig() {
        try {
          const response = await axios.get('/MaskingConfig.json');          
          this.config = response.data;          
          return this.config;  // 데이터를 반환
        } catch (error) {
          console.error("Error loading config:", error);
          throw error;  // 에러 발생 시 throw
        }
      }

      maskingEmail(val: String) {                
        if(this.config == null) return;
        if(this.config.isEmail == true){
            if (!val) {
                return "";
              }
            
              const atIndex = val.indexOf("@");
              if (atIndex === -1 || atIndex === 0) return val; // 유효하지 않은 이메일 형식은 그대로 반환
      
              // 첫 글자만 남기고 @ 앞을 마스킹 처리
              const firstChar = val[0]; // 첫 글자
              const maskedPart = "*".repeat(atIndex - 1); // @ 앞의 나머지 부분을 *로 마스킹
              const domain = val.substring(atIndex); // @ 포함 뒤쪽 부분
      
              return `${firstChar}${maskedPart}${domain}`;
        }
        return val;
      }

      maskingName(val: String) {        
        if(this.config.isName == true){
            if (!val) {
                return "";
              }
              // 이름이 2글자 이상일 때만 마스킹 처리
            if (val.length <= 1) return val;
            // if (val.length > 4) return val;

            // 성과 마지막 글자는 남기고, 나머지를 마스킹 처리
            const firstChar = val[0]; // 첫 글자 (성)
            const lastChar = val[val.length - 1]; // 마지막 글자
            const middleMasked = "*".repeat(val.length - 2); // 중간을 *로 마스킹

            return `${firstChar}${middleMasked}${lastChar}`;
        }
        return val;
      }

      maskingPhone(val:String){
        if(this.config.isPhone == true){
            if(!val){
                return "";
            }           
        // 하이픈이 포함된 형식 확인
        const hasHyphen = val.includes("-");

        // 하이픈이 있으면 그대로 처리, 없으면 하이픈 없는 형식으로 처리
        const phoneRegex = hasHyphen ? /^(\d{3})-(\d{3,4})-(\d{4})$/ : /^(\d{3})(\d{3,4})(\d{4})$/;
        const matches = val.match(phoneRegex); // 원래 형식에 맞춰 매칭

        if (!matches) return val; // 형식이 맞지 않으면 그대로 반환

        const maskedMid = "*".repeat(matches[2].length); // 중간 번호를 *로 마스킹

        // 원래 형식을 유지한 채로 마스킹된 번호 반환
        return hasHyphen ? `${matches[1]}-${maskedMid}-${matches[3]}` : `${matches[1]}${maskedMid}${matches[3]}`;
        }
        return val;
      }      

      maskingCompanyName(val:String){
        if(this.config.isCompanyName == true){
            if(!val){
              return "";
            }
            return '*' + val.slice(1);
        }
        return val;
      }
}

export default new masking();
