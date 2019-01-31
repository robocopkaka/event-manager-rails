import decode from 'jwt-decode';
import AuthApi from '../api/authApi';
import setHeaders from '../helpers/setHeaders';

export function signupSuccess(user) {
  return { type: 'SIGNUP_SUCCESS' };
}

export function signupFailure(data) {
  return { type: 'SIGNUP_FAILURE', data };
}

export function loginSuccess(user) {
  return { type: 'LOGIN_SUCCESS', user };
}

export function loginFailure(data) {
  return { type: 'LOGIN_FAILURE', data };
}

export function authLoading() {
  return { type: 'AUTH_LOADING' };
}

export function clearAuthMessage() {
  return { type: 'CLEAR_AUTH_MESSAGE' };
}

export function logoutSuccess() {
  return { type: 'LOGOUT_SUCCESS' };
}

export function signup(user) {
  const authUser = { user };
  return (dispatch) => {
    dispatch(authLoading());
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

export function login(user) {
  return (dispatch) => {
    dispatch(authLoading());
    return AuthApi.login(user)
      .then((response) => {
        setHeaders(response.jwt);
        const decodedToken = decode(response.jwt);
        localStorage.setItem('userId', decodedToken.sub);
        localStorage.setItem('token', response.jwt);
        dispatch(loginSuccess(decodedToken.sub));
        dispatch(clearAuthMessage());
      })
      .catch((error) => {
        console.log(error.response, 'error')
        dispatch(loginFailure(error));
        dispatch(clearAuthMessage());
      });
  };
}

export function logout() {
  return (dispatch) => {
    dispatch(authLoading());
    localStorage.removeItem("userId");
    dispatch(logoutSuccess());
  };
}
