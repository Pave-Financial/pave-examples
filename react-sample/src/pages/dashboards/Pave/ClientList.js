import React, { useEffect } from "react";
import { connect } from "react-redux";

import { Card, CardBody, CardHeader, CardTitle } from "reactstrap";

import BootstrapTable from "react-bootstrap-table-next";
import paginationFactory from "react-bootstrap-table2-paginator";
import ToolkitProvider, { Search } from "react-bootstrap-table2-toolkit";

import { fetchUsers } from "../../../redux/actions/apiActions";

const tableColumns = [
  {
    dataField: "userId",
    text: "UserId",
    sort: true,
  },
];

const ClientList = ({ onClientSelected, users, dispatch }) => {
  const { data, isFetching } = users;
  const selectRow = {
    mode: "radio",
    clickToSelect: true,
    bgColor: "#f8f9fa",
    onSelect: (row, isSelect, rowIndex, e) => {
      onClientSelected(row.userId);
    },
  };
  const { SearchBar } = Search;
  const tableData = data.map((user) => ({
    userId: user,
  }));

  useEffect(() => {
    dispatch(fetchUsers());
  }, []);

  return (
    <Card className="sticky-top">
      <CardHeader>
        <CardTitle tag="h5" className="mb-0">
          Clients
        </CardTitle>
      </CardHeader>
      <CardBody>
        {isFetching ? (
          "Loading..."
        ) : (
          <ToolkitProvider
            keyField="userId"
            bootstrap4
            bordered={false}
            data={tableData}
            columns={tableColumns}
            search
          >
            {(props) => (
              <div>
                <SearchBar {...props.searchProps} />
                <BootstrapTable
                  bootstrap4
                  bordered={false}
                  selectRow={selectRow}
                  pagination={paginationFactory({
                    sizePerPage: 10,
                    sizePerPageList: [5, 10, 25, 50],
                  })}
                  {...props.baseProps}
                />
              </div>
            )}
          </ToolkitProvider>
        )}
      </CardBody>
    </Card>
  );
};

export default connect((store) => ({
  users: store.users,
}))(ClientList);
