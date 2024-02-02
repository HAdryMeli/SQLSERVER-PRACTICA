-- Crear la tabla de facturación
CREATE TABLE Facturacion (
    Id_Factura INT IDENTITY(1,1) PRIMARY KEY,
	Id_Factura_Formateado AS RIGHT('000' + CAST(Id_Factura AS NVARCHAR(3)), 3) PERSISTED,
    Fecha_Factura DATE,
    Monto DECIMAL(10,2),
    
    -- Agrega otros campos necesarios
);

insert into Facturacion(Fecha_Factura, Monto)
values ('2024-01-27', '150.50')
select * from Facturacion

drop table Facturacion

-- Trigger para actualizar automáticamente la columna formateada

    UPDATE f
    SET Id_Factura_Formateado = RIGHT('000' + CAST(i.Id_Factura AS NVARCHAR(3)), 3)
    FROM Facturacion f
    INNER JOIN inserted i ON f.Id_Factura = i.Id_Factura;
END;

-- Insertar datos en la tabla de facturación
INSERT INTO Facturacion (Fecha_Factura, Monto)
VALUES
('2024-01-26', 100.00),
('2024-01-27', 150.50),
-- Agrega más filas según sea necesario
--------------------------------------------------------------
CREATE TABLE T_FACTURA
(
    Id_Factura_Formateado NVARCHAR(3) PRIMARY KEY,
    Id_Factura INT IDENTITY(1,1),
	NOMBRE varchar (255)
    -- Otros campos de la tabla...
);
go
DROP TABLE T_FACTURA

SELECT *FROM T_FACTURA

-- Insertar datos en la tabla (esto es solo un ejemplo)
INSERT INTO T_FACTURA (NOMBRE)
VALUES ('adriana')

(/* Valores para otros campos, excluyendo Id_Factura_Formateado */);

-- Actualizar la columna Id_Factura_Formateado después de insertar datos
UPDATE T_FACTURA
SET Id_Factura_Formateado = RIGHT('000' + CAST(Id_Factura_Formateado AS NVARCHAR(3)), 3);