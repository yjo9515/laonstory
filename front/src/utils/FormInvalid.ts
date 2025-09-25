import { FieldErrorsImpl } from 'react-hook-form';

export function formInvalid(errors: FieldErrorsImpl, inputs: string[]) {
  for (let i = 0; i < inputs.length; i++) {
    const currentError = errors[inputs[i]];
    if (currentError?.message) {
      return {
        isModal: true,
        content: currentError.message as string,
      };
    }
  }
}
