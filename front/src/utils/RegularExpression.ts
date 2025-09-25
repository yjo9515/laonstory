/* eslint-disable no-useless-escape */
export const Regex = {
  emailRegex: /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/,
  idRegex: /[a-z,0-9]{9,15}/,
  phoneRegExp: /^\d{11}$/,
  accountRegex: /[0-9,\-]{3,6}\-[0-9,\-]{2,6}\-[0-9,\-]/,
  primeNumberRegex: /^[\d]*\.?[\d]{0,4}$/,
  numberRegex: /^[0-9]+$/,
  passwordRegex: /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/,
};
