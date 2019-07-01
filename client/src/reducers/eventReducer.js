import update from 'immutability-helper';
import * as types from '../actions/actionTypes';
import initialState from './initialState';

export default function eventReducer(state = initialState.events, action) {
  let newState;
  switch (action.type) {
    case types.ADD_EVENT_SUCCESS:
      newState = update(state, {
        event: { $set: action.event },
        message: { $set: 'Event created successfully' },
        toastType: { $set: 'is-success' },
        isLoading: { $set: false }
      });
      return newState;
    case types.EVENT_FAILURE:
      newState = update(state, {
        message: { $set: action.error.message },
        isLoading: { $set: false },
        toastType: { $set: 'is-danger' }
      });
      return newState;
    case types.EVENT_LOADING:
      newState = update(state, {
        isLoading: { $set: true }
      });
      return newState;
    case types.CLEAR_EVENT_MESSAGE:
      newState = update(state, {
        message: { $set: '' },
        toastType: { $set: '' }
      });
      return newState;
    default:
      return state;
  }
}
