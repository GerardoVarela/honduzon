CREATE DATABASE HONDUZON;
USE HONDUZON;

CREATE TABLE PREGUNTAS(
ID_PREGUNTA INT IDENTITY(1,1) NOT NULL,
PREGUNTA VARCHAR(300),
CONSTRAINT PK_PREGUNTA PRIMARY KEY (ID_PREGUNTA));

CREATE TABLE DEPARTAMENTO(
ID_DEPARTAMENTO INT IDENTITY(1,1) NOT NULL,
NOMBRE_DEPARTAMENTO NVARCHAR(200) NOT NULL,
CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (ID_DEPARTAMENTO)

);

CREATE TABLE CIUDAD(
ID_CIUDAD INT IDENTITY(1,1) NOT NULL,
	CIUDAD VARCHAR (200) NOT NULL,
	ID_DEPARTAMENTO INT NOT NULL,
	CONSTRAINT PK_CIUDAD PRIMARY KEY (ID_CIUDAD),
	CONSTRAINT FK_DEPARTAMENTO FOREIGN KEY (ID_DEPARTAMENTO) REFERENCES DEPARTAMENTO(ID_DEPARTAMENTO)
);

CREATE TABLE ADMINISTRADOR(
ID_ADMINISTRADOR INT IDENTITY(1,1) NOT NULL,
NOMBRE VARCHAR(200) NOT NULL,
APELLIDO VARCHAR (200) NOT NULL,
CORREO_ELECTRONICO VARCHAR(200) NOT NULL,
	TELEFONO VARCHAR(200) NOT NULL,
	CONTRASENA VARCHAR(200) NOT NULL,
	DIRECCION VARCHAR (200) NOT NULL,
	ID_CIUDAD INT,
	CONSTRAINT PK_ADMINISTRADOR PRIMARY KEY (ID_ADMINISTRADOR),
	CONSTRAINT FKA_CIUDAD FOREIGN KEY (ID_CIUDAD) REFERENCES CIUDAD (ID_CIUDAD)
)

CREATE TABLE [dbo].[Usuarios] (
	ID_USUARIO INT IDENTITY(1,1) NOT NULL,
	NOMBRE VARCHAR(200) NOT NULL,
	APELLIDO VARCHAR(200) NOT NULL,
	CORREO_ELECTRONICO VARCHAR(200) NOT NULL,
	TELEFONO VARCHAR(200) NOT NULL,
	CONTRASENA VARCHAR(200) NOT NULL,
	DIRECCION VARCHAR (200),
	RESPUESTA VARCHAR(200) NOT NULL,
	ID_DEPARTAMENTO INT,
	ID_CIUDAD INT,
	ID_PREGUNTA INT,
	IMAGENS VARBINARY(MAX),
	CONSTRAINT PK_USUARIOS PRIMARY KEY (ID_USUARIO),
	CONSTRAINT FKZ_DEPARTAMENTO FOREIGN KEY (ID_DEPARTAMENTO) REFERENCES DEPARTAMENTO(ID_DEPARTAMENTO),
	CONSTRAINT FKU_CIUDAD FOREIGN KEY (ID_CIUDAD) REFERENCES CIUDAD (ID_CIUDAD),
	CONSTRAINT FKP_PREGUNTA FOREIGN KEY (ID_PREGUNTA) REFERENCES PREGUNTAS (ID_PREGUNTA)

);


CREATE TABLE [dbo].[Categoria](
	ID_CATEGORIA INT IDENTITY (1,1) NOT NULL,
	NOMBRE_CATEGORIA VARCHAR (200) NOT NULL,
	DESCRIPCION_CATEGORIA VARCHAR(200) NOT NULL,
	ID_ADMINISTRADOR INT DEFAULT 1,
	IMAGEN_CATEGORIA VARBINARY(MAX)
	
	CONSTRAINT PK_CATEGORIA PRIMARY KEY (ID_CATEGORIA),
	CONSTRAINT FKC_ADMINISTRADOR FOREIGN KEY (ID_ADMINISTRADOR) REFERENCES ADMINISTRADOR(ID_ADMINISTRADOR)
)

CREATE TABLE IMAGENES(
ID_IMAGEN INT IDENTITY(1,1) NOT NULL,
IMAGEN VARBINARY(MAX) ,
CONSTRAINT PKI_IMAGENES PRIMARY KEY (ID_IMAGEN)

)

