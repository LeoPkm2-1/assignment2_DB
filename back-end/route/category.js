const express = require('express');
const con=require('../model/index');
const router = express.Router();


router.get('/get',(req,res)=>{
    const sql='select * from category';
    con.query(sql,(err,results)=>{
        if(err){
            throw err;
        }
        res.json({'result':results});
    });
});

module.exports=router
