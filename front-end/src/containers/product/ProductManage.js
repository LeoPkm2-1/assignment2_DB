import React, { useEffect, useState } from 'react';
import { Modal, Table, Button, Input, Select } from 'antd';
import { columnsProduct } from './configColumnsProduct';
import { StyledProductManage } from './style';
import { useCreateProductMutation, useDeleteProductMutation, useGetAllProductsQuery, useUpdateProductMutation } from '../../services/productApi';
import { useDispatch, useSelector } from 'react-redux';
import { saveCategoryList, saveProductItem, saveProductList } from '../../redux/slices/coffeehouseSlice';
import { useGetCategoriesQuery } from '../../services/categoryApi';

const { Option } = Select;

const ProductManage = () => {
	const dispatch = useDispatch();
	const { productList, categoryList } = useSelector(state => state.coffeehouse);
	const { data: categoryListRes } = useGetCategoriesQuery();
	const { data: productListRes, refetch } = useGetAllProductsQuery();
	const [ updateProduct ] = useUpdateProductMutation();
	const [ createProduct ] = useCreateProductMutation();
	const [ deleteProduct ] = useDeleteProductMutation();
	const [visible, setVisible] = useState(false);
	const [formData, setFormData] = useState({
		productId: null,
		productImage: '',
		productName: '',
		productPrice: 0,
		productNumber: 0,
		productCategoryId: 0,
		productStartAvg: 0,
	})

	const handleChangeFormData = (element) => {
		setFormData(prev => ({
			...prev,
			[element.target.name]: element.target.value
		}))
	}

	const onSelect = (value) => {
		setFormData(prev => ({
			...prev,
			productCategoryId: value
		}))
		console.log(value)
	}

	const showEditForm = (productId) => {
		const product = productList.find(p => p.product_id === productId);
		if(product) {
			dispatch(saveProductItem(product));
			setFormData((prev) => ({
				...prev,
				productId: product.product_id,
				productImage: product.product_image,
				productName: product.product_name,
				productPrice: product.product_listed_price,
				productNumber: product.product_number,
				productCategoryId: product.product_category_id,
				productStartAvg: product.product_start_avg,
			}));
		}
		setVisible(true);
	}
	const handleEditProduct = () => {
		const payload = {
			id: formData.productId,
			name: formData.productName,
			price: formData.productPrice,
			image: formData.productImage,
			number: formData.productNumber,
			start_avg: formData.productStartAvg,
			category: formData.productCategoryId,
		}
		if(formData.productId) {
			updateProduct(payload).unwrap().then(() => {
				refetch();
			})
		} else {
			createProduct(payload).unwrap().then(() => {
				refetch();
			})
		}
		resetEditForm();
	}
	const handleDeleteProduct = (productId) => {
		console.log(productId);
		deleteProduct({id: productId}).unwrap().then(() => refetch());
	}

	const resetEditForm = () => {
		setFormData({
			productId: null,
			productImage: '',
			productName: '',
			productPrice: '',
			productNumber: 0,
			productCategoryId: 0,
			productStartAvg: 0,
		})
		setVisible(false);
	}

	useEffect(() => {
		if(productListRes && categoryListRes) {
			dispatch(saveCategoryList(categoryListRes.categories))
			dispatch(saveProductList(productListRes.products))
		}
	}, [productListRes, categoryListRes])

	return (
		<StyledProductManage>
			<div className='content'>
				<Button ghost type='primary' className='btn' onClick={() => showEditForm()}>Add new product</Button>
				<Table columns={columnsProduct({action1: showEditForm, action2: handleDeleteProduct}, categoryList)} dataSource={productList}/>
			</div>

			<Modal
				title="Add/Edit product"
				visible={visible}
				onOk={handleEditProduct}
				onCancel={resetEditForm}
			>
				<div>
					<label htmlFor='productCategoryId'>Category</label> <br/>
					<Select
						style={{ width: '100%' }}
						showSearch
						placeholder="Select a person"
						optionFilterProp="children"
						filterOption={(input, option) =>
							(option?.children).toLowerCase().includes(input.toLowerCase())
						}
						onSelect={v => onSelect(v)}
						value={formData.productCategoryId || ''}
				>
						{categoryList.map(c => <Option value={c.category_id}>{c.category_name}</Option>)}
					</Select>
					<br/>
					<label htmlFor='productName'>Product name</label>
					<Input name='productName' placeholder='Product name' value={formData.productName} onChange={(e) => handleChangeFormData(e)}/>
					<br/>
					<label htmlFor='productPrice'>Product price</label>
					<Input name='productPrice' placeholder='Product price' value={formData.productPrice} onChange={(e) => handleChangeFormData(e)}/>
					<br/>
					<label htmlFor='productNumber'>Product quantity</label>
					<Input name='productNumber' placeholder='Product quantity' value={formData.productNumber} onChange={(e) => handleChangeFormData(e)}/>
					<br/>
					<label htmlFor='productImage'>Product image</label>
					<Input name='productImage' placeholder='Product image' value={formData.productImage} onChange={(e) => handleChangeFormData(e)}/>
				</div>
			</Modal>
		</StyledProductManage>
	)
};

export default ProductManage;