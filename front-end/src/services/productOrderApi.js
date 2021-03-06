import { createApi } from '@reduxjs/toolkit/query/react';
import { baseQuery } from './baseQuery';

export const productOrderApi = createApi({
  reducerPath: 'productOrderApi',
  baseQuery,
  endpoints: builder => ({
    getOrders: builder.query({
      query: () => ({
        url: `/order/get`,
      })
    }),
    getProductOrders: builder.query({
      query: (payload) => ({
        url: `/productorder/get/${payload.order_id}`,
      })
    }),
    deleteProductOrder: builder.mutation({
      query: payload => ({
        url: `/productorder/delete`,
        method: 'DELETE',
        body: { id: payload.id }
      })
    }),
    updateProductOrder: builder.mutation({
      query: payload => ({
        url: `/productorder/update`,
        method: 'PUT',
        body: {
          id: payload.id,
          name: payload.name,
          price: payload.price,
          image: payload.image,
          number: payload.number,
          start_avg: payload.start_avg,
          category: payload.category
        }
      })
    }),
    createProductOrder: builder.mutation({
      query: payload => ({
        url: `/productorder/post`,
        method: 'POST',
        body: {
          id: payload.id,
          name: payload.name,
          price: payload.price,
          image: payload.image,
          number: payload.number,
          start_avg: payload.start_avg,
          category: payload.category
        }
      })
    })
  })
});

export const {
  useCreateProductOrderMutation,
  useDeleteProductOrderMutation,
  useUpdateProductOrderMutation,
  useGetProductOrdersQuery,
  useGetOrdersQuery,
} = productOrderApi;