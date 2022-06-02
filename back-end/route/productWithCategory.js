const express = require('express');
const con=require('../model/index');
const router = express.Router();


router.get('/get',(req,res)=>{
    const sql='call select_product_with_category_procedure()';
    con.query(sql,(err,results)=>{
        if(err){
            throw err;
        }
        res.json({'productWithCategory':results});
    });
});
module.exports=router
