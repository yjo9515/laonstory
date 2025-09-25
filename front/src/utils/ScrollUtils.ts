import React from "react";

export const ScrollUtils = {
  scrollAddUpAndDownCheck: (ref: React.RefObject<HTMLDivElement>) => {
    const testHendler = (e: WheelEvent) => {
      // console.log(e.deltaY > 0);
    };
    ref.current?.addEventListener("wheel", testHendler);
    return () => ref.current?.removeEventListener("wheel", testHendler);
  },
};
