CREATE DATABASE Tienda;

USE Tienda;

CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    fecha_registro DATE NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

CREATE TABLE Productos (
    ProductoID INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    precio DECIMAL(10, 2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL CHECK (stock >= 0),
    descripcion TEXT
);

CREATE TABLE Ordenes (
    OrdenID INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    total DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);

CREATE TABLE Detalles_Orden (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orden_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL CHECK (precio_unitario > 0),
    FOREIGN KEY (orden_id) REFERENCES Ordenes(OrdenID),
    FOREIGN KEY (producto_id) REFERENCES Productos(ProductoID)
);

CREATE TABLE Transacciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cuenta_id INT NOT NULL,
    tipo_transaccion ENUM('deposito', 'retiro') NOT NULL,
    monto DECIMAL(10, 2) NOT NULL CHECK (monto > 0),
    fecha DATE NOT NULL
);

INSERT INTO Clientes (nombre, apellido, email, telefono, fecha_registro, fecha_nacimiento) VALUES
('Juan', 'Pérez', 'juan.perez@example.com', '123456789', '2023-01-15', '1990-05-15'),
('María', 'Gómez', 'maria.gomez@example.com', '987654321', '2023-02-20', '1985-08-25'),
('Carlos', 'López', 'carlos.lopez@example.com', '555555555', '2023-03-10', '1978-12-30');

INSERT INTO Productos (nombre, precio, stock, descripcion) VALUES
('Producto A', 25.50, 100, 'Descripción del Producto A'),
('Producto B', 15.75, 200, 'Descripción del Producto B'),
('Producto C', 45.00, 150, 'Descripción del Producto C');

INSERT INTO Ordenes (cliente_id, fecha_pedido, total) VALUES
(1, '2023-04-01', NULL),
(2, '2023-04-05', NULL),
(3, '2023-04-10', NULL);

INSERT INTO Detalles_Orden (orden_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 2, 25.50),
(1, 2, 1, 15.75),
(2, 3, 3, 45.00),
(3, 1, 1, 25.50),
(3, 3, 2, 45.00);

INSERT INTO Transacciones (cuenta_id, tipo_transaccion, monto, fecha) VALUES
(1, 'deposito', 1000.00, '2023-01-01'),
(1, 'retiro', 200.00, '2023-01-15'),
(2, 'deposito', 1500.00, '2023-02-01'),
(2, 'retiro', 500.00, '2023-02-20'),
(3, 'deposito', 2000.00, '2023-03-01'),
(3, 'retiro', 300.00, '2023-03-10');

-- Ejercicio 1
DELIMITER //

CREATE FUNCTION CalcularTotalOrden(id_orden INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN 
    DECLARE total DECIMAL(10,2);
    DECLARE iva DECIMAL(10,2);
    
    SET iva = 0.15;
    
    SELECT SUM(P.precio * O.cantidad) INTO total
    FROM Detalles_Orden O
    JOIN Productos P ON O.producto_id = P.ProductoID
    WHERE O.orden_id = id_orden;
    
    SET total = total * (1 + iva);
    RETURN total;
END;
//

DELIMITER ;
SELECT CalcularTotalOrden(1) AS total_orden;
-- Ejercicio 2
DELIMITER //

CREATE FUNCTION CalcularEdad(fecha_nacimiento DATE) RETURNS INT 
DETERMINISTIC 
BEGIN
    DECLARE edad INT;
    SET edad = TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE());
    RETURN edad;
END;
//

DELIMITER ;
SELECT CalcularEdad(fecha_nacimiento) AS edad
FROM Clientes
WHERE id = 1;
-- Ejercicio 3
DELIMITER //

CREATE FUNCTION VerificarStock(producto_id INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE stock INT;
    SELECT stock INTO stock
    FROM Productos
    WHERE ProductoID = producto_id;
    
    IF stock > 0 THEN
        RETURN TRUE;
    ELSE 
        RETURN FALSE;
    END IF;
END;
//

DELIMITER ;
SELECT VerificarStock(1) AS stock_disponible;
-- Ejericico 4
DELIMITER //

CREATE FUNCTION CalcularSaldo(id_cuenta INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE saldo DECIMAL(10,2);
    
    SELECT SUM(CASE
        WHEN tipo_transaccion = 'deposito' THEN monto 
        WHEN tipo_transaccion = 'retiro' THEN -monto
        ELSE 0
    END) INTO saldo
    FROM Transacciones
    WHERE cuenta_id = id_cuenta;
    
    RETURN saldo;
END;
//

DELIMITER ;
SELECT CalcularSaldo(1) AS saldo;