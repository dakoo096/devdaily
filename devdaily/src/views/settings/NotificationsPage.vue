<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-back-button default-href="/app/profile" text="Atrás" />
        </ion-buttons>
        <ion-title>Notificaciones</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true" class="notifications-content">
      <div class="notif-container">
        <!-- Enable Toggle -->
        <div class="notif-card animate-fade-in-up">
          <div class="notif-header">
            <div class="notif-icon">🔔</div>
            <div class="notif-info">
              <h3>Notificaciones diarias</h3>
              <p>Recibe tu contenido cada día</p>
            </div>
            <ion-toggle
              :checked="settingsStore.preferences.notificationsEnabled"
              @ionChange="settingsStore.toggleNotifications()"
            />
          </div>
        </div>

        <!-- Time Picker -->
        <div
          v-if="settingsStore.preferences.notificationsEnabled"
          class="notif-card animate-fade-in-up stagger-1"
        >
          <div class="time-section">
            <h3 class="time-title">Hora preferida</h3>
            <p class="time-subtitle">¿Cuándo quieres recibir tu contenido?</p>
            <div class="time-picker">
              <input
                type="time"
                :value="settingsStore.preferences.notificationTime"
                @change="(e: Event) => settingsStore.setNotificationTime((e.target as HTMLInputElement).value)"
                class="time-input"
              />
            </div>
          </div>
        </div>

        <!-- Preview -->
        <div
          v-if="settingsStore.preferences.notificationsEnabled"
          class="notif-card preview-card animate-fade-in-up stagger-2"
        >
          <h3 class="preview-title">Vista previa</h3>
          <div class="notif-preview">
            <div class="preview-header">
              <span class="preview-app">⚡ DevDaily</span>
              <span class="preview-time">{{ settingsStore.preferences.notificationTime }}</span>
            </div>
            <p class="preview-text">
              ¡Buenos días! 🌅 Tu contenido diario está listo. Hoy tienes {{ settingsStore.preferences.contentTypes.length }} tipos de contenido esperándote.
            </p>
          </div>
        </div>

        <!-- Disabled State -->
        <div v-if="!settingsStore.preferences.notificationsEnabled" class="disabled-info animate-fade-in-up stagger-1">
          <p class="disabled-text">
            Activa las notificaciones para no perderte tu contenido diario personalizado.
          </p>
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import {
  IonPage, IonHeader, IonToolbar, IonTitle, IonContent,
  IonButtons, IonBackButton, IonToggle,
} from '@ionic/vue';
import { useSettingsStore } from '@/stores/settingsStore';

const settingsStore = useSettingsStore();
</script>

<style scoped>
.notifications-content {
  --background: var(--dd-bg);
}

.notif-container {
  padding: 20px 16px;
}

.notif-card {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md);
  padding: 20px;
  margin-bottom: 16px;
}

.notif-header {
  display: flex;
  align-items: center;
  gap: 14px;
}

.notif-icon {
  font-size: 32px;
}

.notif-info {
  flex: 1;
}

.notif-info h3 {
  font-size: 16px;
  font-weight: 700;
  color: var(--dd-text);
  margin: 0 0 2px;
}

.notif-info p {
  font-size: 13px;
  color: var(--dd-text-secondary);
  margin: 0;
}

/* Time Picker */
.time-title {
  font-size: 16px;
  font-weight: 700;
  color: var(--dd-text);
  margin: 0 0 4px;
}

.time-subtitle {
  font-size: 13px;
  color: var(--dd-text-secondary);
  margin: 0 0 16px;
}

.time-input {
  width: 100%;
  padding: 14px 16px;
  border: 2px solid var(--dd-border);
  border-radius: var(--dd-radius-sm);
  background: var(--dd-bg);
  color: var(--dd-text);
  font-size: 18px;
  font-weight: 600;
  font-family: inherit;
  text-align: center;
  outline: none;
}

.time-input:focus {
  border-color: var(--ion-color-primary);
}

/* Preview */
.preview-title {
  font-size: 14px;
  font-weight: 700;
  color: var(--dd-text-secondary);
  margin: 0 0 12px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.notif-preview {
  background: var(--dd-bg);
  border-radius: var(--dd-radius-sm);
  padding: 14px 16px;
  border: 1px solid var(--dd-border);
}

.preview-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 6px;
}

.preview-app {
  font-size: 13px;
  font-weight: 700;
  color: var(--ion-color-primary);
}

.preview-time {
  font-size: 12px;
  color: var(--dd-text-secondary);
}

.preview-text {
  font-size: 14px;
  color: var(--dd-text);
  margin: 0;
  line-height: 1.5;
}

/* Disabled */
.disabled-info {
  text-align: center;
  padding: 32px;
}

.disabled-text {
  font-size: 15px;
  color: var(--dd-text-secondary);
  line-height: 1.6;
}
</style>
