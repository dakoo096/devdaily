<template>
  <ion-page>
    <ion-content :fullscreen="true" class="register-content">
      <div class="register-container">
        <!-- Header -->
        <div class="brand-section animate-fade-in-up">
          <div class="logo-icon">
            <span>⚡</span>
          </div>
          <h1 class="page-title">Crear Cuenta</h1>
          <p class="page-subtitle">Únete a la comunidad DevDaily</p>
        </div>

        <!-- Register Form -->
        <div class="form-section animate-fade-in-up stagger-2">
          <div class="input-group">
            <div class="input-wrapper">
              <ion-icon :icon="personOutline" class="input-icon" />
              <input
                id="register-name"
                v-model="name"
                type="text"
                placeholder="Nombre completo"
                class="app-input"
              />
            </div>
          </div>

          <div class="input-group">
            <div class="input-wrapper">
              <ion-icon :icon="mailOutline" class="input-icon" />
              <input
                id="register-email"
                v-model="email"
                type="email"
                placeholder="Email"
                class="app-input"
              />
            </div>
          </div>

          <div class="input-group">
            <div class="input-wrapper">
              <ion-icon :icon="lockClosedOutline" class="input-icon" />
              <input
                id="register-password"
                v-model="password"
                :type="showPassword ? 'text' : 'password'"
                placeholder="Contraseña (mín. 6 caracteres)"
                class="app-input"
              />
              <button class="toggle-password" @click="showPassword = !showPassword">
                <ion-icon :icon="showPassword ? eyeOffOutline : eyeOutline" />
              </button>
            </div>
          </div>

          <!-- Error -->
          <div v-if="error" class="error-message">
            <ion-icon :icon="alertCircleOutline" />
            <span>{{ error }}</span>
          </div>

          <!-- Register Button -->
          <button
            id="register-button"
            class="primary-button"
            :class="{ loading: isLoading }"
            :disabled="isLoading"
            @click="handleRegister"
          >
            <span v-if="!isLoading">Crear Cuenta</span>
            <ion-spinner v-else name="crescent" />
          </button>

          <p class="switch-auth">
            ¿Ya tienes cuenta?
            <router-link to="/login" class="switch-link">Inicia Sesión</router-link>
          </p>
        </div>

        <div class="decorative-circle circle-1"></div>
        <div class="decorative-circle circle-2"></div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage, IonContent, IonIcon, IonSpinner } from '@ionic/vue';
import { personOutline, mailOutline, lockClosedOutline, eyeOutline, eyeOffOutline, alertCircleOutline } from 'ionicons/icons';
import { useAuth } from '@/composables/useAuth';

const router = useRouter();
const { register, isLoading, error, clearError } = useAuth();

const name = ref('');
const email = ref('');
const password = ref('');
const showPassword = ref(false);

async function handleRegister() {
  clearError();
  const success = await register({
    name: name.value,
    email: email.value,
    password: password.value,
  });
  if (success) {
    router.replace('/onboarding');
  }
}
</script>

<style scoped>
.register-content {
  --background: var(--dd-bg);
}

.register-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  padding: 32px 24px;
  position: relative;
  overflow: hidden;
}

.brand-section {
  text-align: center;
  margin-bottom: 40px;
  z-index: 1;
}

.logo-icon {
  width: 64px;
  height: 64px;
  border-radius: 20px;
  background: var(--dd-gradient-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 16px;
  font-size: 32px;
  box-shadow: 0 8px 32px rgba(108, 92, 231, 0.3);
}

.page-title {
  font-size: 28px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0;
}

.page-subtitle {
  font-size: 15px;
  color: var(--dd-text-secondary);
  margin: 8px 0 0;
}

.form-section {
  width: 100%;
  max-width: 360px;
  z-index: 1;
}

.input-group { margin-bottom: 16px; }

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

.primary-button:active { transform: scale(0.98); }
.primary-button.loading { opacity: 0.8; }

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

.decorative-circle {
  position: absolute;
  border-radius: 50%;
  opacity: 0.06;
}

.circle-1 {
  width: 250px;
  height: 250px;
  background: var(--ion-color-secondary);
  top: -80px;
  left: -60px;
}

.circle-2 {
  width: 200px;
  height: 200px;
  background: var(--ion-color-tertiary);
  bottom: -40px;
  right: -60px;
}
</style>
