import React, { Component } from 'react';
import { connect } from 'react-redux';
import './stylesheets/signup.scss';

class Signup extends Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '',
      email: '',
      password: '',
      passwordConfirmation: ''
    };
    this.handleChange = this.handleChange.bind(this);
    this.logState = this.logState.bind(this);
  }

  handleChange(e) {
    e.preventDefault();
    const { state} = this;
    const { name, value } = e.target;
    this.setState({
      [name]: value
    });
    // console.log(e.target.name);
  }

  logState(e) {
    e.preventDefault();
    console.log(this.state)
  }
  render() {
    return (
      <div className="centered-form">
        <form className="is-6" id="signup-form">
          <div className="field">
            <label htmlFor="name" className="label">Name</label>
            <div className="control has-icons-left">
              <input
                type="text"
                name="name"
                className="input"
                placeholder="Enter you name"
                value={this.state.name}
                onChange={this.handleChange}
              />
              <span className="icon is-small is-left">
                <i className="fa fa-user" />
              </span>
            </div>
          </div>
          <div className="field">
            <label htmlFor="email" className="label">Email</label>
            <div className="control has-icons-left">
              <input
                type="email"
                name="email"
                className="input"
                placeholder="Enter you email address"
                value={this.state.email}
                onChange={this.handleChange}
              />
              <span className="icon is-small is-left">
                <i className="fa fa-envelope" />
              </span>
            </div>
          </div>
          <div className="field">
            <label htmlFor="password" className="label">Password</label>
            <div className="control has-icons-left">
              <input
                type="password"
                name="password"
                className="input"
                placeholder="Enter your password..."
                value={this.state.password}
                onChange={this.handleChange}
              />
              <span className="icon is-small is-left">
                <i className="fa fa-lock"/>
              </span>
            </div>
          </div>
          <div className="field">
            <label htmlFor="password-confirmation" className="label">Password Confirmation</label>
            <div className="control has-icons-left">
              <input
                type="password"
                name="passwordConfirmation"
                className="input"
                placeholder="Confirm your password"
                value={this.state.passwordConfirmation}
                onChange={this.handleChange}
              />
              <span className="icon is-small is-left">
                <i className="fa fa-lock" />
              </span>
            </div>
          </div>
          <div className="field is-grouped is-grouped-centered">
            <p className="control">
              <a className="button is-primary" onClick={this.logState}>
                Signup
              </a>
            </p>
          </div>
        </form>
      </div>
    );
  }
}

export default Signup;