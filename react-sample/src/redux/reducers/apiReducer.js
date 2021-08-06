import * as types from "../constants";

const initialState = {
  isFetching: false,
  data: {},
  from: null,
  to: null,
  lastUpdated: null
}

const initialUserState = {
  isFetching: false,
  data: [],
  from: null,
  to: null,
  lastUpdated: null
}

export function recurringExpenditures(state=initialState, action) {
  switch(action.type) {
    case types.FETCH_RECURRING_EXPENSES: 
      return Object.assign({}, state, {
        isFetching: true
      })
    case types.RECEIVE_RECURRING_EXPENSES:
      return Object.assign({}, state, {
        isFetching: false,
        data: action.data,
        lastUpdated: action.receivedAt
      })
    default:
      return state;
  }
}

export function users(state=initialUserState, action) {
  switch(action.type) {
    case types.FETCH_USERS: 
      return Object.assign({}, state, {
        isFetching: true
      })
    case types.RECEIVE_USERS:
      return Object.assign({}, state, {
        isFetching: false,
        data: action.data,
        lastUpdated: action.receivedAt
      })
    default:
      return state;
  }
}
