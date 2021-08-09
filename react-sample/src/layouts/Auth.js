import React from "react";

import { Col, Container, Row } from "reactstrap";

import Main from "../components/Main";
import Settings from "../components/Settings";

const Auth = ({ children }) => (
  <React.Fragment>
    <Main className="d-flex w-100 justify-content-center">
      <Container className="d-flex flex-column">
        <Row className="h-100">
          <Col sm="10" md="8" lg="6" className="mx-auto d-table h-100">
            <div className="d-table-cell align-middle">{children}</div>
          </Col>
        </Row>
      </Container>
    </Main>
    <Settings />
  </React.Fragment>
);

export default Auth;