CREATE TABLE [dbo].[Productos](
	ID_PRODUCTO INT IDENTITY(1,1) NOT NULL ,
	NOMBRE_PRODUCTO VARCHAR(200) NOT NULL ,
	DESCRIPCION_PRODUCTO VARCHAR (200) NOT NULL,
	CANTIDAD_PRODUCTO INT NOT NULL,
	CANTIDAD_PROD_VENDIDO INT,
	PRECIO FLOAT NOT NULL,
	ID_USUARIO INT,
	ID_CATEGORIA INT,
	ID_IMAGEN INT,
	CONSTRAINT PK_PRODUCTO PRIMARY KEY(ID_PRODUCTO),
	CONSTRAINT FKP_USUARIO FOREIGN KEY (ID_USUARIO) REFERENCES [dbo].[Usuarios](ID_USUARIO),
	CONSTRAINT FKP_CATEGORIA FOREIGN KEY (ID_CATEGORIA) REFERENCES [dbo].[Categoria](ID_CATEGORIA),
	CONSTRAINT FKI_IMAGENES FOREIGN KEY(ID_IMAGEN) REFERENCES IMAGENES (ID_IMAGEN)

);

CREATE TABLE LISTA_DESEOS (
	ID_LISTA_DESEOS INT IDENTITY(1,1) NOT NULL,
	ID_PRODUCTO INT,
	ID_USUARIO INT,
	CONSTRAINT PK_LISTA_DESEOS PRIMARY KEY (ID_LISTA_DESEOS),
	CONSTRAINT FKLD_PRODUCTO FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTOS(ID_PRODUCTO)
);


ALTER TABLE LISTA_DESEOS
ADD CONSTRAINT FKLD_USUARIO FOREIGN KEY(ID_USUARIO) REFERENCES USUARIOS(ID_USUARIO)

CREATE TABLE VALORACION(
ID_VALORACION INT,
ID_USUARIO INT,
VALORACION FLOAT ,
CONSTRAINT CHECK_VALORACION
CHECK(VALORACION>=1 AND VALORACION<=5),
CONSTRAINT PK_VALORACION PRIMARY KEY(ID_VALORACION),
constraint fkv_usuario foreign key(ID_USUARIO) references USUARIOs(ID_USUARIO)
)

CREATE TABLE USUARIOSxCATEGORIAS(
ID_USUARIOSxCATEGORIAS INT PRIMARY KEY,
ID_USUARIO INT,
ID_CATEGORIA INT,
FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS(ID_USUARIO),
FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA(ID_CATEGORIA)
)

/* INSERT INTO VALORACION (ID_VALORACION,ID_USUARIO,VALORACION) VALUES(1,1,5); */

/* SELECT VALORACION,NOMBRE FROM USUARIOS JOIN VALORACION ON USUARIOS.ID_USUARIO=VALORACION.ID_USUARIO;*/


INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Atlántida');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Choluteca');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Colón');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Comayagua');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Copán');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Cortés');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('El Paraíso');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Francisco Morazán');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Gracias a Dios');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Intibucá');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Islas de la Bahía');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('La Paz');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Lempira');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Ocotepeque');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Olancho');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Santa Bárbara');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Valle');
INSERT INTO DEPARTAMENTO(NOMBRE_DEPARTAMENTO) VALUES ('Yoro');


INSERT INTO  CIUDAD(CIUDAD,ID_DEPARTAMENTO) VALUES ('Tegucigalpa','8');
INSERT INTO  CIUDAD(CIUDAD,ID_DEPARTAMENTO) VALUES ('San Pedro Sula','6');
INSERT INTO  CIUDAD(CIUDAD,ID_DEPARTAMENTO) VALUES ('La Ceiba','1');
INSERT INTO  CIUDAD(CIUDAD,ID_DEPARTAMENTO) VALUES ('Comayagua','4');
INSERT INTO  CIUDAD(CIUDAD,ID_DEPARTAMENTO) VALUES ('El Progreso','18');
INSERT INTO  CIUDAD(CIUDAD,ID_DEPARTAMENTO) VALUES ('Choluteca','2');

INSERT INTO PREGUNTAS(PREGUNTA) VALUES ('¿Cuál fue el nombre de tu primer mascota?');
INSERT INTO PREGUNTAS(PREGUNTA) VALUES ('¿En que ciudad naciste?');
INSERT INTO PREGUNTAS(PREGUNTA) VALUES ('¿Cómo se llama tu tía favorita?');

