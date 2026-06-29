<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-back-button default-href="/tabs/profile" text="Atrás" />
        </ion-buttons>
        <ion-title>Editar Perfil</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true" class="edit-profile-content">
      <div class="edit-container">
        <!-- Avatar -->
        <div class="avatar-section animate-fade-in-up">
          <div class="edit-avatar">
            <span>{{ userInitials }}</span>
          </div>
        </div>

        <!-- Form -->
        <div class="form-section animate-fade-in-up stagger-1">
          <div class="input-group">
            <label class="input-label">Nombre</label>
            <div class="input-wrapper">
              <input v-model="name" type="text" class="app-input" placeholder="Tu nombre" />
            </div>
          </div>

          <div class="input-group">
            <label class="input-label">Email</label>
            <div class="input-wrapper">
              <input v-model="email" type="email" class="app-input" placeholder="tu@email.com" />
            </div>
          </div>

          <button class="save-button" @click="handleSave" :disabled="!hasChanges">
            Guardar Cambios
          </button>

          <div v-if="saved" class="success-message animate-fade-in">
            <span>✅ Perfil actualizado correctamente</span>
          </div>
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton } from '@ionic/vue';
import { useAuthStore } from '@/stores/authStore';

const authStore = useAuthStore();

const name = ref(authStore.user?.name || '');
const email = ref(authStore.user?.email || '');
const saved = ref(false);

const userInitials = computed(() => {
  const n = name.value || 'D';
  return n.split(' ').map((w: string) => w[0]).join('').toUpperCase().slice(0, 2);
});

const hasChanges = computed(() =>
  name.value !== authStore.user?.name || email.value !== authStore.user?.email
);

async function handleSave() {
  if (name.value && email.value) {
    const success = await authStore.updateProfile(name.value, email.value);
    if (success) {
      saved.value = true;
      setTimeout(() => { saved.value = false; }, 3000);
    }
  }
}
</script>

<style scoped>
.edit-profile-content {
  --background: var(--dd-bg);
}

.edit-container {
  padding: 24px 16px;
}

.avatar-section {
  text-align: center;
  margin-bottom: 32px;
}

.edit-avatar {
  width: 96px;
  height: 96px;
  border-radius: 50%;
  background: var(--dd-gradient-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto;
  font-size: 36px;
  font-weight: 800;
  color: #fff;
  box-shadow: 0 8px 24px rgba(108, 92, 231, 0.3);
}

.form-section {
  max-width: 400px;
  margin: 0 auto;
}

.input-group {
  margin-bottom: 20px;
}

.input-label {
  display: block;
  font-size: 13px;
  font-weight: 600;
  color: var(--dd-text-secondary);
  margin-bottom: 8px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.input-wrapper {
  background: var(--dd-surface);
  border: 2px solid var(--dd-border);
  border-radius: var(--dd-radius-sm);
  transition: all 0.3s ease;
}

.input-wrapper:focus-within {
  border-color: var(--ion-color-primary);
  box-shadow: 0 0 0 4px rgba(var(--ion-color-primary-rgb), 0.1);
}

.app-input {
  width: 100%;
  border: none;
  background: none;
  padding: 14px 16px;
  font-size: 15px;
  color: var(--dd-text);
  outline: none;
  font-family: inherit;
  box-sizing: border-box;
}

.save-button {
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
  box-shadow: 0 4px 16px rgba(108, 92, 231, 0.3);
  margin-top: 8px;
}

.save-button:disabled {
  opacity: 0.4;
  cursor: not-allowed;
  box-shadow: none;
}

.save-button:active:not(:disabled) {
  transform: scale(0.98);
}

.success-message {
  text-align: center;
  margin-top: 16px;
  padding: 12px;
  background: rgba(var(--ion-color-success-rgb), 0.1);
  border-radius: var(--dd-radius-sm);
  color: var(--ion-color-success);
  font-size: 14px;
  font-weight: 500;
}
</style>
