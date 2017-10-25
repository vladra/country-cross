import { ApolloClient, createNetworkInterface } from 'react-apollo';
import { createStore, combineReducers, applyMiddleware, compose } from 'redux';

import stages from './stages';

const networkInterface = createNetworkInterface({
  uri: 'http://localhost:9292/graphql',
});
const client = new ApolloClient({
  networkInterface,
  reduxRootSelector: state => state.gql,
});

const store = createStore(
  combineReducers({
    stages,
    gql: client.reducer(),
  }),
  {
    gql: {
      loading: false,
    },
  },
  compose(applyMiddleware(client.middleware())),
);

export { client, store };
