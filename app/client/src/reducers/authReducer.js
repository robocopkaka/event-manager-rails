import update from 'immutability-helper';
import * as types from '../actions/actionTypes';
import initialState from './initialState';

export default function authReducer(state = initialState.auth, action) {
  console.log(action)
  let newState = {};
  switch(action.type) {
    case types.SIGNUP_SUCCESS:
      newState = update(state, {
        authenticated: {  $set: true },
        currentUser: { $set: action.user }
      });
      return newState;
    case types.SIGNUP_FAILURE:
      newState = update(state, {
        errorMessage: { $set: action.data.message }
      });
      return newState;
    default:
      return state;
  }
}