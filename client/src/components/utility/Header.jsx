import React from 'react';
import { Link } from 'react-router-dom';

const Header = () => (
  <nav className="navbar" role="navigation" aria-label="main navigation">
    <div className="navbar-end">
      <div className="buttons">
        <Link to="/signup" className="button is-primary">Signup</Link>
        <Link to="/login" className="button is-light">Login</Link>
      </div>
    </div>
  </nav>
);

export default Header;