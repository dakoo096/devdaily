<template>
  <ion-page>
    <ion-content :fullscreen="true" class="profile-content">
      <div class="profile-container">
        <h1 class="page-main-title animate-fade-in-up">Perfil</h1>
        <!-- User Card -->
        <div class="user-card animate-fade-in-up">
          <div class="user-avatar">
            <span>{{ userInitials }}</span>
          </div>
          <h2 class="user-name">{{ authStore.user?.name || 'Developer' }}</h2>
          <p class="user-email">{{ authStore.user?.email || '' }}</p>

          <!-- Developer level badge and XP bar -->
          <div class="level-container">
            <div class="level-badge">Developer Lv. {{ stats.level }}</div>
            <div class="xp-bar-container">
              <div class="xp-bar-fill" :style="{ width: `${xpProgressPercent}%` }"></div>
            </div>
            <div class="xp-text">{{ xpInCurrentLevel }} / 100 XP</div>
          </div>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid animate-fade-in-up stagger-1">
          <div class="stat-card">
            <span class="stat-value">{{ stats.contentsRead }}</span>
            <span class="stat-label">Leídos</span>
          </div>
          <div class="stat-card">
            <span class="stat-value">{{ stats.quizzesCompleted }}</span>
            <span class="stat-label">Quizzes</span>
          </div>
          <div class="stat-card">
            <span class="stat-value">{{ stats.accuracy }}%</span>
            <span class="stat-label">Precisión</span>
          </div>
          <div class="stat-card">
            <span class="stat-value">🔥 {{ stats.longestStreak }}</span>
            <span class="stat-label">Racha Máx</span>
          </div>
        </div>

        <!-- Achievements Section -->
        <div class="achievements-section animate-fade-in-up stagger-2">
          <h3 class="section-title">Logros</h3>
          <div class="achievements-list">
            <div v-for="ach in achievements.slice(0, 3)" :key="ach.keyName" class="achievement-card"
              :class="{ locked: !ach.unlocked }">
              <div class="achievement-icon">
                {{ getAchievementEmoji(ach.keyName) }}
              </div>
              <div class="achievement-info">
                <div class="achievement-title-row">
                  <span class="achievement-name">{{ ach.title }}</span>
                  <span v-if="ach.unlocked" class="achievement-date">🔓 Desbloqueado</span>
                </div>
                <p class="achievement-desc">{{ ach.description }}</p>
                <div class="achievement-reward">
                  <span class="reward-xp">+{{ ach.xpReward }} Dev XP</span>
                </div>
              </div>
            </div>
          </div>

          <div v-if="achievements.length > 3" class="see-all-achievements-container">
            <button class="see-all-btn" @click="showAllAchievementsModal = true">
              <span>Ver todos los logros ({{ achievements.length }})</span>
              <ion-icon :icon="chevronForward" />
            </button>
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
            <ion-toggle :checked="darkMode.isDark.value" style="pointer-events: none;" />
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

      <!-- All Achievements Modal -->
      <ion-modal :is-open="showAllAchievementsModal" @didDismiss="showAllAchievementsModal = false"
        class="achievements-modal">
        <ion-header>
          <ion-toolbar class="modal-toolbar">
            <ion-title class="modal-title">Todos los Logros</ion-title>
            <ion-buttons slot="end">
              <button class="modal-close-btn" @click="showAllAchievementsModal = false">Cerrar</button>
            </ion-buttons>
          </ion-toolbar>
        </ion-header>
        <ion-content class="ion-padding modal-content">
          <div class="modal-achievements-list">
            <div v-for="ach in achievements" :key="ach.keyName" class="achievement-card"
              :class="{ locked: !ach.unlocked }">
              <div class="achievement-icon">
                {{ getAchievementEmoji(ach.keyName) }}
              </div>
              <div class="achievement-info">
                <div class="achievement-title-row">
                  <span class="achievement-name">{{ ach.title }}</span>
                  <span v-if="ach.unlocked" class="achievement-date">🔓 Desbloqueado</span>
                </div>
                <p class="achievement-desc">{{ ach.description }}</p>
                <div class="achievement-reward">
                  <span class="reward-xp">+{{ ach.xpReward }} Dev XP</span>
                </div>
              </div>
            </div>
          </div>
        </ion-content>
      </ion-modal>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { useRouter } from 'vue-router';
