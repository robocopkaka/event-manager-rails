import * as types from '../actions/actionTypes';
import initialState from './initialState';

export default function centerReducer(state=initialState.centers, action) {
  switch (action.type) {
    case types.FETCH_CENTERS_SUCCESS:
      return action.centers;
    default:
      return state;
  }
}
