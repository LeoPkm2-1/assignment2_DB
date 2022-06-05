import React from 'react'
import Header from '../header/Header'
import { StyledClient } from './style'
import Menu from './../menu/Menu';

function Client({ page = 'menu' }) {
  return (
    <StyledClient>
      <Header/>
      <Menu/>
    </StyledClient>
  )
}

export default Client
