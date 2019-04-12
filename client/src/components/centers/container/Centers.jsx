import React from 'react';
import axios from 'axios';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import CentersList from '../presentation/CentersList';
import * as centerActions from '../../../actions/centerActions';
import '../stylesheets/centers.scss';


class Centers extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      centers: []
    };
  }

  componentDidMount() {
    this.props.actions.fetchCenters();
  }

  render() {
    return (
      <div className="container" id="centers-page">
        <div className="columns is-multiline">
          <CentersList centers={this.props.centers} />
        </div>
      </div>
    );
  }
}

function mapStateToProps(state, ownProps) {
  return {
    centers: state.centers.centers
  };
}

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(centerActions, dispatch)
  };
}

export default connect(mapStateToProps, mapDispatchToProps)(Centers);
