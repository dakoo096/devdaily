-- =========================================================================
-- SEED DATA FOR CONTENTS TABLE (UPPERCASE ENUMS)
-- =========================================================================

-- Tips
INSERT INTO contents (slug, type, difficulty, title, body, area, technology, emoji, created_at, updated_at, active) VALUES
('use-computed-instead-of-watch', 'TIP', 'BEGINNER', 'Usa computed en vez de watch', 
'En Vue, si solo necesitas derivar datos de otro estado reactivo, usa `computed` en lugar de `watch`. Es más declarativo, se cachea automáticamente y evita efectos secundarios innecesarios.', 
'FRONTEND', 'VUE', '💡', NOW(), NOW(), TRUE),

('indexes-on-frequent-columns', 'TIP', 'BEGINNER', 'Índices en columnas frecuentes', 
'Agrega índices a las columnas que usas frecuentemente en cláusulas WHERE, JOIN y ORDER BY. Un índice puede reducir el tiempo de consulta de segundos a milisegundos.', 
'DATABASES', 'MYSQL', '💡', NOW(), NOW(), TRUE),

('use-optional-in-spring-boot', 'TIP', 'BEGINNER', 'Usa Optional en Spring Boot', 
'En vez de retornar `null` desde tus repositorios, utiliza `Optional<T>`. Esto hace explícito que un valor puede no existir y te obliga a manejarlo, evitando NullPointerException.', 
'BACKEND', 'SPRING_BOOT', '💡', NOW(), NOW(), TRUE),

('destructuring-with-aliases', 'TIP', 'BEGINNER', 'Desestructuración con alias', 
'En JavaScript puedes renombrar variables al desestructurar: `const { name: userName, age: userAge } = user;`. Muy útil cuando trabajas con datos de APIs que tienen nombres poco descriptivos.', 
'FRONTEND', 'JAVASCRIPT', '💡', NOW(), NOW(), TRUE),

('multi-stage-builds-docker', 'TIP', 'INTERMEDIATE', 'Multi-stage builds en Docker', 
'Usa multi-stage builds para reducir el tamaño de tus imágenes Docker. Compila en una etapa y copia solo los artefactos necesarios a la imagen final. Puedes reducir imágenes de 1GB a menos de 100MB.', 
'DEVOPS', 'DOCKER', '💡', NOW(), NOW(), TRUE),

('react-memo-performance', 'TIP', 'INTERMEDIATE', 'React.memo para rendimiento', 
'Envuelve componentes con `React.memo()` cuando reciban props que no cambian frecuentemente. Esto evita re-renders innecesarios y mejora el rendimiento en listas largas.', 
'FRONTEND', 'REACT', '💡', NOW(), NOW(), TRUE),

('typescript-utility-types', 'TIP', 'INTERMEDIATE', 'Usa TypeScript Utility Types', 
'`Partial<T>`, `Pick<T, K>`, `Omit<T, K>` y `Record<K, V>` son tus mejores aliados. Evitan duplicar interfaces y hacen tu código más mantenible y expresivo.', 
'FRONTEND', 'TYPESCRIPT', '💡', NOW(), NOW(), TRUE),

('git-stash-with-name', 'TIP', 'BEGINNER', 'Git stash con nombre', 
'Usa `git stash push -m "descripción"` para guardar cambios temporales con un nombre descriptivo. Luego lista con `git stash list` y aplica el que necesites con `git stash apply stash@{n}`.', 
'DEVOPS', 'GIT', '💡', NOW(), NOW(), TRUE),

('explain-analyze-postgresql', 'TIP', 'INTERMEDIATE', 'EXPLAIN ANALYZE en PostgreSQL', 
'Antes de optimizar una consulta, usa `EXPLAIN ANALYZE` para ver exactamente cómo PostgreSQL ejecuta tu query. Te muestra el plan de ejecución real con tiempos, no solo el estimado.', 
'DATABASES', 'POSTGRESQL', '💡', NOW(), NOW(), TRUE),

('streams-in-java-collections', 'TIP', 'BEGINNER', 'Streams en Java para colecciones', 
'Usa la API de Streams para transformar colecciones de forma declarativa: `list.stream().filter(x -> x > 5).map(String::valueOf).collect(Collectors.toList())`. Más legible que loops anidados.', 
'BACKEND', 'JAVA', '💡', NOW(), NOW(), TRUE),

('principle-of-least-privilege', 'TIP', 'BEGINNER', 'Principio de mínimo privilegio', 
'Nunca otorgues más permisos de los necesarios a usuarios, servicios o aplicaciones. Este principio es la base de la seguridad: si una cuenta se compromete, el daño es limitado.', 
'CYBERSECURITY', 'DOCKER', '💡', NOW(), NOW(), TRUE),

