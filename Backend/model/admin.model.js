var bdConfig = require('../config/bd-config');
const mssql = require('mssql');

async function getCredencialesAdministrador(correoAdmin){
    try {
        let pool = await mssql.connect(bdConfig.config);
        let correo = await pool.request()
        .input('correoInput', mssql.VarChar, correoAdmin)
        .query('SELECT ADMINISTRADOR.CORREO_ELECTRONICO, ADMINISTRADOR.CONTRASENA FROM ADMINISTRADOR WHERE CORREO_ELECTRONICO=@correoInput');
    
        return correo.recordset;
    } catch (error) {
        return error;
    }
}

async function getAdminLogeado(adminEmail){
    try {
        var pool = await mssql.connect(bdConfig.config);
        let correoUsuario = await pool.request()
        .input('correoInput',mssql.VarChar, adminEmail)
        .query('SELECT ID_ADMINISTRADOR,NOMBRE, APELLIDO FROM ADMINISTRADOR WHERE CORREO_ELECTRONICO = @correoInput');
        
        return correoUsuario.recordset;
    } catch (error) {
        return error;
    }
}

async function getProductosVencidos(){
    try {
        var pool = await mssql.connect(bdConfig.config);
        let productosVencidos = await pool.request()
        .query("select * from Productos where estado=0 and DescripcionEstado='fecha vencida'");
        return productosVencidos.recordset;
}
catch (error) {
    return error;
}}

async function updateProductoVencido(idProducto){
    try {
        var pool = await mssql.connect(bdConfig.config);
        let updateProducto = await pool.request()
        .input('idProductoInput',mssql.Int, idProducto)
        .query("update Productos set estado=1,DescripcionEstado='disponible',fecha=getdate() where id_Producto=@idProductoInput");
        return updateProducto.recordset;
    }  
         catch (error) { 
        return error;}}


module.exports={
    getCredencialesAdministrador,
    getAdminLogeado,
    getProductosVencidos,
    updateProductoVencido
}