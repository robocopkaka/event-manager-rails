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
}

export default CenterApi;
