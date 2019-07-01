import EventApi from '../api/eventApi';
import {
  ADD_EVENT_SUCCESS, CLEAR_EVENT_MESSAGE, EVENT_FAILURE, EVENT_LOADING
} from './actionTypes';

export function addEventSuccess(event) {
  return { type: ADD_EVENT_SUCCESS, event };
}

export function addEventLoading() {
  return { type: EVENT_LOADING };
}

export function addEventFailure(error) {
  return { type: EVENT_FAILURE, error };
}

export function clearEventMessage() {
  return { type: CLEAR_EVENT_MESSAGE };
}

export function saveEvent(event, centerId) {
  return (dispatch) => {
    dispatch(addEventLoading());
    return EventApi.addEvent(event, centerId)
      .then((response) => {
        dispatch(addEventSuccess(response.data.event));
        dispatch(clearEventMessage())
      })
      .catch((error) => {
        dispatch(addEventFailure(error.response.data));
        dispatch(clearEventMessage())
      });
  };
}
