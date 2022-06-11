import { Space } from "antd";
import moment from "moment";
import { StyledButton } from "./style";

export const columnsOrder = ({action1, action2}, giftCodeList) => ([
  {
    title: 'Order date',
    dataIndex: 'order_date',
    key: 'order_id',
    width: 150,
    render: (date) => <div>{moment(date).format('HH:MM DD-mm-yyyy')}</div>
  },
  {
    title: 'Order address',
    dataIndex: 'order_address',
    key: 'order_id',
  },
  {
    title: 'Gift code',
    dataIndex: 'order_code ',
    key: 'order_id',
    width: 200,
  },
  {
    title: 'Total money',
    dataIndex: 'order_total_money',
    key: 'order_id',
    width: 120,
    render: (money) => <span>${money}</span>
  },
  {
    title: 'Status',
    dataIndex: 'order_status',
    key: 'order_id',
    width: 50,
  },
  {
    title: 'Action',
    dataIndex: 'order_id',
    key: 'order_id',
    width: 50,
    render: (order_id) => (
      <Space size="middle">
        <a href="#" onClick={() => action1(order_id)}>Visit</a>
        <a href="#" onClick={() => action2(order_id)}>Delete</a>
      </Space>
    ),
  },
]);


export const columnsProduct = ({action1, action2}, productList) => ([
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
    title: 'Price',
    dataIndex: 'product_listed_price',
    key: 'product_id',
    render: (productPrice) => <span>${productPrice}</span>
  },
  {
    title: 'Quantity',
    dataIndex: 'quantity',
    key: 'product_id',
    width: 50,
    render: (quantity) => (
      <StyledButton>
      <span>{quantity}</span>
      {/* <div>
        <button onClick={() => action1(true)}>+</button>
        <button onClick={() => action1(false)}>-</button>
      </div> */}
    </StyledButton>
    )
  },
  {
    title: 'Action',
    dataIndex: 'product_id',
    key: 'product_id',
    width: 50,
    render: (product_id) => (
      <Space size="middle">
        <a href="#" onClick={() => action2(product_id)}>Delete</a>
      </Space>
    ),
  },
]);