import React, { Component, Fragment } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import moment from 'moment';
import EventsForm from '../presentation/EventsForm';
import '../stylesheets/events-form.scss';
import eventValidator from '../../../helpers/validators/eventForm';
import * as eventActions from '../../../actions/eventActions';

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

    if (this.validForm()) {
      const newDate = moment(date).format('YYYY-MM-DD');
      const start = moment(`${newDate.toString()} ${startTime.toString()}`, 'YYYY-MM-DDLT').format('YYYY-MM-DDTHH:mm:ss');
      const end = moment(`${newDate.toString()} ${endTime.toString()}`, 'YYYY-MM-DDLT').format('YYYY-MM-DDTHH:mm:ss');
      const event = new FormData();
      event.append('event[name]', name);
      event.append('event[description]', description);
      event.append('event[guests]', guests);
      event.append('event[start_time]', start);
      event.append('event[end_time]', end);

      this.props.actions.addEvent(event);
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

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(eventActions, dispatch)
  };
}

export default connect(null, mapDispatchToProps)(AddEvent);
