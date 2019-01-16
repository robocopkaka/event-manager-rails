import { combineReducers } from 'redux';
import centers from './centerReducer';
import auth from './authReducer';

const rootReducer = combineReducers({
  centers,
  auth
});

export default rootReducer;
