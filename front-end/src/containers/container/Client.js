import React from 'react'
import Header from '../header/Header'
import { StyledClient } from './style'
import Menu from './../menu/Menu';
import Order from '../order/Order';
import Home from '../home/Home';

function Client({ page = 'menu' }) {
  return (
    <StyledClient>
      <Header/>
      {page === 'menu' && <Menu/>}
      {page === 'order' && <Order/>}
      {page === 'home' && <Home/>}
    </StyledClient>
  )
}

export default Client
