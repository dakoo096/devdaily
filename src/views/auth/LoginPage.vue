<template>
  <ion-page>
    <ion-content :fullscreen="true" class="login-content">
      <div class="login-container">
        <!-- Logo & Branding -->
        <div class="brand-section animate-fade-in-up">
          <div class="logo-wrapper">
            <div class="logo-icon">
              <span>⚡</span>
            </div>
          </div>
          <h1 class="app-name">Dev<span class="gradient-text">Daily</span></h1>
          <p class="app-tagline">Tu dosis diaria de desarrollo</p>
        </div>

        <!-- Login Form -->
        <div class="form-section animate-fade-in-up stagger-2">
          <div class="input-group">
            <div class="input-wrapper">
              <ion-icon :icon="mailOutline" class="input-icon" />
              <input
                id="login-email"
                v-model="email"
                type="email"
                placeholder="Email"
                class="app-input"
                @keyup.enter="handleLogin"
              />
            </div>
          </div>

          <div class="input-group">
            <div class="input-wrapper">
              <ion-icon :icon="lockClosedOutline" class="input-icon" />
              <input
                id="login-password"
                v-model="password"
                :type="showPassword ? 'text' : 'password'"
                placeholder="Contraseña"
                class="app-input"
                @keyup.enter="handleLogin"
              />
              <button class="toggle-password" @click="showPassword = !showPassword">
                <ion-icon :icon="showPassword ? eyeOffOutline : eyeOutline" />
              </button>
            </div>
          </div>

          <!-- Error Message -->
          <transition name="shake">
            <div v-if="error" class="error-message">
              <ion-icon :icon="alertCircleOutline" />
              <span>{{ error }}</span>
            </div>
          </transition>

          <!-- Login Button -->
          <button
            id="login-button"
            class="primary-button"
            :class="{ loading: isLoading }"
            :disabled="isLoading"
            @click="handleLogin"
          >
            <span v-if="!isLoading">Iniciar Sesión</span>
            <ion-spinner v-else name="crescent" />
          </button>

          <!-- Register Link -->
          <p class="switch-auth">
            ¿No tienes cuenta?
            <router-link to="/register" class="switch-link">Regístrate</router-link>
          </p>
        </div>

        <!-- Decorative Elements -->
        <div class="decorative-circle circle-1"></div>
        <div class="decorative-circle circle-2"></div>
        <div class="decorative-circle circle-3"></div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage, IonContent, IonIcon, IonSpinner } from '@ionic/vue';
import { mailOutline, lockClosedOutline, eyeOutline, eyeOffOutline, alertCircleOutline } from 'ionicons/icons';
import { useAuth } from '@/composables/useAuth';
import { useAuthStore } from '@/stores/authStore';

const router = useRouter();
const authStore = useAuthStore();
const { login, isLoading, error, clearError } = useAuth();

const email = ref('');
const password = ref('');
const showPassword = ref(false);

async function handleLogin() {
  clearError();
  const success = await login({ email: email.value, password: password.value });
  if (success) {
    if (authStore.onboardingCompleted) {
      router.replace('/tabs/home');
    } else {
      router.replace('/onboarding');
    }
  }
}
</script>

<style scoped>
.login-content {
  --background: var(--dd-bg);
}

.login-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  padding: 32px 24px;
  position: relative;
  overflow: hidden;
}

/* Brand Section */
.brand-section {
  text-align: center;
  margin-bottom: 48px;
  z-index: 1;
}

.logo-wrapper {
  margin-bottom: 16px;
}

.logo-icon {
  width: 80px;
  height: 80px;
  border-radius: 24px;
  background: var(--dd-gradient-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto;
  font-size: 40px;
  box-shadow: 0 8px 32px rgba(108, 92, 231, 0.3);
  animation: pulse 3s ease-in-out infinite;
}

.app-name {
  font-size: 36px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0;
  letter-spacing: -0.5px;
}

.app-tagline {
  font-size: 16px;
  color: var(--dd-text-secondary);
  margin: 8px 0 0;
  font-weight: 400;
}

/* Form Section */
.form-section {
  width: 100%;
  max-width: 360px;
  z-index: 1;
}

.input-group {
  margin-bottom: 16px;
}

.input-wrapper {
  display: flex;
  align-items: center;
  background: var(--dd-surface);
  border: 2px solid var(--dd-border);
  border-radius: var(--dd-radius-sm);
  padding: 0 16px;
  transition: all 0.3s ease;
}

.input-wrapper:focus-within {
  border-color: var(--ion-color-primary);
  box-shadow: 0 0 0 4px rgba(var(--ion-color-primary-rgb), 0.1);
}

.input-icon {
  font-size: 20px;
  color: var(--dd-text-secondary);
  margin-right: 12px;
  flex-shrink: 0;
}

.app-input {
  flex: 1;
  border: none;
  background: none;
  padding: 16px 0;
  font-size: 15px;
  color: var(--dd-text);
  outline: none;
  font-family: inherit;
}

.app-input::placeholder {
  color: var(--dd-text-secondary);
  opacity: 0.6;
}

.toggle-password {
  background: none;
  border: none;
  color: var(--dd-text-secondary);
  font-size: 20px;
  cursor: pointer;
  padding: 4px;
  display: flex;
}

/* Error Message */
.error-message {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 12px 16px;
  background: rgba(var(--ion-color-danger-rgb), 0.1);
  border-radius: var(--dd-radius-sm);
  color: var(--ion-color-danger);
  font-size: 13px;
  font-weight: 500;
  margin-bottom: 16px;
}

/* Primary Button */
.primary-button {
  width: 100%;
  padding: 16px;
  border: none;
  border-radius: var(--dd-radius-sm);
  background: var(--dd-gradient-primary);
  color: #fff;
  font-size: 16px;
  font-weight: 600;
  font-family: inherit;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 16px rgba(108, 92, 231, 0.3);
}

.primary-button:active {
  transform: scale(0.98);
}

.primary-button.loading {
  opacity: 0.8;
}

.primary-button:disabled {
  cursor: not-allowed;
}

/* Switch Auth */
.switch-auth {
  text-align: center;
  margin-top: 24px;
  font-size: 14px;
  color: var(--dd-text-secondary);
}

.switch-link {
  color: var(--ion-color-primary);
  font-weight: 600;
  text-decoration: none;
}

/* Decorative Circles */
.decorative-circle {
  position: absolute;
  border-radius: 50%;
  opacity: 0.06;
}

.circle-1 {
  width: 300px;
  height: 300px;
  background: var(--ion-color-primary);
  top: -100px;
  right: -80px;
}

.circle-2 {
  width: 200px;
  height: 200px;
  background: var(--ion-color-secondary);
  bottom: -60px;
  left: -60px;
}

.circle-3 {
  width: 150px;
  height: 150px;
  background: var(--ion-color-tertiary);
  bottom: 20%;
  right: -40px;
}

/* Transitions */
.shake-enter-active {
  animation: shake 0.4s ease;
}

@keyframes shake {
  0%, 100% { transform: translateX(0); }
  25% { transform: translateX(-8px); }
  75% { transform: translateX(8px); }
}

@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}
</style>
