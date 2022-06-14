import React, { useEffect } from 'react'
import { columnsCategory } from './configColumnCategory'
import { useDispatch, useSelector } from 'react-redux';
import { Button, Table } from 'antd';
import { StyledCategory } from './style';
import { useGetCategoriesQuery } from '../../services/categoryApi';
import { saveCategoryList } from '../../redux/slices/coffeehouseSlice';

function Category() {
	const dispatch = useDispatch();
	const { categoryList } = useSelector(state => state.coffeehouse);
  const { data: categoryListRes } = useGetCategoriesQuery();

  const showEditForm = () => {

  }

  const handleDeleteCategory = () => {

  }

  useEffect(() => {
    if(categoryListRes) {
      dispatch(saveCategoryList(categoryListRes.categories))
    }
  }, categoryListRes)

  return (
    <StyledCategory>
      <div className='content'>
				<Button ghost type='primary' className='btn' onClick={() => showEditForm()}>Add new category</Button>
				<Table columns={columnsCategory({action1: showEditForm, action2: handleDeleteCategory}, categoryList)} dataSource={categoryList}/>
			</div>
    </StyledCategory>
  )
}

export default Category
