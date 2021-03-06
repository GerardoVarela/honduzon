/**
 * 
 * Archivo para modulos de administrador
 * DENUNCIAS, ANUNCIOS Y PPOSIBLEMENTE ESTADISTICA
 * 
 * 
 * 
 */
var express = require('express');
var router = express.Router();
var adminModel=require('../model/admin.model');
const jwt = require('jsonwebtoken');
const { adminJwtKey } = require('../config/keys.config');

router.get('/denuncias',verifyToken,(req,res)=>{

    jwt.verify(req.token, adminJwtKey,(error)=>{
        if (error){
            res.status(403).json({
                mensaje:'Token no valido, Ruta prohibida para usuarios no administradores',
                tokenAutenticado: false
            });
        }else{
            /**
             * Va a extraer todas las denuncias para mostrarlas en la lista de denuncias
             * 
             */
            console.log('Goddamit');
            return;
        }
        
    })

});


router.get('/productosvencidos',(req,res)=>{
    adminModel.getProductosVencidos().then(resultado=>
     {
         if(resultado.length==0){
                res.json(0);
     }  else {  res.send(resultado);}
    });
});

router.put('/actualizarproductosvencidos',(req,res)=>{
    adminModel.updateProductoVencido(req.body.idProducto).then(resultado=>
        {
         
                res.json({mensaje:'Producto actualizado' });
            
        });
});











function verifyToken(req, res, next){

    const bearerHeader = req.headers['authorization'];
    if (typeof bearerHeader !== undefined){
        const bearerToken = bearerHeader.split(' ')[1];
        req.token = bearerToken;
        next();
    }else{
        res.json({
            tokenStatus:false,
            mensaje:'No existe Token'
        }) ;
    }
}


module.exports={
    router
}