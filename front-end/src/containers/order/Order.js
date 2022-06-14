import { Table } from 'antd'
import moment from 'moment';
import React, { useEffect, useState } from 'react'
import { useDispatch, useSelector } from 'react-redux';
import { saveOrderItem, saveOrderList } from '../../redux/slices/coffeehouseSlice';
import { useGetOrdersQuery, useGetProductOrdersQuery } from '../../services/productOrderApi';
import { columnsOrder, columnsProduct } from './configColumnsOrder'
import { StyledOrder, StyledOrderList, StyledProductOrderList } from './style'

function Order() {
	const dispatch = useDispatch();
	const { orderList, orderItem, productList } = useSelector(state => state.coffeehouse);
	const [selectOrder, setSelectOrder] = useState(0)
	const { data: orderListRes } = useGetOrdersQuery();
	const { data: productOrderListRes, refetch: refetchProductOrder } = useGetProductOrdersQuery({ order_id: selectOrder || 0 })

	const handleSelectOrder = (order_id) => {
		setSelectOrder(order_id);
	}

	const handleDeleteOrder = (order_id) => {
		console.log(`The order ${order_id} was delete`);
	}

	useEffect(() => {
		refetchProductOrder();

	}, [selectOrder])

	useEffect(() => {
		if(orderListRes?.productorder) {
			dispatch(saveOrderList(orderListRes.productorder));
			setSelectOrder(orderListRes.productorder[0]?.order_id)
			refetchProductOrder();
		}
	}, [orderListRes])
	
	useEffect(() => {
		if(productOrderListRes?.productorder) {
			const mapProductList = productOrderListRes?.productorder.map(po => {
				return ({
					...productList.find(p => p.product_id === po.product_id),
					quantity: po.quantity,
				})
			})
			dispatch(saveOrderItem(mapProductList));
		}
	}, [productOrderListRes])
	return <StyledOrder>
		<StyledOrderList>
			<h3>Order List</h3>
			<Table columns={columnsOrder({action1: handleSelectOrder, action2: handleDeleteOrder}, [])} dataSource={orderList}/>
		</StyledOrderList>

		<StyledProductOrderList>
			<h3>Chi Tiết Đơn Hàng {moment(orderList.find(o => o?.order_id === selectOrder)?.order_date).format('HH:MM DD-mm-yyyy')}</h3>
			<Table columns={columnsProduct({action1: () => {}, action2: () => {}}, [])} dataSource={orderItem}/>
		</StyledProductOrderList>
	</StyledOrder>
}

export default Order
