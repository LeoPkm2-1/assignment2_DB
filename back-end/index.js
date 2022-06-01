const express =require('express');

const categoryRouter=require('./route/category');
const productRouter=require('./route/product');
const productorderRouter=require('./route/productorder');
const app =express();
app.use(express.json())
const port =5000;



app.use('/api/category',categoryRouter);
app.use('/api/product',productRouter);
app.use('/api/productorder',productorderRouter);


app.listen(port,()=>{
    console.log(`server started at:${port}`);
});

