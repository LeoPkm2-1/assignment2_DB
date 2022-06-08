import React, { useEffect, useState } from 'react';
import { Row, Col, Divider, Modal, Button } from 'antd';
import { ShopOutlined, EditOutlined, StarFilled, StarOutlined } from '@ant-design/icons';
import { StyledMenu } from './style';
import { useDispatch, useSelector } from 'react-redux';
import { useGetAllProductsQuery } from '../../services/productApi';
import { saveCategoryList, saveProductList } from '../../redux/slices/coffeehouseSlice';
import { useGetCategoriesQuery } from '../../services/categoryApi';
import Card from './../card/Card'

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

function Menu({ categoryId = null }) {
  const dispatch = useDispatch();
  const { data: productListRes } = useGetAllProductsQuery();
  const { data: categoryListRes } = useGetCategoriesQuery();
	const { productList, categoryList } = useSelector(state => state.coffeehouse);
  
	const [visible, setVisible] = useState(false);
  const [star, setStar] = useState(0);

  
  const handleAddToCart = (product) => {
    
  }

  const handleOk = () => {
    setStar(0);
    setVisible(false);
  };
  
  const handleCancel = () => {
    setStar(0);
    setVisible(false);
  };

  useEffect(() => {
    if(productListRes && categoryListRes) {
      dispatch(saveProductList(productListRes.products));
      dispatch(saveCategoryList(categoryListRes.categories));
    }
  }, [productListRes, categoryListRes])
  return (
    <StyledMenu>
      {categoryList.map(c => (<>
        <Divider orientation="left">{c.category_name.toUpperCase()}</Divider>
        <Row gutter={16}>
          {productList.map(p => p.product_category_id === c.category_id && (
          <Col className='gutter-row' span={6}>
            <Card name={p.product_name} price={p.product_listed_price}></Card>
          </Col>))}
        </Row>
      </>))}
    </StyledMenu>
  )
}

export default Menu
