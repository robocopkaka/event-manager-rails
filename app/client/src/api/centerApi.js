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

  static fetchOne(id) {
    return axios.get(`/api/v1/centers/${id}`, {
      headers: {
        'Content-type': 'application/json'
      }
    })
      .then(response => response)
      .catch(error => {
        throw error;
      });
  }

  static updateCenter(id, center) {
    return axios.put(`/api/v1/centers/${id}`, center, {
      headers: {
        Authorization: `Bearer ${localStorage.token}`
      }
    })
      .then(response => response)
      .catch(error => {
        throw error;
      });
  }
}

export default CenterApi;
