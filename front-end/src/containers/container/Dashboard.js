import React from 'react'
import Sidebar from '../sidebar/Sidebar'
import Home from '../home/Home';
import Menu from '../menu/Menu';
import Order from '../order/Order';
import { StyledDashboard } from './style';
import ProductManage from '../product/ProductManage';
import Category from '../category/Category';

function Dashboard({ page= 'product' }) {
  return (
    <StyledDashboard>
      <Sidebar/>
      {page === 'menu' && <Menu/>}
      {page === 'order' && <Order/>}
      {page === 'home' && <Home/>}
      {page === 'category' && <Category/>}
      {page === 'product' && <ProductManage/>}
    </StyledDashboard>
  )
}

export default Dashboard
