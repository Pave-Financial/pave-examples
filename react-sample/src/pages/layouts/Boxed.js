import React, { useEffect } from "react";
import { useDispatch } from "react-redux";
import {
  enableBoxedLayout,
  disableBoxedLayout
} from "../../redux/actions/layoutActions";

import Dashboard from "../dashboards/Default";

const Boxed = () => {
  const dispatch = useDispatch();

  useEffect(() => {
    dispatch(enableBoxedLayout());

    return () => {
      dispatch(disableBoxedLayout());
    }
  }, [dispatch])

  return <Dashboard />
}

export default Boxed;
