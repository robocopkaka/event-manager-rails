import EventApi from "../api/eventApi";

export function addEventSuccess(event) {
  return { type: 'ADD_EVENT_SUCCESS', event }
}

export function addEvent(event) {
  return (dispatch) => {
    EventApi.addEvent(event)
      .then((response) => {
        console.log(response)
      })
      .catch((error) => {
        console.log(error.response)
      })
  }
}