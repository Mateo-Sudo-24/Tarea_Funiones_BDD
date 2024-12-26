CREATE DATABASE tienda_online;

USE tienda_online;

CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    fecha_registro DATE NOT NULL
);

CREATE TABLE Productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    precio DECIMAL(10, 2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL CHECK (stock >= 0),
    descripcion TEXT
);

CREATE TABLE Pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    total DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);

CREATE TABLE Detalles_Pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL CHECK (precio_unitario > 0),
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);
-- Datos insertados
-- Datos Clientes
INSERT INTO Clientes (nombre, apellido, email, telefono, fecha_registro) VALUES
('Juan', 'Pérez', 'juan.perez@example.com', '123456789', '2023-01-15'),
('María', 'Gómez', 'maria.gomez@example.com', '987654321', '2023-02-20'),
('Carlos', 'López', 'carlos.lopez@example.com', '555555555', '2023-03-10');
-- Datos Productos 
INSERT INTO Productos (nombre, precio, stock, descripcion) VALUES
('Producto A', 25.50, 100, 'Descripción del Producto A'),
('Producto B', 15.75, 200, 'Descripción del Producto B'),
('Producto C', 45.00, 150, 'Descripción del Producto C');
-- Datos Pedidos
INSERT INTO Pedidos (cliente_id, fecha_pedido, total) VALUES
(1, '2023-04-01', NULL),
(2, '2023-04-05', NULL),
(3, '2023-04-10', NULL);
-- Datos Detalle pedido
INSERT INTO Detalles_Pedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 2, 25.50),
(1, 2, 1, 15.75),
(2, 3, 3, 45.00),
(3, 1, 1, 25.50),
(3, 3, 2, 45.00);
-- Función para obtener el nombre completo de un cliente
DELIMITER //
CREATE FUNCTION obtener_nombre_completo(cliente_id INT) RETURNS VARCHAR(101)
DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(101);
    SELECT CONCAT(nombre, ' ', apellido) INTO nombre_completo
    FROM Clientes
    WHERE id = cliente_id;
    RETURN nombre_completo;
END;
//
DELIMITER ;
SELECT obtener_nombre_completo(1) AS nombre_completo;

-- Función para calcular el descuento de un producto
DELIMITER //

CREATE FUNCTION calcular_descuento(precio DECIMAL(10, 2), descuento DECIMAL(5, 2)) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    RETURN precio - (precio * descuento / 100);
END;
//

DELIMITER ;
SELECT calcular_descuento(100.00, 10) AS precio_con_descuento;
-- Función para calcular el total de un pedido
DELIMITER //

CREATE FUNCTION calcular_total_pedido(pedido_id INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(cantidad * precio_unitario) INTO total
    FROM Detalles_Pedido
    WHERE pedido_id = pedido_id;
    RETURN total;
END;
//

DELIMITER ;
SELECT calcular_total_pedido(1) AS total_pedido;
-- Función para verificar la disponibilidad de stock de un producto
DELIMITER //

CREATE FUNCTION verificar_stock(producto_id INT, cantidad INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE stock_disponible INT;
    SELECT stock INTO stock_disponible
    FROM Productos
    WHERE id = producto_id;
    RETURN stock_disponible >= cantidad;
END;
//
SELECT verificar_stock(1, 5) AS stock_disponible;
DELIMITER ;
-- Función para calcular la antigüedad de un cliente

DELIMITER //

CREATE FUNCTION calcular_antiguedad(cliente_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE antiguedad INT;
    SELECT TIMESTAMPDIFF(YEAR, fecha_registro, CURDATE()) INTO antiguedad
    FROM Clientes
    WHERE id = cliente_id;
    RETURN antiguedad;
END;
//

DELIMITER ;