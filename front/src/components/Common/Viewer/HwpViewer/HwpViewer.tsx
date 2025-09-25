// 현재 사용 안됨

import React, { useState, useCallback, useEffect, useRef } from "react";
import { Viewer } from "hwp.js";

function HwpViewer() {
  const url = "download URL";
  const ref = useRef<any>(null);

  useEffect(() => {
    loadFile();
  }, []);

  const showViewer = useCallback((file: Blob) => {
    const reader = new FileReader();

    reader.onloadend = (result) => {
      var _a;
      const bstr: any = (_a = result.target) === null || _a === void 0 ? void 0 : _a.result;

      if (bstr) {
        try {
          new Viewer(ref.current, bstr);
        } catch (e) {
          // console.log(e);
        }
      }
    };

    reader.readAsBinaryString(file);
  }, []);

  const loadFile = useCallback(() => {
    var xhr = new XMLHttpRequest();
    xhr.responseType = "blob";
    xhr.onload = function (event) {
      showViewer(new File([xhr.response], "random"));
    };
    xhr.open("GET", url);
    xhr.send();
  }, []);

  return (
    <div className="viewer" ref={ref}>
      11
    </div>
  );
}

export default HwpViewer;
