USE pymarktime;

-- Creación de tabla de empleados.
CREATE TABLE employees(
	dni CHAR(8) NOT NULL,
	first_name VARCHAR(30) NOT NULL,
    second_name VARCHAR(30),
    last_name VARCHAR(30) NOT NULL,
    second_last_name VARCHAR(30) NOT NULL,
	pass CHAR(64) NOT NULL,
	is_enabled TINYINT(1) DEFAULT 1 NOT NULL,
    created_on DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	disabled_by CHAR(8),
	CONSTRAINT pk_dni PRIMARY KEY (dni),
	CONSTRAINT fk_dni_updated_by FOREIGN KEY (disabled_by) REFERENCES employees(dni)
);

-- Creación de tabla de marcaciones.
CREATE TABLE markings(
	id INT NOT NULL AUTO_INCREMENT,
	dni CHAR(8) NOT NULL,
    marked_by CHAR(8) NOT NULL,
	mark_time DATETIME NOT NULL,
	CONSTRAINT pk_id PRIMARY KEY (id),
	CONSTRAINT fk_dni FOREIGN KEY (dni) REFERENCES employees(dni),
	CONSTRAINT fk_dni_marked_by FOREIGN KEY (marked_by) REFERENCES employees(dni)
);

-- Creación de tabla permisos.
CREATE TABLE permissions(
	id INT NOT NULL AUTO_INCREMENT,
	description VARCHAR(255),
	CONSTRAINT pk_id PRIMARY KEY (id)
);

-- Creación de tabla que 	relaciona empleados y sus permisos.
CREATE TABLE employee_permission(
	dni CHAR(8) NOT NULL,
	permission INT NOT NULL,
	CONSTRAINT pk_dni_permission PRIMARY KEY (dni, permission),
	CONSTRAINT fk_employee_dni FOREIGN KEY (dni) REFERENCES employees(dni) ON UPDATE CASCADE,
	CONSTRAINT fk_permissions FOREIGN KEY (permission) REFERENCES permissions(id)
);