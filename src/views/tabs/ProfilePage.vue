<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-title class="page-title">Perfil</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true" class="profile-content">
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large" class="page-title-large">Perfil</ion-title>
        </ion-toolbar>
      </ion-header>

      <div class="profile-container">
        <!-- User Card -->
        <div class="user-card animate-fade-in-up">
          <div class="user-avatar">
            <span>{{ userInitials }}</span>
          </div>
          <h2 class="user-name">{{ authStore.user?.name || 'Developer' }}</h2>
          <p class="user-email">{{ authStore.user?.email || '' }}</p>
        </div>

        <!-- Stats -->
        <div class="stats-grid animate-fade-in-up stagger-1">
          <div class="stat-card">
            <span class="stat-value">{{ historyStore.daysActive }}</span>
            <span class="stat-label">Días activos</span>
          </div>
          <div class="stat-card">
            <span class="stat-value">{{ favoritesStore.count }}</span>
            <span class="stat-label">Favoritos</span>
          </div>
          <div class="stat-card">
            <span class="stat-value">{{ historyStore.totalViewed }}</span>
            <span class="stat-label">Vistos</span>
          </div>
        </div>

        <!-- Settings List -->
        <div class="settings-section animate-fade-in-up stagger-2">
          <h3 class="section-title">Configuración</h3>

          <!-- Dark Mode -->
          <div class="setting-item" @click="darkMode.toggle()">
            <div class="setting-left">
              <div class="setting-icon-wrap" style="background: linear-gradient(135deg, #2D3436, #636E72);">
                <ion-icon :icon="moonOutline" />
              </div>
              <span class="setting-label">Modo oscuro</span>
            </div>
            <ion-toggle
              :checked="darkMode.isDark.value"
              @ionChange="darkMode.toggle()"
            />
          </div>

          <!-- Notifications -->
          <div class="setting-item" @click="router.push('/settings/notifications')">
            <div class="setting-left">
              <div class="setting-icon-wrap" style="background: linear-gradient(135deg, #E17055, #FDCB6E);">
                <ion-icon :icon="notificationsOutline" />
              </div>
              <span class="setting-label">Notificaciones</span>
            </div>
            <ion-icon :icon="chevronForward" class="setting-arrow" />
          </div>

          <!-- Edit Preferences -->
          <div class="setting-item" @click="router.push('/onboarding')">
            <div class="setting-left">
              <div class="setting-icon-wrap" style="background: var(--dd-gradient-primary);">
                <ion-icon :icon="optionsOutline" />
              </div>
              <span class="setting-label">Editar preferencias</span>
            </div>
            <ion-icon :icon="chevronForward" class="setting-arrow" />
          </div>

          <!-- Edit Profile -->
          <div class="setting-item" @click="router.push('/settings/profile')">
            <div class="setting-left">
              <div class="setting-icon-wrap" style="background: var(--dd-gradient-turquoise);">
                <ion-icon :icon="createOutline" />
              </div>
              <span class="setting-label">Editar perfil</span>
            </div>
            <ion-icon :icon="chevronForward" class="setting-arrow" />
          </div>
        </div>

        <!-- Logout -->
        <div class="logout-section animate-fade-in-up stagger-3">
          <button class="logout-button" @click="handleLogout">
            <ion-icon :icon="logOutOutline" />
            <span>Cerrar Sesión</span>
          </button>
        </div>

        <!-- App Version -->
        <p class="app-version">DevDaily v1.0.0</p>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import {
  IonPage, IonHeader, IonToolbar, IonTitle, IonContent,
  IonIcon, IonToggle,
} from '@ionic/vue';
import {
  moonOutline, notificationsOutline, optionsOutline,
  createOutline, logOutOutline, chevronForward,
} from 'ionicons/icons';
import { useAuthStore } from '@/stores/authStore';
import { useSettingsStore } from '@/stores/settingsStore';
import { useFavoritesStore } from '@/stores/favoritesStore';
import { useHistoryStore } from '@/stores/historyStore';
import { useDarkMode } from '@/composables/useDarkMode';

const router = useRouter();
const authStore = useAuthStore();
const settingsStore = useSettingsStore();
const favoritesStore = useFavoritesStore();
const historyStore = useHistoryStore();
const darkMode = useDarkMode();

onMounted(() => {
  historyStore.fetchHistory();
  settingsStore.fetchSettingsFromServer();
  favoritesStore.fetchFavorites();
});

const userInitials = computed(() => {
  const name = authStore.user?.name || 'D';
  return name.split(' ').map(n => n[0]).join('').toUpperCase().slice(0, 2);
});

function handleLogout() {
  authStore.logout();
  settingsStore.resetPreferences();
  favoritesStore.clearAll();
  historyStore.clearHistory();
  router.replace('/login');
}
</script>

<style scoped>
.profile-content {
  --background: var(--dd-bg);
}

.page-title { font-weight: 700; }
.page-title-large { font-weight: 800; }

.profile-container {
  padding: 0 16px 100px;
}

/* User Card */
.user-card {
  text-align: center;
  padding: 28px 20px;
  background: var(--dd-surface);
  border-radius: var(--dd-radius-lg);
  border: 1px solid var(--dd-border);
  box-shadow: var(--dd-shadow-sm);
  margin-bottom: 20px;
}

.user-avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: var(--dd-gradient-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 16px;
  font-size: 28px;
  font-weight: 800;
  color: #fff;
  box-shadow: 0 4px 16px rgba(108, 92, 231, 0.3);
}

.user-name {
  font-size: 22px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0 0 4px;
}

.user-email {
  font-size: 14px;
  color: var(--dd-text-secondary);
  margin: 0;
}

/* Stats */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
  margin-bottom: 24px;
}

.stat-card {
  background: var(--dd-surface);
  border-radius: var(--dd-radius-md);
  border: 1px solid var(--dd-border);
  padding: 16px 12px;
  text-align: center;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.stat-value {
  font-size: 28px;
  font-weight: 800;
  color: var(--ion-color-primary);
}

.stat-label {
  font-size: 12px;
  color: var(--dd-text-secondary);
  font-weight: 500;
}

/* Settings */
.section-title {
  font-size: 13px;
  font-weight: 700;
  color: var(--dd-text-secondary);
  text-transform: uppercase;
  letter-spacing: 1px;
  margin: 0 0 12px;
  padding-left: 4px;
}

.setting-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 14px 16px;
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md);
  margin-bottom: 8px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.setting-item:active {
  transform: scale(0.98);
  background: var(--dd-surface-hover);
}

.setting-left {
  display: flex;
  align-items: center;
  gap: 14px;
}

.setting-icon-wrap {
  width: 36px;
  height: 36px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 18px;
}

.setting-label {
  font-size: 15px;
  font-weight: 600;
  color: var(--dd-text);
}

.setting-arrow {
  font-size: 18px;
  color: var(--dd-text-secondary);
}

/* Logout */
.logout-section {
  margin-top: 24px;
}

.logout-button {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  padding: 16px;
  background: none;
  border: 2px solid var(--ion-color-danger);
  border-radius: var(--dd-radius-md);
  color: var(--ion-color-danger);
  font-size: 15px;
  font-weight: 600;
  font-family: inherit;
  cursor: pointer;
  transition: all 0.2s ease;
}

.logout-button:active {
  background: rgba(var(--ion-color-danger-rgb), 0.08);
  transform: scale(0.98);
}

.logout-button ion-icon {
  font-size: 20px;
}

/* Version */
.app-version {
  text-align: center;
  font-size: 12px;
  color: var(--dd-text-secondary);
  margin-top: 24px;
  opacity: 0.6;
}
</style>
