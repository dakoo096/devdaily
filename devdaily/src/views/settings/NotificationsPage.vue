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
        <div class="notif-layout-grid">
          <!-- Configuration Column (Left) -->
          <div class="notif-config-column">
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
          </div>

          <!-- Preview Column (Right) -->
          <div class="notif-preview-column animate-fade-in-up stagger-2">
            <div class="notif-card preview-card">
              <h3 class="preview-title">Vista previa</h3>
              
              <!-- Enabled Mockup -->
              <div v-if="settingsStore.preferences.notificationsEnabled" class="notification-mockup-container">
                <div class="mock-notification">
                  <div class="mock-app-icon">
                    <span>⚡</span>
                  </div>
                  <div class="mock-notification-content">
                    <div class="mock-header">
                      <span class="mock-app-name">DevBloom</span>
                      <span class="mock-time">{{ settingsStore.preferences.notificationTime }}</span>
                    </div>
                    <h4 class="mock-title">¡Contenido Listo! 🧠</h4>
                    <p class="mock-body">
                      ¡Buenos días! 🌅 Tu contenido diario está listo. Hoy tienes {{ settingsStore.preferences.contentTypes.length }} tipos de contenido esperándote.
                    </p>
                  </div>
                </div>
                <p class="mockup-hint">Así es como verás la notificación push en tu dispositivo.</p>
              </div>

              <!-- Disabled Mockup -->
              <div v-else class="notification-mockup-container">
                <div class="mock-notification disabled">
                  <div class="mock-app-icon gray">
                    <span>🔕</span>
                  </div>
                  <div class="mock-notification-content">
                    <div class="mock-header">
                      <span class="mock-app-name">DevBloom</span>
                      <span class="mock-time">--:--</span>
                    </div>
                    <h4 class="mock-title">Notificaciones inactivas</h4>
                    <p class="mock-body">
                      Activa las notificaciones en el panel izquierdo para recibir tu contenido diario personalizado.
                    </p>
                  </div>
                </div>
                <p class="mockup-hint">Las notificaciones push están desactivadas actualmente.</p>
              </div>
            </div>
          </div>
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

/* Preview Layout & Mockup */
.preview-title {
  font-size: 14px;
  font-weight: 700;
  color: var(--dd-text-secondary);
  margin: 0 0 12px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.notification-mockup-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 30px 10px;
  background: radial-gradient(circle at top left, rgba(108, 92, 231, 0.06) 0%, transparent 60%);
  border-radius: var(--dd-radius-md);
  border: 1px dashed var(--dd-border);
}

.mock-notification {
  display: flex;
  gap: 12px;
  width: 100%;
  max-width: 360px;
  padding: 16px;
  border-radius: 18px;
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.06);
  transition: transform 0.3s ease;
}

:global(body.dark) .mock-notification {
  background: rgba(30, 39, 46, 0.8);
  border-color: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
}

.mock-notification:hover {
  transform: translateY(-2px);
}

.mock-app-icon {
  width: 36px;
  height: 36px;
  background: var(--dd-gradient-primary);
  border-radius: 9px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 18px;
  flex-shrink: 0;
  box-shadow: 0 4px 10px rgba(108, 92, 231, 0.2);
}

.mock-app-icon.gray {
  background: var(--dd-border);
  color: var(--dd-text-secondary);
  box-shadow: none;
}

.mock-notification.disabled {
  opacity: 0.7;
  border-style: dashed;
  background: var(--dd-bg);
}

.mock-notification-content {
  flex: 1;
  min-width: 0;
}

.mock-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 4px;
}

.mock-app-name {
  font-size: 11px;
  font-weight: 700;
  color: var(--dd-text-secondary);
  text-transform: uppercase;
  letter-spacing: 0.8px;
}

.mock-time {
  font-size: 11px;
  color: var(--dd-text-secondary);
}

.mock-title {
  font-size: 14px;
  font-weight: 700;
  color: var(--dd-text);
  margin: 0 0 2px 0;
}

.mock-body {
  font-size: 13px;
  color: var(--dd-text-secondary);
  margin: 0;
  line-height: 1.4;
  word-wrap: break-word;
}

.mockup-hint {
  font-size: 12px;
  color: var(--dd-text-secondary);
  margin: 16px 0 0 0;
  text-align: center;
  opacity: 0.8;
}

/* DESKTOP RESPONSIVE DESIGN (>= 1024px) */
@media (min-width: 1024px) {
  .notif-container {
    max-width: 960px;
    margin: 40px auto 80px;
    padding: 0;
  }

  .notif-layout-grid {
    display: grid;
    grid-template-columns: minmax(0, 1.2fr) minmax(0, 1fr);
    gap: 32px;
    align-items: start;
  }

  .notif-card {
    padding: 28px;
    margin-bottom: 0;
    box-shadow: var(--dd-shadow-sm);
  }
  
  .notif-config-column {
    display: flex;
    flex-direction: column;
    gap: 24px;
  }

  .notif-preview-column {
    display: flex;
    flex-direction: column;
  }
  
  .time-input {
    padding: 16px 20px;
    font-size: 20px;
  }

  .notification-mockup-container {
    padding: 40px 20px;
  }

  .mock-notification {
    max-width: 100%;
    padding: 20px;
  }
}
</style>
