<template>
  <ion-page>
    <ion-content :fullscreen="true" class="profile-content">
      <div class="profile-container">
        <h1 class="page-main-title animate-fade-in-up">Perfil</h1>

        <div class="profile-grid">
          
          <!-- Left Column (User Card & Settings) -->
          <div class="profile-side-column">
            <!-- User Card -->
            <div class="user-card animate-fade-in-up">
              <div class="user-avatar">
                <span>{{ userInitials }}</span>
              </div>
              <h2 class="user-name">{{ authStore.user?.name || 'Developer' }}</h2>
              <p class="user-email">{{ authStore.user?.email || '' }}</p>

              <!-- Developer level badge and XP bar -->
              <div class="level-container">
                <div class="level-badge">Developer Lv. {{ displayLevel }}</div>
                <div class="xp-bar-container">
                  <div class="xp-bar-fill" :style="{ width: `${xpProgressPercent}%` }"></div>
                </div>
                <div class="xp-text">{{ xpInCurrentLevel }} / 100 XP</div>
              </div>
            </div>

            <!-- Settings List -->
            <div class="settings-section animate-fade-in-up stagger-1">
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
            <div class="logout-section animate-fade-in-up stagger-2">
              <button class="logout-button" @click="handleLogout">
                <ion-icon :icon="logOutOutline" />
                <span>Cerrar Sesión</span>
              </button>
            </div>

            <!-- App Version -->
            <p class="app-version">DevDaily v1.0.0</p>
          </div>

          <!-- Right Column (Stats Grid & Achievements) -->
          <div class="profile-main-column">
            <!-- Stats Grid -->
            <div class="stats-grid animate-fade-in-up">
              <div class="stat-card">
                <span class="stat-value">{{ contentsReadCount }}</span>
                <span class="stat-label">Leídos</span>
              </div>
              <div class="stat-card">
                <span class="stat-value">{{ favoritesCount }}</span>
                <span class="stat-label">Favoritos</span>
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
              <div class="stat-card">
                <span class="stat-value">{{ daysActiveCount }}</span>
                <span class="stat-label">Días activos</span>
              </div>
            </div>

            <!-- Achievements Section -->
            <div class="achievements-section animate-fade-in-up stagger-1">
              <h3 class="section-title">Logros</h3>
              <div class="achievements-list">
                <div v-for="ach in achievements.slice(0, 4)" :key="ach.keyName" class="achievement-card"
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

              <div v-if="achievements.length > 4" class="see-all-achievements-container">
                <button class="see-all-btn" @click="showAllAchievementsModal = true">
                  <span>Ver todos los logros ({{ achievements.length }})</span>
                  <ion-icon :icon="chevronForward" />
                </button>
              </div>
            </div>
          </div>

        </div>

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
import { ref, computed, onMounted } from 'vue';
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
import { useSearchStore } from '@/stores/searchStore';
import { useLayout } from '@/composables/useLayout';
import { useDarkMode } from '@/composables/useDarkMode';
import { api } from '@/services/api';

const router = useRouter();
const authStore = useAuthStore();
const settingsStore = useSettingsStore();
const favoritesStore = useFavoritesStore();
const historyStore = useHistoryStore();
const searchStore = useSearchStore();
useLayout();
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

const displayLevel = computed(() => {
  return authStore.user?.devLevel || stats.value.level || 1;
});

const xpInCurrentLevel = computed(() => {
  const xp = authStore.user?.devXp !== undefined ? authStore.user.devXp : (stats.value.xp || 0);
  return xp % 100;
});

const xpProgressPercent = computed(() => {
  const xp = authStore.user?.devXp !== undefined ? authStore.user.devXp : (stats.value.xp || 0);
  return xp % 100;
});

const contentsReadCount = computed(() => {
  return stats.value.contentsRead || historyStore.entries.reduce((acc, entry) => acc + entry.items.length, 0) || historyStore.totalViewed;
});

const favoritesCount = computed(() => {
  return stats.value.favorites || favoritesStore.count;
});

const daysActiveCount = computed(() => {
  return stats.value.daysActive || historyStore.daysActive;
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
  searchStore.clear(); // Clear search box when moving into Profile page
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
  searchStore.clear();

  const toast = await toastController.create({
    message: 'Sesión cerrada correctamente.',
    duration: 2000,
    color: 'medium',
    position: 'bottom'
  });
  await toast.present();

  router.replace('/login');
}

onMounted(() => {
  loadProfileData();
});
</script>

<style scoped>
.profile-content {
  --background: var(--dd-bg);
}

.page-main-title {
  font-size: 28px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0 16px 24px;
  line-height: 1.2;
}

.profile-container {
  padding: 16px 16px 100px;
  padding-top: calc(env(safe-area-inset-top) + 16px);
}

/* User Card */
.user-card {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-lg);
  padding: 24px;
  text-align: center;
  margin-bottom: 24px;
  box-shadow: var(--dd-shadow-sm);
  position: relative;
  overflow: hidden;
}

.user-avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: var(--dd-gradient-primary);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 16px;
  font-size: 28px;
  font-weight: 800;
  box-shadow: 0 8px 24px rgba(108, 92, 231, 0.25);
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
  margin: 0 0 20px;
}

.level-container {
  border-top: 1px solid var(--dd-border);
  padding-top: 20px;
}

.level-badge {
  display: inline-block;
  font-size: 12px;
  font-weight: 800;
  color: var(--ion-color-primary);
  background: rgba(var(--ion-color-primary-rgb), 0.1);
  padding: 6px 14px;
  border-radius: var(--dd-radius-full);
  margin-bottom: 12px;
}

