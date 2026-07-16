<template>
  <ion-page class="landing-layout-page">
    <!-- Navbar -->
    <header class="landing-navbar" :class="{ 'menu-open': isMenuOpen }">
      <div class="navbar-container">
        <!-- Logo -->
        <div class="navbar-logo" @click="goHome">
          <span class="logo-emoji">⚡</span>
          <span class="logo-text">DevBloom</span>
        </div>

        <!-- Desktop Navigation Links -->
        <nav class="navbar-links">
          <a href="/#features" @click="handleNavClick($event, 'features')">Características</a>
          <a href="/#screenshots" @click="handleNavClick($event, 'screenshots')">Capturas</a>
          <a href="/#roadmap" @click="handleNavClick($event, 'roadmap')">Roadmap</a>
          <router-link to="/about">About</router-link>
          
          <!-- Dark Mode Toggle -->
          <button class="dark-mode-toggle" @click="darkMode.toggle()" aria-label="Toggle dark mode">
            <ion-icon :icon="darkMode.isDark.value ? sunnyOutline : moonOutline" />
          </button>

          <div class="navbar-actions">
            <router-link to="/login" class="btn-landing btn-outline-landing">Ingresar</router-link>
            <router-link to="/register" class="btn-landing btn-primary-landing">Registrarse</router-link>
          </div>
        </nav>

        <!-- Mobile Menu Toggle Button -->
        <button class="hamburger-toggle" @click="toggleMenu" aria-label="Toggle menu">
          <ion-icon :icon="isMenuOpen ? closeOutline : menuOutline" />
        </button>
      </div>
    </header>

    <!-- Mobile Dropdown Menu Drawer -->
    <transition name="slide-down">
      <div v-if="isMenuOpen" class="mobile-drawer" @click="closeMenu">
        <nav class="mobile-links" @click.stop>
          <a href="/#features" @click="handleNavClick($event, 'features')">Características</a>
          <a href="/#screenshots" @click="handleNavClick($event, 'screenshots')">Capturas</a>
          <a href="/#roadmap" @click="handleNavClick($event, 'roadmap')">Roadmap</a>
          <router-link to="/about" @click="closeMenu">About</router-link>
          
          <!-- Mobile Dark Mode Toggle -->
          <div class="mobile-theme-row" @click="darkMode.toggle()">
            <span>Modo oscuro</span>
            <ion-icon :icon="darkMode.isDark.value ? sunnyOutline : moonOutline" />
          </div>

          <div class="mobile-actions">
            <router-link to="/login" class="btn-landing btn-outline-landing" @click="closeMenu">Ingresar</router-link>
            <router-link to="/register" class="btn-landing btn-primary-landing" @click="closeMenu">Registrarse</router-link>
          </div>
        </nav>
      </div>
    </transition>

    <!-- Main Scrollable Content Area -->
    <ion-content :scroll-y="true" class="landing-content-scroll" id="landing-content-element">
      <main class="landing-main-view">
        <router-view />
      </main>

      <!-- Footer Section -->
      <footer class="landing-footer">
        <div class="footer-container">
          <div class="footer-brand">
            <div class="footer-logo">
              <span class="logo-emoji">⚡</span>
              <span class="logo-text">DevBloom</span>
            </div>
            <p class="footer-desc">
              Mejora tus habilidades y adquiere hábitos de aprendizaje diario en programación con microlecciones y desafíos rápidos.
            </p>
          </div>
          <div class="footer-links-grid">
            <div class="footer-col">
              <h4>Producto</h4>
              <a href="/#features" @click="handleNavClick($event, 'features')">Características</a>
              <router-link to="/login">Probar Web App</router-link>
            </div>
            <div class="footer-col">
              <h4>Contacto y Redes</h4>
              <a href="https://github.com/dakoo096" target="_blank" rel="noopener">GitHub</a>
              <a href="https://www.linkedin.com/in/noelia-cabral-381723140" target="_blank" rel="noopener">LinkedIn</a>
              <a href="https://dakoo096.github.io/portfolio-noelia-cabral-2025/" target="_blank" rel="noopener">Portfolio</a>
            </div>
          </div>
        </div>
        <div class="footer-bottom">
          <p>&copy; {{ new Date().getFullYear() }} DevBloom. Todos los derechos reservados.</p>
          <div class="footer-meta">
            <span class="footer-version">v1.0.0</span>
          </div>
        </div>
      </footer>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { menuOutline, closeOutline, sunnyOutline, moonOutline } from 'ionicons/icons';
import { useDarkMode } from '@/composables/useDarkMode';

const router = useRouter();
const isMenuOpen = ref(false);
const darkMode = useDarkMode();

function toggleMenu() {
  isMenuOpen.value = !isMenuOpen.value;
}

function closeMenu() {
  isMenuOpen.value = false;
}

function goHome() {
  closeMenu();
  router.push('/');
}

function handleNavClick(event: Event, targetId: string) {
  event.preventDefault();
  closeMenu();
  
  // If we are not on the landing page, navigate there first
  if (window.location.pathname !== '/') {
    router.push('/').then(() => {
      setTimeout(() => scrollToElement(targetId), 200);
    });
  } else {
    scrollToElement(targetId);
  }
}

