/**
 *  @author: Jamador
 * 
 * Archivo para poner todas las web services del Log in.
 * Aca se pondran todos
 * 
 * 
 * @param res= parametro respuesta del servidor hacia el cliente
 * @param req= parametro request o peticion del cliente al servidor.
 * 
 */


const express = require('express');
const router = express.Router();
const login = require('../model/login-model');
const adminLogin = require('../model/admin.model'); 
const bcrypt = require ('bcrypt');
const jwt = require('jsonwebtoken');
const token = require('../token/jwt');
const categoriaModel = require('../model/categoria.model');
const { jwtKey,adminJwtKey } = require('../config/keys.config');


var isAdmin = false;
var logeado = false;
var createdToken = '';
var loggedUser = {}
var tempName = []
var firstName = '';
var lastName = '';


router.post('/adminVerification',(req,res, next)=>{
    adminLogin.getCredencialesAdministrador(req.body.formEmailLogin).then((resultado)=>{
        if(resultado.length == 0){
            res.send(false)
        }else{
            isAdmin = true;
            
            createdAdminToken = token.createToken(req.body.formEmailLogin,isAdmin);
            logeado = true;
            res.status(200).json(createdAdminToken);
            return;
        }
    });
});


router.post('/',(req,res, next)=>{
    login.getCredencialesUsuario(req.body.formEmailLogin).then(resultado=>{
        
        if(resultado.length>0){
            bcrypt.compare(req.body.formPasswordLogin,resultado[0].CONTRASENA).then(match=>{
                
                if(resultado[0].CORREO_ELECTRONICO==req.body.formEmailLogin && 
                    match){
                        isAdmin = false;
                        createdToken = token.createToken(req.body.formEmailLogin,isAdmin);
                        logeado = true;
                        res.json(createdToken);
                    
                        // res.status(201).send( {
                        //     mensaje:"Bienvenido ",
                        //     logeado:true
                        // });
                
                }else{
                    logeado = false;
                    res.send(logeado);
                    return;
                }
            })
            
        }else {
                logeado = false;
                res.send(logeado);
                return;
                // res.status(201).send( {
                //     mensaje:"algo salio mal :(",
                //     logeado:false
                // });
        }
    });
    
});



router.get('/getloggeduser',verifyToken,(req,res)=>{
    jwt.verify(req.token, jwtKey,(error, authedUser)=>{
        if (error){
            res.json({
                mensaje:'Token no valido',
                tokenAutenticado: false
            });
        }else{
            login.getUsuarioLogeado(authedUser.email).then(resultado =>{

                if(resultado.length == 0){
                    res.send(false);
                    return;
                }else{
                    firstName = formatNames(resultado[0].NOMBRE);
                    lastName = formatNames(resultado[0].APELLIDO);

                    loggedUser = {
                    nombreCompleto : firstName + ' ' + lastName,
                    idUsuario : resultado[0].ID_USUARIO,
                    imagenPerfil: resultado[0].IMAGENS
                    };
                    categoriaModel.getCategoriasSuscritas(authedUser.email).then(resultado2=>{
                        if(resultado2.length == 0){
                            res.json({loggedUser,
                                mensaje:'No tiene suscripciones en Categorias',
                                suscripciones: false
                            });
                        }else{
                            var idCats=[];
                            for (var i = 0; i< resultado2.length; i++){
                                idCats.push(resultado2[i].ID_CATEGORIA);
                            }
                            console.log(idCats);
                            res.json({loggedUser,
                                suscripciones:true,
                                categoriasSuscritas:idCats
                            });
                            return;
                        }
                        
                    });
                    
                    return;
                }

                
            })
        }
        
    })
});




router.get('/loggedAdministrator',verifyToken,(req,res)=>{
    jwt.verify(req.token, adminJwtKey,(error, authedUser)=>{
        if (error){
            res.json({
                mensaje:'Token no valido',
                tokenAutenticado: false
            });
        }else{
            adminLogin.getAdminLogeado(authedUser.email).then(resultado =>{
                firstName = formatNames(resultado[0].NOMBRE);
                lastName = formatNames(resultado[0].APELLIDO);

                loggedAdmin = {
                    nombreCompleto : firstName + ' ' + lastName,
                    idAdminitrador : resultado[0].ID_ADMINISTRADOR,
                    imagenPerfil: resultado[0].IMAGENS
                };
                res.status(200).json(loggedAdmin);
                return;
            })
        }
        
    })
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


function formatNames (name){
    tempName = name.split(' ');
    return tempName[0];

}
router.get('/:',(req,res)=>{

    res.status(500);
    
    
});


module.exports={
    router : router
}