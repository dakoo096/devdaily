<template>
  <div class="landing-page">
    <!-- Hero Section -->
    <section class="hero-section" id="hero">
      <div class="hero-container">
        <div class="hero-text-content">
          <span class="hero-tagline animate-fade-in-up"
            >⚡ DevBloom PWA & App</span
          >
          <h1 class="hero-title animate-fade-in-up stagger-1">
            Aprende algo nuevo sobre programación
            <span class="gradient-text">todos los días</span>.
          </h1>
          <p class="hero-desc animate-fade-in-up stagger-2">
            DevBloom es una plataforma de microlearning diseñada para
            desarrolladores. Recibe lecciones breves, tips prácticos y quizzes
            adaptados a tus tecnologías preferidas en menos de 5 minutos al día.
          </p>
          <div class="hero-actions animate-fade-in-up stagger-3">
            <router-link to="/register" class="btn-hero-primary">
              <ion-icon
                :icon="rocketOutline"
                class="btn-hero-icon rocket-icon"
              />
              <span>Empezar Gratis</span>
            </router-link>
            <router-link to="/login" class="btn-hero-secondary">
              <ion-icon
                :icon="laptopOutline"
                class="btn-hero-icon laptop-icon"
              />
              <span>Probar en el Navegador</span>
            </router-link>
          </div>
        </div>
        <div class="hero-media-content animate-fade-in stagger-2">
          <div class="mockup-wrapper">
            <img
              src="/DevBloom header.png"
              alt="DevBloom Hero Mascot"
              class="mockup-img hero-mascot-img"
            />
            <div class="glow-effect"></div>
          </div>
        </div>
      </div>
    </section>

    <!-- Concept Section (¿Qué es DevBloom?) -->
    <section class="concept-section" id="about-concept">
      <div class="concept-container">
        <div class="concept-header">
          <h2>¿Qué es DevBloom?</h2>
          <div class="header-line"></div>
        </div>
        <div class="concept-content-grid">
          <div class="concept-card animate-fade-in-up">
            <div class="concept-icon-box">
              <ion-icon :icon="rocketOutline" />
            </div>
            <h3>Microlearning Efectivo</h3>
            <p>
              Evita la fatiga cognitiva de cursos interminables. DevBloom
              sintetiza conceptos complejos en formatos cortos de lectura rápida
              para asimilar conocimientos sin esfuerzo.
            </p>
          </div>
          <div class="concept-card animate-fade-in-up stagger-1">
            <div class="concept-icon-box">
              <ion-icon :icon="constructOutline" />
            </div>
            <h3>Contenido a tu Medida</h3>
            <p>
              Configura tus preferencias durante el onboarding y recibe
              diariamente solo lo que te interesa de tus lenguajes y tecnologías
              favoritas (JavaScript, Spring Boot, Git, Docker, etc.).
            </p>
          </div>
          <div class="concept-card animate-fade-in-up stagger-2">
            <div class="concept-icon-box">
              <ion-icon :icon="schoolOutline" />
            </div>
            <h3>Valida lo Aprendido</h3>
            <p>
              Pon a prueba tu memoria y comprensión resolviendo el quiz diario
              basado en el contenido del día. Recibe retroalimentación
              instantánea y gana puntos de experiencia.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Features Section (Características) -->
    <section class="features-section" id="features">
      <div class="features-container">
        <div class="features-header">
          <h2>Características principales</h2>
          <p>
            Herramientas diseñadas para potenciar tu crecimiento continuo sin
            aburrirte en el camino.
          </p>
          <div class="header-line"></div>
        </div>
        <div class="features-grid">
          <div
            v-for="(feat, idx) in featuresList"
            :key="idx"
            class="feature-item animate-fade-in-up"
            :class="`stagger-${Math.min(idx, 6)}`"
          >
            <div class="feature-icon" :style="{ background: feat.gradient }">
              <ion-icon :icon="feat.icon" />
            </div>
            <h3>{{ feat.title }}</h3>
            <p>{{ feat.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- How it works (¿Cómo funciona?) -->
    <section class="flow-section" id="how-it-works">
      <div class="flow-container">
        <div class="flow-header">
          <h2>¿Cómo funciona?</h2>
          <p>Un hábito de aprendizaje en 5 sencillos pasos.</p>
          <div class="header-line"></div>
        </div>
        <div class="flow-content-wrapper">
          <div class="flow-image-side animate-fade-in">
            <img
              src="/assets/DevBloom_question.png"
              alt="DevBloom Mascot Question"
              class="flow-mascot-img"
            />
          </div>
          <div class="flow-steps">
            <div
              v-for="(step, idx) in flowSteps"
              :key="idx"
              class="flow-step animate-fade-in-up"
              :class="`stagger-${idx}`"
            >
              <div class="step-num-box">
                <span class="step-number">{{ idx + 1 }}</span>
                <div
                  v-if="idx < flowSteps.length - 1"
                  class="step-connector"
                ></div>
              </div>
              <div class="step-content">
                <h3>{{ step.title }}</h3>
                <p>{{ step.description }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Roadmap Section -->
    <section class="roadmap-section" id="roadmap">
      <div class="roadmap-container">
        <div class="roadmap-header">
          <span class="roadmap-tag">🚀 Proyección</span>
          <h2>Roadmap del Proyecto</h2>
          <p>
            DevBloom está vivo y en constante evolución. Conoce lo que ya está
            listo y lo que estamos construyendo.
          </p>
          <div class="header-line"></div>
        </div>
        <div class="roadmap-box">
          <div class="roadmap-column">
            <h3>✅ Implementado</h3>
            <ul class="roadmap-list">
              <li>
                <span class="status-icon success-icon">✓</span>
                <div class="roadmap-item-info">
                  <strong>Contenido Diario:</strong> Microlecciones curadas e
                  interactivas cada mañana.
                </div>
              </li>
              <li>
                <span class="status-icon success-icon">✓</span>
                <div class="roadmap-item-info">
                  <strong>Quizzes Rápidos:</strong> Cuestionarios diarios con
                  estadísticas de precisión.
                </div>
              </li>
              <li>
                <span class="status-icon success-icon">✓</span>
                <div class="roadmap-item-info">
                  <strong>Historial y Favoritos:</strong> Repasa lo leído y
                  guarda lecciones importantes.
                </div>
              </li>
              <li>
                <span class="status-icon success-icon">✓</span>
                <div class="roadmap-item-info">
                  <strong>Perfil y Logros:</strong> Sistema inicial de XP y
                  niveles de desarrollador.
                </div>
              </li>
            </ul>
          </div>
          <div class="roadmap-column">
            <h3>🚧 En Desarrollo / Próximamente</h3>
            <ul class="roadmap-list">
              <li>
                <span class="status-icon progress-icon">⚙</span>
                <div class="roadmap-item-info">
                  <strong>Árbol de Habilidades (RPG):</strong> Ruta interactiva
                  para desbloquear tecnologías de forma secuencial.
                </div>
              </li>
              <li>
                <span class="status-icon progress-icon">⚙</span>
                <div class="roadmap-item-info">
                  <strong>Desafíos de Código Interactivos:</strong> Editor
                  integrado para completar código en el navegador/móvil.
                </div>
              </li>
              <li>
                <span class="status-icon progress-icon">⚙</span>
                <div class="roadmap-item-info">
                  <strong>Duelos de Programación (PvP):</strong> Compite
                  asíncronamente con otros desarrolladores en velocidad de
                  lógica.
                </div>
              </li>
              <li>
                <span class="status-icon progress-icon">⚙</span>
                <div class="roadmap-item-info">
                  <strong>Soporte offline y PWA avanzada:</strong> Cacheo
                  inteligente y notificaciones locales mejoradas.
                </div>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <!-- Screenshots Carousel -->
    <section class="screenshots-section" id="screenshots">
      <div class="screenshots-container">
        <div class="screenshots-header">
          <h2>Capturas de Pantalla</h2>
          <p>Un vistazo a la experiencia limpia e interactiva de DevBloom.</p>
          <div class="header-line"></div>
        </div>

        <!-- Custom Interactive Carousel -->
        <div class="carousel-container">
          <button
            class="carousel-btn prev-btn"
            @click="prevSlide"
            aria-label="Previous slide"
          >
            <ion-icon :icon="chevronBackOutline" />
          </button>

          <div class="carousel-track-wrapper">
            <div
              class="carousel-track"
              :style="{ transform: `translateX(-${activeSlide * 100}%)` }"
            >
              <div
                v-for="(slide, index) in slides"
                :key="index"
                class="carousel-slide"
              >
                <div class="slide-card">
                  <img
                    :src="slide.image"
                    :alt="slide.title"
                    class="slide-img"
                  />
                  <div class="slide-caption">
                    <h3>{{ slide.title }}</h3>
                    <p>{{ slide.description }}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <button
            class="carousel-btn next-btn"
            @click="nextSlide"
            aria-label="Next slide"
          >
            <ion-icon :icon="chevronForwardOutline" />
          </button>

          <div class="carousel-dots">
            <span
              v-for="(_, index) in slides"
              :key="index"
              class="dot"
              :class="{ active: index === activeSlide }"
              @click="setSlide(index)"
            ></span>
          </div>
        </div>
      </div>
    </section>

    <!-- Download CTA Section -->
    <section class="download-section" id="download">
      <div class="download-container">
        <div class="download-content">
          <h2>Lleva DevBloom a todas partes</h2>
          <p>
            Instala nuestra Aplicación Web Progresiva (PWA) o descarga la app
            nativa para Android y continúa aprendiendo desde cualquier
            dispositivo, incluso sin conexión a internet.
          </p>
          <div class="download-actions">
            <a
              href="https://github.com/dakoo096/devbloom/actions/runs/28680098515/artifacts/8073767581"
              target="_blank"
              rel="noopener"
              class="btn-download-cta btn-download-primary"
            >
              <ion-icon
                :icon="logoAndroid"
                class="btn-download-icon android-icon"
              />
              <span>Descargar APK (Android)</span>
            </a>
            <router-link
              to="/register"
              class="btn-download-cta btn-download-secondary"
            >
              <ion-icon
                :icon="rocketOutline"
                class="btn-download-icon rocket-icon"
              />
              <span>Empezar Gratis</span>
            </router-link>
          </div>
          <p class="download-subtext">
            También puedes instalarla desde tu navegador móvil usando la opción
            "Agregar a pantalla de inicio".
          </p>
        </div>
      </div>
    </section>

    <!-- Tech Stack Section (Branding) -->
    <section class="tech-section" id="tech-stack">
      <div class="tech-container">
        <div class="tech-header">
          <h2>Branded Stack</h2>
          <p>
            Desarrollado sobre un ecosistema de tecnologías robustas y modernas.
          </p>
          <div class="header-line"></div>
        </div>
        <div class="tech-grid">
          <div class="tech-card">
            <h4>Frontend</h4>
            <div class="tech-chips">
              <span class="tech-chip font-vue">Vue 3</span>
              <span class="tech-chip font-ionic">Ionic Vue</span>
              <span class="tech-chip font-ts">TypeScript</span>
              <span class="tech-chip font-pinia">Pinia Store</span>
            </div>
          </div>
          <div class="tech-card">
            <h4>Backend</h4>
            <div class="tech-chips">
              <span class="tech-chip font-springboot">Spring Boot</span>
              <span class="tech-chip font-security">Spring Security</span>
              <span class="tech-chip font-jwt">JWT Auth</span>
              <span class="tech-chip font-mysql">MySQL</span>
              <span class="tech-chip font-flyway">Flyway Migrations</span>
            </div>
          </div>
          <div class="tech-card">
            <h4>Infraestructura</h4>
            <div class="tech-chips">
              <span class="tech-chip font-railway">Railway Host</span>
              <span class="tech-chip font-vercel">Vercel Web</span>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";
import { IonIcon } from "@ionic/vue";
import {
  laptopOutline,
  bookOutline,
  bulbOutline,
  helpCircleOutline,
  heartOutline,
  barChartOutline,
  trophyOutline,
  flameOutline,
  optionsOutline,
  moonOutline,
  rocketOutline,
  constructOutline,
  schoolOutline,
  chevronBackOutline,
  chevronForwardOutline,
  logoAndroid,
} from "ionicons/icons";

// Features List Configuration
const featuresList = [
  {
    title: "Tips Diarios",
    description:
      "Lecciones breves enfocadas en buenas prácticas y trucos de codificación.",
    icon: bookOutline,
    gradient: "linear-gradient(135deg, #6C5CE7, #A29BFE)",
  },
  {
    title: "Conceptos Claros",
    description:
      "Explicaciones directas y sin rodeos de temas complejos de desarrollo.",
    icon: bulbOutline,
    gradient: "linear-gradient(135deg, #00CEC9, #55EFC4)",
  },
  {
    title: "Quizzes Rápidos",
    description:
      "Evaluaciones cortas para verificar tu retención inmediatamente.",
    icon: helpCircleOutline,
    gradient: "linear-gradient(135deg, #FD79A8, #FD86B1)",
  },
  {
    title: "Tus Favoritos",
    description:
      "Marca y guarda contenidos importantes para consultarlos más adelante.",
    icon: heartOutline,
    gradient: "linear-gradient(135deg, #E17055, #E47E66)",
  },
  {
    title: "Estadísticas",
    description:
      "Supervisa tu precisión, cantidad de lecciones leídas y tiempo activo.",
    icon: barChartOutline,
    gradient: "linear-gradient(135deg, #00B894, #1ABF9F)",
  },
  {
    title: "Logros Desbloqueables",
    description:
      "Cumple objetivos para conseguir recompensas y acumular Dev XP.",
    icon: trophyOutline,
    gradient: "linear-gradient(135deg, #FDCB6E, #FDD07D)",
  },
  {
    title: "Rachas Diarias",
    description:
      "Mantén activo el hábito diario de lectura para conseguir multiplicadores.",
    icon: flameOutline,
    gradient: "linear-gradient(135deg, #D63031, #FF7675)",
  },
  {
    title: "Filtros Personalizados",
    description:
      "Selecciona tus lenguajes y áreas de interés para adaptar el feed.",
    icon: optionsOutline,
    gradient: "linear-gradient(135deg, #0984E3, #74B9FF)",
  },
  {
    title: "Modo Oscuro Native",
    description:
      "Interfaz fluida y descansada, perfecta para programadores nocturnos.",
    icon: moonOutline,
    gradient: "linear-gradient(135deg, #2D3436, #636E72)",
  },
];

// How It Works Steps
const flowSteps = [
  {
    title: "Elige tus tecnologías",
    description:
      "Personaliza tu perfil marcando tus áreas de interés y tus lenguajes en el onboarding.",
  },
  {
    title: "Recibe contenido diario",
    description:
      "Cada mañana, DevBloom genera lecciones personalizadas basadas en tus preferencias.",
  },
  {
    title: "Responde Quizzes",
    description:
      "Realiza el test diario para evaluar lo aprendido y comprobar tu asimilación.",
  },
  {
    title: "Gana Experiencia",
    description:
      "Sube de nivel de desarrollador al acumular puntos XP y desbloquear logros en tu perfil.",
  },
  {
    title: "Mejora tus habilidades",
    description:
      "Adquiere un hábito sólido y amplía tus conocimientos día con día en unos minutos.",
  },
];

// Carousel Slides Configuration
const baseUrl = import.meta.env.BASE_URL || "/";
const slides = [
  {
    title: "Lecciones Diarias",
    description:
      "Visualiza tus tarjetas diarias filtradas según tus tecnologías e intereses.",
    image: `${baseUrl}pagPrincipal_DevBloom.png`,
  },
  {
    title: "Quizzes Dinámicos",
    description:
      "Valida tu conocimiento resolviendo cuestionarios con feedback en tiempo real.",
    image: `${baseUrl}quizdiario_DevBloom.png`,
  },
  {
    title: "Perfil y Gamificación",
    description:
      "Revisa tu nivel de desarrollador, barra de XP, rachas, precisión de respuestas y logros.",
    image: `${baseUrl}miPerfil_DevBloom.png`,
  },
];

// Carousel Logic
const activeSlide = ref(0);

function nextSlide() {
  activeSlide.value = (activeSlide.value + 1) % slides.length;
}

function prevSlide() {
  activeSlide.value = (activeSlide.value - 1 + slides.length) % slides.length;
}

function setSlide(idx: number) {
  activeSlide.value = idx;
}
</script>

<style scoped>
.landing-page {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  color: var(--dd-text);
  overflow-x: hidden;
}

/* Sections Global */
section {
  padding: 80px 24px;
}

.header-line {
  width: 60px;
  height: 4px;
  background: var(--dd-gradient-primary);
  margin: 16px auto 0;
  border-radius: var(--dd-radius-full);
}

/* Hero Section */
.hero-section {
  padding: 120px 24px 80px;
  background: radial-gradient(circle at 80% 20%, rgba(108, 92, 231, 0.08) 0%, transparent 50%),
              radial-gradient(circle at 10% 80%, rgba(0, 206, 201, 0.05) 0%, transparent 50%);
}

.hero-container {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  gap: 48px;
}

.hero-text-content {
  flex: 1.2;
}

.hero-tagline {
  display: inline-block;
  font-size: 13px;
  font-weight: 700;
  color: var(--ion-color-primary);
  background: rgba(var(--ion-color-primary-rgb), 0.1);
  padding: 6px 14px;
  border-radius: var(--dd-radius-full);
  margin-bottom: 24px;
}

.hero-title {
  font-size: clamp(36px, 5vw, 52px);
  font-weight: 800;
  line-height: 1.15;
  letter-spacing: -1.5px;
  color: var(--dd-text);
  margin: 0 0 24px;
}

.hero-desc {
  font-size: 17px;
  color: var(--dd-text-secondary);
  line-height: 1.6;
  margin: 0 0 36px;
  max-width: 580px;
}

/* Hero Buttons CSS */
.hero-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 18px;
  margin-top: 10px;
}

.btn-hero-primary,
.btn-hero-secondary {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 16px 36px;
  border-radius: 12px;
  font-size: 16px;
  font-weight: 700;
  text-decoration: none;
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  cursor: pointer;
  position: relative;
  overflow: hidden;
  letter-spacing: -0.2px;
}

/* Primary CTA Button (Empezar Gratis) */
.btn-hero-primary {
  background: var(--dd-gradient-primary, linear-gradient(135deg, #6C5CE7, #8c7ae6));
  color: #ffffff !important;
  box-shadow: 0 8px 24px rgba(108, 92, 231, 0.35),
              inset 0 1px 0 rgba(255, 255, 255, 0.2);
  border: none;
}

.btn-hero-primary::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(
    90deg,
    transparent,
    rgba(255, 255, 255, 0.25),
    transparent
  );
  transition: 0.5s;
}

.btn-hero-primary:hover {
  transform: translateY(-4px) scale(1.03);
  box-shadow: 0 15px 30px rgba(108, 92, 231, 0.5),
              inset 0 1px 0 rgba(255, 255, 255, 0.3);
}

.btn-hero-primary:hover::before {
  left: 100%;
  transition: 0.8s ease-in-out;
}

.btn-hero-primary:active {
  transform: translateY(-1px) scale(0.98);
}

/* Secondary CTA Button (Probar en el Navegador) */
.btn-hero-secondary {
  background: rgba(255, 255, 255, 0.03);
  color: var(--dd-text) !important;
  border: 1px solid var(--dd-border);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  backdrop-filter: blur(10px);
}

.btn-hero-secondary:hover {
  transform: translateY(-4px) scale(1.03);
  background: rgba(108, 92, 231, 0.06);
  border-color: rgba(108, 92, 231, 0.5);
  box-shadow: 0 12px 24px rgba(108, 92, 231, 0.15);
  color: var(--ion-color-primary) !important;
}

.btn-hero-secondary:active {
  transform: translateY(-1px) scale(0.98);
}

/* Icons inside Hero Buttons */
.btn-hero-icon {
  font-size: 20px;
  margin-right: 10px;
  transition: transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

/* Rocket Icon Hover Animation */
.btn-hero-primary:hover .rocket-icon {
  transform: translateY(-4px) translateX(4px) rotate(15deg) scale(1.2);
}

/* Laptop Icon Hover Animation */
.btn-hero-secondary:hover .laptop-icon {
  transform: scale(1.2) rotate(-5deg);
}

.hero-media-content {
  flex: 0.8;
  display: flex;
  justify-content: center;
  align-items: center;
}

.mockup-wrapper {
  position: relative;
  max-width: 320px;
  width: 100%;
}

.mockup-img {
  width: 100%;
  height: auto;
  border-radius: 40px;
  box-shadow: 0 20px 50px rgba(108, 92, 231, 0.2);
  position: relative;
  z-index: 2;
  border: 4px solid var(--dd-border);
}

.hero-mascot-img {
  border: none !important;
  border-radius: 0 !important;
  box-shadow: none !important;
  max-width: 320px;
  height: auto;
  margin: 0 auto;
  display: block;
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.hero-mascot-img:hover {
  transform: translateY(-8px) rotate(-2deg);
}

.glow-effect {
  position: absolute;
  top: 10%;
  left: 10%;
  right: 10%;
  bottom: 10%;
  background: var(--dd-gradient-primary);
  filter: blur(60px);
  opacity: 0.45;
  z-index: 1;
}

/* Concept Section (¿Qué es DevBloom?) */
.concept-section {
  background: var(--dd-surface);
  border-top: 1px solid var(--dd-border);
  border-bottom: 1px solid var(--dd-border);
}

.concept-container {
  max-width: 1200px;
  margin: 0 auto;
}

.concept-header {
  text-align: center;
  margin-bottom: 56px;
}

.concept-header h2 {
  font-size: 32px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0;
}

.concept-content-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 32px;
}

.concept-card {
  padding: 32px;
  background: var(--dd-bg);
  border-radius: var(--dd-radius-lg);
  border: 1px solid var(--dd-border);
  transition: all 0.3s ease;
}

.concept-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--dd-shadow-md);
  border-color: var(--ion-color-primary);
}

.concept-icon-box {
  width: 56px;
  height: 56px;
  background: var(--dd-gradient-primary);
  color: #fff;
  border-radius: var(--dd-radius-md);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  margin: 0 auto 24px;
  box-shadow: 0 4px 12px rgba(108, 92, 231, 0.2);
}

.concept-card h3 {
  font-size: 20px;
  font-weight: 800;
  margin: 0 0 12px;
  color: var(--dd-text);
  text-align: center;
}

.concept-card p {
  font-size: 14px;
  color: var(--dd-text-secondary);
  line-height: 1.6;
  margin: 0;
  text-align: justify;
}

/* Features Section (Características) */
.features-container {
  max-width: 1200px;
  margin: 0 auto;
}

.features-header {
  text-align: center;
  margin-bottom: 64px;
}

.features-header h2 {
  font-size: 32px;
  font-weight: 800;
  margin: 0 0 12px;
}

.features-header p {
  font-size: 16px;
  color: var(--dd-text-secondary);
  margin: 0;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
}

.feature-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  padding: 24px;
  background: var(--dd-surface);
  border-radius: var(--dd-radius-md);
  border: 1px solid var(--dd-border);
  box-shadow: var(--dd-shadow-sm);
  transition: all 0.3s ease;
}

.feature-item:hover {
  transform: translateY(-2px);
  box-shadow: var(--dd-shadow-md);
}

.feature-icon {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 20px;
  margin-bottom: 16px;
}

.feature-item h3 {
  font-size: 18px;
  font-weight: 700;
  margin: 0 0 8px;
}

.feature-item p {
  font-size: 13px;
  color: var(--dd-text-secondary);
  line-height: 1.6;
  margin: 0;
}

/* Flow Section (¿Cómo funciona?) */
.flow-section {
  background: var(--dd-surface);
  border-top: 1px solid var(--dd-border);
  border-bottom: 1px solid var(--dd-border);
}

.flow-container {
  max-width: 1000px;
  margin: 0 auto;
}

.flow-header {
  text-align: center;
  margin-bottom: 56px;
}

.flow-header h2 {
  font-size: 32px;
  font-weight: 800;
  margin: 0 0 12px;
}

.flow-header p {
  font-size: 16px;
  color: var(--dd-text-secondary);
  margin: 0;
}

.flow-content-wrapper {
  display: flex;
  align-items: center;
  gap: 48px;
}

.flow-image-side {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
}

.flow-mascot-img {
  max-width: 320px;
  width: 100%;
  height: auto;
  filter: drop-shadow(0 15px 30px rgba(108, 92, 231, 0.15));
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.flow-mascot-img:hover {
  transform: translateY(-8px) rotate(-2deg);
}

.flow-steps {
  flex: 1.2;
  display: flex;
  flex-direction: column;
  gap: 32px;
}

.flow-step {
  display: flex;
  gap: 24px;
}

.step-num-box {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.step-number {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: var(--dd-gradient-primary);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  font-weight: 800;
  z-index: 2;
  box-shadow: 0 4px 10px rgba(108, 92, 231, 0.25);
}

.step-connector {
  width: 2px;
  flex: 1;
  background: var(--dd-border);
  margin-top: 8px;
  margin-bottom: -40px;
}

.step-content {
  padding-top: 6px;
}

.step-content h3 {
  font-size: 18px;
  font-weight: 700;
  margin: 0 0 8px;
}

.step-content p {
  font-size: 14px;
  color: var(--dd-text-secondary);
  line-height: 1.6;
  margin: 0;
}

/* Roadmap Section */
.roadmap-container {
  max-width: 1000px;
  margin: 0 auto;
}

.roadmap-header {
  text-align: center;
  margin-bottom: 56px;
}

.roadmap-tag {
  display: inline-block;
  font-size: 12px;
  font-weight: 700;
  color: var(--ion-color-secondary);
  background: rgba(0, 206, 201, 0.1);
  padding: 4px 12px;
  border-radius: var(--dd-radius-full);
  margin-bottom: 16px;
}

.roadmap-header h2 {
  font-size: 32px;
  font-weight: 800;
  margin: 0 0 12px;
}

.roadmap-header p {
  font-size: 16px;
  color: var(--dd-text-secondary);
}

.roadmap-box {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 32px;
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-lg);
  padding: 40px;
  box-shadow: var(--dd-shadow-sm);
}

.roadmap-column h3 {
  font-size: 20px;
  font-weight: 800;
  margin: 0 0 24px;
  border-bottom: 2px solid var(--dd-border);
  padding-bottom: 12px;
}

.roadmap-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.roadmap-list li {
  display: flex;
  gap: 16px;
  align-items: flex-start;
}

.status-icon {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 800;
  font-size: 13px;
  flex-shrink: 0;
}

.success-icon {
  background: rgba(0, 184, 148, 0.1);
  color: var(--ion-color-success);
}

.progress-icon {
  background: rgba(253, 203, 110, 0.1);
  color: var(--ion-color-warning-shade);
}

.roadmap-item-info {
  font-size: 14px;
  line-height: 1.5;
  color: var(--dd-text-secondary);
}

.roadmap-item-info strong {
  color: var(--dd-text);
}

/* Screenshots Section */
.screenshots-section {
  background: var(--dd-surface);
  border-top: 1px solid var(--dd-border);
  border-bottom: 1px solid var(--dd-border);
}

.screenshots-container {
  max-width: 1200px;
  margin: 0 auto;
}

.screenshots-header {
  text-align: center;
  margin-bottom: 56px;
}

.screenshots-header h2 {
  font-size: 32px;
  font-weight: 800;
  margin: 0 0 12px;
}

.screenshots-header p {
  font-size: 16px;
  color: var(--dd-text-secondary);
}

/* Carousel */
.carousel-container {
  position: relative;
  max-width: 900px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.carousel-track-wrapper {
  overflow: hidden;
  width: 100%;
  border-radius: var(--dd-radius-lg);
  border: 1px solid var(--dd-border);
  background: var(--dd-bg);
  box-shadow: var(--dd-shadow-md);
}

.carousel-track {
  display: flex;
  transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}

.carousel-slide {
  min-width: 100%;
  flex-shrink: 0;
  padding: 40px;
  box-sizing: border-box;
}

.slide-card {
  display: flex;
  align-items: center;
  gap: 40px;
  width: 100%;
}

.slide-img {
  width: 100%;
  max-width: 320px;
  height: auto;
  object-fit: cover;
  background: #0d0f12;
  border-radius: var(--dd-radius-md);
  border: 1px solid var(--dd-border);
  box-shadow: var(--dd-shadow-sm);
  flex-shrink: 0;
}

.slide-caption {
  flex: 1;
}

.slide-caption h3 {
  font-size: 24px;
  font-weight: 800;
  margin: 0 0 16px;
  color: var(--dd-text);
}

.slide-caption p {
  font-size: 15px;
  color: var(--dd-text-secondary);
  line-height: 1.6;
}

.carousel-btn {
  position: absolute;
  top: 45%;
  transform: translateY(-50%);
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  color: var(--dd-text);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  z-index: 10;
  box-shadow: var(--dd-shadow-sm);
  transition: all 0.2s ease;
  font-size: 20px;
}

.carousel-btn:hover {
  background: var(--dd-surface-hover);
  color: var(--ion-color-primary);
}

.prev-btn {
  left: -24px;
}

.next-btn {
  right: -24px;
}

.carousel-dots {
  display: flex;
  gap: 8px;
  margin-top: 24px;
}

.dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: var(--dd-border);
  cursor: pointer;
  transition: all 0.3s ease;
}

.dot.active {
  background: var(--ion-color-primary);
  transform: scale(1.2);
}

/* Tech Section */
.tech-container {
  max-width: 1200px;
  margin: 0 auto;
}

.tech-header {
  text-align: center;
  margin-bottom: 56px;
}

.tech-header h2 {
  font-size: 32px;
  font-weight: 800;
}

.tech-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
}

.tech-card {
  padding: 32px;
  background: var(--dd-surface);
  border-radius: var(--dd-radius-md);
  border: 1px solid var(--dd-border);
  box-shadow: var(--dd-shadow-sm);
}

.tech-card h4 {
  font-size: 16px;
  font-weight: 800;
  color: var(--dd-text-secondary);
  margin: 0 0 20px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.tech-chips {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.tech-chip {
  padding: 6px 12px;
  border-radius: var(--dd-radius-sm);
  font-size: 13px;
  font-weight: 700;
  background: var(--dd-bg);
  border: 1px solid var(--dd-border);
}

/* Tech color highlights for branding */
.font-vue { color: #42b883; border-color: rgba(66, 184, 131, 0.2); }
.font-ionic { color: #3880ff; border-color: rgba(56, 128, 255, 0.2); }
.font-ts { color: #3178c6; border-color: rgba(49, 120, 198, 0.2); }
.font-pinia { color: #ffe15d; border-color: rgba(255, 225, 93, 0.2); }
.font-springboot { color: #6db33f; border-color: rgba(109, 179, 63, 0.2); }
.font-security { color: var(--dd-tech-security-color); border-color: var(--dd-tech-security-border); }
.font-jwt { color: #f25f5c; border-color: rgba(242, 95, 92, 0.2); }
.font-mysql { color: #00758f; border-color: rgba(0, 117, 143, 0.2); }
.font-flyway { color: #cc0200; border-color: rgba(204, 2, 0, 0.2); }
.font-railway { color: #9c27b0; border-color: rgba(156, 39, 176, 0.2); }
.font-vercel { color: var(--dd-tech-vercel-color); border-color: var(--dd-tech-vercel-border); }

/* Download CTA Section */
.download-section {
  background: var(--dd-gradient-primary);
  color: #ffffff;
  text-align: center;
  border-radius: var(--dd-radius-lg);
  margin: 0 24px;
  padding: 80px 24px;
}

.download-container {
  max-width: 800px;
  margin: 0 auto;
}

.download-content h2 {
  font-size: 38px;
  font-weight: 800;
  margin: 0 0 16px;
  letter-spacing: -1px;
}

.download-content p {
  font-size: 17px;
  line-height: 1.6;
  opacity: 0.9;
  margin: 0 0 40px;
}

.download-actions {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  gap: 20px;
  margin-top: 10px;
}

.btn-download-cta {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 16px 36px;
  border-radius: 14px;
  font-size: 16px;
  font-weight: 700;
  text-decoration: none !important;
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  cursor: pointer;
  position: relative;
  overflow: hidden;
  letter-spacing: -0.2px;
}

.btn-download-cta span {
  text-decoration: none !important;
}

/* Primary Button (Descargar APK) */
.btn-download-primary {
  background: #ffffff;
  color: #5f27cd !important;
  border: none;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15),
              inset 0 1px 0 rgba(255, 255, 255, 0.8);
}

.btn-download-primary::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(
    90deg,
    transparent,
    rgba(108, 92, 231, 0.08),
    transparent
  );
  transition: 0.5s;
}

.btn-download-primary:hover {
  transform: translateY(-4px) scale(1.03);
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.25),
              inset 0 1px 0 rgba(255, 255, 255, 0.9);
  background: #f5f6ff;
  color: #5f27cd !important;
}

.btn-download-primary:hover::before {
  left: 100%;
  transition: 0.8s ease-in-out;
}

.btn-download-primary:active {
  transform: translateY(-1px) scale(0.98);
}

/* Secondary Button (Empezar Gratis) */
.btn-download-secondary {
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.25);
  color: #ffffff !important;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.05);
}

.btn-download-secondary:hover {
  transform: translateY(-4px) scale(1.03);
  background: rgba(255, 255, 255, 0.18);
  border-color: rgba(255, 255, 255, 0.6);
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
}

.btn-download-secondary:active {
  transform: translateY(-1px) scale(0.98);
}

/* Download Icons styling */
.btn-download-icon {
  font-size: 22px;
  margin-right: 10px;
  transition: transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.btn-download-primary:hover .android-icon {
  transform: scale(1.2) rotate(10deg);
}

.btn-download-secondary:hover .rocket-icon {
  transform: translateY(-4px) translateX(4px) rotate(15deg) scale(1.2);
}

.download-subtext {
  margin-top: 24px;
  font-size: 13px;
  opacity: 0.8;
}

/* Animations */
.animate-fade-in-up {
  opacity: 0;
  transform: translateY(20px);
  animation: fadeInUp 0.6s cubic-bezier(0.4, 0, 0.2, 1) forwards;
}

.animate-fade-in {
  opacity: 0;
  animation: fadeIn 0.8s ease forwards;
}

.stagger-1 { animation-delay: 0.1s; }
.stagger-2 { animation-delay: 0.2s; }
.stagger-3 { animation-delay: 0.3s; }
.stagger-4 { animation-delay: 0.4s; }

/* Responsive adjustments */
@media (max-width: 1024px) {
  .concept-content-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .features-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .tech-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  section {
    padding: 60px 16px;
  }
  .hero-container {
    flex-direction: column;
    text-align: center;
  }
  .hero-desc {
    margin-left: auto;
    margin-right: auto;
  }
  .hero-actions {
    justify-content: center;
  }
  .concept-content-grid {
    grid-template-columns: 1fr;
  }
  .features-grid {
    grid-template-columns: 1fr;
  }
  .roadmap-box {
    grid-template-columns: 1fr;
    padding: 24px;
  }
  .slide-card {
    flex-direction: column;
    align-items: center;
    text-align: center;
    gap: 24px;
  }
  .slide-img {
    width: auto;
    max-width: 100%;
    max-height: 55vh;
    height: auto;
    object-fit: contain;
  }
  .flow-content-wrapper {
    flex-direction: column;
    gap: 40px;
  }
  .flow-mascot-img {
    max-width: 240px;
  }
  .carousel-btn {
    width: 40px;
    height: 40px;
    font-size: 16px;
  }
  .carousel-slide {
    padding: 16px 12px;
  }
  .slide-caption {
    width: 100%;
    padding: 0 12px;
  }
  .carousel-dots {
    margin-top: 16px;
  }
  .prev-btn { left: -12px; }
  .next-btn { right: -12px; }
  .download-section {
    margin: 0;
    border-radius: 0;
  }
  .download-actions .btn-download-cta {
    width: 100%;
  }
}
</style>
