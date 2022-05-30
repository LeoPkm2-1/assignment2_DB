const express =require('express');
const mysql =require('mysql');
const app =express();
const port =5000;

// create connect object
const con=mysql.createConnection({
    host:"localhost",
    user:'root',
    password:'',
    database:'assignment2',
});

// connect to database
con.connect((err)=>{
    if(err){
        throw err
    }
    console.log('connected to database success.');
});


app.get('/api/get-category',(req,res)=>{
    const sql='select * from category';
    con.query(sql,(err,results)=>{
        if(err){
            throw err;
        }
        res.json({'result':results});
    });
});
app.listen(port,()=>{
    console.log(`server started at:${port}`);
});

