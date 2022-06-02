const express = require('express');
const con=require('../model/index');
const router = express.Router();


router.get('/get',(req,res)=>{
    const sql='select * from productorder';
    con.query(sql,(err,results)=>{
        if(err){
            throw err;
        }
        res.json({'productorder':results});
    });
});

router.delete('/delete',(req,res)=>{
    const {order_id,product_id}=req.body;
    const sql = `call productOrder_delete_procedure(${order_id},${product_id})`
    con.query(sql,(err,results)=>{
        if(err){
            throw err;
        }
        res.json(`Product deleted`)
    })
})

router.post('/post',(req,res)=>{
    const {order_id,product_id,quantity}=req.body;
    const sql = `call productOrder_insert_procedure(${order_id},${product_id},${quantity})`
    con.query(sql,(err,results)=>{
        if(err){
            throw err;
        }
        res.json(`Product created`)
    })
})

router.put('/update',(req,res)=>{
    const {order_id,product_id,quantity}=req.body;
    const sql = `call productOrder_update_procedure(${order_id},${product_id},${quantity})`
    con.query(sql,(err,results)=>{
        if(err){
            throw err;
        }
        res.json(`Product updated`)
    })
})

module.exports=router
