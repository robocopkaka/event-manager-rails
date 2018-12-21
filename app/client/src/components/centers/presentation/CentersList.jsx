import React from 'react';
import PropTypes from 'prop-types';
import event from '../../../images/Events-1200x630.jpg';
import '../stylesheets/centers.scss';

const MAX_LENGTH = 50;

const CentersList = ({centers}) => (
  <React.Fragment>
    {centers.map(center => (
        <div className="column is-one-quarter" id="center-column" key={center.id}>
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
                <div className="center-description">
                  {center.description.length > MAX_LENGTH ?
                    (
                      <div>
                        {`${center.description.substring(0, MAX_LENGTH)}...`}
                      </div>
                    ) : (
                      <div>{center.description}</div>
                    )
                  }
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
      ))}
  </React.Fragment>
);

CentersList.propTypes = {
  center: PropTypes.shape({
    name: PropTypes.string,
    address: PropTypes.string,
    description: PropTypes.string,
    capacity: PropTypes.number
  })
};

export default CentersList;