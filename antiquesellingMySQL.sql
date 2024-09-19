# CREACIÓN DE LA BASE DE DATOS ANTIQUESELLINGDB
DROP DATABASE if EXISTS antiquesellingDB;
CREATE DATABASE if NOT EXISTS antiquesellingDB;

# SELECCIÓN DE LA BASE DE DATOS
USE antiquesellingDB;


# CREACIÓN DE LAS TABLAS DE LA BASE DE DATOS
CREATE TABLE rol (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(20) NOT null
);

CREATE TABLE tipo_documento (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(20) NOT null
);

CREATE TABLE documento (
	id INT PRIMARY KEY AUTO_INCREMENT,
	numero VARCHAR(30) NOT NULL,
	tipo_documento_id INT,
	FOREIGN KEY (tipo_documento_id) REFERENCES tipo_documento(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE
);

CREATE TABLE tipo_telefono (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(20) NOT null
);

CREATE TABLE telefono (
	id INT PRIMARY KEY AUTO_INCREMENT,
	numero VARCHAR(20) NOT NULL,
	tipo_telefono_id INT,
	FOREIGN KEY (tipo_telefono_id) REFERENCES tipo_telefono(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE
);


CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE,
	telefono_id INT,
	documento_id INT,
	fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (telefono_id) REFERENCES telefono(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE,
	FOREIGN KEY (documento_id) REFERENCES documento(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE
);

CREATE TABLE usuario_rol (
	usuario_id INT NOT NULL,
	rol_id INT NOT NULL,
	PRIMARY KEY (usuario_id, rol_id),
	FOREIGN KEY (usuario_id) REFERENCES usuario(id)
		ON DELETE CASCADE
	   ON UPDATE CASCADE,
	FOREIGN KEY (rol_id) REFERENCES rol(id)
		ON DELETE CASCADE
	   ON UPDATE CASCADE
);

CREATE TABLE categoria (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	descripcion TINYTEXT 
);

CREATE TABLE epoca (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	descripcion TINYTEXT 
);

CREATE TABLE estado_conservacion (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT null
);
CREATE TABLE articulo (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(100) NOT NULL,
	categoria_id INT,
	epoca_id INT,
	estado_id INT,
	stock INT,
	precio_unit_compra DECIMAL(9, 2) NOT NULL,
	precio_unit_venta DECIMAL(9, 2) NOT NULL,
	FOREIGN KEY (categoria_id) REFERENCES categoria(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE,
	FOREIGN KEY (epoca_id) REFERENCES epoca(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE,
	FOREIGN KEY (estado_id) REFERENCES estado_conservacion(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE
);


CREATE TABLE metodo_pago (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(30) NOT null
);

CREATE TABLE estado_transaccion (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(20) NOT null
);


CREATE TABLE compra(
	id INT PRIMARY KEY AUTO_INCREMENT,
	fecha_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
	estado_id INT,
	metodo_pago_compra_id INT,
	usuario_proveedor_id INT,
	empleado_responsable_id INT,
	total DECIMAL(9, 2),
	FOREIGN KEY (estado_id) REFERENCES estado_transaccion(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE,
	FOREIGN KEY (metodo_pago_compra_id) REFERENCES metodo_pago(id)
		ON DELETE SET NULL
   	ON UPDATE CASCADE,
	FOREIGN KEY (usuario_proveedor_id) REFERENCES usuario(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE,
	FOREIGN KEY (empleado_responsable_id) REFERENCES usuario(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE
);

CREATE TABLE venta(
	id INT PRIMARY KEY AUTO_INCREMENT,
	fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
	estado_id INT,
	metodo_pago_venta_id INT,
	usuario_comprador_id INT,
	empleado_responsable_id INT,
	total DECIMAL(9, 2),
	FOREIGN KEY (estado_id) REFERENCES estado_transaccion(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE,
	FOREIGN KEY (metodo_pago_venta_id) REFERENCES metodo_pago(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE,
	FOREIGN KEY (usuario_comprador_id) REFERENCES usuario(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE,
	FOREIGN KEY (empleado_responsable_id) REFERENCES usuario(id)
		ON DELETE SET NULL
	   ON UPDATE CASCADE
);

CREATE TABLE detalle_compra (
	id INT PRIMARY KEY AUTO_INCREMENT,
	compra_id INT NOT NULL,
	articulo_id INT,
	cantidad INT NOT NULL,
	FOREIGN KEY (compra_id) REFERENCES compra(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (articulo_id) REFERENCES articulo(id)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);

CREATE TABLE detalle_venta (
	id INT PRIMARY KEY AUTO_INCREMENT,
	venta_id INT NOT NULL,
	articulo_id INT,
	cantidad INT NOT NULL,
	FOREIGN KEY (venta_id) REFERENCES compra(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (articulo_id) REFERENCES articulo(id)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);


# INSERCIONES EN LAS TABLAS
insert into rol (nombre)
values ('Cajero'),
		('Vendedor'), 
		('Comprador'),
		('Administrador');


insert into tipo_documento (nombre)
values ('Pasaporte'), ('Cedula de ciudadania'), ('Licencia de conducir'), ('RUT');

insert into documento (numero, tipo_documento_id)
values 	('1315353131', 2), 
	('AGB132', 1),
	('GRDF2224515', 3),
	('2151632', 2),
	('1516565', 2),
	('3543542', 2),
	('4521689', 2);

insert into tipo_telefono (nombre)
values ('movil'), ('fijo');

insert into telefono (numero, tipo_telefono_id)
values 	('6076581548', 2),
	('3145268479', 1),
	('6076458215', 2),
	('3175484512', 1),
	('6070158215', 2),
	('3164184512', 1),
	('3108544512', 1);

insert into usuario (nombre, email, telefono_id, documento_id)
values	('Juan Perez Trujillo', 'juan.perez123@email.com', 1, 1),
	('Maria Gomez Monsalve', 'maria.gomez456@correo.co', 2, 2),
	('Luis Alfonso Martinez', 'luis.martinez789@dominio.com', 3, 3),
	('Ana Sanchez Buitrago', 'ana.sanchez2023@ejemplo.com', 4, 4),
	('Carlos Antonio Lopez', 'carlos.lopez007@mail.co', 5, 5),
	('Alexandra Sofia Rodriguez', 'sofia.rodriguez555@prueba.com', 6, 6),
	('Alejandro Moncada Suárez', 'suares.alejo123@email.com', 7, 7);

insert into usuario_rol (usuario_id, rol_id)
values 	(1, 4),
	(2, 2),
	(2, 3),
	(3, 1),
	(4, 2),
	(4, 3),
	(5, 1),
	(6, 2),
	(6, 3),
	(7, 2),
	(7, 3);
	
insert into categoria (nombre, descripcion)
values	('Muebles antiguos', 'Mesas, sillas, armarios, cómodas, escritorios, entre otros.'),
	('Joyería y relojes antiguos', 'Collares, anillos, broches, relojes de bolsillo y pulseras.'),
	('Arte decorativo', 'Porcelana, esculturas, candelabros, tapices y vidrios tallados.'),
	('Libros y documentos antiguos', 'Manuscritos, primeras ediciones, mapas antiguos, cartas y grabados.');


insert into epoca (nombre, descripcion)
values	('Era Victoriana (1837-1901)', 'Objetos de este período reflejan la influencia del diseño gótico, el renacimiento y el arte decorativo ornamentado. Incluye muebles, joyas, porcelana y textiles.'),
	('Época Georgiana (1714-1830)', 'Caracterizada por el estilo neoclásico y el uso de maderas nobles como la caoba. Se encuentran muebles elegantes, relojes de pie y piezas de plata.'),
	('Siglo XVIII - Barroco y Rococó (1700s)', 'Este período es famoso por su extravagancia, con muebles tallados, esculturas doradas, y arte decorativo exuberante. Piezas de este tiempo suelen ser muy ornamentadas.');

insert into estado_conservacion (nombre)
values	('Excelente condición'),
	('Buena condición'),
	('Restauración necesaria'),
	('Excluido');

insert into articulo (nombre, categoria_id, epoca_id, estado_id, stock, precio_unit_compra, precio_unit_venta)
values	('Cómoda victoriana en nogal con detalles en latón', 1, 1, 1, 5, 800000.00, 1000000.00),
	('Espejo de pie victoriano con marco de madera tallada', 3, 1, 2, 7, 450000.00, 600000.00),
	('Jarra de porcelana Wedgwood con relieve floral', 3, 1, 2, 8, 270000.00, 450000.00),
	('Mesa de comedor extensible en caoba', 1, 2, 3, 1, 50000.00, 125000.00),
	('Escritorio de caballete en madera de roble', 1, 2, 1, 1, 910000.00, 1200000.00),
	('Juego de sillas georgianas con respaldos tallados', 1, 2, 1, 2, 500000.00, 850000.00),
	('Aparador barroco con incrustaciones de mármol', 3, 3, 2, 1, 170000.00, 360000.00),
	('Candelabros de bronce dorado estilo Rococó', 3, 3, 1, 5, 450000.00, 560000.00),
	('Biblia con pasta en madera tallada', 4, 1, 4, 1, 365000.00, 520000.00); 


insert into metodo_pago (nombre)
values	('Tarjetas de crédito'),
	('Tarjetas de débito'),
	('Transferencia bancaria'),
	('Efectivo');


insert into estado_transaccion (nombre)
values 	('Pendiente'),
	('Procesando'),
	('Completada'),
	('Cancelada');

insert into compra (estado_id, metodo_pago_compra_id, usuario_proveedor_id, empleado_responsable_id)
values	(1, 4, 2, 3),
	(3, 3, 4, 5),
	(3, 4, 6, 3),
	(3, 1, 2, 5);

insert into detalle_compra (compra_id, articulo_id, cantidad)
values 	(1, 2, 2),
	(1, 8, 2),
	(2, 1, 1),
	(2, 7, 1),
	(3, 6, 1),
	(3, 1, 1),
	(4, 8, 2),
	(4, 3, 2);

insert into venta (estado_id, metodo_pago_venta_id, usuario_comprador_id, empleado_responsable_id)
values	(3, 4, 2, 3),
	(3, 1, 4, 5),
	(3, 3, 6, 3),
	(3, 2, 2, 5);

insert into detalle_venta (venta_id, articulo_id, cantidad)
values	(1, 3, 2),
	(1, 4, 1),
	(2, 6, 1),
	(2, 8, 2),
	(3, 8, 1),
	(3, 7, 1),
	(3, 2, 2),
	(4, 1, 2);

# PROCEDIMIENTOS ALMACENADOS

# Todas las antigüedades disponibles para la venta
delimiter $$

DROP PROCEDURE if EXISTS listar_articulos_disponibles $$
CREATE PROCEDURE listar_articulos_disponibles()
BEGIN 
	

		SELECT	
					a.nombre,
					c.nombre AS categoria,
					ep.nombre AS epoca,
					es.nombre AS estado_conservacion,
					a.stock,
					a.precio_unit_compra,
					a.precio_unit_venta
					
		FROM
					articulo AS a,
					categoria AS c,
					epoca AS ep,
					estado_conservacion AS es
		WHERE
					a.categoria_id = c.id AND
					a.epoca_id = ep.id AND 
					a.estado_id = es.id AND 
					es.nombre <> 'Excluido' ;

END $$

delimiter ;		


# Todas las antiguëdades disponibles por categoría y rango de precio
delimiter $$

DROP PROCEDURE if EXISTS articulos_categoria_precio $$
CREATE PROCEDURE articulos_categoria_precio(IN categ VARCHAR(50), IN prec_min  DECIMAL(9, 2), IN prec_max  DECIMAL(9, 2)) 
BEGIN
		
		DECLARE numCoincidencias INT;
		
		SELECT 
					COUNT(*) INTO numCoincidencias
		
		FROM 
					categoria
		
		WHERE
					nombre = categ;
		
		IF numCoincidencias = 0 then
			SELECT "Esta categoría no se encuentra almacenada";
		
		ELSEIF prec_min < 0 OR prec_max < 0 then
			SELECT "Los precios no pueden ser negativos";
			
		ELSEIF prec_max <= prec_min then
			SELECT "El precio máximo no puede ser menor que el precio mínimo";
			
		ELSE


			SELECT	
						a.nombre,
						c.nombre AS categoria,
						ep.nombre AS epoca,
						es.nombre AS estado_conservacion,
						a.stock,
						a.precio_unit_compra,
						a.precio_unit_venta
								
			FROM
						articulo AS a,
						categoria AS c,
						epoca AS ep,
						estado_conservacion AS es
			WHERE
						a.categoria_id = c.id AND
						a.epoca_id = ep.id AND 
						a.estado_id = es.id AND 
						c.nombre = categ AND 
						a.precio_unit_venta >= prec_min AND
						a.precio_unit_venta <= prec_max;
		END IF;

END $$
delimiter ;	


# Historial de ventas de un cliente en específico
delimiter $$

DROP PROCEDURE if EXISTS historial_ventas_cliente $$
CREATE PROCEDURE historial_ventas_cliente(IN id_cliente INT) 
BEGIN
		DECLARE numCoincidencias INT;
		DECLARE numVentasCliente INT;
		
		
		SELECT 
					COUNT(u.nombre) INTO numCoincidencias
		
		FROM 
					usuario AS u,
					rol AS r,
					usuario_rol AS ur
		
		WHERE
					u.id = ur.usuario_id AND 
					r.id = ur.rol_id and
					r.nombre = 'Vendedor' AND 		
					u.id = id_cliente;
		
		IF numCoincidencias = 0 then
			SELECT "Este cliente no se encuentra registrado";
		
		ELSE
			
			SELECT
						COUNT(u.nombre) INTO numVentasCliente
			
			FROM
						usuario AS u,
						usuario AS uv,
						articulo AS a,
						compra AS c,
						detalle_compra AS dc
			
			WHERE
						u.id = c.usuario_proveedor_id AND 
						uv.id = c.empleado_responsable_id AND
						c.id = dc.compra_id AND 
						a.id = dc.articulo_id AND 
						u.id = id_cliente;
			
			IF numVentasCliente = 0 then
				SELECT "Este cliente no ha venido artículos todavía";
			
			ELSE 
			
				SELECT
							u.nombre AS cliente,
							a.nombre AS articulo,
							uv.nombre AS vendedor,
							a.precio_unit_compra AS precio_venta,
							dc.cantidad
				
				FROM
							usuario AS u,
							usuario AS uv,
							articulo AS a,
							compra AS c,
							detalle_compra AS dc
				
				WHERE
							u.id = c.usuario_proveedor_id AND 
							uv.id = c.empleado_responsable_id AND
							c.id = dc.compra_id AND 
							a.id = dc.articulo_id AND 
							u.id = id_cliente;
			END if;
		
		END IF;
END $$
	
delimiter ;


# Total de ventas realizadas por periodo de tiempo
delimiter $$

DROP PROCEDURE if EXISTS total_ventas_fecha $$
CREATE PROCEDURE total_ventas_fecha(IN fecha_min DATE, IN fecha_max  DATE) 
BEGIN
		DECLARE numVentas INT;
		
		SELECT 
				COUNT(id) INTO numVentas
				
		FROM 
				venta
		WHERE 
				fecha_venta > fecha_min AND 
				fecha_venta <= fecha_max;
		
		if fecha_max < fecha_min then
			SELECT "La fecha máxima no puede ser menor que la fecha mínima";
		
		ELSEIF numVentas = 0 then
			SELECT "No se registran ventas en este periodo";

		ELSE 
			SELECT numVentas;
		
		END IF;
END $$

delimiter ;

# Clientes más activos
delimiter $$

DROP PROCEDURE if EXISTS clientes_mas_activos $$
CREATE PROCEDURE clientes_mas_activos() 
BEGIN

		
		SELECT 
				u.nombre,
				COUNT(u.nombre) AS num_compras
		
		FROM
				usuario AS u,
				venta AS v,
				rol AS r,
				usuario_rol AS ur
		
		WHERE 
				u.id = v.usuario_comprador_id AND 
				u.id = ur.usuario_id AND 
				r.id = ur.rol_id and
				r.nombre = 'Comprador'
		
		GROUP BY 
				u.id
				
		ORDER BY
				num_compras DESC
				
		LIMIT 3;
		
END $$
delimiter ;


# PERMISOS
DROP USER if EXISTS 'carlosjhoan'@'localhost';
CREATE USER 'carlosjhoan'@'localhost' IDENTIFIED BY '20241709';

GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'carlosjhoan'@'localhost' WITH GRANT OPTION;

DROP USER if EXISTS 'juanchopolo'@'localhost';
CREATE USER 'juanchopolo'@'localhost' IDENTIFIED BY '1095822445';

GRANT SELECT ON *.* TO 'juanchopolo'@'localhost' WITH GRANT OPTION;
GRANT EXECUTE ON *.* TO 'juanchopolo'@'localhost';