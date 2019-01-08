import axios from 'axios';

class AuthApi {
  static signup(user) {
    return axios.post('/api/v1/users', user, {
      headers: {
        'Content-Type': 'application/json',
      }
    })
      .then(response => response.data)
      .catch(error => new Error(error))
  }
}

export default AuthApi;
