# PymMarkTime-Database

_Scripts para crear la base de datos de las aplicaciones PyMarkTime_

## Para usarlo debes tener:
- MySQL 8.0.36 o superior.

## Pasos para la creación de la base de datos:
- Iniciar sesión en MySQL con el usuario root (o un usuario que tenga permisos para crear a usuarios de base de datos).
- Ejecutar el archivo `execute_as_root.sql` para crear al usuario de la base
de datos y concederle permisos.
- Ejecutar el archivo `schema.sql` para crear el esquema de la base de datos.
- Ejecutar el archivo `procedures.sql` para crear los procedimientos 
almacenados.