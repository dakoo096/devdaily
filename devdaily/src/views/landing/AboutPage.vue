<template>
  <div class="about-page">
    <div class="about-hero animate-fade-in-up">
      <span class="about-tag">💡 Filosofía</span>
      <h1>Sobre DevDaily</h1>
      <p>Entendiendo el porqué detrás del aprendizaje en porciones diarias.</p>
      <div class="header-line"></div>
    </div>

    <section class="about-content">
      <div class="about-container">
        <!-- Section 1: The Problem -->
        <div class="about-block">
          <div class="block-text">
            <h2>El Desafío: Fatiga Cognitiva</h2>
            <p>
              Como desarrolladores de software, nos enfrentamos a una avalancha constante de nueva información, herramientas y lenguajes. Intentar aprender todo de golpe mediante tutoriales de 10 horas o libros de 600 páginas a menudo conduce a la fatiga mental y a la pérdida de interés.
            </p>
            <p>
              La retención a largo plazo se debilita cuando intentamos consumir demasiada información en una sola sesión de estudio intensivo.
            </p>
          </div>
          <div class="block-visual">
            <div class="visual-card error-card">
              <span class="visual-emoji">🤯</span>
              <h4>Sobrecarga Informativa</h4>
              <p>Tratar de procesar múltiples conceptos complejos en poco tiempo satura la memoria de trabajo.</p>
            </div>
          </div>
        </div>

        <!-- Section 2: The Solution -->
        <div class="about-block reverse">
          <div class="block-text">
            <h2>Nuestra Filosofía: Microlearning Diario</h2>
            <p>
              DevDaily nació para resolver esto aplicando el concepto de <strong>microlearning</strong> (o microaprendizaje). Estudiar un solo concepto claro y bien estructurado al día toma menos de 5 minutos, pero genera un hábito poderoso a largo plazo.
            </p>
            <p>
              Al complementar la lectura diaria con un quiz rápido de retroalimentación inmediata, obligamos a nuestra memoria a realizar una recuperación activa del conocimiento, lo que afianza la memoria a largo plazo.
            </p>
          </div>
          <div class="block-visual">
            <div class="visual-card success-card">
              <span class="visual-emoji">🎯</span>
              <h4>Hábitos Eficaces</h4>
              <p>5 minutos de constancia diaria superan a 5 horas de estudio en un solo fin de semana.</p>
            </div>
          </div>
        </div>

        <!-- Section 3: Open Source & PWA -->
        <div class="about-block">
          <div class="block-text">
            <h2>Una PWA moderna para todos</h2>
            <p>
              Queríamos que DevDaily fuera accesible al instante. Por eso, además de ofrecer una aplicación móvil nativa a través de una APK de Android, DevDaily está construido como una Aplicación Web Progresiva (PWA).
            </p>
            <p>
              Puedes usarla desde cualquier navegador de escritorio, tablet, o instalarla directamente en la pantalla de inicio de tu teléfono iOS o Android sin pasar por la tienda de aplicaciones.
            </p>
          </div>
          <div class="block-visual">
            <div class="visual-card tech-card">
              <span class="visual-emoji">💻</span>
              <h4>Multiplataforma</h4>
              <p>Sincronización perfecta entre tu base de datos local y la nube.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Call to Action -->
    <section class="about-cta-section">
      <div class="about-cta-container">
        <h2>Únete a los programadores del mañana</h2>
        <p>Comienza a aprender, responder quizzes y superar tu racha hoy mismo.</p>
        <div class="cta-actions">
          <router-link to="/register" class="btn-landing btn-primary-landing btn-cta-about">Crear cuenta gratis</router-link>
          <router-link to="/" class="btn-landing btn-outline-landing btn-cta-about alt-btn">Volver al inicio</router-link>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
// No extra scripts required for static about layout
</script>

<style scoped>
.about-page {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  color: var(--dd-text);
}

.header-line {
  width: 60px;
  height: 4px;
  background: var(--dd-gradient-primary);
  margin: 16px auto 0;
  border-radius: var(--dd-radius-full);
}

/* Hero */
.about-hero {
  text-align: center;
  padding: 120px 24px 60px;
  background: radial-gradient(circle at 50% 30%, rgba(108, 92, 231, 0.05) 0%, transparent 60%);
}

