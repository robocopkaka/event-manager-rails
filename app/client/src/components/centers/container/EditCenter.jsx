import React, { Component, Fragment } from 'react';
import { connect } from 'react-redux';
import  { bindActionCreators } from 'redux';
// import qs from 'query-string';
import PropTypes from 'prop-types';
import CentersForm from '../presentation/CentersForm';
import * as centerActions from '../../../actions/centerActions';
import centerFormValidator from '../../../helpers/validators/centerForm';
import resetCenterFields from '../../../helpers/resetFields/resetCenterFields';
import history from '../../../history';
import Toast from '../../utility/Toast';

class EditCenter extends Component {
  constructor(props) {
    super(props);
    this.state = {
      id: '',
      name: '',
      address: '',
      description: '',
      capacity: 0,
      image: '',
      imageChanged: false,
      errorMessages: {
        name: '', address: '', description: '', capacity: '', image: ''
      },
      fieldsValidity: {
        name: true, address: true, description: true, capacity: true, image: true
      },
      valid: true
    };
    this.handleChange = this.handleChange.bind(this);
    this.handleImageUpload = this.handleImageUpload.bind(this);
    this.update = this.update.bind(this);
  }

  componentDidMount() {
    const id = parseInt(this.props.match.params.id, 10);
    this.props.actions.fetchSingleCenter(id);
  }

  componentDidUpdate(prevProps) {
    if (this.props.center && this.props.center.name !== prevProps.center.name) {
      const { center: { name, address, description, capacity, image, id } } = this.props;
      this.setState({
        name, address, description, capacity, image, id
      });
    }
  }

  handleChange(e) {
    e.preventDefault();
    const { target: { name, value }} = e;
    this.setState({
      [name]: value
    });
  }

  handleImageUpload(e) {
    e.preventDefault();
    this.setState({
      image: e.target.files[0],
      imageChanged: true
    });
  }

  validForm() {
    return centerFormValidator(this.state).valid;
  }

  update(e) {
    e.preventDefault();
    this.setState(centerFormValidator);
    if (this.validForm()) {
      const { name, description, address, capacity, image, id, imageChanged } = this.state;
      const { actions: { updateCenter } } = this.props;
      const center = new FormData();
      center.append('center[name]', name);
      center.append('center[address]', address);
      center.append('center[capacity]', capacity);
      center.append('center[description]', description);
      if (imageChanged) {
        center.append('center[image]', image);
      }
      updateCenter(id, center)
        .then(() => {
          this.setState(resetCenterFields);
          history.push('/centers');
        })
        .catch(() => {});
    }
  }

  render() {
    const {
      name, address, description, capacity, fieldsValidity, errorMessages,
      valid, image
    } = this.state;
    const { toastType, message } = this.props;
    return (
      <Fragment>
        <div className="add-center">
          <h2 id="form-header">Edit {this.props.center.name}</h2>
          <CentersForm
            name={name}
            address={address}
            description={description}
            capacity={capacity}
            image={image}
            fieldsValidity={fieldsValidity}
            errorMessages={errorMessages}
            valid={valid}
            handleChange={this.handleChange}
            handleImageUpload={this.handleImageUpload}
            submit={this.update}
          />
        </div>
        <Toast message={message} type={toastType} />
      </Fragment>
    );
  }
}

EditCenter.propTypes = {
  center: PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
    address: PropTypes.string,
    capacity: PropTypes.number,
    description: PropTypes.string,
  }),
  updateCenter: PropTypes.func
};

EditCenter.defaultProps = {
  center: {},
  updateCenter: () => {}
};

function mapStateToProps(state) {
  return {
    center: state.centers.center,
    toastType: state.centers.toastType,
    message: state.centers.message,
    actions: {
      updateCenter: () => {},
      fetchSingleCenter: () => {}
    }
  };
}

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(centerActions, dispatch)
  };
}

export default connect(mapStateToProps, mapDispatchToProps)(EditCenter);
