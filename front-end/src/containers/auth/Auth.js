import React from 'react'
import LoginForm from '../../components/LoginForm';
import RegisterForm from '../../components/RegisterForm';
import { StyledAuth } from './style';

function Auth({ isLogin = true }) {
  return (
    <StyledAuth>
      {isLogin && <LoginForm/>}
      {!isLogin && <RegisterForm/>}
    </StyledAuth>
  )
}

export default Auth
