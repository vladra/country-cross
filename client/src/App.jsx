import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import { Body } from 'components/Layout';
import { StageTable, StagesIndexTable } from 'components/Stages';

// eslint-disable-next-line
class App extends Component {
  render() {
    return (
      <Router>
        <Body>
          <Route exact path="/" component={StagesIndexTable} />
          <Route path="/stages/:id" component={StageTable} />
        </Body>
      </Router>
    );
  }
}

export default App;
