const express =require('express');
const cors = require('cors');

const categoryRouter=require('./route/category');
const productRouter=require('./route/product');
const productorderRouter=require('./route/productOrder');
const orderRouter=require('./route/order')
const productWithCategoryRouter = require('./route/productWithCategory')
const app =express();
app.use(express.json())
const port =5000;

app.use(cors());

app.use('/api/category',categoryRouter);
app.use('/api/product',productRouter);
app.use('/api/productorder',productorderRouter);
app.use('/api/order',orderRouter);
app.use('/api/productwithcategory',productWithCategoryRouter)


app.listen(port,()=>{
    console.log(`server started at:${port}`);
});

