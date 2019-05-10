import axios from 'axios';

class EventApi {
  static addEvent(event) {
    return axios.post('/api/v1/centers/1/events', event, {
      headers: {
        Authorization: `${localStorage.token}`
      }
    })
      .then(response => response)
      .catch((error) => {
        throw error
      });
  }
}
export default EventApi;