CREATE PROCEDURE SP_INSERTAR_USUARIO
@NOMBRE VARCHAR(200),
@APELLIDO VARCHAR(200),
@CORREO_ELECTRONICO VARCHAR(200),
@TELEFONO VARCHAR(200),
@DIRECCION VARCHAR (200),
@RESPUESTA VARCHAR (200),
@ID_DEPARTAMENTO INT,
@CONTRASENA VARCHAR(200),
@ID_CIUDAD INT,
@ID_PREGUNTA INT
AS
BEGIN 
	INSERT INTO dbo.Usuarios(
	NOMBRE ,
APELLIDO ,
CORREO_ELECTRONICO,
TELEFONO ,
DIRECCION,
RESPUESTA,
ID_DEPARTAMENTO ,
CONTRASENA ,
ID_CIUDAD ,
ID_PREGUNTA 
	) VALUES (
	@NOMBRE ,
@APELLIDO ,
@CORREO_ELECTRONICO,
@TELEFONO ,
@DIRECCION,
@RESPUESTA,
@ID_DEPARTAMENTO ,
@CONTRASENA ,
@ID_CIUDAD ,
@ID_PREGUNTA 
);
END

CREATE PROCEDURE SP_INSERTAR_CATEGORIA
@NOMBRE_CATEGORIA VARCHAR(200),
@DESCRIPCION_CATEGORIA VARCHAR(200),
@IMAGEN_CATEGORIA VarBinary
AS
BEGIN 
	INSERT INTO  [dbo].[Categoria] (
	NOMBRE_CATEGORIA,
	DESCRIPCION_CATEGORIA,
	IMAGEN_CATEGORIA
	) VALUES (
	@NOMBRE_CATEGORIA ,
@DESCRIPCION_CATEGORIA ,
@IMAGEN_CATEGORIA
);
END


CREATE PROCEDURE SP_BUSCAR_PRODUCTO
@NOMBRE_PRODUCTO VARCHAR(200)
AS
BEGIN 
select * from productos join IMAGENES ON Productos.ID_IMAGEN=IMAGENES.ID_IMAGEN where Productos.NOMBRE_PRODUCTO LIKE ('%'+@NOMBRE_PRODUCTO+'%')
END

/* select * from productos join IMAGENES ON Productos.ID_IMAGEN=IMAGENES.ID_IMAGEN where Productos.NOMBRE_PRODUCTO LIKE ('%nin%')

select Productos.NOMBRE_PRODUCTO,Productos.DESCRIPCION_PRODUCTO,Productos.CANTIDAD_PRODUCTO,IMAGENES.IMAGEN,Usuarios.NOMBRE,Usuarios.TELEFONO,Usuarios.CORREO_ELECTRONICO,
Productos.PRECIO from Productos join Usuarios on Productos.ID_USUARIO=Usuarios.ID_USUARIO join IMAGENES ON PRODUCTOS.ID_IMAGEN=IMAGENES.ID_IMAGEN  where
(ID_CATEGORIA=6 and PRECIO=1900) or (ID_CATEGORIA=0 and PRECIO=0 and ID_CIUDAD=0) or(ID_CATEGORIA=0 and PRECIO=1 and ID_CIUDAD=1 and ID_DEPARTAMENTO=1) or
(ID_CATEGORIA=1 and ID_CIUDAD=1) or  (ID_CATEGORIA=1 and ID_DEPARTAMENTO=1) or (PRECIO=1 and ID_CIUDAD=1) or (PRECIO=1 and ID_DEPARTAMENTO=1) or
(ID_CIUDAD=1 and ID_DEPARTAMENTO=1)

SELECT * FROM [dbo].[Productos] WHERE PRECIO<=4500 and Precio>=1200
select * from Categoria
*/

INSERT INTO ADMINISTRADOR (NOMBRE ,APELLIDO ,CORREO_ELECTRONICO,TELEFONO ,DIRECCION ,CONTRASENA ,ID_CIUDAD) 
VALUES ('Pedro Alejandro', 'Vasquez Gutierrez', 'asd1@asd.com','1234-1234','Col. America','asd.1234',1);

