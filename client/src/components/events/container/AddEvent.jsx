import React, { Component, Fragment } from 'react';
import EventsForm from '../presentation/EventsForm';
import "../stylesheets/events-form.scss";
import eventValidator from '../../../helpers/validators/eventForm';
import centerFormValidator from "../../../helpers/validators/centerForm";

class AddEvent extends Component {
  constructor(props) {
    super(props);

    this.state = {
      name: '',
      description: '',
      guests: '',
      date: new Date(),
      startTime: new Date(),
      endTime: new Date(),
      errorMessages: {
        name: '', description: '', guests: '', startTime: '', endTime: '', date: ''
      },
      fieldsValidity: {
        name: true, description: true, guests: true, startTime: true, endTime: true, date: true
      },
      valid: true
    };

    this.handleChange = this.handleChange.bind(this);
    this.handleDateChange = this.handleDateChange.bind(this);
    this.handleStartTimeChange = this.handleStartTimeChange.bind(this);
    this.handleEndTimeChange = this.handleEndTimeChange.bind(this);
    this.submitEvent = this.submitEvent.bind(this);
  }

  handleChange(e) {
    e.preventDefault();
    const { name, value } = e.target;
    this.setState({
      [name]: value
    });
  }

  handleDateChange(date) {
    this.setState({
      date
    });
  }

  handleStartTimeChange(time) {
    this.setState({
      startTime: time
    });
  }

  handleEndTimeChange(time) {
    this.setState({
      endTime: time
    });
  }

  validForm() {
    return eventValidator(this.state).valid;
  }

  submitEvent(e) {
    e.preventDefault();
    const {
      name, description, guests, date, startTime, endTime
    } = this.state;
    this.setState(eventValidator);

    if (!this.validForm()) {
      console.log([this.state.fieldsValidity, this.state.errorMessages]);
    }
  }

  render() {
    const { name, guests, description, startTime, endTime, date } = this.state;
    return (
      <Fragment>
        <div className="container" id="events-form">
          <div id="inside">
            <EventsForm
              name={name}
              guests={guests}
              description={description}
              date={date}
              startTime={startTime}
              endTime={endTime}
              handleChange={this.handleChange}
              handleDateChange={this.handleDateChange}
              handleStartTimeChange={this.handleStartTimeChange}
              handleEndTimeChange={this.handleEndTimeChange}
              submitEvent={this.submitEvent}
            />
          </div>
        </div>
      </Fragment>
    );
  }
}

export default AddEvent;
