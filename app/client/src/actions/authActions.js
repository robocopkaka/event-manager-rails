import AuthApi from '../api/authApi';

export function signupSuccess(user) {
  return { type: 'SIGNUP_SUCCESS' }
}

export function signupFailure() {
  return { type: 'SIGNUP_FAILURE' }
}

export function signupLoading() {
  return { type: 'SIGNUP_LOADING' }
}

export function signup(user) {
  console.log(user);
  const authUser = { user };
  return (dispatch) => {
    dispatch(signupLoading());
    return AuthApi.signup(authUser)
      .then((response) => {
        dispatch(signupSuccess(response))
      })
      .catch((error) => {
        console.log(error)
        dispatch(signupFailure())
      });
  };
}
