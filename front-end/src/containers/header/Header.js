import React from 'react'
import { Link } from 'react-router-dom'
import { StyledHeader } from './style';
import './../../styles/header.css'
import logo from'./../../image/thecoffeehouse.png'

function Header() {
  return (
    <div class="header">
        <img src={logo} alt=""></img>
        <ul class="list">
            <li>Đặt hàng</li>
            <li>Tin tức</li>
            <li>Cừa hàng</li>
            <li>Khuyến mãi</li>
            <li>Tuyển dụng</li>
        </ul>
        <div class="icon">
            <i class="fa-solid fa-user"></i>
            <i class="fa-solid fa-cart-plus"></i>
        </div>
    </div>
  )
}

export default Header
