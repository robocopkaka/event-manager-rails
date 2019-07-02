import React, { Fragment } from 'react';
import { Link } from 'react-router-dom';
import moment from 'moment';
import '../stylesheets/single-center.scss';
import '../../events/stylesheets/events.scss';
import eventImg from '../../../images/Events-1200x630.jpg';


const CenterPage = ({ center, events }) => {
  return (
    <Fragment>
      <div className="center-page">
        <div id="center-details">
          <div className="columns">
            <div className="column is-two-fifths" id="center-page-left">
              <img src={eventImg} alt="" />
            </div>
            <div className="column is-three-fifths" id="center-page-right">
              <h2 id="center-name">{center.name}</h2>
              <div id="center-address">{center.address}</div>
              <p id="description-heading">Brief description:
                <br />
                <span id="center-description">{center.description}</span>
              </p>
              <div id="event-button">
                <Link to={`/centers/${center.id}/add-event`} className="button is-medium"> Add Event </Link>
              </div>
            </div>
          </div>
        </div>

        <div className="center-events">
          <h2 id="center-events-heading">Upcoming events</h2>
          <div className="container">
            <div className="columns is-8 is-multiline" id="events-set">
              {events.map((event) => (
                <div className="column is-4 is-mobile" id="event-column" key={event.id}>
                  <div className="card" id="event-card">
                    <div className="card-content">
                      <div className="content">
                        <div className="event-time">
                          {moment(event.start_time).format('LLL')}
                        </div>
                        <div className="event-name">{event.name}</div>
                        <div className="event-address">
                          <span className="icon">
                            <i className="fa fa-map-marker" />
                          </span>
                          {center.address}
                        </div>
                        <div id="event-attendees">
                          <div id="attendees">
                            {event.guests} slots remaining
                          </div>
                          <div id="book-event">
                            <Link to={'#'} className="button is-medium">Book</Link>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </Fragment>
  );
};

export default CenterPage;
