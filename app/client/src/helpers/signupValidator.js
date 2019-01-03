import validator from 'validator';

export default function validateForm(state) {
  const newState = Object.assign({}, state);
  if(validator.isEmpty(newState.name)) {
    newState.errorMessages.name = 'Name is missing';
    newState.formValidity.name = false;
    newState.formValid = false;
  }
  if(validator.isEmpty(newState.email)) {
    newState.errorMessages.email = 'Email is missing';
    newState.formValidity.email = false;
    newState.formValid = false;
  }
  if(!validator.isEmail(newState.email)) {
    newState.errorMessages.email = 'Email is invalid';
    newState.formValidity.email = false;
    newState.formValid = false;
  }
  if(validator.isEmpty(newState.password)) {
    newState.errorMessages.password = 'Password is missing';
    newState.formValidity.password = false;
    newState.formValid = false;
  }
  if(validator.isEmpty(newState.passwordConfirmation)) {
    newState.errorMessages.passwordConfirmation = 'Password confirmation is missing';
    newState.formValidity.passwordConfirmation = false;
    newState.formValid = false;
  }
  if(!validator.equals(newState.password, newState.passwordConfirmation)) {
    newState.errorMessages.passwordConfirmation = 'Passwords don\'t match';
    newState.formValidity.passwordConfirmation = false;
    newState.formValid = false;
  }
  return {
    name: newState.name,
    email: newState.email,
    password: newState.password,
    passwordConfirmation: newState.passwordConfirmation,
    formValid: newState.formValid
  };
}