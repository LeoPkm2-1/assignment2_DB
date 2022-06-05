import React from 'react'
import { Link } from 'react-router-dom'
import { StyledHeader } from './style';

function Header() {
  return (
    <StyledHeader>
      <div className='logo'><h2>Coffee House</h2></div>
      <div className='search'>
        <form>
          <input placeholder='Enter...'/>
          <button type='button'>Search</button>
        </form>
      </div>
      <div>
        <Link to='../login'>Đăng nhập</Link>
      </div>
    </StyledHeader>
  )
}

export default Header
