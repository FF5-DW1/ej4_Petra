USE petra;

-- Insertamos datos en la tabla usuario
INSERT INTO usuario (nombre, rol) VALUES 
("Jesús", "estudiante"),
("Bea", "estudiante"),
("Silvio", "estudiante"),
("Alex", "profesor"),
("Gonzalo", "profesor"),
("Jenni", "profesora"),
("Admin", "Admin");

-- Insertamos datos en tabla cursos
INSERT INTO curso (titulo, duracion, id_profesor) VALUES 
("HTML", 50, 4),
("MySQL", 60, 5),
("Dockers", 60, 5),
("Tutoria", 80, 6),
("JavaScript", 50, 4);

-- Insertamos datos en la tabla leccion
INSERT INTO leccion (titulo, duracion, id_curso) VALUES 
("Leccion 1 HTML", 25, 1),
("leccion 2 HTML", 25, 1),
("Leccion 1 SQL", 20, 2),
("Leccion 2 SQL", 20, 2),
("Leccion 3 SQL", 20, 2),
("Leccion 1 Dockers", 30, 3),
("Leccion 2 Dockers", 30, 3),
("Leccion 1 Tutoria", 80, 4),
("Leccion 1 JS", 25, 5),
("leccion 2 JS", 25, 5);

-- Unimos datos en la tabla progreso
INSERT INTO progreso (id_usuario, id_curso, id_leccion, finalizado) VALUES
(1, 1, 1, true),
(1, 1, 2, true),
(2, 4, 8, true),
(2, 3, 6, true),
(2, 3, 7, false),
(3, 5, 9, true),
(3, 5, 10, true);

-- Insertamos datos en la Tabla acceso
INSERT INTO acceso (id_usuario, fecha, hora, accion_acceso) VALUES
(1, '2023-05-15', '10:00:00', 'login'),
(1, '2023-05-15', '11:30:00', 'leccion'),
(2, '2023-05-15', '14:00:00', 'login'),
(3, '2023-05-16', '09:30:00', 'login'),
(3, '2023-05-16', '10:15:00', 'leccion'),
(4, '2023-05-17', '08:45:00', 'login'),
(6, '2023-05-17', '09:30:00', 'login'),
(7, '2023-05-17', '12:00:00', 'inicio');

-- Peticiones 
SELECT * FROM usuario;
SELECT * FROM curso;
SELECT * FROM leccion;
SELECT * FROM progreso;
SELECT * FROM acceso;

-- Obtener los cursos con profesor y duracion
SELECT c.titulo AS Curso, c.duracion AS Duracion, u.nombre AS Docente
FROM Curso c
INNER JOIN Usuario u ON c.id_profesor = u.id_usuario;

-- Obtener la duracion y cursos perteneciente de cada leccion 
SELECT l.titulo AS Leccion, c.titulo AS curso, l.duracion
FROM leccion l
INNER JOIN curso c ON l.id_curso = c.id_curso;

-- Obtener la duración total de un curso sumando la leccion correspondiente de ese curso
SELECT c.titulo, SUM(l.duracion) AS duracionTotal
FROM Curso c
JOIN Leccion l ON c.id_curso = l.id_curso
WHERE c.id_curso != 'id_curso'
GROUP BY c.titulo;

-- Obtener el progreso de un usuario en lecciones
SELECT c.titulo AS curso, l.titulo AS leccion, 
       CASE WHEN p.finalizado = 1 THEN 'si' ELSE 'no' END AS finalizado, 
       u.nombre AS estudiante
FROM progreso p
JOIN curso c ON p.id_curso = c.id_curso
JOIN leccion l ON p.id_leccion = l.id_leccion
JOIN usuario u ON p.id_usuario = u.id_usuario 
WHERE u.rol LIKE '%estudiante%';

-- Obtener el progreso de un usuario en cursos
SELECT c.titulo AS curso, COUNT(p.finalizado) AS lecciones_finalizadas, u.nombre AS Alumno
FROM progreso p
INNER JOIN usuario u ON p.id_usuario = u.id_usuario
JOIN curso c ON p.id_curso = c.id_curso
WHERE p.id_usuario = u.id_usuario AND p.finalizado = true AND u.rol LIKE '%estudiante%'
GROUP BY c.titulo, p.id_usuario;

-- Obtener el registro de acceso de un usuario
SELECT u.nombre, a.fecha, a.hora, a.accion_acceso
FROM acceso a
JOIN usuario u ON a.id_usuario = u.id_usuario
WHERE a.id_usuario = u.id_usuario;

-- Añadir un nuevo curso dentro de los cursos y se asigna a un profesor
INSERT INTO curso (titulo, duracion, id_profesor) VALUES ('CSS', 100, 6);
SELECT * FROM curso;

-- Añadir una leccion a un curso existente
INSERT INTO Leccion (titulo, duracion, id_curso) VALUES ('Nueva Lección', 60, 1);
SELECT * from leccion;

-- Aun sin añadir, es comprobacion de la suma del total del curso segun sus lecciones
INSERT INTO leccion (titulo, duracion, id_curso) VALUES ('Leccion 2 CSS', 50, 6);

-- estudiante añade que ha iniciado una leccion de un curso y su progreso
INSERT INTO progreso (id_usuario, id_curso, id_leccion, finalizado) VALUES (1, 6, 11, false);

-- investigamos si algun usuario no ha iniciado ningun curso
SELECT u.nombre AS Usuario
FROM usuario u
LEFT JOIN progreso p ON u.id_usuario = p.id_usuario
WHERE p.id_usuario IS NULL;

-- Progreso promedio de cada curso por estudiantes
SELECT c.titulo AS Curso, AVG(p.finalizado) AS ProgresoPromedio
FROM progreso p
JOIN curso c ON p.id_curso = c.id_curso
JOIN usuario u ON p.id_usuario = u.id_usuario
WHERE u.rol LIKE '%estudiante%'
GROUP BY c.titulo;

-- Obtener la lista de lecciones y su progreso para un estudiante y un curso específico:
SELECT u.nombre AS estudiante, l.titulo AS Leccion, CASE WHEN p.finalizado = 1 THEN 'Finalizado' ELSE 'En progreso' END AS Estado
FROM leccion l
JOIN progreso p ON l.id_leccion = p.id_leccion
JOIN usuario u ON p.id_usuario = u.id_usuario
JOIN curso c ON p.id_curso = c.id_curso
WHERE u.id_usuario = 1 AND c.id_curso = 6;


