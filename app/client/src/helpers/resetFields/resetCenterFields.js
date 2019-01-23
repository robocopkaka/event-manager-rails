export default function resetCenterFields(state) {
  for (const key in state.fieldsValidity) {
    state.fieldsValidity[key] = true;
  }

  for (const key in state.errorMessages) {
    state.errorMessages[key] = '';
  }

  return {
    name: '',
    address: '',
    description: '',
    capacity: 0,
    fieldsValidity: state.fieldsValidity,
    errorMessages: state.errorMessages,
    valid: true
  };
}
