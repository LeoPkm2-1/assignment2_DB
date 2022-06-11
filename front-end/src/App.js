import './App.css';
import { Routes, Route } from 'react-router-dom';
import Auth from './containers/auth/Auth';
import Dashboard from './containers/container/Dashboard';
import Client from './containers/container/Client';
import { useDispatch } from 'react-redux';
import { useGetAllProductsQuery } from './services/productApi';
import { useEffect } from 'react';
import { saveProductList } from './redux/slices/coffeehouseSlice';

function App() {
  const dispatch = useDispatch();
  const { data: productListRes } = useGetAllProductsQuery();
  useEffect(() => {
    if(productListRes?.products) {
      dispatch(saveProductList(productListRes.products))
    }
  }, [productListRes])
  return (
    <div className='App'>
      <Routes>
        {/* manager */}
        <Route path='/coffeehouse/category/:categoryId/:productId' element={<Dashboard page='menu'/>}/>
        <Route path='/coffeehouse/category/:categoryId' element={<Dashboard page='menu'/>}/>
        <Route path='/coffeehouse/category' element={<Dashboard page='category'/>}/>
        <Route path='/coffeehouse/employee' element={<Dashboard page='menu'/>}/>
        <Route path='/coffeehouse/customer' element={<Dashboard page='menu'/>}/>
        <Route path='/coffeehouse/profile' element={<Dashboard page='menu'/>}/>
        <Route path='/coffeehouse/menu' index element={<Dashboard page='menu'/>}/>
        <Route path='/coffeehouse/product' index element={<Dashboard/>}/>
        <Route path='/coffeehouse/' index element={<Dashboard/>}/>



        {/* client */}
        <Route path='/order' element={<Client page='order'/>}/>
        <Route path='/cart/payment' element={<div>Trang thanh toán</div>}/>
        <Route path='/cart' element={<div>Giỏ hàng</div>}/>
        <Route path='/category/:categoryId/:productId' element={<Client page='menu'/>}/>
        <Route path='/category/:categoryId' element={<Client page='menu'/>}/>
        <Route path='/profile' element={<Client page='profile'/>}/>
        <Route path='/' index element={<Client/>}/>
        


        {/* auth log in / register */}
        <Route path='/login' element={<Auth/>}/>
        <Route path='/register' element={<Auth isLogin={false}/>}/>
      </Routes>
    </div>
  );
}

export default App;
