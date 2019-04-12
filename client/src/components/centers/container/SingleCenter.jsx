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
    this.props.actions.fetchSingleCenter(id)
  }

  render() {
    console.log(this.props.center);

    const styles  = {
      fontFamily: `${this.props.center.font_family}`
    }
    const { center } = this.props;
    return (
      <Fragment>
        <CenterPage center={center} style={styles} />
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
  actions: PropTypes.shape({
    fetchSingleCenter: PropTypes.func
  }),
  match: PropTypes.shape({
    params: PropTypes.shape({
      id: PropTypes.string
    })
  })
};

SingleCenter.defaultProps = {
  center: {},
  actions: {},
  match: {}
};

function mapStateToProps(state) {
  return {
    center: state.centers.center
  };
}

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(centerActions, dispatch)
  };
}

export default connect(mapStateToProps, mapDispatchToProps)(SingleCenter);
