import React, { useEffect } from "react";
import { useDispatch } from "react-redux";
import { enableClassicTheme } from "../../redux/actions/themeActions";

import Dashboard from "../dashboards/Default";

const ThemeClassic = () => {
  const dispatch = useDispatch();

  useEffect(() => {
    dispatch(enableClassicTheme());
  }, [dispatch])

  return <Dashboard />
}

export default ThemeClassic;
