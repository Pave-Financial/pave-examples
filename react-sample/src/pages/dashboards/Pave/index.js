import React from "react";
import { Container, Row, Col } from "reactstrap";

import Clients from "./Clients";

const Pave = () => (
  <Container fluid className="p-0">
    <Row>
      <Col lg="12" className="d-flex">
        <Clients />
      </Col>
    </Row>
  </Container>
);

export default Pave;
