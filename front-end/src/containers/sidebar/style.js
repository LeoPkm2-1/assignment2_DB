import styled from 'styled-components';

export const StyledSidebar = styled.div`
  background: #fff;
  width: 256px;
  height: 100vh;
  padding: 16px;
  .sidebar-header {
    display: flex;
    align-items: center;
    padding: 16px;
    .sidebar-header-avatar {
      margin-right: 12px;
    }
    h2 {
      margin: 0;
    }
  }
  .sidebar-btn-logout {
    width: 100%;
  }
`;