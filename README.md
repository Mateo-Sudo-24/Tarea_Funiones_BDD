# Tarea_Funiones_BDD
Deber 10


Tarea Funciones de Usuario

Nombre: Mateo Jessael Paredes Guevara

PARTE 1 
Tarea: Funciones de Usuario en Bases de Datos
Objetivo:

El objetivo de esta tarea es que los estudiantes aprendan a crear funciones de usuario en bases de datos
Escenario:

Vas a crear una base de datos para una tienda en línea que maneja clientes, productos, pedidos y detalles de los pedidos.
Pasos a Seguir:

1.	Crear la Base de Datos y Tablas:
○	Crea una base de datos llamada tienda_online.
 
○	Dentro de la base de datos, crea las siguientes tablas:
■	Clientes: Contendrá información básica sobre los clientes (id, nombre, apellido, email, teléfono, fecha de registro).
 
■	Productos: Contendrá información sobre los productos (id, nombre, precio, stock, descripción).
 
■	Pedidos: Registra los pedidos realizados por los clientes (id, cliente_id, fecha del pedido, total).
 
■	Detalles_Pedido: Registra los detalles de cada pedido (id, pedido_id, producto_id, cantidad, precio unitario).
 
2.	Restricciones:
○	No se permiten valores nulos en campos como nombre, apellido, email, precio, y cantidad.
○	Los precios deben ser positivos.
○	El stock de los productos no puede ser negativo.
○	Los nombres de los productos no deben repetirse.
○	El email de los clientes debe ser único.
 
 
 
3.	Crear Funciones de Usuario
4.	Función para obtener el nombre completo de un cliente:
■	Esta función debe aceptar un cliente_id como parámetro y devolver el nombre completo (nombre + apellido) del cliente.
 
○	Función para calcular el descuento de un producto:
■	Esta función debe aceptar el precio y el descuento como parámetros y devolver el precio con descuento.
 
○	Función para calcular el total de un pedido:
■	Esta función debe aceptar un pedido_id y calcular el total del pedido sumando los precios de los productos multiplicados por sus respectivas cantidades.
 
○	Función para verificar la disponibilidad de stock de un producto:
■	Esta función debe aceptar un producto_id y una cantidad como parámetros y devolver TRUE si el stock disponible es suficiente, de lo contrario, debe devolver FALSE.
 
○	Función para calcular la antigüedad de un cliente:
■	Esta función debe aceptar un cliente_id y calcular la antigüedad del cliente en años a partir de la fecha de registro.
 
5.	Consultas de Uso de Funciones:
■	Consulta para obtener el nombre completo de un cliente dado su
cliente_id.
 

■	Consulta para calcular el descuento de un producto dado su precio y un descuento del 10%.
 
■	Consulta para calcular el total de un pedido dado su pedido_id.
 
■	Consulta para verificar si un producto tiene suficiente stock para una cantidad solicitada.
 
PARTE 2
Aprendizaje de Funciones SQL: Creación, Análisis y Ejecución
Objetivo:
El objetivo de esta actividad es aprender a crear y utilizar funciones definidas por el usuario en SQL, analizar su estructura y lógica, y practicar la creación de tablas y consultas con funciones personalizadas. También se incluirán ejemplos prácticos para mostrar cómo utilizar estas funciones en un contexto real.

Instrucciones:
1.	Transcripción y análisis del código SQL.
Ejercicio 1
 


Ejercicio 2
 
Ejercicio 3
 


Ejercicio 4
 
2.	Creación de las tablas necesarias para almacenar los datos.

Creación de la base de datos
 
Creación de la tabla clientes
 



Creación de la tabla productos
 
Creación de la tabla Ordenes
 
Creación de la tabla Detalles Orden
 
Creación tabal transacciones
 










Inserción de datos

 
 
3.	Ejecución de las funciones SQL creadas y captura de los resultados.

Ejecución función 1

 









Ejecución función 2
 
Ejecución función 3
 
Ejecución función 4
 

4.	Explicación detallada de cada línea del código.

Crear la base de datos y usarla:

 


•	CREATE DATABASE tienda;: Crea una nueva base de datos llamada tienda.
•	USE tienda;: Selecciona la base de datos tienda para trabajar con ella.






Tabla Clientes:

 

•	AUTO_INCREMENT PRIMARY KEY: Define id como clave primaria que se incrementa automáticamente.
•	NOT NULL: Indica que los campos no pueden tener valores nulos.
•	UNIQUE: Asegura que los valores en el campo email sean únicos.

Tabla Productos:

 


•	CHECK (precio > 0): Asegura que el precio sea positivo.
•	CHECK (stock >= 0): Asegura que el stock no sea negativo.


Tabla Ordenes:
 



•	FOREIGN KEY (cliente_id) REFERENCES Clientes(id): Define una clave foránea que referencia a la tabla Clientes.

Tabla Detalles_Orden:

 

•	FOREIGN KEY (orden_id) REFERENCES Ordenes(OrdenID): Define una clave foránea que referencia a la tabla Ordenes.
•	FOREIGN KEY (producto_id) REFERENCES Productos(ProductoID): Define una clave foránea que referencia a la tabla Productos.


Tabla Transacciones:

 

•	ENUM('deposito', 'retiro'): Define un campo que solo puede tener los valores 'deposito' o 'retiro'.















Función para calcular el total de una orden:

 

•	DELIMITER //: Cambia el delimitador para permitir el uso de ; dentro de la función.
•	DETERMINISTIC: Indica que la función siempre devuelve el mismo resultado para los mismos parámetros.
•	SET iva = 0.15;: Define el valor del IVA.
•	SELECT SUM(P.precio * O.cantidad) INTO total: Calcula el total de la orden sumando los precios de los productos multiplicados por sus cantidades.
•	SET total = total * (1 + iva);: Aplica el IVA al total.

Función para calcular la edad:

 

•	TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()): Calcula la diferencia en años entre la fecha de nacimiento y la fecha actual.


Función para verificar el stock:

 


•	SELECT stock INTO stock: Obtiene el stock del producto.
•	IF stock > 0 THEN RETURN TRUE; ELSE RETURN FALSE; END IF;: Verifica si el stock es mayor que cero.

Función para calcular el saldo:

 

•	SUM(CASE WHEN tipo_transaccion = 'deposito' THEN monto WHEN tipo_transaccion = 'retiro' THEN -monto ELSE 0 END): Calcula el saldo sumando los depósitos y restando los retiros.


SUBIR A GIT HUB EL SCRIPT Y EL PDF


EJERCICIO 1

EJERCICIO 2
 

EJERCICIO 3









EJERCICIO 4
 

 
