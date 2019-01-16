import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { Router } from 'react-router-dom';
import './index.css';
import configureStore from './store/configureStore';
import App from './App';
import history from './history';
import * as serviceWorker from './serviceWorker';
import {fetchCenters} from "./actions/centerActions";

const store = configureStore();
store.dispatch(fetchCenters());

ReactDOM.render(
  <Provider store={store}>
    <Router history={history}>
      <App />
    </Router>
  </Provider>, document.getElementById('root')
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: http://bit.ly/CRA-PWA
serviceWorker.unregister();
