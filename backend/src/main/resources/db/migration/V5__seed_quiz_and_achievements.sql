-- Achievements Seeding
INSERT INTO achievements (key_name, title, description, xp_reward) VALUES
('FIRST_READ', 'Primer paso', 'Lee tu primer contenido diario.', 20),
('STREAK_3', 'Constancia', 'Completa el quiz diario por 3 días seguidos.', 30),
('STREAK_7', 'Disciplina', 'Completa el quiz diario por 7 días seguidos.', 50),
('QUIZ_10', 'Sabelotodo', 'Responde 10 preguntas de quiz correctamente.', 40),
('TECH_JAVA', 'Java Lover', 'Completa 5 preguntas de Java correctamente.', 30),
('TECH_DOCKER', 'Docker Fan', 'Completa 5 preguntas de Docker correctamente.', 30);

-- Questions Seeding
-- Question 1 (JavaScript, INTERMEDIATE) - Related to let-const-var-difference (ID 61)
INSERT INTO quiz_questions (id, text, code_snippet, explanation, category, difficulty, area, technology, related_content_id, created_at, updated_at)
VALUES (1, '¿Cuál es el resultado de comparar [] == ![] en JavaScript?', 'console.log([] == ![]);', 'El operador ! tiene mayor precedencia, por lo que ![] se evalúa como false. Luego, [] == false se convierte numéricamente: [] se convierte a 0 y false a 0, dando como resultado true.', 'QUE_IMPRIME', 'INTERMEDIATE', 'FRONTEND', 'JAVASCRIPT', 61, NOW(), NOW());

INSERT INTO quiz_options (id, question_id, text, is_correct) VALUES
(1, 1, 'true', true),
(2, 1, 'false', false),
(3, 1, 'TypeError', false),
(4, 1, 'undefined', false);

-- Question 2 (Java, BEGINNER) - Related to streams-in-java-collections (ID 10)
INSERT INTO quiz_questions (id, text, code_snippet, explanation, category, difficulty, area, technology, related_content_id, created_at, updated_at)
VALUES (2, 'En Java, ¿cuál es la diferencia entre String, StringBuilder y StringBuffer?', NULL, 'String es inmutable. StringBuilder y StringBuffer son mutables, pero StringBuilder no es seguro para hilos (no está sincronizado), lo que lo hace más rápido que StringBuffer, el cual sí está sincronizado.', 'CONCEPTO', 'BEGINNER', 'BACKEND', 'JAVA', 10, NOW(), NOW());

INSERT INTO quiz_options (id, question_id, text, is_correct) VALUES
(5, 2, 'String es mutable, StringBuilder y StringBuffer son inmutables.', false),
(6, 2, 'StringBuilder es seguro para hilos (sincronizado) y StringBuffer no.', false),
(7, 2, 'String es inmutable, StringBuilder no es seguro para hilos y StringBuffer sí lo es.', true),
(8, 2, 'No hay ninguna diferencia práctica entre ellos.', false);

-- Question 3 (Vue, BEGINNER) - Related to ref-vs-reactive-vue (ID 63)
INSERT INTO quiz_questions (id, text, code_snippet, explanation, category, difficulty, area, technology, related_content_id, created_at, updated_at)
VALUES (3, 'En Vue 3 (Composition API), ¿cuál es la diferencia clave entre ref() y reactive()?', NULL, 'ref() se usa para declarar variables reactivas de cualquier tipo (primitivos u objetos) y requiere acceder al valor mediante .value en JavaScript. reactive() solo funciona con objetos/arrays y no requiere .value.', 'CONCEPTO', 'BEGINNER', 'FRONTEND', 'VUE', 63, NOW(), NOW());

INSERT INTO quiz_options (id, question_id, text, is_correct) VALUES
(9, 3, 'ref() solo sirve para números y reactive() solo para strings.', false),
(10, 3, 'ref() envuelve cualquier tipo y usa .value para acceder al valor, mientras que reactive() es solo para objetos y no usa .value.', true),
(11, 3, 'reactive() es una característica obsoleta de Vue 2.', false),
(12, 3, 'ref() y reactive() son exactamente iguales en todos los casos.', false);

-- Question 4 (Git, BEGINNER) - Related to git-undo-last-commit (ID 78 / 325)
-- We know git-undo-last-commit is at row 3 of shortcuts. Let's make it null or match the correct ID. To be safe, we can use 78.
INSERT INTO quiz_questions (id, text, code_snippet, explanation, category, difficulty, area, technology, related_content_id, created_at, updated_at)
VALUES (4, '¿Qué comando de Git se utiliza para deshacer commits locales pero conservando los cambios en tu área de trabajo (staged/working directory)?', NULL, 'git reset --soft desplaza el puntero HEAD al commit anterior conservando los cambios realizados en el área de preparación (staged). git reset --hard borraría todo.', 'BUENAS_PRACTICAS', 'BEGINNER', 'DEVOPS', 'GIT', NULL, NOW(), NOW());

INSERT INTO quiz_options (id, question_id, text, is_correct) VALUES
(13, 4, 'git reset --hard HEAD~1', false),
(14, 4, 'git reset --soft HEAD~1', true),
(15, 4, 'git revert HEAD', false),
(16, 4, 'git checkout --force', false);

-- Question 5 (MySQL, BEGINNER) - Related to indexes-on-frequent-columns (ID 2)
INSERT INTO quiz_questions (id, text, code_snippet, explanation, category, difficulty, area, technology, related_content_id, created_at, updated_at)
VALUES (5, '¿Qué es una clave foránea (Foreign Key) en una base de datos relacional?', NULL, 'Una clave foránea es una columna o conjunto de columnas en una tabla que hace referencia a la clave primaria (Primary Key) de otra tabla, estableciendo una relación y garantizando la integridad referencial.', 'CONCEPTO', 'BEGINNER', 'DATABASES', 'MYSQL', 2, NOW(), NOW());

INSERT INTO quiz_options (id, question_id, text, is_correct) VALUES
(17, 5, 'Una clave que encripta los datos confidenciales de la tabla.', false),
(18, 5, 'Una columna que identifica de forma única a cada fila de la misma tabla.', false),
(19, 5, 'Una columna que hace referencia a la clave primaria de otra tabla para relacionarlas.', true),
(20, 5, 'Una clave temporal que se destruye al cerrar la conexión.', false);

-- Question 6 (Spring Boot, INTERMEDIATE) - Related to use-response-status-in-spring (ID 14)
INSERT INTO quiz_questions (id, text, code_snippet, explanation, category, difficulty, area, technology, related_content_id, created_at, updated_at)
VALUES (6, '¿Qué anotación se utiliza en Spring Boot para definir el código de estado HTTP de respuesta en una excepción personalizada?', 'import org.springframework.web.bind.annotation.ResponseStatus;\nimport org.springframework.http.HttpStatus;\n\n@ResponseStatus(value = HttpStatus.NOT_FOUND, reason = "Recurso no encontrado")\npublic class RecursoNoEncontradoException extends RuntimeException {}', 'La anotación @ResponseStatus de Spring Boot permite indicar de forma declarativa el código de estado HTTP que debe devolverse cuando la excepción es lanzada.', 'BUENAS_PRACTICAS', 'INTERMEDIATE', 'BACKEND', 'SPRING_BOOT', 14, NOW(), NOW());

INSERT INTO quiz_options (id, question_id, text, is_correct) VALUES
(21, 6, '@ResponseStatus', true),
(22, 6, '@HttpStatus', false),
(23, 6, '@ExceptionHandler', false),
(24, 6, '@ResponseCode', false);
