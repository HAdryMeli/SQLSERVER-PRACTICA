CREATE DATABASE Ferretria;

CREATE TABLE  Producto(
   
   IDProd int,
   IDTipoPro varchar (255),
   Precio int,
   Descripcion varchar (255),
   stock decimal (8,2),
);

CREATE TABLE Proveedores (
   
   IDProve int,
   Nombre varchar (255),
   Direccion Varchar (255),
   Telefono int ,
   Correo  varchar (255),
);

CREATE TABLE Ventas (
   
   IDVentas int,
   IDProd int ,
   Fecha datetime,
   IDLocal int,
);

CREATE TABLE Cliente (
   
   IDCliente int,
 Nombre varchar (255),
 Apellido varchar (255),
 Cantidad_Comprada  int,
 IDProd int,
 IDVent int,
);

CREATE TABLE Tip_roducto (
   
   IDPROD int,
 Tipo_Producto varchar (255),
 IDProve int, 
);