('testing-arrange-act-assert', 'TIP', 'BEGINNER', 'Testing: Arrange, Act, Assert', 
'Estructura tus tests en tres bloques claros: Arrange (prepara datos), Act (ejecuta la acción) y Assert (verifica resultados). Hace tus tests más legibles y mantenibles.', 
'TESTING', 'JAVA', '💡', NOW(), NOW(), TRUE),

('design-mobile-first', 'TIP', 'BEGINNER', 'Diseña mobile-first', 
'Siempre diseña primero para móvil y luego escala a escritorio. Es más fácil agregar complejidad que quitarla, y la mayoría del tráfico web ya viene de dispositivos móviles.', 
'UIUX', 'JAVASCRIPT', '💡', NOW(), NOW(), TRUE),

('use-response-status-in-spring', 'TIP', 'INTERMEDIATE', 'Usa @ResponseStatus en Spring', 
'Anota tus excepciones personalizadas con `@ResponseStatus(HttpStatus.NOT_FOUND)` para que Spring Boot automáticamente devuelva el código HTTP correcto sin necesidad de try-catch en cada controller.', 
'BACKEND', 'SPRING_BOOT', '💡', NOW(), NOW(), TRUE),

('composables-instead-of-mixins', 'TIP', 'INTERMEDIATE', 'Composables en vez de mixins', 
'En Vue 3, reemplaza los mixins por composables (funciones que usan la Composition API). Son más predecibles, tipables con TypeScript y no tienen conflictos de nombres.', 
'FRONTEND', 'VUE', '💡', NOW(), NOW(), TRUE);

-- Curiosities
INSERT INTO contents (slug, type, difficulty, title, body, area, technology, emoji, created_at, updated_at, active) VALUES
('first-bug-history', 'CURIOSITY', 'BEGINNER', 'El primer bug fue un insecto real', 
'En 1947, Grace Hopper encontró una polilla atrapada en el relé del computador Harvard Mark II. Pegó el insecto en el registro con la nota "First actual case of bug being found". Así nació el término "debugging".', 
'BACKEND', 'JAVA', '🔍', NOW(), NOW(), TRUE),

('javascript-created-in-10-days', 'CURIOSITY', 'BEGINNER', 'JavaScript se creó en 10 días', 
'Brendan Eich creó la primera versión de JavaScript en solo 10 días en mayo de 1995 mientras trabajaba en Netscape. Originalmente se llamó "Mocha", luego "LiveScript" y finalmente "JavaScript" como estrategia de marketing.', 
'FRONTEND', 'JAVASCRIPT', '🔍', NOW(), NOW(), TRUE),

('git-created-in-2-weeks', 'CURIOSITY', 'BEGINNER', 'Git fue creado en 2 semanas', 
'Linus Torvalds creó Git en abril de 2005 en aproximadamente dos semanas después de que BitKeeper dejara de ser gratuito para el desarrollo del kernel de Linux. Hoy es usado por el 93% de los desarrolladores.', 
'DEVOPS', 'GIT', '🔍', NOW(), NOW(), TRUE),

('mysql-named-after-daughter', 'CURIOSITY', 'BEGINNER', 'MySQL y la hija de su creador', 
'MySQL fue nombrado por la hija de su co-creador Michael Widenius: "My" es el nombre de su hija. Más tarde creó MariaDB, nombrado por su otra hija, Maria.', 
'DATABASES', 'MYSQL', '🔍', NOW(), NOW(), TRUE),

('docker-whale-logo', 'CURIOSITY', 'BEGINNER', 'Docker y el logo de la ballena', 
'La ballena de Docker se llama "Moby Dock". Los contenedores que lleva representan los contenedores de software. La idea es una referencia a los contenedores de carga de los barcos, estandarizando el transporte como Docker estandariza el despliegue.', 
'DEVOPS', 'DOCKER', '🔍', NOW(), NOW(), TRUE),

('vue-was-personal-project', 'CURIOSITY', 'BEGINNER', 'Vue fue un proyecto personal', 
'Evan You creó Vue.js en 2013 como un proyecto personal mientras trabajaba en Google. Quería extraer las partes que más le gustaban de AngularJS y crear algo más liviano. Hoy Vue tiene más de 200k estrellas en GitHub.', 
'FRONTEND', 'VUE', '🔍', NOW(), NOW(), TRUE),

('java-named-after-coffee', 'CURIOSITY', 'BEGINNER', 'Java y el café', 
'Java originalmente se llamó "Oak" por un roble fuera de la oficina de James Gosling. Cuando descubrieron que ese nombre ya estaba registrado, lo cambiaron a "Java" por el café Java que el equipo bebía constantemente.', 
'BACKEND', 'JAVA', '🔍', NOW(), NOW(), TRUE),

('cost-of-one-pixel', 'CURIOSITY', 'BEGINNER', 'El costo de un pixel', 
'Según estudios de Amazon, cada 100ms adicional de carga reduce las ventas un 1%. Google demostró que un retraso de 500ms reduce el tráfico un 20%. Cada pixel y cada milisegundo importan en UI/UX.', 
'UIUX', 'JAVASCRIPT', '🔍', NOW(), NOW(), TRUE),

