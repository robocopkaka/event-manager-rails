import React, { Component, Fragment } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import classNames from 'classnames';
import Navbar from './Navbar';
import * as activeActions from '../../actions/activeActions';

class Header extends Component {
  constructor(props) {
    super(props);
    this.state = {};
    this.toggleActive = this.toggleActive.bind(this);
  }

  toggleActive = (value) => (e) => { //uses currying
    switch (value) {
      case 'centers':
        this.props.actions.centersActive();
        break;
      case 'events':
        this.props.actions.eventsActive();
        break;
      case 'home':
        this.props.actions.homeActive();
        break;
      default:
        this.props.actions.homeActive();
    }
  };

  render() {
    const { centersActive, eventsActive, homeActive } = this.props;
    const centersActiveClasses = classNames('navbar-link', { 'active-item': centersActive });
    const eventsActiveClasses = classNames('navbar-link', { 'active-item': eventsActive });
    const homeActiveClasses = classNames('navbar-item', { 'active-item': homeActive });
    return (
      <Fragment>
        <Navbar
          centersActiveClasses={centersActiveClasses}
          eventsActiveClasses={eventsActiveClasses}
          homeActiveClasses={homeActiveClasses}
          toggleActive={this.toggleActive}
        />
      </Fragment>
    );
  }
}

Header.propTypes = {
  centersActive: PropTypes.bool,
  eventsActive: PropTypes.bool,
  homeActive: PropTypes.bool
};

Header.defaultProps = {
  centersActive: false,
  eventsActive: false,
  homeActive: false
};

function mapStateToProps(state) {
  return {
    centersActive: state.active.centers,
    eventsActive: state.active.events,
    homeActive: state.active.home,
  };
}

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(activeActions, dispatch)
  }
}
export default connect(mapStateToProps, mapDispatchToProps)(Header);
