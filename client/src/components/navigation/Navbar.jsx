import React from 'react';
import { Link } from 'react-router-dom';
import './navbar.scss';

const Navbar = (
  { eventsActiveClasses, centersActiveClasses, homeActiveClasses, toggleActive }
) => (
  <div id="main-header">
    <nav className="navbar is-primary" role="navigation" aria-label="main navigation">
      <div className="navbar-brand">
        <div className="navbar-item">
          EventsM
        </div>
        <a role="button" className="navbar-burger burger" aria-label="menu" aria-expanded="false">
          <span aria-hidden="true" />
          <span aria-hidden="true" />
          <span aria-hidden="true" />
        </a>
      </div>
      <div className="navbar-menu">
        <div className="navbar-start">
          <Link to="/" className={homeActiveClasses} onClick={toggleActive('home')}>
            Home
          </Link>
          <div className="navbar-item has-dropdown is-hoverable">
            <a className={centersActiveClasses}>
              Centers
            </a>
            <div className="navbar-dropdown">
              <Link to="/add-center" className="navbar-item" onClick={toggleActive('centers')}>Add Center</Link>
              <Link to="/centers" className="navbar-item" onClick={toggleActive('centers')}>View Centers</Link>
            </div>
          </div>
          <div className="navbar-item has-dropdown is-hoverable">
            <a className={eventsActiveClasses}>
              Events
            </a>
            <div className="navbar-dropdown">
              <Link to="#" className="navbar-item" onClick={toggleActive('events')}>Add Event</Link>
              <Link to="#" className="navbar-item" onClick={toggleActive('events')}>View Events</Link>
            </div>
          </div>
        </div>
        <div className="navbar-end">
          <div className="buttons">
            <Link to="/signup" className="button is-primary">Signup</Link>
            <Link to="/login" className="button is-light">Login</Link>
          </div>
        </div>
      </div>
    </nav>
  </div>
);

export default Navbar;