('postgresql-over-35-years', 'CURIOSITY', 'BEGINNER', 'PostgreSQL tiene más de 35 años', 
'PostgreSQL nació en 1986 como proyecto académico en UC Berkeley llamado "POSTGRES" (Post-Ingres). Es uno de los sistemas de bases de datos open source más antiguos y robustos que siguen activos.', 
'DATABASES', 'POSTGRESQL', '🔍', NOW(), NOW(), TRUE),

('typescript-satisfaction', 'CURIOSITY', 'BEGINNER', 'TypeScript superó a JavaScript en satisfacción', 
'En la encuesta State of JS 2023, TypeScript tuvo una tasa de satisfacción del 93%. Los equipos que adoptan TypeScript reportan un 15% menos de bugs en producción según un estudio de Microsoft.', 
'FRONTEND', 'TYPESCRIPT', '🔍', NOW(), NOW(), TRUE),

('most-expensive-attack', 'CURIOSITY', 'BEGINNER', 'El ataque más costoso de la historia', 
'El ransomware NotPetya en 2017 causó daños estimados en $10 mil millones. Empresas como Maersk perdieron 45,000 PCs y 4,000 servidores. Todo comenzó con una actualización comprometida de un software de contabilidad ucraniano.', 
'CYBERSECURITY', 'DOCKER', '🔍', NOW(), NOW(), TRUE),

('react-rejected-internally', 'CURIOSITY', 'BEGINNER', 'React fue rechazado internamente', 
'Cuando Jordan Walke presentó React internamente en Facebook en 2011, muchos ingenieros lo rechazaron por mezclar HTML con JavaScript (JSX). Hoy es la librería frontend más popular del mundo.', 
'FRONTEND', 'REACT', '🔍', NOW(), NOW(), TRUE),

('spring-boot-convention', 'CURIOSITY', 'BEGINNER', 'Spring Boot y la convención sobre configuración', 
'Antes de Spring Boot, configurar un proyecto Spring requería cientos de líneas de XML. Spring Boot redujo eso a una clase con `@SpringBootApplication` y un archivo `application.properties`. Revolucionó el desarrollo Java.', 
'BACKEND', 'SPRING_BOOT', '🔍', NOW(), NOW(), TRUE),

('most-code-never-runs', 'CURIOSITY', 'BEGINNER', 'El 90% del código nunca se ejecuta', 
'Estudios muestran que en proyectos grandes, hasta el 90% del código escrito nunca se ejecuta en producción. Por eso el testing es fundamental: ayuda a identificar y eliminar código muerto.', 
'TESTING', 'JAVA', '🔍', NOW(), NOW(), TRUE),

('mobile-apps-one-time-use', 'CURIOSITY', 'BEGINNER', 'Apps móviles: 25% se usan una sola vez', 
'Según estadísticas de 2024, el 25% de las apps móviles descargadas se abren una sola vez y nunca más. Una buena experiencia de onboarding puede reducir esta cifra dramáticamente.', 
'MOBILE', 'JAVASCRIPT', '🔍', NOW(), NOW(), TRUE);

-- Phrases
INSERT INTO contents (slug, type, difficulty, title, body, area, technology, emoji, created_at, updated_at, active) VALUES
('code-and-humor', 'PHRASE', 'BEGINNER', 'Código y humor', 
'"El código es como el humor. Si tienes que explicarlo, es malo." — Cory House', 
'FRONTEND', 'JAVASCRIPT', '💬', NOW(), NOW(), TRUE),

('simplicity-sophistication', 'PHRASE', 'BEGINNER', 'Simplicidad', 
'"La simplicidad es la máxima sofisticación." — Leonardo da Vinci. Aplica a tu código: la solución más simple que funciona suele ser la mejor.', 
'BACKEND', 'JAVA', '💬', NOW(), NOW(), TRUE),

('measure-twice-cut-once', 'PHRASE', 'BEGINNER', 'Medir dos veces', 
'"Dame seis horas para cortar un árbol y pasaré las primeras cuatro afilando el hacha." — Abraham Lincoln. Planifica antes de codear.', 
'BACKEND', 'SPRING_BOOT', '💬', NOW(), NOW(), TRUE),

('testing-confidence', 'PHRASE', 'BEGINNER', 'Testing matters', 
'"Los tests no son para encontrar bugs. Son para permitirte hacer cambios con confianza." — Martin Fowler', 
'TESTING', 'JAVA', '💬', NOW(), NOW(), TRUE),

('perfection-vs-pragmatism', 'PHRASE', 'BEGINNER', 'Perfección vs. Pragmatismo', 
'"Lo perfecto es enemigo de lo bueno." — Voltaire. No busques la perfección en tu primer commit. Itera, mejora, refactoriza.', 
'FRONTEND', 'VUE', '💬', NOW(), NOW(), TRUE),

