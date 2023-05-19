CREATE DATABASE petra;
SHOW DATABASES;
USE petra;

-- Tabla usuario
CREATE TABLE usuario (
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR (50) NOT NULL,
    rol VARCHAR (20) NOT NULL
);

-- Tabla Curso
CREATE TABLE curso (
	id_curso INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR (100) NOT NULL,
    duracion INT NOT NULL,
    id_profesor INT NOT NULL,
    FOREIGN KEY (id_profesor) REFERENCES usuario (id_usuario)
);

-- Tabla Lección
CREATE TABLE leccion (
	id_leccion INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR (100) NOT NULL,
    duracion INT NOT NULL,
    id_curso INT NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES curso (id_curso)
);

-- Tabla Progreso
CREATE TABLE progreso (
	id_progreso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_curso INT NOT NULL,
    id_leccion INT NOT NULL,
    finalizado BOOLEAN NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
    FOREIGN KEY (id_curso) REFERENCES curso (id_curso),
    FOREIGN KEY (id_leccion) REFERENCES leccion (id_leccion)
);

-- Tabla Acceso
CREATE TABLE acceso (
	id_acceso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    accion_acceso VARCHAR (20) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);
