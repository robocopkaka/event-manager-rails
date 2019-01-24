import React from 'react';
import { Switch, Route } from 'react-router-dom';
import Centers from '../centers/container/Centers';
import AddCenter from '../centers/container/AddCenter';
import Signup from './Signup';
import Login from './Login';

const Main = () => (
  <main>
    <Switch>
      <Route exact path="/" component={Centers} />
      <Route path="/centers" component={Centers} />
      <Route path="/add-center" component={AddCenter} />
      <Route exact path="/signup" component={Signup} />
      <Route exact path="/login" component={Login} />
    </Switch>
  </main>
);

export default Main;
