import CenterApi from '../api/centerApi';
import {
  CENTER_FAILURE,
  CENTER_LOADING,
  ADD_CENTER_SUCCESS,
  CLEAR_CENTER_ACTION_MESSAGE,
  FETCH_CENTERS_SUCCESS,
  FETCH_SINGLE_CENTER_SUCCESS, UPDATE_CENTER_SUCCESS
} from './actionTypes';

export function fetchCentersSuccess(centers) {
  return { type: FETCH_CENTERS_SUCCESS, centers };
}

export function addCenterSuccess(center) {
  return { type: ADD_CENTER_SUCCESS, center };
}

export function centerFailure(error) {
  return { type: CENTER_FAILURE, error };
}
export function centerLoading() {
  return { type: CENTER_LOADING };
}

export function updateCenterSuccess(center) {
  return { type: UPDATE_CENTER_SUCCESS, center };
}

export function clearCenterActionMessage() {
  return { type: CLEAR_CENTER_ACTION_MESSAGE };
}

export function fetchSingleCenterSuccess(center) {
  return { type: FETCH_SINGLE_CENTER_SUCCESS, center };
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
    dispatch(centerLoading());
    return CenterApi.addCenter(center)
      .then((response) => {
        dispatch(addCenterSuccess(response.data.data.center));
        dispatch(clearCenterActionMessage());
      })
      .catch((error) => {
        dispatch(centerFailure(error.response.data));
        dispatch(clearCenterActionMessage());
        throw error.response.data;
      });
  };
}

export function fetchSingleCenter(id) {
  return (dispatch) => {
    dispatch(centerLoading());
    return CenterApi.fetchOne(id)
      .then((response) => {
        dispatch(fetchSingleCenterSuccess(response.data.data.center));
      })
      .catch((error) => {
        console.log(error.response)
        dispatch(centerFailure(error.response.data));
        throw error.response.data;
      });
  };
}

export function updateCenter(id, center) {
  return (dispatch) => {
    dispatch(centerLoading());
    return CenterApi.updateCenter(id, center)
      .then((response) => {
        dispatch(updateCenterSuccess(response.data.data.center));
        dispatch(clearCenterActionMessage());
      })
      .catch((error) => {
        dispatch(centerFailure(error.response.data));
        dispatch(clearCenterActionMessage());
        throw error.response.data;
      });
  };
}
