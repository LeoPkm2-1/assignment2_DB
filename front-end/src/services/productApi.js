import { createApi } from '@reduxjs/toolkit/query/react';
import { baseQuery } from './baseQuery';

export const productApi = createApi({
  reducerPath: 'productApi',
  baseQuery,
  endpoints: builder => ({
    getProducts: builder.query({
      query: payload => ({
        url: `/product/get/${payload.id}`,
      })
    }),
    getAllProducts: builder.query({
      query: () => ({
        url: `/product/get`,
      })
    }),
    createProduct: builder.mutation({
      query: payload => ({
        url: `/product/post`,
        method: 'POST',
        body: {
          name: payload.name,
          price: payload.price,
          image: payload.image,
          number: payload.number,
          start_avg: payload.start_avg,
          category: payload.category
        }
      })
    }),
    deleteProduct: builder.mutation({
      query: payload => ({
        url: `/product/delete`,
        method: 'DELETE',
        body: { id: payload.id }
      })
    }),
    updateProduct: builder.mutation({
      query: payload => ({
        url: `/product/update`,
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
    })
  })
});

export const {
  useGetProductsQuery,
  useCreateProductMutation,
  useDeleteProductMutation,
  useUpdateProductMutation,
  useGetAllProductsQuery
} = productApi;