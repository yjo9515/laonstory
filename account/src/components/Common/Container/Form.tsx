import React from "react";

export default function Form({
  children,
  onSubmit,
  ref,
}: {
  children: React.ReactNode;
  onSubmit: any;
  ref?: React.LegacyRef<HTMLFormElement>;
}) {
  return (
    <form
      onKeyPress={(e) => {
        if (e.key === "Enter") {
          e.preventDefault();
        }
      }}
      onSubmit={onSubmit}
      ref={ref}
    >
      {children}
    </form>
  );
}
