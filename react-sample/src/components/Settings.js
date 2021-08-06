import React from "react";
import { connect } from "react-redux";

import { toggleBoxedLayout } from "../redux/actions/layoutActions";
import { toggleStickySidebar } from "../redux/actions/sidebarActions";
import { toggleSidebar } from "../redux/actions/sidebarActions";
import { enableClassicTheme } from "../redux/actions/themeActions";
import { enableCorporateTheme } from "../redux/actions/themeActions";
import { enableModernTheme } from "../redux/actions/themeActions";

import { Badge, Button } from "reactstrap";
import PerfectScrollbar from "react-perfect-scrollbar";

import { Settings as SettingsIcon } from "react-feather";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faAngleRight,
  faShoppingCart
} from "@fortawesome/free-solid-svg-icons";

import screenshotClassic from "../assets/img/screenshots/theme-classic-small.png";
import screenshotCorporate from "../assets/img/screenshots/theme-corporate-small.png";
import screenshotModern from "../assets/img/screenshots/theme-modern-small.png";

class Settings extends React.Component {
  constructor() {
    super();

    this.state = {
      isOpen: false
    };

    this.setWrapperRef = this.setWrapperRef.bind(this);
    this.handleClickOutside = this.handleClickOutside.bind(this);
  }

  toggleSidebar() {
    this.setState({ isOpen: !this.state.isOpen });
  }

  componentDidMount() {
    document.addEventListener('mousedown', this.handleClickOutside);
  }

  componentWillUnmount() {
    document.removeEventListener('mousedown', this.handleClickOutside);
  }

  setWrapperRef(node) {
    this.wrapperRef = node;
  }

  handleClickOutside(event) {
    if (this.wrapperRef && !this.wrapperRef.contains(event.target)) {
      this.setState({ isOpen: false });
    }
  }

  render() {
    const { isOpen } = this.state;
    const { layout, sidebar, dispatch } = this.props;

    return (
      <div ref={this.setWrapperRef} className={"settings " + (isOpen ? "open" : "")}>
        <div className="settings-toggle" onClick={() => this.toggleSidebar()}>
          <SettingsIcon />
        </div>

        <div className="settings-panel">
          <div className="settings-content">
            <PerfectScrollbar>
              <div className="settings-title">
                <Button close onClick={() => this.toggleSidebar()} />

                <h4>Settings</h4>
              </div>

              <div className="settings-section">
                <small className="d-block text-uppercase font-weight-bold text-muted mb-2">
                  Layouts
                </small>

                <ul className="settings-layouts">
                  <li>
                    <span
                      className="settings-layouts-item"
                      onClick={() =>
                        dispatch(toggleStickySidebar(), this.toggleSidebar())
                      }
                    >
                      {sidebar.isSticky ? "Static Sidebar" : "Sticky Sidebar"}
                      <Badge tag="small" className="float-right mt-1">
                        <FontAwesomeIcon icon={faAngleRight} />
                      </Badge>
                    </span>
                  </li>
                  <li>
                    <span
                      className="settings-layouts-item"
                      onClick={() =>
                        dispatch(toggleSidebar(), this.toggleSidebar())
                      }
                    >
                      {sidebar.isOpen ? "Collapsed Sidebar" : "Visible Sidebar"}
                      <Badge tag="small" className="float-right mt-1">
                        <FontAwesomeIcon icon={faAngleRight} />
                      </Badge>
                    </span>
                  </li>
                  <li>
                    <span
                      className="settings-layouts-item"
                      onClick={() =>
                        dispatch(toggleBoxedLayout(), this.toggleSidebar())
                      }
                    >
                      {layout.isBoxed ? "Full Layout" : "Boxed Layout"}
                      <Badge tag="small" className="float-right mt-1">
                        <FontAwesomeIcon icon={faAngleRight} />
                      </Badge>
                    </span>
                  </li>
                </ul>
              </div>

              <div className="settings-section">
                <small className="d-block text-uppercase font-weight-bold text-muted mb-2">
                  Themes
                </small>

                <div
                  className="settings-theme"
                  onClick={() =>
                    dispatch(enableClassicTheme(), this.toggleSidebar())
                  }
                >
                  <img
                    src={screenshotClassic}
                    className="img-fluid"
                    alt="Classic"
                  />
                  <span className="d-inline-block mt-1 text-muted">
                    Classic
                  </span>
                </div>

                <div
                  className="settings-theme"
                  onClick={() =>
                    dispatch(enableCorporateTheme(), this.toggleSidebar())
                  }
                >
                  <img
                    src={screenshotCorporate}
                    className="img-fluid"
                    alt="Corporate"
                  />
                  <span className="d-inline-block mt-1 text-muted">
                    Corporate
                  </span>
                </div>

                <div
                  className="settings-theme"
                  onClick={() =>
                    dispatch(enableModernTheme(), this.toggleSidebar())
                  }
                >
                  <img
                    src={screenshotModern}
                    className="img-fluid"
                    alt="Modern"
                  />
                  <span className="d-inline-block mt-1 text-muted">Modern</span>
                </div>

                <Button
                  color="primary"
                  block
                  size="lg"
                  href="https://themes.getbootstrap.com/product/appstack-react-admin-dashboard-template/"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <span className="align-middle">
                    <FontAwesomeIcon
                      icon={faShoppingCart}
                      className="text-white"
                    />{" "}
                  </span>
                  <span className="align-middle">Buy AppStack</span>
                </Button>
              </div>
            </PerfectScrollbar>
          </div>
        </div>
      </div>
    );
  }
}

export default connect(store => ({
  layout: store.layout,
  sidebar: store.sidebar
}))(Settings);
