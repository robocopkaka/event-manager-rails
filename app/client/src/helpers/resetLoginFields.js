export default function resetLoginFields(state) {
  for (const key in state.formValidity) {
    state.formValidity[key] = true;
  }

  for (const key in state.errorMessages) {
    state.errorMessages[key] = '';
  }

  return {
    email: '',
    password: '',
    formValidity: state.formValidity,
    errorMessages: state.errorMessages,
    formValid: true
  };
}