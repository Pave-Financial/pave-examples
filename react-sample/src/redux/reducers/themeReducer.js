import * as types from "../constants";

const themes = {
  corporate: {
    primary: "#3B82EC",
    secondary: "#495057",
    tertiary: "#0069fc",
    success: "#4BBF73",
    info: "#1F9BCF",
    warning: "#f0ad4e",
    danger: "#d9534f"
  },
  modern: {
    primary: "#2c7be5",
    secondary: "#9d7bd8",
    tertiary: "#5997eb",
    success: "#4caf50",
    info: "#47bac1",
    warning: "#ff9800",
    danger: "#e51c23"
  },
  classic: {
    primary: "#47bac1",
    secondary: "#a180da",
    tertiary: "#5fc27e",
    success: "#5fc27e",
    info: "#5b7dff",
    warning: "#fcc100",
    danger: "#f44455"
  }
};

const initialState = {
  currentTheme: themes.corporate,
  themes: themes
};

export default function reducer(state = initialState, actions) {
  switch (actions.type) {
    case types.THEME_TOGGLE:
      return {
        ...state,
        currentTheme: state.themes[actions.payload]
      };

    default:
      return state;
  }
}
