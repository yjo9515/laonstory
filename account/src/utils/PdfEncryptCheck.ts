export const PdfEncryptCheck = (fileData: File[]): boolean => {
  let check: boolean = false;

  const callback = (data: boolean) => {
    check = data;
  };
  if (fileData && fileData.length > 0) {
    const file = fileData[0];

    if (file.type.split("/")[1] === "pdf") {
      Test(file, callback);
    }
  }

  return check;
};

const Test = (file: File, callback: any) => {
  const reader = new FileReader();
  reader.readAsArrayBuffer(file);
  reader.onload = async function () {
    if (reader.result) {
      var files = new Blob([reader.result], { type: "application/pdf" });
      await files.text().then((x) => {
        // console.log("isEncrypted", x.includes("Encrypt"));
        // console.log(
        //   "isEncrypted",
        //   x.substring(x.lastIndexOf("<<"), x.lastIndexOf(">>")).includes("/Encrypt")
        // );
        if (
          x.includes("Encrypt") ||
          x.substring(x.lastIndexOf("<<"), x.lastIndexOf(">>")).includes("/Encrypt")
        ) {
          callback(true);
        } else {
          callback(false);
        }
      });
    }
  };
};
