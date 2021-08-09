import React from "react";
import { toastr } from "react-redux-toastr";

import {
  Button,
  Card,
  CardBody,
  CardHeader,
  CardTitle,
  Col,
  Container,
  CustomInput,
  FormGroup,
  Input,
  Label,
  Row
} from "reactstrap";

class Notifications extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      title: "",
      message: "",
      type: "success",
      timeOut: 5000,
      showCloseButton: true,
      progressBar: true,
      position: "top-right"
    };
  }

  showToastr() {
    const options = {
      timeOut: parseInt(this.state.timeOut),
      showCloseButton: this.state.showCloseButton,
      progressBar: this.state.progressBar,
      position: this.state.position
    };

    const toastrInstance =
      this.state.type === "info"
        ? toastr.info
        : this.state.type === "warning"
        ? toastr.warning
        : this.state.type === "error"
        ? toastr.error
        : toastr.success;

    toastrInstance(
      this.state.title,
      this.state.message || "Have fun storming the castle!",
      options
    );
  }

  render() {
    return (
      <Container fluid className="p-0">
        <h1 className="h3 mb-3">Notifications</h1>

        <Card>
          <CardHeader>
            <CardTitle tag="h5">Toastr notifications</CardTitle>
            <h6 className="card-subtitle text-muted">
              Toastr notifications by react-redux-toastr
            </h6>
          </CardHeader>
          <CardBody>
            <Row>
              <Col md="7">
                <FormGroup>
                  <Label for="title">Title</Label>
                  <Input
                    type="text"
                    value={this.state.title}
                    onChange={e => this.setState({ title: e.target.value })}
                    placeholder="Enter a title"
                  />
                </FormGroup>
                <FormGroup>
                  <Label for="message">Message</Label>
                  <Input
                    type="text"
                    value={this.state.message}
                    onChange={e => this.setState({ message: e.target.value })}
                    placeholder="Enter a message"
                  />
                </FormGroup>
                <FormGroup>
                  <Label for="type">Type</Label>
                  <CustomInput
                    id="type"
                    type="select"
                    value={this.state.type}
                    onChange={e => this.setState({ type: e.target.value })}
                  >
                    <option value="success">Success</option>
                    <option value="info">Info</option>
                    <option value="warning">Warning</option>
                    <option value="error">Danger</option>
                  </CustomInput>
                </FormGroup>
                <FormGroup>
                  <Label for="timeOut">Duration</Label>
                  <CustomInput
                    id="duration"
                    type="select"
                    value={this.state.timeOut}
                    onChange={e => this.setState({ timeOut: e.target.value })}
                  >
                    <option value={2500}>2.5s</option>
                    <option value={5000}>5s</option>
                    <option value={7500}>7.5s</option>
                    <option value={10000}>10s</option>
                  </CustomInput>
                </FormGroup>

                <FormGroup>
                  <div>
                    <CustomInput
                      id="showCloseButton"
                      type="checkbox"
                      label="Close button"
                      className="mb-2"
                      checked={this.state.showCloseButton}
                      onChange={() =>
                        this.setState({
                          showCloseButton: !this.state.showCloseButton
                        })
                      }
                    />
                    <CustomInput
                      id="progressBar"
                      type="checkbox"
                      label="Progress bar"
                      checked={this.state.progressBar}
                      onChange={() =>
                        this.setState({ progressBar: !this.state.progressBar })
                      }
                    />
                  </div>
                </FormGroup>
              </Col>

              <Col md="5">
                <FormGroup>
                  <Label>Position</Label>
                  <div>
                    <CustomInput
                      type="radio"
                      id="top-right"
                      value="top-right"
                      label="Top right"
                      checked={this.state.position === "top-right"}
                      onChange={() => this.setState({ position: "top-right" })}
                      className="mb-2"
                    />
                    <CustomInput
                      type="radio"
                      id="top-center"
                      value="top-center"
                      label="Top center"
                      checked={this.state.position === "top-center"}
                      onChange={() => this.setState({ position: "top-center" })}
                      className="mb-2"
                    />
                    <CustomInput
                      type="radio"
                      id="top-left"
                      value="top-left"
                      label="Top left"
                      checked={this.state.position === "top-left"}
                      onChange={() => this.setState({ position: "top-left" })}
                      className="mb-2"
                    />
                    <CustomInput
                      type="radio"
                      id="bottom-right"
                      value="bottom-right"
                      label="Bottom right"
                      checked={this.state.position === "bottom-right"}
                      onChange={() =>
                        this.setState({ position: "bottom-right" })
                      }
                      className="mb-2"
                    />
                    <CustomInput
                      type="radio"
                      id="bottom-center"
                      value="bottom-center"
                      label="Bottom center"
                      checked={this.state.position === "bottom-center"}
                      onChange={() =>
                        this.setState({ position: "bottom-center" })
                      }
                      className="mb-2"
                    />
                    <CustomInput
                      type="radio"
                      id="bottom-left"
                      value="bottom-left"
                      label="Bottom left"
                      checked={this.state.position === "bottom-left"}
                      onChange={() =>
                        this.setState({ position: "bottom-left" })
                      }
                      className="mb-2"
                    />
                  </div>
                </FormGroup>
              </Col>
            </Row>

            <hr />

            <Button
              onClick={() => this.showToastr()}
              type="button"
              className="mr-1"
              color="primary"
            >
              Show notification
            </Button>
          </CardBody>
        </Card>
      </Container>
    );
  }
}

// top-left top-center top-right bottom-left bottom-center and bottom-right

export default Notifications;
