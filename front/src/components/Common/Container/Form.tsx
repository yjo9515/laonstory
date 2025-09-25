import React from "react";

export default function Form({
  children,
  onSubmit,
}: {
  children: React.ReactNode;
  onSubmit?: any;
}) {
  return (
    <form
      onKeyPress={(e) => {
        if (e.key === "Enter") {
          e.preventDefault();
        }
      }}
      onSubmit={onSubmit}
    >
      {children}
    </form>
  );
}
