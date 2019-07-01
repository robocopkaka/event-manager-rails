import React, { Fragment } from 'react';
import { Link } from 'react-router-dom';
import PropTypes from 'prop-types';
import '../stylesheets/single-center.scss';
import event from '../../../images/Events-1200x630.jpg';


const CenterPage = ({ center }) => {
  return (
    <Fragment>
      <div className="center-page">
        <div id="center-details">
          <div className="columns">
            <div className="column is-two-fifths" id="center-page-left">
              <img src={event} alt="" />
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
            <div className="columns is-8">
              <div className="column is-one-third" id="center-column" key={1}>
                <div className="card" id="center-card">
                  <div className="card-image">
                    <figure className="image is-3by3">
                      <img src={event} alt=""/>
                    </figure>
                  </div>
                  <div className="card-content">
                    <div className="content">
                      <div className="center-name">{center.name}</div>
                      <div className="center-address">
                        {center.address}
                      </div>
                    </div>
                  </div>
                  <footer className="card-footer">
                    <div id="center-capacity">
                      <span id="capacity-heading">Capacity</span> <br/>
                      <span>{center.capacity}</span>
                    </div>
                    <div className="is-divider-vertical" />
                    <div id="center-others">
                      <span id="capacity-heading">Book</span> <br/>
                      <span>Now</span>
                    </div>
                  </footer>
                </div>
              </div>
              <div className="column is-one-third" id="center-column" key={1}>
                <div className="card" id="center-card">
                  <div className="card-image">
                    <figure className="image is-3by3">
                      <img src={event} alt=""/>
                    </figure>
                  </div>
                  <div className="card-content">
                    <div className="content">
                      <div className="center-name">{center.name}</div>
                      <div className="center-address">
                        {center.address}
                      </div>
                    </div>
                  </div>
                  <footer className="card-footer">
                    <div id="center-capacity">
                      <span id="capacity-heading">Capacity</span> <br/>
                      <span>{center.capacity}</span>
                    </div>
                    <div className="is-divider-vertical" />
                    <div id="center-others">
                      <span id="capacity-heading">Book</span> <br/>
                      <span>Now</span>
                    </div>
                  </footer>
                </div>
              </div>
              <div className="column is-one-third" id="center-column" key={1}>
                <div className="card" id="center-card">
                  <div className="card-image">
                    <figure className="image is-3by3">
                      <img src={event} alt=""/>
                    </figure>
                  </div>
                  <div className="card-content">
                    <div className="content">
                      <div className="center-name">{center.name}</div>
                      <div className="center-address">
                        {center.address}
                      </div>
                    </div>
                  </div>
                  <footer className="card-footer">
                    <div id="center-capacity">
                      <span id="capacity-heading">Capacity</span> <br/>
                      <span>{center.capacity}</span>
                    </div>
                    <div className="is-divider-vertical" />
                    <div id="center-others">
                      <span id="capacity-heading">Book</span> <br/>
                      <span>Now</span>
                    </div>
                  </footer>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </Fragment>
  );
};

export default CenterPage;
