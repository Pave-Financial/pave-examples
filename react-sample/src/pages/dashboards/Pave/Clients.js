import React, {useState} from "react";


import {
  Col,
  Container,
  Row,
} from "reactstrap";

import Single from './Single';
import ClientList from './ClientList';

const Clients = () => {
  const [clientId, setClientId] = useState(0);

  const onClientSelected = (clientId) => {
    setClientId(clientId)
  }

  return (
    <Container fluid className="p-0">
      <Row>
        <Col xl="4">
          <ClientList 
            onClientSelected={onClientSelected}
          />
        </Col>
        <Col xl="8">
          <Single 
            clientId={clientId}
          />
        </Col>
      </Row>
    </Container>
  )
};

export default Clients;
