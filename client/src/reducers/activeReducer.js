import update from 'immutability-helper';
import initialState from './initialState';
import * as types from '../actions/actionTypes';

export default function activeReducer(state = initialState.active, action)  {
  switch (action.type) {
    case types.HOME_ACTIVE:
      return update(state, {
        home: { $set: true },
        centers: { $set: false },
        events: { $set: false }
      });
    case types.CENTERS_ACTIVE:
      return update(state, {
        centers: { $set: true },
        home: { $set: false },
        events: { $set: false }
      });
    case types.EVENTS_ACTIVE:
      return update(state, {
        events: { $set: true },
        centers: { $set: false },
        home: { $set: false }
      });
    default:
      return state;
  }
}