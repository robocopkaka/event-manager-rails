import validator from 'validator';
import moment from 'moment';

function resetStates(state) {
  for (const key in state.fieldsValidity) {
    state.fieldsValidity[key] = true;
    state.errorMessages[key] = '';
  }
  state.valid = true;
}

function resolveTimes(date, startTime, endTime ) {
  const newDate = moment(date).format('YYYY-MM-DD');
  const beginTime = moment(startTime).format('HH:mm:ss');
  const closeTime = moment(endTime).format('HH:mm:ss');
  const begin = moment(`${newDate.toString()} ${beginTime.toString()}`, 'YYYY-MM-DDLT').format('YYYY-MM-DDTHH:mm:ss');
  const end = moment(`${newDate.toString()} ${closeTime.toString()}`, 'YYYY-MM-DDLT').format('YYYY-MM-DDTHH:mm:ss');
  return [begin, end];
}

export default function eventValidator(state) {
  resetStates(state);
  let {
    name, description, guests, startTime, endTime,
    fieldsValidity, errorMessages, valid, date
  } = state;
  const [begin, end] = resolveTimes(date, startTime, endTime);
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

  if (moment(begin).isBefore(moment(), 'minute')) {
    fieldsValidity.startTime = false;
    errorMessages.startTime = 'Start time is in the past';
    valid = false;
  }

  if (moment(end) .isBefore(begin, 'minute')) {
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
