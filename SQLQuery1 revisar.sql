

use Ferreteria
--Crear la tabla PROVEEDORES


CREATE TABLE T_PRODUCTO (--PENDIENTE CLAVES
    Id_Producto int identity (1,1) primary key,
    Nombre_Producto NVARCHAR(100),
    Descripcion NVARCHAR(200),
    Fecha_Ingreso DATE,
    Stock INT,
	Id_TipoProducto INT,
    Id_Proveedores INT,
    Id_Almacen INT,
    --FOREIGN KEY (Id_TipoProducto) REFERENCES T_TIPOPRODUCTO(Id_TipoProducto),
    --FOREIGN KEY (Id_Proveedores) REFERENCES T_PROVEEDORES(Id_Proveedores),
    --FOREIGN KEY (Id_Almacen) REFERENCES T_ALMACEN(Id_Almacen)
);
GO

CREATE TABLE T_PROVEEDORES ( --LISTA
    Id_Proveedores int identity (1,1) primary key,
    Nombre_Proveedor NVARCHAR(100),
    Direccion NVARCHAR(100),
    Telefono NVARCHAR(15),
    Correo NVARCHAR(100),
    Id_TipoProducto INT, --clave foranea
    FOREIGN KEY ( Id_TipoProducto) REFERENCES T_TIPOPRODUCTO(Id_TipoProducto)

);
GO

-- Crear la tabla TIPO_PRODUCTO   lista la relacion
CREATE TABLE T_TIPOPRODUCTO (
    Id_TipoProducto int identity (1,1) primary key,
    Id_Proveedor INT,
    Categoria NVARCHAR(50),
	FOREIGN KEY (Id_Proveedor) REFERENCES T_PROVEEDORES(Id_Proveedores)
   
);
GO


-- Crear la tabla ALMACEN   LISTA
CREATE TABLE T_ALMACEN (
    Id_Almacen int identity (1,1) primary key,
    Nombre_Producto NVARCHAR(100),
	stock INT,
    Id_TipoProducto INT,
    Id_Sucursal INT,
    FOREIGN KEY (Id_TipoProducto) REFERENCES T_TIPOPRODUCTO(Id_TipoProducto),
    FOREIGN KEY (Id_Sucursal) REFERENCES SUCURSAL(Id_Sucursal)
);
GO

-- Crear la tabla VENTAS  LISTA
CREATE TABLE T_VENTAS (
    Id_Ventas int identity (1,1) primary key,
	Fecha_Venta DATE,
	Id_TipoProducto INT,
    Id_Vendedor INT,
    Id_Sucursal INT,
    FOREIGN KEY (Id_TipoProducto) REFERENCES T_TIPOPRODUCTO(Id_TipoProducto),
    FOREIGN KEY (Id_Vendedor) REFERENCES T_VENDEDOR(Id_Vendedor),
    FOREIGN KEY (Id_Sucursal) REFERENCES  SUCURSAL(Id_Sucursal)
);
GO

-- Crear la tabla CLIENTE  FALTA  CLAVE FORANEA
CREATE TABLE T_CLIENTE (
    Id_Cliente int identity (1,1) primary key,
    Nombre NVARCHAR(100),
    Apellido NVARCHAR(100),
    Telefono NVARCHAR(15),
    Direccion NVARCHAR(100),
    Id_Compras INT,
    Id_Vendedor INT,
   --FOREIGN KEY (Id_Compras) REFERENCES T_COMPRAS_CLIENTES(Id_Compras),
    --FOREIGN KEY (Id_Vendedor) REFERENCES T_VENDEDOR(Id_Vendedor)
);
GO

-- Crear la tabla VENDEDOR  LISTA
CREATE TABLE T_VENDEDOR (
    Id_Vendedor INT PRIMARY KEY,--- CAMBIAR A AUTOINCREMENTABLE
    Nombre NVARCHAR(100) not null,
    Apellido NVARCHAR(100),
    Telefono NVARCHAR(15),
    Direccion NVARCHAR(100),
	Id_Cargo int
	FOREIGN KEY (Id_Cargo) REFERENCES T_CARGOS(Id_Cargo)
);
GO
    

-- Crear la tabla COMPRAS  LISTA
CREATE TABLE T_COMPRAS_CLIENTES (
    Id_Compras INT PRIMARY KEY, --- CAMBIAR A AUTOINCREMENTABLE
    Fecha_Compra DATE,
	MontoTotal Decimal (10,2),
	Id_Cliente int,
	FOREIGN KEY (Id_Cliente) REFERENCES T_CLIENTE(Id_Cliente)

);
GO

-- Crear la tabla SUCURSAL lista
CREATE TABLE SUCURSAL (
    Id_Sucursal  int identity (1,1) primary key,
    Nombre_Sucursal NVARCHAR(100),
    Direccion NVARCHAR(100),
    Telefono NVARCHAR(15)
);
GO
             --lista
CREATE TABLE T_prueba (  
    Id_prueba int identity (01,01) primary key,
	prueba NVARCHAR(100),

);
SELECT
    RIGHT('000' + CAST(Id_prueba AS VARCHAR(3)), 3) AS Formatted_ID
    FROM T_prueba;

GO
insert into T_prueba(prueba)
values ('prueba2')

INSERT INTO T_CARGOS(Cargos, Area_Asignada, Direccion, Telefono, Correo)
VALUES ('Vendedor1', 'Caja', 'Barrio Way', '88888888', 'sin@correo');

select * from T_prueba

INSERT INTO T_VENDEDOR(Nombre, Apellido,Telefono,Direccion,Id_Cargo)
VALUES ('Mesa','Perez','99885566','Sucursa1','1');
select* from T_VENDEDOR

DROP TABLE T_prueba;

ALTER TABLE T_VENDEDOR
ALTER COLUMN Id_Vendedor INT IDENTITY (1 , 1) primary key,

ALTER TABLE T_VENDEDOR
ALTER COLUMN Id_Vendedor INT IDENTITY(1,1),
ADD PRIMARY KEY (Id_Vendedor);