('good-programming-habits', 'PHRASE', 'BEGINNER', 'Resolver problemas', 
'"No soy un gran programador; solo soy un buen programador con grandes hábitos." — Kent Beck, creador de TDD', 
'TESTING', 'JAVASCRIPT', '💬', NOW(), NOW(), TRUE),

('code-for-humans', 'PHRASE', 'BEGINNER', 'Trabajo en equipo', 
'"Cualquier tonto puede escribir código que una computadora entienda. Los buenos programadores escriben código que los humanos entienden." — Martin Fowler', 
'BACKEND', 'TYPESCRIPT', '💬', NOW(), NOW(), TRUE),

('learning-from-failures', 'PHRASE', 'BEGINNER', 'Aprender de errores', 
'"El éxito consiste en ir de fracaso en fracaso sin perder el entusiasmo." — Winston Churchill. Cada bug resuelto te hace mejor desarrollador.', 
'FRONTEND', 'REACT', '💬', NOW(), NOW(), TRUE),

('user-experience-steve-jobs', 'PHRASE', 'BEGINNER', 'Experiencia de usuario', 
'"El diseño no es solo cómo se ve o cómo se siente. El diseño es cómo funciona." — Steve Jobs', 
'UIUX', 'JAVASCRIPT', '💬', NOW(), NOW(), TRUE),

('security-is-process', 'PHRASE', 'BEGINNER', 'Seguridad primero', 
'"La seguridad es un proceso, no un producto." — Bruce Schneier. No existe una solución mágica; la seguridad requiere vigilancia constante.', 
'CYBERSECURITY', 'DOCKER', '💬', NOW(), NOW(), TRUE),

('clean-code-uncle-bob', 'PHRASE', 'BEGINNER', 'Código limpio', 
'"El código limpio siempre parece como si hubiera sido escrito por alguien a quien le importa." — Robert C. Martin (Uncle Bob)', 
'BACKEND', 'JAVA', '💬', NOW(), NOW(), TRUE),

('culture-eats-strategy', 'PHRASE', 'BEGINNER', 'DevOps culture', 
'"La cultura eat a la estrategia para el desayuno." — Peter Drucker. En DevOps, las herramientas son importantes, pero la cultura de colaboración lo es más.', 
'DEVOPS', 'DOCKER', '💬', NOW(), NOW(), TRUE),

('without-data-opinion', 'PHRASE', 'BEGINNER', 'Datos y decisiones', 
'"Sin datos, solo eres una persona más con una opinión." — W. Edwards Deming. Mide antes de optimizar.', 
'DATABASES', 'POSTGRESQL', '💬', NOW(), NOW(), TRUE),

('constant-in-technology', 'PHRASE', 'BEGINNER', 'Aprendizaje continuo', 
'"La única constante en tecnología es el cambio." — Aprender una nueva tecnología cada año no es un lujo, es una necesidad.', 
'MOBILE', 'TYPESCRIPT', '💬', NOW(), NOW(), TRUE),

('frequent-small-commits', 'PHRASE', 'BEGINNER', 'Git wisdom', 
'"Haz commits pequeños y frecuentes. Un buen historial de Git cuenta una historia." — Cada commit debería poder explicarse en una línea.', 
'DEVOPS', 'GIT', '💬', NOW(), NOW(), TRUE);

-- Concepts
INSERT INTO contents (slug, type, difficulty, title, body, area, technology, emoji, created_at, updated_at, active) VALUES
('solid-design-principles', 'CONCEPT', 'INTERMEDIATE', 'SOLID — Principios de diseño', 
'SOLID son 5 principios de diseño orientado a objetos: Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation y Dependency Inversion. Aplicarlos produce código más mantenible y testeable.', 
'BACKEND', 'JAVA', '📚', NOW(), NOW(), TRUE),

('virtual-dom-concept', 'CONCEPT', 'BEGINNER', 'Virtual DOM', 
'El Virtual DOM es una representación ligera del DOM real en memoria. Frameworks como Vue y React lo usan para calcular los cambios mínimos necesarios (diffing) antes de actualizar el DOM real, mejorando el rendimiento.', 
'FRONTEND', 'VUE', '📚', NOW(), NOW(), TRUE),

('rest-vs-graphql', 'CONCEPT', 'INTERMEDIATE', 'REST vs GraphQL', 
'REST usa endpoints fijos que devuelven datos predefinidos. GraphQL permite al cliente pedir exactamente los datos que necesita en una sola petición. REST es más simple; GraphQL es más flexible para frontends complejos.', 
'BACKEND', 'SPRING_BOOT', '📚', NOW(), NOW(), TRUE),

('closures-in-javascript', 'CONCEPT', 'BEGINNER', 'Closures en JavaScript', 
'Un closure es una función que recuerda el scope en el que fue creada, incluso después de que ese scope haya terminado. Es la base de patrones como módulos, currying y funciones de orden superior.', 
'FRONTEND', 'JAVASCRIPT', '📚', NOW(), NOW(), TRUE),