insert into Categoria(NOMBRE_CATEGORIA,DESCRIPCION_CATEGORIA,ID_ADMINISTRADOR)
values('Videojuegos','Encuentra una gran variedad de videojuegos para distintos tipos de consolas.',1)
insert into Categoria(NOMBRE_CATEGORIA,DESCRIPCION_CATEGORIA,ID_ADMINISTRADOR)
values('Ropa','Vestimenta de todos los colores, tallas y tipos.',1)
insert into Categoria(NOMBRE_CATEGORIA,DESCRIPCION_CATEGORIA,ID_ADMINISTRADOR)
values('Tecnología','Descubre y adquiere los componentes y aparatos tecnológicos que necesitas.',1)
insert into Categoria(NOMBRE_CATEGORIA,DESCRIPCION_CATEGORIA,ID_ADMINISTRADOR)
values('Muebles','Todo lo necesario para decorar tu hogar u oficina de trabajo.',1)
insert into Categoria(NOMBRE_CATEGORIA,DESCRIPCION_CATEGORIA,ID_ADMINISTRADOR)
values('Gimnasio','Encuentra los elementos necesarios para ponerte en forma.',1)
insert into Categoria(NOMBRE_CATEGORIA,DESCRIPCION_CATEGORIA,ID_ADMINISTRADOR)
values('Juguetes','Lleva la diversión hasta tu casa con estos increíbles juguetes.',1)

INSERT INTO Usuarios(NOMBRE,APELLIDO,CORREO_ELECTRONICO,TELEFONO,CONTRASENA,RESPUESTA)
VALUES ('CHOMIN','CHOMINIO','CHOMIN@LAMOTO@GMAIL.COM','88431212','CHOMIN123','CHOMINIA')

INSERT INTO Usuarios
VALUES ('Prueba','PruebaApellido','prueba@gmail.com','9999-9999','prueba123$','Res. Prueba', 'Pedro',1,1,1,1)

insert into IMAGENES values (0)

/* Videojuegos */
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Nintendo 3DS',
		'Nintendo 3DS es tu puerta de acceso portátil a un mundo de increíbles juegos y servicios; te permite conectar con amigos y la comunidad global de Nintendo.',
		1,0,1900,1,1,1)
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Control Xbox',
		'Haz que tu experiencia de juego sea más envolvente con los accesorios y los controles Xbox para las consolas Xbox.',
		25,4,1500,1,1,1)
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('PlayStation 5',
		'La nueva PS5 es la consola con la que Sony planea asaltar la nueva generación.',
		15,2,15000,1,1,1)

/* Ropa */
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Blue Jeans',
		'Jeans de alta calidad, color azul marino y en distintas tallas.',
		30,5,400,2,1,2)
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Calcetines con rombos',
		'Calcetines 100% de algodón, escala de rojos y distintas tallas.',
		45,5,150,2,1,2)
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Camisetas negras',
		'Camisetas 80% de algodón, 20% polyestireno, talla única.',
		25,15,175,2,1,2)
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Tenis blancos',
		'Tenis de damas bajos, color blanco con piedras brillantes, talla única.',
		10,0,700,2,1,2)
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Suéter rayado',
		'Tenis de damas bajos, color blanco con piedras brillantes, talla única.',
		40,2,330,1,1,2)

/* Tecnología */
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Laptop Dell',
		'Laptop para uso empresarial o personal, imprescindible para trabajo de oficina, color plateado.',
		8,0,11999,1,1,3)

/* Muebles */
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Sillón Reclinable',
		'Sillón reclinable Commodity, sistema mecedora, tela vinil en color negro y base de metal.',
		30,5,8000,1,1,4)
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Mesa Plegable',
		'Mesa comercial, ajustable y ligera, es fácil de transportar, su diseño la hace ligera, de fácil instalación y almacenaje.',
		30,5,8000,1,1,4)

/* Gimnasio */	
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Mancuernas',
		'Mancuernas de hierro, base cuadrada, 30 kg, color plateado.',
		4,0,800,1,1,5)
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Discos',
		'Discos de goma, 10 cm de diámetro, 10 kg, color negro.',
		10,0,400,2,1,5)
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Pesas rusas',
		'Material de goma, 25 kg, color negro.',
		15,4,450,2,1,5)
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Saco de boxeo',
		'Capa de cuero, 35 kg, 1.25 m de alto, color negro.',
		5,1,1000,1,1,5)
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Cuerda de salto',
		'Hecho de hule, 1.2 m de largo, color negro y naranja.',
		45,17,300,1,1,5)
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Bicicletas estáticas',
		'Ideal para recorrer largas distancias desde casa, con marcaje de recorrido.',
		4,0,2300,2,1,5)

/* Juguetes */
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Conjunto de ajedrez',
		'Piezas color crema y marrón, dimensión 30x30 cm, con estuche para guardar.',
		15,13,450,1,1,6)
insert into Productos(NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD_PRODUCTO,CANTIDAD_PROD_VENDIDO,PRECIO,ID_USUARIO,ID_IMAGEN,ID_CATEGORIA)
values ('Monopoly',
		'Monopoly versión turista, dimensión 25x25 cm, piezas color plata.',
		10,1,500,2,1,6)