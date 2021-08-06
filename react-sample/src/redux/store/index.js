import { createStore, applyMiddleware } from "redux";
import rootReducer from "../reducers/index";
import { createLogger } from 'redux-logger';
import thunkMiddleware from 'redux-thunk';

const loggerMiddleware = createLogger({
  collapsed: true
});

const store = createStore(
  rootReducer, 
  applyMiddleware(
    loggerMiddleware,
    thunkMiddleware
  ));

export default store;
