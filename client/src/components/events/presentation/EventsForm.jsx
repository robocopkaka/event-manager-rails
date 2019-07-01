import React, { Fragment } from 'react';
import DatePicker from 'react-datepicker';
import "react-datepicker/dist/react-datepicker.css";

const EventsForm = ({
 name, guests, description, date, startTime, endTime, handleChange, handleDateChange,
 handleEndTimeChange, handleStartTimeChange, submitEvent
}) => (
  <Fragment>
    <form onSubmit={submitEvent}>
      <div className="field">
        <label htmlFor="name" className="label">Name</label>
        <div className="control">
          <input type="text" className="input" name="name" onChange={handleChange} />
        </div>
      </div>
      <div className="field">
        <label htmlFor="guests" className="label">Guests</label>
        <div className="control">
          <input type="number" className="input" name="guests" onChange={handleChange} />
        </div>
      </div>
      <div className="field">
        <label htmlFor="description" className="label">Description</label>
        <div className="control">
          <textarea name="description" className="textarea" name="description" onChange={handleChange} />
        </div>
      </div>
      <div className="field">
        <label htmlFor="" className="label">Date</label>
        <div className="control" id="event-date">
          <DatePicker
            selected={ date }
            onChange={handleDateChange}
          />
        </div>
      </div>
      <div className="field" id="event-times">
        <label htmlFor="" className="label">Time</label>
        <div className="control">
          <span id="from-time">
            <DatePicker
              selected={startTime}
              showTimeSelect
              showTimeSelectOnly
              dateFormat="h:mm aa"
              timeCaption="Time"
              onChange={handleStartTimeChange}
            />
          </span>

          <span id="time-separator">To</span>
          <span id="to-time">
            <DatePicker
              selected={endTime}
              showTimeSelect
              showTimeSelectOnly
              dateFormat="h:mm aa"
              timeCaption="Time"
              onChange={handleEndTimeChange}
            />
          </span>
        </div>
      </div>
      <div className="field">
        <p className="control">
          <button className="button is-primary">Submit</button>
        </p>
      </div>
    </form>
  </Fragment>
);
export default EventsForm;