('containers-vs-vms', 'CONCEPT', 'BEGINNER', 'Containerización vs Virtualización', 
'Las VMs virtualizan el hardware completo incluyendo el SO. Los contenedores comparten el kernel del host y solo aíslan el proceso. Por eso los contenedores arrancan en segundos y usan una fracción de los recursos.', 
'DEVOPS', 'DOCKER', '📚', NOW(), NOW(), TRUE),

('db-normalization', 'CONCEPT', 'BEGINNER', 'Normalización de bases de datos', 
'La normalización organiza datos para reducir redundancia. 1NF: valores atómicos. 2NF: sin dependencias parciales. 3NF: sin dependencias transitivas. La desnormalización a veces es necesaria para rendimiento.', 
'DATABASES', 'MYSQL', '📚', NOW(), NOW(), TRUE),

('typescript-generics', 'CONCEPT', 'INTERMEDIATE', 'TypeScript Generics', 
'Los generics permiten crear componentes que trabajan con cualquier tipo manteniendo type-safety: `function identity<T>(arg: T): T { return arg; }`. Son esenciales para librerías y utilidades reutilizables.', 
'FRONTEND', 'TYPESCRIPT', '📚', NOW(), NOW(), TRUE),

('cicd-pipeline-concept', 'CONCEPT', 'INTERMEDIATE', 'CI/CD Pipeline', 
'CI (Integración Continua) automatiza la compilación y testing en cada commit. CD (Despliegue Continuo) automatiza el release a producción. Juntos reducen errores humanos y aceleran el ciclo de entrega.', 
'DEVOPS', 'GIT', '📚', NOW(), NOW(), TRUE),

('dependency-injection', 'CONCEPT', 'BEGINNER', 'Inyección de dependencias', 
'En vez de que una clase cree sus dependencias, se las "inyectan" desde fuera. Spring Boot hace esto automáticamente con `@Autowired`. Facilita el testing (puedes inyectar mocks) y reduce el acoplamiento.', 
'BACKEND', 'SPRING_BOOT', '📚', NOW(), NOW(), TRUE),

('reactive-programming', 'CONCEPT', 'INTERMEDIATE', 'Reactive Programming', 
'La programación reactiva modela datos como flujos (streams) que emiten valores a lo largo del tiempo. En Vue, la reactividad hace que la UI se actualice automáticamente cuando cambian los datos. Es el corazón de la Composition API.', 
'FRONTEND', 'VUE', '📚', NOW(), NOW(), TRUE),

('acid-database-properties', 'CONCEPT', 'INTERMEDIATE', 'ACID en bases de datos', 
'ACID garantiza transacciones confiables: Atomicidad (todo o nada), Consistencia (datos válivos), Isolation (transacciones independientes), Durabilidad (cambios permanentes). PostgreSQL cumple completamente con ACID.', 
'DATABASES', 'POSTGRESQL', '📚', NOW(), NOW(), TRUE),

('cross-site-scripting-xss', 'CONCEPT', 'BEGINNER', 'XSS — Cross-Site Scripting', 
'XSS ocurre cuando un atacante inyecta scripts maliciosos en páginas web vistas por otros usuarios. Prevención: sanitizar inputs, usar Content Security Policy (CSP), y escapar outputs en el HTML.', 
'CYBERSECURITY', 'JAVASCRIPT', '📚', NOW(), NOW(), TRUE),

('component-lifecycle', 'CONCEPT', 'BEGINNER', 'Component Lifecycle', 
'En Vue 3, los hooks del ciclo de vida son: onBeforeMount, onMounted, onBeforeUpdate, onUpdated, onBeforeUnmount, onUnmounted. Saber cuándo usar cada uno es clave para manejar side effects correctamente.', 
'FRONTEND', 'VUE', '📚', NOW(), NOW(), TRUE),

('design-system-concept', 'CONCEPT', 'INTERMEDIATE', 'Design System', 
'Un Design System es un conjunto de componentes reutilizables, guías de estilo y principios de diseño. Garantiza consistencia visual, acelera el desarrollo y facilita la colaboración entre diseñadores y desarrolladores.', 
'UIUX', 'REACT', '📚', NOW(), NOW(), TRUE),

('test-pyramid-concept', 'CONCEPT', 'INTERMEDIATE', 'Test Pyramid', 
'La pirámide de testing tiene tres niveles: muchos tests unitarios (base), algunos tests de integración (medio) y pocos tests E2E (punta). Esta distribución optimiza velocidad, costo y confianza.', 
'TESTING', 'JAVA', '📚', NOW(), NOW(), TRUE);

-- Questions
INSERT INTO contents (slug, type, difficulty, title, body, area, technology, emoji, created_at, updated_at, active) VALUES
('let-const-var-difference', 'QUESTION', 'BEGINNER', '¿let, const o var?', 
'¿Cuál es la diferencia entre `let`, `const` y `var` en JavaScript?\n\n✅ `var`: scope de función, se puede redeclarar (evitar).\n✅ `let`: scope de bloque, reasignable.\n✅ `const`: scope de bloque, no reasignable (pero objetos/arrays sí son mutables).', 
'FRONTEND', 'JAVASCRIPT', '❓', NOW(), NOW(), TRUE),

