const express = require('express');
const con=require('../model/index');
const router = express.Router();


router.get('/get',(req,res)=>{
    const sql='select * from product';
    con.query(sql,(err,results)=>{
        if(err){
            throw err;
        }
        res.json({'product':results});
    });
});

// router.delete('/delete',(req,res)=>{
//     const sql = 
// })
module.exports=router
