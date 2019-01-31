import validator from 'validator';

function resetStates(state) {
  for (const key in state.formValidity) {
    state.formValidity[key] = true
  }
  state.formValid = true;
}

function loginValidator(state) {
  const newState = Object.assign({}, state);
  resetStates(newState);

  if (validator.isEmpty(newState.email)) {
    newState.errorMessages.email = 'Email is missing';
    newState.formValidity.email = false;
    newState.formValid = false;
  }

  if (!validator.isEmail(newState.email)) {
    newState.errorMessages.email = 'Email is invalid';
    newState.formValidity.email = false;
    newState.formValid = false;
  }

  if (validator.isEmpty(newState.password)) {
    newState.errorMessages.password = 'Password is missing';
    newState.formValidity.password = false;
    newState.formValid = false
  }
  return {
    email: newState.email,
    password: newState.password,
    formValidity: newState.formValidity,
    formValid: newState.formValid
  };
}

export default loginValidator;