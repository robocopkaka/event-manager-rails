import React, { Component, Fragment } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';
import * as centerActions from '../../../actions/centerActions';
import CenterPage from '../presentation/CenterPage';

class SingleCenter extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  componentDidMount() {
    const { match: { params: { id } } } = this.props;
    const { actions: { fetchCenterEvents, fetchSingleCenter } } = this.props
    fetchSingleCenter(id);
    fetchCenterEvents(id);
  }

  render() {
    const { center, events } = this.props;
    return (
      <Fragment>
        <CenterPage center={center} events={events} />
      </Fragment>
    );
  }
}

SingleCenter.propTypes = {
  center: PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
    address: PropTypes.string,
    capacity: PropTypes.number,
    description: PropTypes.string,
  }),
  events: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number,
      name: PropTypes.string,
      description: PropTypes.string,
      start_time: PropTypes.string,
      end_time: PropTypes.string,
    })
  ),
  actions: PropTypes.shape({
    fetchSingleCenter: PropTypes.func,
    fetchCenterEvents: PropTypes.func
  }),
  match: PropTypes.shape({
    params: PropTypes.shape({
      id: PropTypes.string
    })
  })
};

SingleCenter.defaultProps = {
  center: {},
  events: [],
  actions: {},
  match: {}
};

function mapStateToProps(state) {
  return {
    center: state.centers.center,
    events: state.events.events
  };
}

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(centerActions, dispatch)
  };
}

export default connect(mapStateToProps, mapDispatchToProps)(SingleCenter);
