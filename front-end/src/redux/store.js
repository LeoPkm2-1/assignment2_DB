import { configureStore, combineReducers } from '@reduxjs/toolkit';
import coffeehouse from './slices/coffeehouseSlice';
import { categoryApi, productApi, productOrderApi } from '../services';

const rootReducer = combineReducers({
  coffeehouse,
  [categoryApi.reducerPath]: categoryApi.reducer,
  [productApi.reducerPath]: productApi.reducer,
  [productOrderApi.reducerPath]: productOrderApi.reducer,
});

export const store = configureStore({
  reducer: rootReducer,
  middleware: getDefaultMiddleware =>getDefaultMiddleware().concat([
    categoryApi.middleware,
    productApi.middleware,
    productOrderApi.middleware,
  ]),
});
