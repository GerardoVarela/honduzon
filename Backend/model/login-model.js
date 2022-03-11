/*@author Jamador
*/
var bdConfig = require ('../config/bd-config');

 var mssql = require('mssql');
 
 
 
/*
 async function getCorreoUsuario(correo){
    try {
        var pool = await mssql.connect(bdConfig.config);
        let correoUsuario = await pool.request()
        .input('correoInput',mssql.VarChar, correo)
        .query('SELECT CORREO_ELECTRONICO FROM Usuarios WHERE CORREO_ELECTRONICO = @correoInput');
        console.log(correoUsuario.recordset);
        return correoUsuario.recordset;
    } catch (error) {
        console.log(error);
        process.exit(1);
    }}
    
*/


 
 async function getUsuario(Usuariocorreo,usuarioPassword){
     try {
         let pool = await mssql.connect(bdConfig.config);
         let correo = await pool.request()
         .input('correoIput', mssql.VarChar, Usuariocorreo)
         .input('paswwordIput', mssql.VarChar, usuarioPassword)
         .query('select Usuarios.CORREO_ELECTRONICO, Usuarios.CONTRASENA from Usuarios where Usuarios.CORREO_ELECTRONICO=@correoIput and Usuarios.CONTRASENA=@paswwordIput');
       
         return correo.recordset;
     } catch (error) {
         console.log(error);
     }
 }
 


 module.exports = {
   getUsuario:getUsuario    

 }