import * as types from "../constants";

export function toggleSidebar() {
  return {
    type: types.SIDEBAR_VISIBILITY_TOGGLE
  };
}

export function showSidebar() {
  return {
    type: types.SIDEBAR_VISIBILITY_SHOW
  };
}

export function hideSidebar() {
  return {
    type: types.SIDEBAR_VISIBILITY_HIDE
  };
}

export function toggleStickySidebar() {
  return {
    type: types.SIDEBAR_STICKY_TOGGLE
  };
}

export function enableStickySidebar() {
  return {
    type: types.SIDEBAR_STICKY_ENABLE
  };
}

export function disableStickySidebar() {
  return {
    type: types.SIDEBAR_STICKY_DISABLE
  };
}