.about-tag {
  display: inline-block;
  font-size: 13px;
  font-weight: 700;
  color: var(--ion-color-primary);
  background: rgba(var(--ion-color-primary-rgb), 0.1);
  padding: 6px 14px;
  border-radius: var(--dd-radius-full);
  margin-bottom: 16px;
}

.about-hero h1 {
  font-size: clamp(32px, 5vw, 46px);
  font-weight: 800;
  letter-spacing: -1px;
  margin: 0 0 16px;
}

.about-hero p {
  font-size: 16px;
  color: var(--dd-text-secondary);
  max-width: 600px;
  margin: 0 auto;
}

/* Content Blocks */
.about-content {
  padding: 40px 24px;
}

.about-container {
  max-width: 1000px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 80px;
}

.about-block {
  display: flex;
  align-items: center;
  gap: 64px;
}

.about-block.reverse {
  flex-direction: row-reverse;
}

.block-text {
  flex: 1.2;
}

.block-text h2 {
  font-size: 26px;
  font-weight: 800;
  margin: 0 0 20px;
  color: var(--dd-text);
}

.block-text p {
  font-size: 15px;
  color: var(--dd-text-secondary);
  line-height: 1.7;
  margin: 0 0 16px;
}

.block-text p:last-child {
  margin: 0;
}

.block-visual {
  flex: 0.8;
  display: flex;
  justify-content: center;
}

.visual-card {
  padding: 32px;
  border-radius: var(--dd-radius-lg);
  border: 1px solid var(--dd-border);
  background: var(--dd-surface);
  box-shadow: var(--dd-shadow-sm);
  text-align: center;
  max-width: 280px;
  width: 100%;
}

.visual-emoji {
  font-size: 40px;
  display: block;
  margin-bottom: 16px;
}

.visual-card h4 {
  font-size: 16px;
  font-weight: 800;
  margin: 0 0 8px;
}

.visual-card p {
  font-size: 12px;
  color: var(--dd-text-secondary);
  line-height: 1.5;
  margin: 0;
}

/* Styles variations for card states */
.error-card {
  border-color: rgba(var(--ion-color-danger-rgb), 0.2);
}
.error-card h4 {
  color: var(--ion-color-danger);
}

.success-card {
  border-color: rgba(var(--ion-color-success-rgb), 0.2);
}
.success-card h4 {
  color: var(--ion-color-success);
}

.tech-card {
  border-color: rgba(var(--ion-color-primary-rgb), 0.2);
}
.tech-card h4 {
  color: var(--ion-color-primary);
}

/* Call to Action */
.about-cta-section {
  background: var(--dd-surface);
  border-top: 1px solid var(--dd-border);
  padding: 80px 24px;
  text-align: center;
  margin-top: 80px;
}

.about-cta-container {
  max-width: 600px;
  margin: 0 auto;
}

.about-cta-container h2 {
  font-size: 30px;
  font-weight: 800;
  margin: 0 0 12px;
}

.about-cta-container p {
  font-size: 15px;
  color: var(--dd-text-secondary);
  margin: 0 0 32px;
}

.cta-actions {
  display: flex;
  justify-content: center;
  gap: 16px;
  flex-wrap: wrap;
}

.btn-landing {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 12px 28px;
  border-radius: var(--dd-radius-sm, 10px);
  font-size: 14px;
  font-weight: 700;
  text-decoration: none;
  transition: all 0.25s ease;
  cursor: pointer;
}

.btn-primary-landing {
  background: var(--dd-gradient-primary);
  color: #ffffff !important;
  box-shadow: 0 4px 12px rgba(108, 92, 231, 0.25);
  border: none;
}

.btn-primary-landing:hover {
  transform: translateY(-1px);
  box-shadow: 0 6px 16px rgba(108, 92, 231, 0.35);
}

.btn-outline-landing {
  background: transparent;
  border: 1px solid var(--dd-border);
  color: var(--dd-text) !important;
}

.btn-outline-landing:hover {
  background: var(--dd-surface-hover);
  border-color: var(--dd-text-secondary);
}

.btn-cta-about {
  padding: 12px 28px;
}

/* Responsive */
@media (max-width: 768px) {
  .about-hero {
    padding-top: 100px;
  }
  .about-block, 
  .about-block.reverse {
    flex-direction: column;
    gap: 32px;
    text-align: center;
  }
  .block-visual {
    width: 100%;
  }
  .visual-card {
    max-width: 100%;
  }
  .cta-actions .btn-landing {
    width: 100%;
  }
}
</style>
