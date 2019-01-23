import CenterApi from '../api/centerApi';
import {ADD_CENTER_FAILURE, ADD_CENTER_LOADING, ADD_CENTER_SUCCESS, CLEAR_CENTER_ACTION_MESSAGE} from './actionTypes';

export function fetchCentersSuccess(centers) {
  return { type: 'FETCH_CENTERS_SUCCESS', centers };
}

export function addCenterSuccess(center) {
  return { type: ADD_CENTER_SUCCESS, center };
}
export function addCenterFailure(error) {
  return { type: ADD_CENTER_FAILURE, error };
}
export function addCenterLoading() {
  return { type: ADD_CENTER_LOADING };
}

export function clearCenterActionMessage() {
  return { type: CLEAR_CENTER_ACTION_MESSAGE };
}

export function fetchCenters() {
  return (dispatch) => {
    return CenterApi.getCenters()
      .then((response) => {
        dispatch(fetchCentersSuccess(response.data.data.centers));
      })
      .catch((error) => {
        throw (error);
      });
  };
}

export function addCenter(center) {
  return (dispatch) => {
    dispatch(addCenterLoading());
    return CenterApi.addCenter(center)
      .then((response) => {
        dispatch(addCenterSuccess(response.data.center));
        dispatch(clearCenterActionMessage());
      })
      .catch((error) => {
        dispatch(addCenterFailure(error.response.data));
        dispatch(clearCenterActionMessage());
        throw error.response.data;
      });
  };
}