import {
  IonPage, IonHeader, IonToolbar, IonTitle, IonContent,
  IonIcon, IonToggle, toastController, IonModal, IonButtons,
  onIonViewWillEnter
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
import { api } from '@/services/api';

const router = useRouter();
const authStore = useAuthStore();
const settingsStore = useSettingsStore();
const favoritesStore = useFavoritesStore();
const historyStore = useHistoryStore();
const darkMode = useDarkMode();

const showAllAchievementsModal = ref(false);

const stats = ref<any>({
  daysActive: 0,
  favorites: 0,
  contentsRead: 0,
  quizzesCompleted: 0,
  accuracy: 0,
  longestStreak: 0,
  level: 1,
  xp: 0
});

const achievements = ref<any[]>([]);

const xpInCurrentLevel = computed(() => {
  return stats.value.xp % 100;
});

const xpProgressPercent = computed(() => {
  return stats.value.xp % 100;
});

async function loadProfileData() {
  try {
    const [statsData, achievementsData] = await Promise.all([
      api.get<any>('/api/users/stats'),
      api.get<any[]>('/api/users/achievements')
    ]);
    stats.value = statsData;
    achievements.value = achievementsData;
  } catch (e) {
    console.error('Error loading profile data', e);
  }
}

function getAchievementEmoji(keyName: string): string {
  switch (keyName) {
    case 'FIRST_READ': return '🚀';
    case 'STREAK_3': return '🔥';
    case 'STREAK_7': return '👑';
    case 'QUIZ_10': return '🧠';
    case 'TECH_JAVA': return '☕';
    case 'TECH_DOCKER': return '🐳';
    default: return '🏆';
  }
}

onIonViewWillEnter(() => {
  historyStore.fetchHistory();
  settingsStore.fetchSettingsFromServer();
  favoritesStore.fetchFavorites();
  loadProfileData();
});

const userInitials = computed(() => {
  const name = authStore.user?.name || 'D';
  return name.split(' ').map(n => n[0]).join('').toUpperCase().slice(0, 2);
});

async function handleLogout() {
  authStore.logout();
  settingsStore.resetPreferences();
  favoritesStore.clearAll();
  historyStore.clearHistory();

  const toast = await toastController.create({
    message: 'Sesión cerrada correctamente.',
    duration: 2000,
    color: 'medium',
    position: 'bottom'
  });
  await toast.present();

  router.replace('/login');
}
</script>

<style scoped>
.profile-content {
  --background: var(--dd-bg);
}

.page-title {
  font-weight: 700;
}

.page-title-large {
  font-weight: 800;
}

.profile-container {
  padding: 16px 16px 100px;
  padding-top: calc(env(safe-area-inset-top) + 16px);
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
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;
  margin-bottom: 24px;
}

.stat-card {
  background: var(--dd-surface);
  border-radius: var(--dd-radius-md);
  border: 1px solid var(--dd-border);
  padding: 14px 12px;
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

/* Level and XP styling */
.level-container {
  margin-top: 14px;
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  max-width: 260px;
}

.level-badge {
  font-size: 12px;
  font-weight: 700;
  color: var(--ion-color-primary);
  background: rgba(var(--ion-color-primary-rgb), 0.1);
  padding: 4px 12px;
  border-radius: var(--dd-radius-full);
  margin-bottom: 8px;
}

.xp-bar-container {
  width: 100%;
  height: 8px;
  background: var(--dd-border);
  border-radius: var(--dd-radius-full);
  overflow: hidden;
  margin-bottom: 6px;
}

.xp-bar-fill {
  height: 100%;
  background: var(--dd-gradient-primary);
  border-radius: var(--dd-radius-full);
  transition: width 0.4s ease;
}

.xp-text {
  font-size: 11px;
  font-weight: 600;
  color: var(--dd-text-secondary);
}

/* Achievements */
.achievements-section {
  margin-bottom: 24px;
}

.achievements-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.achievement-card {
  display: flex;
  align-items: flex-start;
  gap: 14px;
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md);
  padding: 16px;
  transition: all 0.25s ease;
}

.achievement-card.locked {
  opacity: 0.65;
  filter: grayscale(0.5);
  border-color: rgba(var(--dd-border-rgb), 0.5);
}

.achievement-icon {
  font-size: 32px;
  line-height: 1;
  padding: 8px;
  background: rgba(var(--dd-border-rgb), 0.1);
  border-radius: var(--dd-radius-sm);
  display: flex;
  align-items: center;
  justify-content: center;
}

.achievement-card:not(.locked) .achievement-icon {
  background: rgba(var(--ion-color-primary-rgb), 0.08);
}

.achievement-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.achievement-title-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.achievement-name {
  font-size: 15px;
  font-weight: 700;
  color: var(--dd-text);
}

.achievement-date {
  font-size: 11px;
  font-weight: 700;
  color: var(--ion-color-success);
  background: rgba(45, 211, 111, 0.08);
  padding: 2px 6px;
  border-radius: 4px;
}

.achievement-desc {
  font-size: 12px;
  color: var(--dd-text-secondary);
  margin: 0;
  line-height: 1.4;
}

.achievement-reward {
  margin-top: 4px;
}

.reward-xp {
  font-size: 11px;
  font-weight: 700;
  color: var(--ion-color-primary);
  background: rgba(var(--ion-color-primary-rgb), 0.06);
  padding: 2px 6px;
  border-radius: 4px;
}

/* See All Achievements Button */
.see-all-achievements-container {
  margin-top: 16px;
  display: flex;
  justify-content: center;
}

.see-all-btn {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md);
  padding: 12px 18px;
  color: var(--ion-color-primary);
  font-size: 14px;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  width: 100%;
  justify-content: center;
  box-shadow: var(--dd-shadow-sm);
}

.see-all-btn:active {
  transform: scale(0.98);
  background: var(--dd-surface-hover);
}

.see-all-btn ion-icon {
  font-size: 16px;
}

/* Modal layout */
.achievements-modal {
  --background: var(--dd-bg);
  --border-color: var(--dd-border);
  --border-radius: 16px;
}

.modal-achievements-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
  padding-bottom: 24px;
}
</style>
