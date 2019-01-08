import validator from 'validator';

// Loop through the items in the formValidity object
// and set all of them to true. This helps clear
// warnings on fields whose inputs have been corrected after an initial
// error.
function setValidAttributesToTrue(form) {
  for (const key in form) {
    form[key] = true;
  }
}

export default function validateForm(state) {
  const newState = Object.assign({}, state);
  setValidAttributesToTrue(newState.formValidity)
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
