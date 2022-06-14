import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom';
import { Avatar, Button, Menu } from 'antd';
import { AppstoreOutlined, AccountBookOutlined } from '@ant-design/icons';
import { StyledSidebar } from'./style';

function getItem(label, key, icon, children, type) {
  return {
    key,
    icon,
    children,
    label,
    type,
  };
}

const items = [
  getItem('Quản lý tài nguyên', 'sub1', <AppstoreOutlined />, [
    getItem('Thực đơn', 'menu'),
    getItem('Danh mục', 'category'),
    getItem('Sản phẩm', 'product'),
    getItem('Giftcode', 'giftcode'),
    getItem('Đơn hàng', 'order'),
  ]),
  getItem('Quản lý tài khoản', 'sub2', <AccountBookOutlined />, [
    getItem('Nhân viên', 'employee'),
    getItem('Khách hàng', 'customer'),
    getItem('Tài khoản của tôi', 'profile'),
  ])
];

const rootSubmenuKeys = ['sub1', 'sub2'];

function Sidebar() {
  const navigate = useNavigate();
  const [openKeys, setOpenKeys] = useState(['sub1']);

  const onClick = (e) => {
    navigate(`../coffeehouse/${e.keyPath[0]}`)
  }
  const onOpenChange = (keys) => {
    const latestOpenKey = keys.find((key) => openKeys.indexOf(key) === -1);

    if (rootSubmenuKeys.indexOf(latestOpenKey) === -1) {
      setOpenKeys(keys);
    } else {
      setOpenKeys(latestOpenKey ? [latestOpenKey] : []);
    }
  };

  return (
    <StyledSidebar>
      <div className='sidebar-header'>
        <Avatar src={''} size='default' className='sidebar-header-avatar'>T</Avatar>
        <h2>Coffee House</h2>
      </div>
      <Menu
        mode="inline"
        openKeys={openKeys}
        onClick={onClick}
        defaultActiveFirst
        onOpenChange={onOpenChange}
        style={{
          width: '100%',
        }}
        items={items}
      />
      <Button ghost type='primary' className='sidebar-btn-logout'>Log out</Button>
    </StyledSidebar>
  )
}

export default Sidebar
