import validator from 'validator';

export default function eventValidator(state) {
  let {
    name, description, guests, startTime, endTime,
    fieldsValidity, errorMessages, valid
  } = state;
  if (validator.isEmpty(name)) {
    fieldsValidity.name = false;
    errorMessages.name = 'Name is missing';
    valid = false;
  }

  if (validator.isEmpty(description)) {
    fieldsValidity.description = false;
    errorMessages.description = 'Description is missing';
    valid = false;
  }

  if (validator.isAfter(startTime.toLocaleTimeString(), new Date().toLocaleTimeString())) {
    fieldsValidity.startTime = false;
    errorMessages.startTime = 'Start time is in the past';
    valid = false;
  }

  if (validator.isBefore(endTime.toLocaleTimeString(), startTime.toLocaleTimeString())) {
    fieldsValidity.endTime = false;
    errorMessages.endTime = 'End time should not be earlier than start time';
    valid = false;
  }

  if (!validator.isInt(guests)) {
    fieldsValidity.guests = false;
    errorMessages.guests = 'Guests should be a number';
    valid = false;
  }

  return {
    name,
    guests,
    description,
    startTime,
    endTime,
    fieldsValidity,
    errorMessages,
    valid
  };
}
