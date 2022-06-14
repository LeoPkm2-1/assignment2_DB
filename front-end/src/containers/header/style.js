import styled from 'styled-components';

export const StyledHeader = styled.header`
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  height: 50px;
  padding: 6px 12px;
  background: #fff;
  margin-bottom: 6px;
  border-radius: 4px;

  .search {
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: #eee;
    border-radius: 30px;
    overflow: hidden;

    form {
      width: 100%;
      display: flex;
      justify-content: space-between;
    }

    form input {
      flex: 1;
      outline: none;
      background: none;
      border: none;
      border-radius: 30px;
      padding: 6px 12px;
    }
    form button {
      width: 60px;
      padding: 6px 4px;
      margin-left: 2px;
      border-radius: 20px;
      border: 1px solid #aaa;
      background-color: #fff;
      outline: none;
    }
  }
`;