('sql-joins-explained', 'QUESTION', 'BEGINNER', '¿Qué es un JOIN?', 
'¿Cuántos tipos de JOIN existen en SQL?\n\n✅ INNER JOIN: solo filas con coincidencia en ambas tablas.\n✅ LEFT JOIN: todas las filas de la izquierda + coincidencias.\n✅ RIGHT JOIN: todas las filas de la derecha + coincidencias.\n✅ FULL JOIN: todas las filas de ambas tablas.\n✅ CROSS JOIN: producto cartesiano.', 
'DATABASES', 'MYSQL', '❓', NOW(), NOW(), TRUE),

('ref-vs-reactive-vue', 'QUESTION', 'BEGINNER', '¿ref() o reactive()?', 
'¿Cuándo usar `ref()` vs `reactive()` en Vue 3?\n\n✅ `ref()`: para primitivos (strings, numbers, booleans). Accedes con `.value`.\n✅ `reactive()`: para objetos y arrays. Acceso directo a propiedades.\n💡 Pro tip: `ref()` funciona para todo y es más predecible. Úsalo por defecto.', 
'FRONTEND', 'VUE', '❓', NOW(), NOW(), TRUE),

('event-loop-javascript', 'QUESTION', 'INTERMEDIATE', '¿Qué es el Event Loop?', 
'¿Cómo maneja JavaScript las operaciones asíncronas si es single-threaded?\n\n✅ El Event Loop revisa constantemente si la call stack está vacía.\n✅ Si lo está, toma la primera tarea de la callback queue.\n✅ Las microtasks (Promises) tienen prioridad sobre macrotasks (setTimeout).', 
'FRONTEND', 'JAVASCRIPT', '❓', NOW(), NOW(), TRUE),

('transactional-annotation-spring', 'QUESTION', 'INTERMEDIATE', '¿Qué es @Transactional?', 
'¿Qué hace la anotación `@Transactional` en Spring Boot?\n\n✅ Envuelve el método en una transacción de base de datos.\n✅ Si hay excepción, hace rollback automático.\n✅ Propagation.REQUIRED: usa la transacción existente o crea una nueva.\n✅ readOnly=true: optimiza consultas de solo lectura.', 
'BACKEND', 'SPRING_BOOT', '❓', NOW(), NOW(), TRUE),

('docker-compose-vs-kubernetes', 'QUESTION', 'INTERMEDIATE', '¿Docker Compose o Kubernetes?', 
'¿Cuándo usar Docker Compose vs Kubernetes?\n\n✅ Docker Compose: desarrollo local, pocos servicios, configuración simple con docker-compose.yml.\n✅ Kubernetes: producción, alta disponibilidad, auto-scaling, orquestación de muchos contenedores.\n💡 Empieza con Compose; migra a K8s cuando necesites escalar.', 
'DEVOPS', 'DOCKER', '❓', NOW(), NOW(), TRUE),

('orm-advantages-disadvantages', 'QUESTION', 'BEGINNER', '¿Qué es un ORM?', 
'¿Qué ventajas y desventajas tiene usar un ORM?\n\n✅ Ventajas: código más legible, menos SQL manual, portabilidad entre DBs, prevención de SQL injection.\n❌ Desventajas: overhead de rendimiento, queries complejas difíciles, curva de aprendizaje, "magia" oculta.', 
'DATABASES', 'POSTGRESQL', '❓', NOW(), NOW(), TRUE),

('cors-explained-spring', 'QUESTION', 'BEGINNER', '¿Qué es CORS?', 
'¿Por qué existe CORS y cómo se configura?\n\n✅ CORS (Cross-Origin Resource Sharing) protege contra peticiones no autorizadas desde otros dominios.\n✅ El servidor debe incluir headers como `Access-Control-Allow-Origin`.\n✅ En Spring Boot: usa `@CrossOrigin` o configura un `WebMvcConfigurer`.', 
'CYBERSECURITY', 'SPRING_BOOT', '❓', NOW(), NOW(), TRUE),

('interface-vs-type-typescript', 'QUESTION', 'BEGINNER', '¿Interface o Type?', 
'¿Cuándo usar `interface` vs `type` en TypeScript?\n\n✅ `interface`: para definir la forma de objetos. Soporta extensión y declaration merging.\n✅ `type`: para aliases, uniones, intersecciones y tipos complejos.\n💡 Regla simple: usa `interface` para objetos, `type` para todo lo demás.', 
'FRONTEND', 'TYPESCRIPT', '❓', NOW(), NOW(), TRUE),

