import { Space } from "antd";

export const columnsCategory = ({action1, action2}) => ([
  {
    title: 'Name',
    dataIndex: 'category_name',
    key: 'category_name',
    render: (text) => <a href="#">{text}</a>,
  },
  // {
  //   title: 'Product quantity',
  //   dataIndex: 'product_quantity',
  //   key: 'product_quantity',
  // },
  {
    title: 'Action',
    dataIndex: 'product_id',
    key: 'action',
    render: (category_id) => (
      <Space size="middle">
        <a onClick={() => action1(category_id)}>Edit</a>
        <a onClick={() => action2(category_id)}>Delete</a>
      </Space>
    ),
  },
]);