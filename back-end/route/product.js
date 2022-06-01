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

router.delete('/delete',(req,res)=>{
    const {id}=req.body;
    const sql = `DELETE FROM product WHERE product_id = ${id}`
    con.query(sql,(err,results)=>{
        if(err){
            throw err;
        }
        res.json(`Product ${id} deleted`)
    })
})

router.put('/update',(req,res)=>{
    const {id,name,price,image,number,start_avg,category}=req.body
    const sql = `UPDATE product 
    SET product_name = "${name}", 
    product_listed_price = ${price}, 
    product_image ="${image}", 
    product_number = ${number}, 
    product_start_avg = ${start_avg}, 
    product_category_id =${category}
    WHERE product_id = ${id};`
    con.query(sql,(err,results)=>{
        if(err){
            throw err;
        }
        res.json(`Product ${id} updated`)
    })
    
})

router.post('/post',(req,res)=>{
    const {name,price,image,number,start_avg,category}=req.body
    const sql = `INSERT INTO product (product_name,product_listed_price,product_image,product_number,product_start_avg,product_category_id)
    VALUES ("${name}",${price},"${image}",${number},${start_avg},${category});`
    con.query(sql,(err,results)=>{
        if(err){
            throw err;
        }
        res.json(`Product created`)
    })
})
module.exports=router
