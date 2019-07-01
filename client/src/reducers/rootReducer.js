import { combineReducers } from 'redux';
import centers from './centerReducer';
import events from './eventReducer';
import active from './activeReducer';
import auth from './authReducer';

const rootReducer = combineReducers({
  centers,
  events,
  auth,
  active
});

export default rootReducer;
