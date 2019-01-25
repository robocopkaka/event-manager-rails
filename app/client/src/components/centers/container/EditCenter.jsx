import React, { Component, Fragment } from 'react';
import { connect } from 'react-redux';
import  { bindActionCreators } from 'redux';
import qs from 'query-string';
import CentersForm from '../presentation/CentersForm';
import * as centerActions from '../../../actions/centerActions';

class EditCenter extends Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '', address: '', description: '', capacity: 0, image: '',
      errorMessages: {
        name: '', address: '', description: '', capacity: '', image: ''
      },
      fieldsValidity: {
        name: true, address: true, description: true, capacity: true, image: true
      },
      valid: true
    };
  }

  componentDidMount() {
    const id = parseInt(this.props.match.params.id, 10);
    // this.props.actions.fetchSingleCenter(id);
  }

  render() {
    const {
      name, address, description, capacity, fieldsValidity, errorMessages,
      valid
    } = this.state
    return (
      <Fragment>
        <CentersForm
          name={name}
          address={address}
          description={description}
          capacity={capacity}
          fieldsValidity={fieldsValidity}
          errorMessages={errorMessages}
          valid={valid}
        />
      </Fragment>
    );
  }
}

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(centerActions, dispatch)
  }
}

export default connect(null, mapDispatchToProps)(EditCenter);
