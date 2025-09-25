/** pdf,jpg,png 파일 타입에 맞지 않는지 검사하는 함수 */
export const checkFileType = (files: File[][]) => {
  let result = false;
  files.forEach((file) => {
    const fileType = file[0].type;
    if (fileType !== "image/jpeg" && fileType !== "image/png" && fileType !== "application/pdf") {
      result = true;
    }
  });

  return result;
};
