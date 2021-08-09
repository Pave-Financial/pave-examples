import React, { useEffect } from "react";
import { useDispatch } from "react-redux";
import { showSidebar, hideSidebar } from "../../redux/actions/sidebarActions";

import Dashboard from "../dashboards/Default";

const SidebarCollapsed = () => {
  const dispatch = useDispatch();

  useEffect(() => {
    dispatch(hideSidebar());

    return () => {
      dispatch(showSidebar());
    }
  }, [dispatch])

  return <Dashboard />
}

export default SidebarCollapsed;
