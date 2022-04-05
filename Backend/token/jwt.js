const {sign, verify} = require('jsonwebtoken');
const keys = require('../config/keys.config');

const createToken = (userEmail, userPassword)=>{
    const payload = {
        email : userEmail,
        password : userPassword
    }
    const accessToken = sign(
        payload,
        keys.jwtKey
    )
    return accessToken;


    
}

const verifyToken = (res,req, next)=>{
    const bearerHeader = req.headers['authorization'];
    if (typeof bearerHeader !== 'undefined'){
        const bearerToken = bearerHeader.split(' ')[1];
        req.token = bearerToken;
        console.log('verification');
        next();
    }else{
        return false;
    }
}


module.exports={
    createToken,
    verifyToken
}