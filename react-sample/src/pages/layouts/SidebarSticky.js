import React, { useEffect } from "react";
import { useDispatch } from "react-redux";
import {
  enableStickySidebar,
  disableStickySidebar
} from "../../redux/actions/sidebarActions";

import Dashboard from "../dashboards/Default";

const SidebarSticky = () => {
  const dispatch = useDispatch();

  useEffect(() => {
    dispatch(enableStickySidebar());

    return () => {
      dispatch(disableStickySidebar());
    }
  }, [dispatch])

  return <Dashboard />
}

export default SidebarSticky;
