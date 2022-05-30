const mysql =require('mysql');
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

module.exports=con;