import React from "react";
import { Container, Row, Col } from "reactstrap";

const Footer = () => (
  <footer className="footer">
    <Container fluid>
      <Row className="text-muted">
        <Col xs="6" className="text-left">
          <ul className="list-inline">
            <li className="list-inline-item">
              <span className="text-muted" href="#">
                Support
              </span>
            </li>
            <li className="list-inline-item">
              <span className="text-muted" href="#">
                Help Center
              </span>
            </li>
            <li className="list-inline-item">
              <span className="text-muted" href="#">
                Privacy
              </span>
            </li>
            <li className="list-inline-item">
              <span className="text-muted" href="#">
                Terms of Service
              </span>
            </li>
          </ul>
        </Col>
        <Col xs="6" className="text-right">
          <p className="mb-0">
            &copy; {new Date().getFullYear()} -{" "}
            <span href="/" className="text-muted">
              Pave Dev
            </span>
          </p>
        </Col>
      </Row>
    </Container>
  </footer>
);

export default Footer;