('git-merge-vs-rebase', 'QUESTION', 'INTERMEDIATE', '¿Qué es git rebase?', 
'¿Cuál es la diferencia entre `git merge` y `git rebase`?\n\n✅ `merge`: crea un commit de fusión, preserva el historial completo.\n✅ `rebase`: reescribe el historial, aplica commits sobre la rama destino.\n💡 Usa rebase para ramas locales, merge para ramas compartidas.', 
'DEVOPS', 'GIT', '❓', NOW(), NOW(), TRUE),

('vue-props-vs-events', 'QUESTION', 'BEGINNER', '¿Props vs Events en Vue?', 
'¿Cómo se comunican los componentes en Vue 3?\n\n✅ Props: datos del padre al hijo (flujo unidireccional).\n✅ Events ($emit): del hijo al padre para notificar cambios.\n✅ Provide/Inject: para componentes profundamente anidados.\n✅ Pinia: para estado global compartido.', 
'FRONTEND', 'VUE', '❓', NOW(), NOW(), TRUE),

('dry-principle-meaning', 'QUESTION', 'BEGINNER', '¿Qué es el Principio DRY?', 
'¿"Don\'t Repeat Yourself" significa que nunca debo duplicar código?\n\n✅ DRY significa no duplicar CONOCIMIENTO, no necesariamente código.\n✅ Duplicar código similar pero con propósitos diferentes es válido.\n❌ Abstraer prematuramente para evitar duplicación puede crear acoplamiento innecesario.', 
'BACKEND', 'JAVA', '❓', NOW(), NOW(), TRUE),

('why-react-hooks', 'QUESTION', 'BEGINNER', '¿Qué son los React Hooks?', 
'¿Por qué React introdujo Hooks?\n\n✅ Permiten usar estado y efectos en componentes funcionales.\n✅ `useState`: estado local. `useEffect`: side effects. `useContext`: contexto.\n✅ Reemplazan class components con una API más simple y composable.\n💡 Los custom hooks permiten reutilizar lógica entre componentes.', 
'FRONTEND', 'REACT', '❓', NOW(), NOW(), TRUE),

('responsive-vs-adaptive', 'QUESTION', 'BEGINNER', '¿Responsive o Adaptive Design?', 
'¿Cuál es la diferencia?\n\n✅ Responsive: un solo layout que se adapta con media queries y unidades relativas.\n✅ Adaptive: múltiples layouts fijos para breakpoints específicos.\n💡 Responsive es más flexible y mantenible. Adaptive da más control en dispositivos específicos.', 
'UIUX', 'JAVASCRIPT', '❓', NOW(), NOW(), TRUE),

('mocking-in-testing', 'QUESTION', 'INTERMEDIATE', '¿Qué es mocking en tests?', 
'¿Por qué necesitamos mocks en testing?\n\n✅ Un mock simula el comportamiento de una dependencia externa.\n✅ Aísla la unidad bajo test de la base de datos, APIs, etc.\n✅ Hace los tests rápidos, predecibles y repetibles.\n💡 En Spring: `@MockBean`. En JS: `jest.mock()` o `vi.mock()`.', 
'TESTING', 'JAVA', '❓', NOW(), NOW(), TRUE);

-- Shortcuts
INSERT INTO contents (slug, type, difficulty, title, body, area, technology, emoji, created_at, updated_at, active) VALUES
('vscode-command-palette', 'SHORTCUT', 'BEGINNER', 'VS Code: Paleta de comandos', 
'`Ctrl+Shift+P` (Windows/Linux) o `Cmd+Shift+P` (Mac) abre la paleta de comandos. Desde ahí puedes acceder a cualquier funcionalidad de VS Code sin tocar el mouse.', 
'FRONTEND', 'JAVASCRIPT', '⌨️', NOW(), NOW(), TRUE),

('vscode-multi-cursor', 'SHORTCUT', 'BEGINNER', 'VS Code: Multi-cursor', 
'`Alt+Click` crea cursores múltiples. `Ctrl+D` selecciona la siguiente ocurrencia de la palabra seleccionada. `Ctrl+Shift+L` selecciona TODAS las ocurrencias. Edita en múltiples lugares simultáneamente.', 
'FRONTEND', 'TYPESCRIPT', '⌨️', NOW(), NOW(), TRUE),

('git-undo-last-commit', 'SHORTCUT', 'BEGINNER', 'Git: Deshacer último commit', 
'`git reset --soft HEAD~1` deshace el último commit pero mantiene los cambios en staging. `git reset --hard HEAD~1` deshace TODO (cuidado!). `git revert HEAD` crea un nuevo commit que revierte los cambios.', 
'DEVOPS', 'GIT', '⌨️', NOW(), NOW(), TRUE),

('intellij-generate-code', 'SHORTCUT', 'BEGINNER', 'IntelliJ: Generar código', 
'`Alt+Insert` (Windows) o `Cmd+N` (Mac) en IntelliJ abre el menú de generación: constructores, getters/setters, equals/hashCode, toString. Ahorra tiempo en clases Java.', 
'BACKEND', 'JAVA', '⌨️', NOW(), NOW(), TRUE),

