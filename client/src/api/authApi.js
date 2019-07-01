import axios from 'axios';

class AuthApi {
  static signup(user) {
    return axios.post('/api/v1/users', user, {
      headers: {
        'Content-Type': 'application/json',
      }
    })
      .then(response => response.data)
      .catch((error) => {
        // console.log(error)
        throw error;
      });
  }

  static login(user) {
    return axios.post('api/v1/login', user, {
      headers: {
        'Content-Type': 'application/json'
      }
    })
      .then(response =>response.data)
      .catch((error) => {
        throw error;
      });
  }
}

export default AuthApi;
