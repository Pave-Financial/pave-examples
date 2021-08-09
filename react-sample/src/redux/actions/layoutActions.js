import * as types from "../constants";

export function toggleBoxedLayout() {
  return {
    type: types.LAYOUT_BOXED_TOGGLE
  };
}

export function enableBoxedLayout() {
  return {
    type: types.LAYOUT_BOXED_ENABLE
  };
}

export function disableBoxedLayout() {
  return {
    type: types.LAYOUT_BOXED_DISABLE
  };
}
