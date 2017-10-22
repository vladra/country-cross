import React from 'react';
import ReactDOM from 'react-dom';
import { ApolloProvider } from 'react-apollo';

import './index.css';
import App from './App';
import registerServiceWorker from './registerServiceWorker';
import { store, client } from './store';


/* eslint-disable react/jsx-filename-extension */
ReactDOM.render(
  <ApolloProvider client={client} store={store}>
    <App />
  </ApolloProvider>,
  document.getElementById('root'),
);

registerServiceWorker();
/* eslint-enable react/jsx-filename-extension */
