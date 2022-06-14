import { Space } from "antd";

export const columnsProduct = ({action1, action2}, categoryList = []) => ([
  {
    title: 'Image',
    dataIndex: 'product_image',
    key: 'product_id',
    render: (imgSrc) => <img src={imgSrc} alt={''} width={50} height={50}/>
  },
  {
    title: 'Name',
    dataIndex: 'product_name',
    key: 'product_id',
    render: (text) => <a href="#">{text}</a>,
  },
  {
    title: 'Category',
    dataIndex: 'product_category_id',
    key: 'product_id',
    render: (productCategoryId) => <span>{categoryList.find(c => c?.category_id === productCategoryId)?.category_name}</span>
  },
  {
    title: 'Price',
    dataIndex: 'product_listed_price',
    key: 'product_id',
    render: (productPrice) => <span>${productPrice}</span>
  },
  {
    title: 'Remain',
    dataIndex: 'product_number',
    key: 'product_id',
  },
  {
    title: 'Rate (5.0)',
    dataIndex: 'product_start_avg',
    key: 'product_id',
  },
  {
    title: 'Action',
    dataIndex: 'product_id',
    key: 'product_id',
    render: (product_id) => (
      <Space size="middle">
        <a href='#' onClick={() => action1(product_id)}>Edit</a>
        <a href="#" onClick={() => action2(product_id)}>Delete</a>
      </Space>
    ),
  },
]);