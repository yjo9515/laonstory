import React from "react";
import { useRecoilValue } from "recoil";
import styled from "styled-components";
import { alertModalState } from "../../modules/Client/Modal/Modal";

export default function Overlay({ children }: { children: React.ReactNode }) {
  const alertModal = useRecoilValue(alertModalState);

  return <OverlayContainer isAlert={alertModal.isModal}>{children}</OverlayContainer>;
}

const OverlayContainer = styled.div<{ isAlert: boolean }>`
  position: fixed; /* Stay in place */
  /* z-index: ${(props) => (props.isAlert ? 500 : 100)}; Sit on top */
  z-index: 999;
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0, 0, 0); /* Fallback color */
  background-color: rgba(0, 0, 0, 0.7); /* Black w/ opacity */
  display: flex;
  justify-content: center;
  align-items: center;
`;
