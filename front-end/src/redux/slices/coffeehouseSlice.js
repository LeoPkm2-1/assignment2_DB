import { createSlice } from '@reduxjs/toolkit';

const initialState = {
  user: null,
  employeeList: [],
  customerList: [],
  branchList: [],
  categoryList: [],
  productList: [],
  productItem: null,
  orderList: [],
  orderItem: null,
};

const coffeehouseSlice = createSlice({
  name: 'coffeehouse',
  initialState,
  reducers: {
    saveUser(state, action) {
      state.user = action.payload;
    },
    saveProductList(state, action) {
      state.productList = action.payload;
    },
    saveProductItem(state, action) {
      state.productItem = action.payload;
    },
    saveCategoryList(state, action) {
      state.categoryList = action.payload;
    },
    saveBranchList(state, action) {
      state.branchList = action.payload;
    },
    saveOrderList(state, action) {
      state.orderList = action.payload;
    },
    saveOrderItem(state, action) {
      state.orderItem = action.payload;
    },
    saveEmployeeList(state, action) {
      state.employeeList = action.payload;
    },
    saveCustomerList(state, action) {
      state.customerList = action.payload;
    },
  }
});

const { actions, reducer } = coffeehouseSlice;

export const {
  saveUser,
  saveProductList,
  saveProductItem,
  saveCategoryList,
  saveBranchList,
  saveOrderList,
  saveOrderItem,
  saveEmployeeList,
  saveCustomerList,
} = actions;

export default reducer;