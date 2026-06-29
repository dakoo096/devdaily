# ⚡ DevDaily

**DevDaily** es una aplicación móvil multiplataforma premium diseñada para desarrolladores que desean consumir contenido técnico personalizado de manera diaria. Desde consejos de productividad, preguntas técnicas de preparación para entrevistas, atajos de teclado, conceptos y curiosidades del mundo del software, hasta frases inspiradoras.

La aplicación permite personalizar la dosis diaria en base a áreas de interés (Frontend, Backend, Bases de Datos, Ciberseguridad, etc.), tecnologías favoritas (Java, Spring Boot, Vue, React, Docker, Git, etc.) y nivel de seniority (Estudiante, Junior, Semi Senior, Senior).

---

## 🛠️ Arquitectura del Proyecto

El proyecto está estructurado como un **monorepositorio** que contiene tanto el cliente móvil como la API del servidor:

```bash
proyecto devDaily/
├── backend/          # API REST en Spring Boot 3 (Java 21)
└── devdaily/         # Aplicación Móvil en Ionic 7 + Vue 3 (Vite)
```

---

## 🚀 Tecnologías Utilizadas

### 📱 Frontend (Aplicación Móvil)
- **Framework Core**: [Ionic Framework](https://ionicframework.com/) + [Vue 3](https://vuejs.org/) (Composition API)
- **Gestión de Estado**: [Pinia](https://pinia.vuejs.org/) (con persistencia local automatizada)
- **Compilador & Bundler**: [Vite](https://vitejs.dev/)
- **Cliente HTTP**: Fetch API Wrapper con inyección de JWT automática
- **Estilos**: Vanilla CSS con variables CSS personalizadas, Glassmorphism, y transiciones fluidas.

### ⚙️ Backend (API REST)
- **Lenguaje**: Java 21
- **Framework**: Spring Boot 3.x
- **Seguridad**: Spring Security 6 & Autenticación basada en **JWT (JSON Web Tokens)**
- **Persistencia**: Spring Data JPA & Hibernate
- **Base de Datos**: MySQL
- **Control de Versiones BD**: Flyway Migrations
- **Utilidades**: Lombok

---

## 📸 Características Destacadas
- **Registro y Autenticación Segura (JWT)** con validaciones en tiempo real.
- **Onboarding de Preferencias** en 4 pasos dinámicos para definir tus intereses exactos.
- **Motor de Contenido Diario**: Genera de 5 a 8 contenidos dinámicos cada día en base a las preferencias y nivel de seniority del usuario, guardando automáticamente las lecturas en el historial para evitar repetidos.
- **Favoritos**: Guarda contenidos en la base de datos de manera síncrona.
- **Historial Completo**: Visualiza tus lecturas organizadas en una línea de tiempo agrupada por fecha.
- **Modo Oscuro Adaptativo**: Interruptor persistente sincronizado con tu perfil en la nube.

---

## ⚙️ Requisitos Previos

Asegúrate de tener instalado:
- **Java JDK 21**
- **Node.js** (v18 o superior)
- **MySQL** (ej. a través de XAMPP, Docker o instalación nativa)
- **Maven** (incluido en el wrapper del proyecto)

---

## 📦 Guía de Instalación y Lanzamiento

### 1. Base de Datos (MySQL)
Crea una base de datos vacía llamada `devdaily` en tu servidor local:
```sql
CREATE DATABASE devdaily CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 2. Configurar y lanzar el Backend
1. Navega a la carpeta del servidor:
   ```bash
   cd backend
   ```
2. Modifica el archivo `src/main/resources/application-dev.yml` si tus credenciales de MySQL (usuario o contraseña) son distintas a las por defecto (`root` / vacía).
3. Compila y ejecuta la aplicación (Flyway creará las tablas e insertará 90 contenidos de semilla automáticamente):
   ```bash
   mvnw spring-boot:run
   ```
   *La API estará escuchando en `http://localhost:8080`.*

### 3. Configurar y lanzar el Frontend
1. Navega a la carpeta de la aplicación móvil:
   ```bash
   cd ../devdaily
   ```
2. Instala las dependencias necesarias:
   ```bash
   npm install
   ```
3. Inicia el servidor de desarrollo en modo local:
   ```bash
   npm run dev
   ```
   *La aplicación móvil se abrirá en tu navegador en `http://localhost:5173` (o un puerto alternativo como `http://localhost:5174`).*

---

## 📁 Estructura del Código

### Backend (Spring Boot)
- `/config`: Configuración de seguridad (CORS, JWT) y auditoría JPA.
- `/controller`: Endpoints REST expuestos (`/api/auth`, `/api/content`, `/api/favorites`, `/api/history`, `/api/users`).
- `/dto`: Objetos de transferencia de datos para entrada/salida y validaciones `@Valid`.
- `/entity`: Modelo relacional de JPA mapeado a la base de datos.
- `/enums`: Enums estandarizados (Tecnologías, Áreas, Tipos de Contenido).
- `/exception`: Controlador global de errores y excepciones del sistema.
- `/mapper`: Conversión manual e inyección de dependencias para modelos y DTOs.
- `/repository`: Interfaces de Spring Data para acceso a MySQL.
- `/security`: Filtros de autenticación, JWT Provider y servicio de detalles del usuario.
- `/service`: Lógica de negocios (algoritmos de recomendación diaria, autenticación).

### Frontend (Ionic + Vue)
- `/src/components`: Componentes reutilizables (Tarjetas de contenido, Chips, Skeletons de carga, Estados vacíos).
- `/src/composables`: Hooks y composables de lógica compartida (`useAuth`, `useDarkMode`).
- `/src/router`: Manejo de rutas y guardianes de navegación por estado de login y onboarding.
- `/src/services`: Cliente API centralizado (`api.ts`).
- `/src/stores`: Manejo de estados globales con Pinia (`authStore`, `contentStore`, `favoritesStore`, `historyStore`, `settingsStore`).
- `/src/views`: Pantallas de la aplicación organizadas por módulos (Autenticación, Onboarding, Configuración, Pestañas principales).

---

## ⚖️ Licencia
Este proyecto es de código abierto y está desarrollado con fines educativos y de portafolio profesional.
