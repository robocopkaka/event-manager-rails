import axios from 'axios';

class CenterApi {
  static getCenters() {
    // console.log("gets here")
    return axios.get('/api/v1/centers',{
      headers: {
        'Content-Type': 'application/json',
      }
    })
      .then((response) => response)
      .catch(error => error);
  }

  static addCenter(center) {
    console.log(center)
    return axios.post('/api/v1/centers', center, {
      headers: {
        // 'Content-Type': 'application/json',
        // 'Content-Type': 'multipart/form-data',
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
