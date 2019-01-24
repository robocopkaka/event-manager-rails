import axios from 'axios';

class CenterApi {
  static getCenters() {
    return axios.get('/api/v1/centers',{
      headers: {
        'Content-Type': 'application/json',
      }
    })
      .then((response) => response)
      .catch(error => error);
  }

  static addCenter(center) {
    return axios.post('/api/v1/centers', center, {
      headers: {
        Authorization: `${localStorage.token}`
      }
    })
      .then(response => response)
      .catch(error => {
        throw error;
      });
  }
}

export default CenterApi;
