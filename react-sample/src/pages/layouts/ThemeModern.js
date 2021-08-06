import React, { useEffect } from "react";
import { useDispatch } from "react-redux";
import { enableModernTheme } from "../../redux/actions/themeActions";

import Dashboard from "../dashboards/Default";

const ThemeModern = () => {
  const dispatch = useDispatch();

  useEffect(() => {
    dispatch(enableModernTheme());
  }, [dispatch])

  return <Dashboard />
}

export default ThemeModern;
