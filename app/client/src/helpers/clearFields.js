export default function clearFields(state) {
  const { formValidity, errorMessages } = state;
  for (const[key] in formValidity) {
    formValidity[key] = true;
  }
  for (const[key] in errorMessages) {
    errorMessages[key] = '';
  }

  return {
    name: '',
    email: '',
    password: '',
    passwordConfirmation: '',
    formValidity,
    errorMessages,
    formValid: true
  };
}
