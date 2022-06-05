import { createApi } from '@reduxjs/toolkit/query/react';
import { baseQuery } from './baseQuery';

export const categoryApi = createApi({
  reducerPath: 'categoryApi',
  baseQuery,
  endpoints: builder => ({
    getCategories: builder.query({
      query: payload => ({
        url: `/category/get`
      })
    })
  })
})

export const {
  useGetCategoriesQuery,
} = categoryApi;