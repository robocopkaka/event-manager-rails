import AuthApi from '../api/authApi';

export function signupSuccess(user) {
  return { type: 'SIGNUP_SUCCESS' }
}

export function signupFailure(data) {
  return { type: 'SIGNUP_FAILURE', data }
}

export function signupLoading() {
  return { type: 'SIGNUP_LOADING' }
}

export function clearAuthMessage() {
  return { type: 'CLEAR_AUTH_MESSAGE' }
}

export function signup(user) {
  const authUser = { user };
  return (dispatch) => {
    dispatch(signupLoading());
    return AuthApi.signup(authUser)
      .then((response) => {
        dispatch(signupSuccess(response));
        dispatch(clearAuthMessage());
        return '';
      })
      .catch((error) => {
        dispatch(signupFailure(error.response.data));
        dispatch(clearAuthMessage());
        throw error.response.data.message;
      });
  };
}
