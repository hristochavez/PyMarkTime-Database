USE pymarktime;

-- Retorna al empleado para un inicio de sesíon.
DROP PROCEDURE IF_EXISTS get_employee;
DELIMITER $
CREATE PROCEDURE get_employee(
    IN dni CHAR(8),
    IN pass CHAR(64)
)
BEGIN
    SELECT
		t1.dni,
		t1.first_name,
        t1.last_name,
		t2.permission
	FROM
		employees AS t1
	INNER JOIN
		employee_permission AS t2
	USING
		(dni)
    WHERE
    	t1.dni = dni AND 
        t1.pass = pass AND
       	t1.is_enabled = 1;
END $
DELIMITER ;

-- Crea la marcación de un empleado.
DROP PROCEDURE IF_EXISTS create_marktime;
DELIMITER $
CREATE PROCEDURE create_marktime(
    IN dni CHAR(8),
    IN marked_by CHAR(8)
)
BEGIN
	INSERT INTO markings(dni, marked_by, mark_time)
	VALUES (dni, marked_by, NOW());
END $
DELIMITER ;

-- Crea a un empleado.
DROP PROCEDURE IF_EXISTS create_employee;
DELIMITER $
CREATE PROCEDURE create_employee(
	IN dni CHAR(8),
	IN first_name VARCHAR(30),
	IN second_name VARCHAR(30),
	IN last_name VARCHAR(30),
	IN second_last_name VARCHAR(30)
)
BEGIN
	-- Por defecto crea la contraseña 1234 al empleado recien creado.
	DECLARE pass CHAR(64);
	SELECT SHA2('1234', 256) INTO pass;

    -- Crea a un empleado.
    INSERT INTO
        employees (
            dni, first_name, second_name, last_name, second_last_name, pass
        )
    VALUES (dni, first_name, second_name, last_name, second_last_name, pass);
	
    -- Otorga el permiso para marcar al empleado recien creado.
	INSERT INTO employee_permission(dni, permission)
	VALUES(dni, 1);
END $
DELIMITER ;

-- Deshabilita a un empleado.
DROP PROCEDURE IF_EXISTS disable_employee;
DELIMITER $
CREATE PROCEDURE disable_employee(
	IN dni CHAR(8),
	IN updated_by CHAR(8)
)
BEGIN
	UPDATE employees AS t1
	SET t1.is_enabled = 0, t1.updated_by = updated_by
	WHERE t1.dni = dni;
END $
DELIMITER ;

-- Retorna la información de un empleado`
DROP PROCEDURE IF_EXISTS employee_information;
DELIMITER $
CREATE PROCEDURE employee_information(
	IN dni CHAR(8)
)
BEGIN
	SELECT
		t1.first_name,
        t1.last_name,
		t1.is_enabled
	FROM
		employees AS t1
	WHERE
		t1.dni = dni;
END $
DELIMITER ;
