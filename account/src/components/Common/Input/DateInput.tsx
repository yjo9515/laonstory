import styled from "styled-components";
import theme from "../../../theme";

import LabelButton from "../Button/LabelButton";

interface IInputSetProps {  
  onChange?: (e: React.ChangeEvent<HTMLInputElement>) => void;
  name: string;
  id: string;
  value?: string;
}

export default function DateInput(
    {  
  onChange,
  name,
  id,
  value
}: IInputSetProps
) {
  return (
    <InputSetContainer type="date" name={name} id={id} onChange={onChange} value={value} autoComplete="false" />      
    
  );
}

const InputSetContainer = styled.input`
    height: 30px;
    border: 1px solid;    
    border-radius: 5px;
    padding-left: 5px;

`;
