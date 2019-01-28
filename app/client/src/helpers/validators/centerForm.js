import validator from 'validator';

function resetStates(state) {
  for (const key in state.fieldsValidity) {
    state.fieldsValidity[key] = true;
  }
  state.valid = true;
}

export default function centerFormValidator(state) {
  resetStates(state);
  if(validator.isEmpty(state.name)) {
    state.fieldsValidity.name = false;
    state.errorMessages.name = 'Name is missing';
    state.valid = false;
  }
  if(validator.isEmpty(state.address)) {
    state.fieldsValidity.address = false;
    state.errorMessages.address = 'Address is missing';
    state.valid = false;
  }
  if(validator.equals(state.capacity.toString(), '0')) {
    state.fieldsValidity.capacity = false;
    state.errorMessages.capacity = 'Capacity is missing';
    state.valid = false;
  }
  if(validator.isEmpty(state.description)) {
    state.fieldsValidity.description = false;
    state.errorMessages.description = 'Description is missing';
    state.valid = false;
  }

  return {
    name: state.name,
    address: state.address,
    capacity: state.capacity,
    description: state.description,
    fieldsValidity: state.fieldsValidity,
    errorMessages: state.errorMessages,
    valid: state.valid
  };
}
