import React from 'react';
import PropTypes from 'prop-types';

import './Body.css'

const Body = ({ children }) => (
  <div className="Body">
    {children}
  </div>
);

Body.propTypes = {
  children: PropTypes.node.isRequired,
};

export default Body;
