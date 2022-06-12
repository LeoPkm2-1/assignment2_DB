import React, { useEffect, useState } from 'react';
import { Row, Col, Divider, Modal, Button } from 'antd';
import { ShopOutlined, EditOutlined, StarFilled, StarOutlined } from '@ant-design/icons';
import { StyledMenu } from './style';
import { useDispatch, useSelector } from 'react-redux';
import { useGetAllProductsQuery } from '../../services/productApi';
import { saveCategoryList, saveProductList } from '../../redux/slices/coffeehouseSlice';
import { useGetCategoriesQuery } from '../../services/categoryApi';
import Card from './../card/Card'
import CardIcon from '../card-icon/CardIcon';

import './style.css'
import Header from '../header/Header';

// const { Meta } = Card
const starList = [1, 2, 3, 4, 5];
const styledStar = {
  marginRight: 12,
  color: 'yellow',
  fontSize: 20
}
const styledMeta = {
  marginRight: 12,
}

const array_img =[
  'https://minio.thecoffeehouse.com/image/tch-web-order/category-thumbnails/banh-snack.png',
  'https://minio.thecoffeehouse.com/image/tch-web-order/category-thumbnails/ca-phe.png',
  'https://minio.thecoffeehouse.com/image/tch-web-order/category-thumbnails/hi-tea.png',
  'https://minio.thecoffeehouse.com/image/tch-web-order/category-thumbnails/tra-trai-cay-tra-sua.png',
  'https://minio.thecoffeehouse.com/image/tch-web-order/category-thumbnails/da-xa.png'
]

function Menu({ categoryId = null }) {
  const dispatch = useDispatch();
  const { data: productListRes } = useGetAllProductsQuery();
  const { data: categoryListRes } = useGetCategoriesQuery();
	const { productList, categoryList } = useSelector(state => state.coffeehouse);

  const [productListTarget, setProductListTarget] =useState(productList)

  useEffect(() => {
    if(productListRes && categoryListRes) {
      dispatch(saveProductList(productListRes.products));
      dispatch(saveCategoryList(categoryListRes.categories));
    }
  }, [productListRes, categoryListRes,categoryList,productList,productListTarget])

  const chageProductList = (category_id)=>{
    let rs = productList.filter(p=>p.product_category_id === category_id)
    setProductListTarget(rs)
  }

  return (
    <>
    <div className="menu-container">
      {categoryList.map((c,index) => (<>
      {console.log(index)}
      <div key={c.category_id} onClick={()=>chageProductList(c.category_id)}>
        <CardIcon name={c.category_name} img={array_img[index]}></CardIcon>
      </div>
      </>))}
    </div>
    <div className='product-menu'>
    {productListTarget.map(p => (
      <Card key={p.product_id} name={p.product_name} price={p.product_listed_price} img={p.product_image}></Card>
    ))}
    </div>
    </>
  )
}

export default Menu
