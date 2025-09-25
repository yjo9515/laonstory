import { useEffect, useRef } from "react";

export const useOutSideClick = (setShow: () => void) => {
  const ref = useRef(null);

  useEffect(() => {
    const clickOutside = (e: MouseEvent) => {
      const current = ref?.current as any;

      if (current && !current.contains(e.target)) {
        setShow();
      }
    };

    document.addEventListener("mousedown", clickOutside);

    return () => document.removeEventListener("mousedown", clickOutside);
  }, [ref]);
  return { ref };
};
