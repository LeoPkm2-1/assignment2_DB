const express =require('express');

const categoryRouter=require('./route/category');
const app =express();
const port =5000;



app.use('/api/category',categoryRouter);


app.listen(port,()=>{
    console.log(`server started at:${port}`);
});

