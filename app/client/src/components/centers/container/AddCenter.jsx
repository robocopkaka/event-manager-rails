import React, { Component, Fragment } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import CentersForm from '../presentation/CentersForm';
import '../stylesheets/centers-form.scss';
import centerFormValidator from '../../../helpers/validators/centerForm';
import * as centerActions from '../../../actions/centerActions';
import Toast from '../../utility/Toast';
import resetCenterFields from '../../../helpers/resetFields/resetCenterFields';
import history from '../../../history';

class AddCenter extends Component {
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
    this.handleChange = this.handleChange.bind(this);
    this.submit = this.submit.bind(this);
    this.handleImageUpload = this.handleImageUpload.bind(this);
  }

  handleChange(e) {
    e.preventDefault();
    const { name, value } = e.target;
    this.setState({
      [name]: value
    });
  }

  handleImageUpload(e) {
    e.preventDefault();
    console.log(e.target.files[0])
    this.setState({
      image: e.target.files[0]
    });
    const image = new FormData();
    image.append('image', e.target.files[0], e.target.files[0].name);
    for (var key of image.entries()) {
      console.log(key[1])
    }
    // this.props.actions.uploadImage(formData);
  }

  validForm() {
    return centerFormValidator(this.state).valid;
  }

  submit(e) {
    e.preventDefault();
    const { name, address, description, capacity, image } = this.state;
    this.setState(centerFormValidator);
    if (this.validForm()) {
      const center = new FormData();
      center.append('center[image]', image, image.name);
      center.append('center[name]', name);
      center.append('center[address]', address);
      center.append('center[description]', description);
      center.append('center[capacity]', capacity);

      this.props.actions.addCenter(center)
        .then(() => {
          this.setState(resetCenterFields);
          history.push('/centers');
        })
        .catch(() => {});
    }
    // console.log('stuff');
  }

  render() {
    const {
      name, email, address, description, image, errorMessages, fieldsValidity
    } = this.state;
    const { toastType, message } = this.props;
    return (
      <Fragment>
        <div className="add-center">
          <CentersForm
            name={name}
            email={email}
            address={address}
            description={description}
            image={image}
            errorMessages={errorMessages}
            fieldsValidity={fieldsValidity}
            handleChange={this.handleChange}
            handleImageUpload={this.handleImageUpload}
            submit={this.submit}
          />
        </div>
        <Toast type={toastType} message={message} />
      </Fragment>
    );
  }
}

function mapStateToProps(state) {
  return {
    toastType: state.centers.toastType,
    message: state.centers.message
  };
}

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(centerActions, dispatch)
  };
}
export default connect(mapStateToProps, mapDispatchToProps)(AddCenter);
