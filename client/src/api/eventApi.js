import axios from 'axios';

class EventApi {
  static addEvent(event, centerId) {
    return axios.post(`/api/v1/centers/${centerId}/events`, event, {
      headers: {
        Authorization: `Bearer ${localStorage.token}`
      }
    })
      .then(response => response)
      .catch((error) => {
        throw error;
      });
  }
}
export default EventApi;
