import { combineReducers } from 'redux';
import centers from './centerReducer';
import active from './activeReducer';
import auth from './authReducer';

const rootReducer = combineReducers({
  centers,
  auth,
  active
});

export default rootReducer;
