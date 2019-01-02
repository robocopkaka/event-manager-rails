import React from 'react';
import { Switch, Route } from 'react-router-dom';
import Centers from '../centers/container/Centers';
import Signup from './Signup';

const Main = () => (
  <main>
    <Switch>
      <Route exact path="/" component={Centers} />
      <Route path="/centers" component={Centers} />
      <Route exact path="/signup" component={Signup} />
      {/*<Route exact path="/login" component={Login} />*/}
    </Switch>
  </main>
);

export default Main;
