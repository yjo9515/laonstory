import styled from "styled-components";

export function CheckBox({ register }: { register: any }) {
  return <CheckBoxContainer type="checkbox" {...register} />;
}

const CheckBoxContainer = styled.input`
  border: 1px solid ${(props) => props.theme.colors.gray4};
  width: 24px;
  height: 24px;
`;