.xp-bar-container {
  width: 100%;
  height: 8px;
  background: var(--dd-bg);
  border-radius: var(--dd-radius-full);
  overflow: hidden;
  margin-bottom: 8px;
}

.xp-bar-fill {
  height: 100%;
  background: var(--dd-gradient-primary);
  border-radius: var(--dd-radius-full);
  transition: width 0.5s ease;
}

.xp-text {
  font-size: 13px;
  font-weight: 600;
  color: var(--dd-text-secondary);
}

/* Stats Grid */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
  margin-bottom: 24px;
}

.stat-card {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md);
  padding: 16px;
  text-align: center;
  box-shadow: var(--dd-shadow-sm);
  display: flex;
  flex-direction: column;
  justify-content: center;
  transition: transform 0.2s ease;
}

.stat-card:hover {
  transform: translateY(-2px);
  border-color: var(--ion-color-primary);
}

.stat-value {
  font-size: 20px;
  font-weight: 800;
  color: var(--dd-text);
  line-height: 1.2;
}

.stat-label {
  font-size: 11px;
  font-weight: 600;
  color: var(--dd-text-secondary);
  text-transform: uppercase;
  margin-top: 4px;
  letter-spacing: 0.5px;
}

/* Achievements */
.achievements-section {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-lg);
  padding: 24px;
  margin-bottom: 24px;
  box-shadow: var(--dd-shadow-sm);
}

.section-title {
  font-size: 18px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0 0 20px;
  letter-spacing: -0.2px;
}

.achievements-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.achievement-card {
  display: flex;
  gap: 16px;
  background: var(--dd-bg);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md);
  padding: 16px;
  transition: all 0.2s ease;
}

.achievement-card:hover {
  border-color: var(--ion-color-primary);
}

.achievement-card.locked {
  opacity: 0.6;
}

.achievement-icon {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  flex-shrink: 0;
}

.achievement-info {
  flex: 1;
  min-width: 0;
}

.achievement-title-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 4px;
  flex-wrap: wrap;
  gap: 4px;
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
}

.achievement-desc {
  font-size: 13px;
  color: var(--dd-text-secondary);
  margin: 0 0 8px;
  line-height: 1.4;
}

.achievement-reward {
  display: flex;
}

.reward-xp {
  font-size: 11px;
  font-weight: 700;
  color: var(--ion-color-primary);
  background: rgba(var(--ion-color-primary-rgb), 0.1);
  padding: 2px 8px;
  border-radius: 4px;
}

.see-all-achievements-container {
  margin-top: 16px;
  display: flex;
  justify-content: center;
}

.see-all-btn {
  background: transparent;
  border: none;
  color: var(--ion-color-primary);
  font-size: 14px;
  font-weight: 700;
  display: flex;
  align-items: center;
  gap: 4px;
  cursor: pointer;
  padding: 8px 16px;
  border-radius: var(--dd-radius-sm);
  transition: background 0.2s ease;
}

.see-all-btn:hover {
  background: rgba(var(--ion-color-primary-rgb), 0.08);
}

/* Settings */
.settings-section {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-lg);
  padding: 24px;
  margin-bottom: 24px;
  box-shadow: var(--dd-shadow-sm);
}

.setting-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 14px 0;
  border-bottom: 1px solid var(--dd-border);
  cursor: pointer;
  transition: padding-left 0.2s ease;
}

.setting-item:last-child {
  border-bottom: none;
  padding-bottom: 0;
}

.setting-item:first-of-type {
  padding-top: 0;
}

.setting-item:hover {
  padding-left: 4px;
}

.setting-left {
  display: flex;
  align-items: center;
  gap: 14px;
}

.setting-icon-wrap {
  width: 36px;
  height: 36px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 18px;
}

.setting-label {
  font-size: 14px;
  font-weight: 700;
  color: var(--dd-text);
}

.setting-arrow {
  font-size: 18px;
  color: var(--dd-text-secondary);
}

/* Logout */
.logout-section {
  margin-bottom: 24px;
}

.logout-button {
  width: 100%;
  padding: 16px;
  background: transparent;
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md);
  color: #ff7675;
  font-size: 15px;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.logout-button:hover {
  background: rgba(255, 118, 117, 0.08);
  border-color: #ff7675;
}

.logout-button ion-icon {
  font-size: 20px;
}

.app-version {
  text-align: center;
  font-size: 12px;
  color: var(--dd-text-secondary);
  opacity: 0.8;
  margin: 0;
}

/* Achievements Modal */
.achievements-modal {
  --background: var(--dd-bg);
}

.modal-toolbar {
  --background: var(--dd-surface);
  --border-color: var(--dd-border);
}

.modal-title {
  color: var(--dd-text);
  font-weight: 800;
}

.modal-close-btn {
  background: transparent;
  border: none;
  color: var(--ion-color-primary);
  font-weight: 700;
  font-size: 14px;
}

.modal-content {
  --background: var(--dd-bg);
}

.modal-achievements-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
  padding: 8px 0;
}

/* DESKTOP STYLING (>=1024px) */
@media (min-width: 1024px) {
  .profile-container {
    padding: 0;
  }
  
  .page-main-title {
    display: none;
  }

  .profile-grid {
    display: grid;
    grid-template-columns: minmax(0, 1fr) minmax(0, 1.6fr);
    gap: 32px;
    align-items: start;
    padding-bottom: 60px;
  }
  
  .profile-side-column {
    display: flex;
    flex-direction: column;
    gap: 24px;
  }
  
  .profile-main-column {
    display: flex;
    flex-direction: column;
    gap: 24px;
  }
  
  .user-card {
    margin-bottom: 0;
  }
  
  .settings-section {
    margin-bottom: 0;
  }
  
  .logout-section {
    margin-bottom: 0;
  }
}
</style>
