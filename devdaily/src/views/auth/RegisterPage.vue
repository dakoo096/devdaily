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

          <!-- Social Divider -->
          <div class="social-divider">
            <span class="divider-line"></span>
            <span class="divider-text">o continuar con</span>
            <span class="divider-line"></span>
          </div>

          <!-- Social Buttons -->
          <div class="social-buttons-container">
            <button class="social-button google-btn" @click="handleSocialRegister('google')">
              <ion-icon :icon="logoGoogle" class="social-icon" />
              <span>Google</span>
            </button>
            <button class="social-button facebook-btn" @click="handleSocialRegister('facebook')">
              <ion-icon :icon="logoFacebook" class="social-icon" />
              <span>Facebook</span>
            </button>
          </div>

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
import { IonPage, IonContent, IonIcon, IonSpinner, toastController } from '@ionic/vue';
import {
  personOutline, mailOutline, lockClosedOutline, eyeOutline, eyeOffOutline,
  alertCircleOutline, logoGoogle, logoFacebook,
} from 'ionicons/icons';
import { useAuth } from '@/composables/useAuth';
import { useAuthStore } from '@/stores/authStore';
import { socialAuth } from '@/services/socialAuth';

const router = useRouter();
const authStore = useAuthStore();
const { register, socialLogin, isLoading, error, clearError } = useAuth();

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
    const toast = await toastController.create({
      message: '¡Cuenta creada con éxito! Bienvenido.',
      duration: 2000,
      color: 'success',
      position: 'bottom'
    });
    await toast.present();
    
    router.replace('/onboarding');
  }
}

async function handleSocialRegister(provider: string) {
  clearError();

  const onSuccess = async (socialData: any) => {
    const success = await socialLogin(socialData);
    if (success) {
      const toast = await toastController.create({
        message: `¡Sesión iniciada con ${provider === 'google' ? 'Google' : 'Facebook'}!`,
        duration: 2000,
        color: 'success',
        position: 'bottom'
      });
      await toast.present();
      
      if (authStore.onboardingCompleted) {
        router.replace('/tabs/home');
      } else {
        router.replace('/onboarding');
      }
    }
  };

  const onError = (err: any) => {
    error.value = err.message || 'Error al iniciar sesión con cuenta social';
  };

  if (provider === 'google') {
    await socialAuth.signInWithGoogle(onSuccess, onError);
  } else {
    await socialAuth.signInWithFacebook(onSuccess, onError);
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

/* Social Buttons */
.social-divider {
  display: flex;
  align-items: center;
  margin: 20px 0;
  color: var(--dd-text-secondary);
  font-size: 13px;
  opacity: 0.8;
}

.divider-line {
  flex: 1;
  height: 1px;
  background: var(--dd-border);
}

.divider-text {
  padding: 0 12px;
  font-weight: 500;
  text-transform: lowercase;
}

.social-buttons-container {
  display: flex;
  gap: 12px;
  margin-bottom: 8px;
}

.social-button {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  padding: 12px;
  border-radius: var(--dd-radius-sm);
  font-size: 14px;
  font-weight: 600;
  font-family: inherit;
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  border: 1px solid var(--dd-border);
}

.social-button:active {
  transform: scale(0.97);
}

.google-btn {
  background: var(--dd-surface);
  color: var(--dd-text);
}

.google-btn:hover {
  background: var(--dd-surface-hover);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.facebook-btn {
  background: #1877F2;
  color: #fff;
  border-color: #1877F2;
}

.facebook-btn:hover {
  background: #166FE5;
  box-shadow: 0 4px 12px rgba(24, 119, 242, 0.3);
}

.social-icon {
  font-size: 20px;
}
</style>
