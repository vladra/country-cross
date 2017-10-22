import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import { StageTable, StagesIndexTable } from './components/stages';

class App extends Component {
  render() {
    console.log(StageTable)
    return (
      <Router>
        <div>
          <Route path="/" component={StagesIndexTable} />
          <Route path="/stages/" component={StageTable} />
        </div>
      </Router>
    );
  }
}

export default App;
