import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import classNames from 'classnames';
import './stylesheets/signup.scss';
import Toast from './Toast';
import loginValidator from '../../helpers/validators/login'
import * as authActions from '../../actions/authActions';

class Login extends Component {
  constructor(props) {
    super(props);
    this.state = {
      email: '',
      password: '',
      formValidity: { email: true, password: true },
      errorMessages: { email: '', password: '' },
      formValid: true
    };
    this.handleChange = this.handleChange.bind(this);
    this.login = this.login.bind(this);
  }

  handleChange(e) {
    e.preventDefault();
    const { name, value } = e.target;
    this.setState({
      [name]: value
    });
  }

  formValid() {
    return loginValidator(this.state).formValid;
  }

  login(e) {
    e.preventDefault();
    this.setState(loginValidator);
    const { email, password } = this.state;
    if (this.formValid()) {
      const user = {
        auth: {
          email,
          password
        }
      };
      this.props.actions.login(user);
    }
  }

  render() {
    const emailClasses = classNames('input', { 'is-danger': !this.state.formValidity.email });
    const emailErrorClasses = classNames('help is-danger', { 'display-none': this.state.formValidity.email });
    const passwordClasses = classNames('input', { 'is-danger': !this.state.formValidity.password });
    const passwordErrorClasses = classNames('help is-danger', { 'display-none': this.state.formValidity.password });
    return (
      <div className="centered-form">
        <form id="signup-form" className="is-6">
          <div className="field">
            <label htmlFor="email">Email</label>
            <div className="control has-icons-left">
              <input
                type="text"
                name="email"
                className={emailClasses}
                placeholder="Enter your email"
                value={this.state.email}
                onChange={this.handleChange}
              />
              <span className="icon is-small is-left">
                <i className="fa fa-user" />
              </span>
            </div>
            <p className={emailErrorClasses}>{this.state.errorMessages.email}</p>
          </div>
          <div className="field">
            <label htmlFor="password">Password</label>
            <div className="control has-icons-left">
              <input
                type="password"
                name="password"
                className={passwordClasses}
                placeholder="Enter your password"
                value={this.state.password}
                onChange={this.handleChange}
              />
              <span className="icon is-small is-left">
                <i className="fa fa-lock" />
              </span>
            </div>
            <p className={passwordErrorClasses}>{this.state.errorMessages.password}</p>
          </div>
          <div className="field is-grouped is-grouped-centered">
            <p className="control">
              <a className="button is-primary" onClick={this.login}>
                Login
              </a>
            </p>
          </div>
        </form>
        {this.props.message ? (
          <Toast message={this.props.message} type={this.props.toastType} />
        ) : (
          <React.Fragment />
        )}
      </div>
    );
  }
}

function mapStateToProps(state, ownProps) {
  return {
    authenticated: state.auth.authenticated,
    message: state.auth.message,
    toastType: state.auth.toastType
  };
}

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(authActions, dispatch)
  };
}

export default connect(mapStateToProps, mapDispatchToProps)(Login);
