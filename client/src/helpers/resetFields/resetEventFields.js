export default function resetEventFields(state) {
  for (const key in state.fieldsValidity) {
    state.fieldsValidity[key] = true;
  }

  for (const key in state.errorMessages) {
    state.errorMessages[key] = '';
  }

  return {
    name: '',
    description: '',
    guests: 0,
    date: new Date(),
    startTime: new Date(),
    endTime: new Date(),
    fieldsValidity: state.fieldsValidity,
    errorMessages: state.errorMessages
  };
}
