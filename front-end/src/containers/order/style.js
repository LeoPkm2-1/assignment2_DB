import styled from "styled-components";

export const StyledOrder = styled.div`
  display: flex;
  justify-content: space-between;
`;

export const StyledOrderList = styled.div`
  flex: 0.6;
  padding: 8px;
`

export const StyledProductOrderList = styled.div`
  flex: 0.4;
  padding: 8px;

`

export const StyledButton = styled.div`
  display: flex;
  align-items: center;
  justify-content: space-between;
  div {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    button {
      text-align: center;
      padding: 0px 2px;
      width: 20px;
      border: 1px solid #aaa;
      background: none;
      font-size: 16px;
      color: #aaa;
    }
  }
  span {
    margin-right: 4px;
    font-size: 20px;
  }
`