function scrollToElement(id: string) {
  const contentElement = document.getElementById('landing-content-element');
  const targetElement = document.getElementById(id);
  
  if (contentElement && targetElement) {
    // Scroll the ion-content container to the element's position
    targetElement.scrollIntoView({ behavior: 'smooth', block: 'start' });
  }
}
</script>

<style scoped>
.landing-layout-page {
  --background: var(--dd-bg);
  background: var(--dd-bg);
}

.landing-content-scroll {
  --background: var(--dd-bg);
  --padding-top: 70px;
}

.landing-navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: 70px;
  background: var(--dd-glass-bg);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid var(--dd-border);
  z-index: 1000;
  transition: all 0.3s ease;
}

.navbar-container {
  max-width: 1200px;
  height: 100%;
  margin: 0 auto;
  padding: 0 24px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.navbar-logo {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
}

.logo-emoji {
  font-size: 24px;
}

.logo-text {
  font-size: 20px;
  font-weight: 800;
  color: var(--dd-text);
  letter-spacing: -0.5px;
}

.navbar-links {
  display: flex;
  align-items: center;
  gap: 28px;
}

.navbar-links a {
  text-decoration: none;
  font-size: 15px;
  font-weight: 600;
  color: var(--dd-text-secondary);
  transition: color 0.2s ease;
}

.navbar-links a:hover,
.navbar-links a.router-link-active {
  color: var(--ion-color-primary);
}

.navbar-actions {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-left: 16px;
}

/* Buttons */
.btn-landing {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 10px 20px;
  border-radius: var(--dd-radius-sm);
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

.hamburger-toggle {
  display: none;
  background: none;
  border: none;
  color: var(--dd-text);
  font-size: 28px;
  cursor: pointer;
  padding: 4px;
}

/* Mobile menu drawer */
.mobile-drawer {
  position: fixed;
  top: 70px;
  left: 0;
  right: 0;
  bottom: 0;
  background: var(--dd-bg);
  z-index: 1001;
  padding: 24px;
  display: flex;
  flex-direction: column;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
  overflow-y: auto;
}

.mobile-links {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.mobile-links a {
  text-decoration: none;
  font-size: 18px;
  font-weight: 700;
  color: var(--dd-text);
  padding: 8px 0;
  border-bottom: 1px solid var(--dd-border);
}

.mobile-actions {
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-top: 32px;
}

.mobile-actions .btn-landing {
  width: 100%;
  padding: 14px;
  font-size: 16px;
}

/* Footer styling */
.landing-footer {
  background: var(--dd-surface);
  border-top: 1px solid var(--dd-border);
  padding: 64px 24px 32px;
  margin-top: 64px;
}

.footer-container {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 40px;
}

.footer-brand {
  max-width: 360px;
}

.footer-logo {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 16px;
}

.footer-desc {
  font-size: 14px;
  color: var(--dd-text-secondary);
  line-height: 1.6;
}

.footer-links-grid {
  display: flex;
  gap: 64px;
}

.footer-col {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.footer-col h4 {
  font-size: 14px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0 0 8px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.footer-col a {
  font-size: 14px;
  color: var(--dd-text-secondary);
  text-decoration: none;
  transition: color 0.2s ease;
}

.footer-col a:hover {
  color: var(--ion-color-primary);
}

.footer-bottom {
  max-width: 1200px;
  margin: 48px auto 0;
  padding-top: 24px;
  border-top: 1px solid var(--dd-border);
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 13px;
  color: var(--dd-text-secondary);
}

.footer-meta {
  display: flex;
  gap: 16px;
}

.footer-version {
  font-weight: 700;
  background: var(--dd-bg);
  padding: 2px 8px;
  border-radius: 4px;
}

/* Animations */
.slide-down-enter-active,
.slide-down-leave-active {
  transition: all 0.3s ease;
}

.slide-down-enter-from,
.slide-down-leave-to {
  transform: translateY(-20px);
  opacity: 0;
}

/* Responsive breakpoint */
@media (max-width: 768px) {
  .navbar-links {
    display: none;
  }
  
  .hamburger-toggle {
    display: block;
  }
  
  .footer-links-grid {
    gap: 32px;
    width: 100%;
    justify-content: space-between;
  }
  
  .footer-container {
    flex-direction: column;
  }
  
  .footer-bottom {
    flex-direction: column;
    gap: 12px;
    text-align: center;
  }
}

.dark-mode-toggle {
  background: none;
  border: none;
  color: var(--dd-text);
  font-size: 20px;
  cursor: pointer;
  padding: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  transition: all 0.2s ease;
}

.dark-mode-toggle:hover {
  background: var(--dd-surface-hover);
  color: var(--ion-color-primary);
}

.mobile-theme-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 18px;
  font-weight: 700;
  color: var(--dd-text);
  padding: 8px 0;
  border-bottom: 1px solid var(--dd-border);
  cursor: pointer;
}

.mobile-theme-row ion-icon {
  font-size: 22px;
  color: var(--ion-color-primary);
}
</style>
