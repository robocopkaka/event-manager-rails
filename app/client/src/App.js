import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import Centers from './components/centers/container/Centers';

class App extends Component {
  render() {
    return (
      <div className="container">
        <Centers />
      </div>
    );
  }
}

export default App;