('docker-clean-system', 'SHORTCUT', 'BEGINNER', 'Docker: Limpiar todo', 
'`docker system prune -a` elimina todos los contenedores parados, imágenes sin usar, redes y build cache. Agrega `--volumes` para incluir volúmenes. Puede liberar gigas de espacio.', 
'DEVOPS', 'DOCKER', '⌨️', NOW(), NOW(), TRUE),

('mysql-describe-table', 'SHORTCUT', 'BEGINNER', 'MySQL: Ver estructura de tabla', 
'`DESCRIBE nombre_tabla;` o `SHOW CREATE TABLE nombre_tabla;` muestra la estructura completa. `SHOW INDEX FROM nombre_tabla;` lista todos los índices. Esencial para debugging de queries lentas.', 
'DATABASES', 'MYSQL', '⌨️', NOW(), NOW(), TRUE),

('chrome-devtools-console-tricks', 'SHORTCUT', 'BEGINNER', 'Chrome DevTools: Console tricks', 
'`console.table(array)` muestra datos tabulados. `console.time("label")` / `console.timeEnd("label")` mide tiempo de ejecución. `$0` referencia el elemento seleccionado en Elements.', 
'FRONTEND', 'JAVASCRIPT', '⌨️', NOW(), NOW(), TRUE),

('vscode-quick-file-search', 'SHORTCUT', 'BEGINNER', 'VS Code: Búsqueda rápida', 
'`Ctrl+P`: buscar archivos por nombre. `Ctrl+Shift+F`: buscar en todos los archivos. `Ctrl+G`: ir a línea. `Ctrl+T`: buscar símbolos en el workspace. Navega tu proyecto como un pro.', 
'FRONTEND', 'VUE', '⌨️', NOW(), NOW(), TRUE),

('postgresql-psql-commands', 'SHORTCUT', 'BEGINNER', 'PostgreSQL: psql commands', 
'`\\dt`: lista tablas. `\\d tabla`: describe tabla. `\\di`: lista índices. `\\l`: lista bases de datos. `\\c dbname`: conecta a otra DB. `\\timing`: activa medición de tiempo de queries.', 
'DATABASES', 'POSTGRESQL', '⌨️', NOW(), NOW(), TRUE),

('springboot-actuator-endpoints', 'SHORTCUT', 'INTERMEDIATE', 'Spring Boot Actuator endpoints', 
'`/actuator/health`: estado de la app. `/actuator/info`: info personalizada. `/actuator/metrics`: métricas de rendimiento. `/actuator/env`: variables de entorno. Agrega `spring-boot-starter-actuator` al pom.', 
'BACKEND', 'SPRING_BOOT', '⌨️', NOW(), NOW(), TRUE),

('git-visual-log', 'SHORTCUT', 'BEGINNER', 'Git: Log visual', 
'`git log --oneline --graph --all` muestra un historial visual compacto con ramas. Agrega `--decorate` para ver tags y refs. Para algo más elegante: `git log --pretty=format:"%h %s (%an, %ar)"`.', 
'DEVOPS', 'GIT', '⌨️', NOW(), NOW(), TRUE),

('vscode-fast-refactoring', 'SHORTCUT', 'BEGINNER', 'VS Code: Refactoring rápido', 
'`F2`: renombrar símbolo en todo el proyecto. `Ctrl+.`: Quick Fix (sugerencias). `Ctrl+Shift+R`: refactorizar (extraer método, variable, etc.). TypeScript potencia estas herramientas al máximo.', 
'FRONTEND', 'TYPESCRIPT', '⌨️', NOW(), NOW(), TRUE),

('react-devtools-shortcuts', 'SHORTCUT', 'BEGINNER', 'React DevTools shortcuts', 
'Instala React DevTools y usa `Ctrl+Shift+I` para abrir DevTools. El tab "Components" te permite inspeccionar el árbol, props and state. "Profiler" identifica re-renders innecesarios.', 
'FRONTEND', 'REACT', '⌨️', NOW(), NOW(), TRUE),

('terminal-chained-commands', 'SHORTCUT', 'BEGINNER', 'Terminal: Comandos encadenados', 
'`&&`: ejecuta el siguiente solo si el anterior tuvo éxito. `||`: ejecuta solo si falló. `;`: ejecuta siempre. Ejemplo: `npm run build && npm run deploy` — solo despliega si el build pasa.', 
'DEVOPS', 'GIT', '⌨️', NOW(), NOW(), TRUE),

('vue-devtools-time-travel', 'SHORTCUT', 'BEGINNER', 'Vue DevTools: Time Travel', 
'Vue DevTools permite "viajar en el tiempo" por los estados de tu aplicación. Cada mutación de Pinia queda registrada. Puedes hacer click en cualquier estado anterior para ver cómo se veía la app.', 
'FRONTEND', 'VUE', '⌨️', NOW(), NOW(), TRUE);
