import React from 'react';
import PropTypes from 'prop-types';

const CentersList = ({centers}) => (
  // console.log(props)
  <div>
    {centers.map(center => (
        <div className="tile" key={center.id}>
          <p>{center.name}</p>
          <p>{center.address}</p>
        </div>
      ))}
  </div>
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