import * as types from "../constants";

import { toggleTheme } from "../../services/themeService";

export function enableClassicTheme() {
  return enableTheme("classic");
}

export function enableCorporateTheme() {
  return enableTheme("corporate");
}

export function enableModernTheme() {
  return enableTheme("modern");
}

function enableTheme(name) {
  toggleTheme(name);

  return {
    type: types.THEME_TOGGLE,
    payload: name
  };
}
