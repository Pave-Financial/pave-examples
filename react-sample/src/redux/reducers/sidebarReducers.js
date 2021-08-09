import * as types from "../constants";

const initialState = {
  isOpen: true,
  isSticky: false
};

export default function reducer(state = initialState, actions) {
  switch (actions.type) {
    case types.SIDEBAR_VISIBILITY_TOGGLE:
      return {
        ...state,
        isOpen: !state.isOpen
      };
    case types.SIDEBAR_VISIBILITY_SHOW:
      return {
        ...state,
        isOpen: true
      };
    case types.SIDEBAR_VISIBILITY_HIDE:
      return {
        ...state,
        isOpen: false
      };

    case types.SIDEBAR_STICKY_TOGGLE:
      return {
        ...state,
        isSticky: !state.isSticky
      };
    case types.SIDEBAR_STICKY_ENABLE:
      return {
        ...state,
        isSticky: true
      };
    case types.LAYOUT_BOXED_ENABLE:
    case types.LAYOUT_BOXED_TOGGLE:
    case types.SIDEBAR_STICKY_DISABLE:
      return {
        ...state,
        isSticky: false
      };

    default:
      return state;
  }
}
