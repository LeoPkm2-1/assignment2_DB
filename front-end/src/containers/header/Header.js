import React, { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { StyledHeader } from './style';
import './../../styles/header.css'
import logo from'./../../image/thecoffeehouse.png'
import { Col, Row, Slider } from 'antd';
import { useSelector } from 'react-redux';

function Header() {
  const { productList } = useSelector(state => state.coffeehouse)
  const [visible, setVisible] = useState(false);
  const [searchInput, setSearchInput] = useState('');
  const [filtedProduct, setFiltedProduct] = useState([]);

  const handleSearch = () => {
    console.log(searchInput)
    resetForm();
  };

  const handleCancel = () => {
    resetForm();
  };

  const resetForm = () => {
    setSearchInput('');
    setVisible(false);
  }

  useEffect(() => {
    const timeout = setTimeout(() => {
      const filter = searchInput ? productList.filter(p => p.product_name.includes(searchInput)) : [];
      setFiltedProduct(filter);
    }, 500)
    return function () {
      clearTimeout(timeout);
    }
  }, [searchInput])

  return (
    <>
      <div className="header">
          <a href='../'>
            <img src={logo} alt=""></img>
          </a>
          <ul className="list">
              <li>Đặt hàng</li>
              <li>Tin tức</li>
              <li>Cừa hàng</li>
              <li>Khuyến mãi</li>
              <li>Tuyển dụng</li>
          </ul>
          <div className="icon">
              <Link to='#'>
                <i className="fa-solid fa-search" onClick={() => setVisible(true)}></i>
              </Link>
              <Link to='#'>
                <i className="fa-solid fa-user"></i>
              </Link>
              <Link to='/order'>
                <i className="fa-solid fa-cart-plus"></i>
              </Link>
          </div>
      </div>
      <div className='modal' style={{ display: visible? 'block' : 'none' }}>
        <div className='modal-search'>
          <div className='modal-search-form' >
            <i className="fa-solid fa-times" onClick={() => handleCancel()}></i>
            <input value={searchInput} onChange={(e) => setSearchInput(e.target.value)}/>
            <i className="fa-solid fa-search" onClick={() => handleSearch()}></i>
          </div>
          {filtedProduct.length ? <div className='modal-search-result'>
          <Row gutter={[12, 12]}>
            {filtedProduct.map(fp => (
              <Col key={fp.product_id} span={12}>
                <div className='filted-item'>
                  <img src={fp.product_image} alt='' width={100} height={100}/>
                  <div>
                    <h4>{fp.product_name}</h4>
                    <span>{fp.product_listed_price}.000đ</span>
                  </div>
                  <button>+</button>
                </div>
              </Col>
            ))}
          </Row>
          </div> : null}
        </div>
      </div>
    </>
  )
}

export default Header
