import React from "react";
import { connect } from "react-redux";

import { Col, Container, Row } from "reactstrap";


import Column from "./Column";
import Pie from "./Pie";
class ApexCharts extends React.Component {
  componentDidUpdate() {
    setTimeout(() => {
      window.dispatchEvent(new Event("resize"));
    }, 100);
  }

  render() {
    return (
      <Container fluid className="p-0">
        <h1 className="h3 mb-3">ApexCharts</h1>

        <Row>
          <Col lg="6">
            <Column />
          </Col>
          <Col lg="6">
            <Pie />
          </Col>
        </Row>
      </Container>
    );
  }
}

export default connect(store => ({
  theme: store.theme.currentTheme
}))(ApexCharts);
