<template>
  <aside class="desktop-sidebar-inner">
    <!-- Header Logo -->
    <div class="sidebar-header" @click="goToHome">
      <span class="logo-emoji">⚡</span>
      <span class="logo-text">DevBloom</span>
    </div>

    <!-- Navigation Section 1 -->
    <nav class="sidebar-nav">
      <router-link to="/app/home" class="nav-item" active-class="active">
        <ion-icon :icon="todayOutline" class="nav-icon" />
        <span>Hoy</span>
      </router-link>
      <router-link to="/app/favorites" class="nav-item" active-class="active">
        <ion-icon :icon="heartOutline" class="nav-icon" />
        <span>Favoritos</span>
      </router-link>
      <router-link to="/app/history" class="nav-item" active-class="active">
        <ion-icon :icon="timeOutline" class="nav-icon" />
        <span>Historial</span>
      </router-link>
      <router-link to="/app/profile" class="nav-item" active-class="active">
        <ion-icon :icon="personOutline" class="nav-icon" />
        <span>Perfil</span>
      </router-link>
    </nav>

    <div class="sidebar-divider"></div>

    <!-- Navigation Section 2 (SaaS learning references) -->
    <div class="sidebar-section-title">Aprendizaje</div>
    <nav class="sidebar-nav secondary-nav">
      <router-link to="/app/home" class="nav-item">
        <ion-icon :icon="bookOutline" class="nav-icon" />
        <span>Lecciones</span>
      </router-link>
      <a href="/#roadmap" target="_blank" rel="noopener" class="nav-item">
        <ion-icon :icon="mapOutline" class="nav-icon" />
        <span>Roadmap</span>
      </a>
      <div class="nav-item play-store-badge disabled">
        <ion-icon :icon="logoAndroid" class="nav-icon" />
        <span>Google Play</span>
        <span class="badge-tag">Próximamente</span>
      </div>
    </nav>

    <!-- Spacer to push profile to bottom -->
    <div class="sidebar-spacer"></div>

    <!-- User Profile Footer Card -->
    <div class="sidebar-footer" v-if="authStore.user">
      <div class="user-info-wrapper">
        <div class="user-avatar-small">
          <span>{{ userInitials }}</span>
        </div>
        <div class="user-detail-texts">
          <div class="user-name-text">{{ authStore.user.name }}</div>
          <div class="user-level-info">Nivel {{ displayLevel }} • {{ displayXp }} XP</div>
        </div>
      </div>
      
      <!-- Actions Row -->
      <div class="sidebar-footer-actions">
        <button class="footer-action-btn logout-btn" @click="handleLogout" title="Cerrar Sesión">
          <ion-icon :icon="logOutOutline" />
          <span>Cerrar Sesión</span>
        </button>
      </div>
    </div>
  </aside>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { IonIcon, toastController } from '@ionic/vue';
import { 
  todayOutline, heartOutline, timeOutline, personOutline, 
  bookOutline, mapOutline, logoAndroid, logOutOutline 
} from 'ionicons/icons';
import { useAuthStore } from '@/stores/authStore';
import { useSettingsStore } from '@/stores/settingsStore';
import { useFavoritesStore } from '@/stores/favoritesStore';
import { useHistoryStore } from '@/stores/historyStore';
import { api } from '@/services/api';

const router = useRouter();
const authStore = useAuthStore();
const settingsStore = useSettingsStore();
const favoritesStore = useFavoritesStore();
const historyStore = useHistoryStore();

const stats = ref({
  level: 1,
  xp: 0
});

const userInitials = computed(() => {
  const name = authStore.user?.name || 'D';
  return name.split(' ').map(n => n[0]).join('').toUpperCase().slice(0, 2);
});

const displayLevel = computed(() => {
  return authStore.user?.devLevel || stats.value.level || 1;
});

const displayXp = computed(() => {
  return authStore.user?.devXp !== undefined ? authStore.user.devXp : (stats.value.xp || 0);
});

async function loadSidebarStats() {
  try {
    const data = await api.get<any>('/api/users/stats');
    stats.value = {
      level: data.level || 1,
      xp: data.xp || 0
    };
  } catch (e) {
    console.error('Error loading sidebar user stats', e);
  }
}

function goToHome() {
  router.push('/app/home');
}

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

onMounted(() => {
  loadSidebarStats();
});
</script>

<style scoped>
.desktop-sidebar-inner {
  display: flex;
  flex-direction: column;
  height: 100%;
  padding: 24px 16px;
  background: var(--dd-surface);
  color: var(--dd-text);
  overflow-y: auto;
}

.sidebar-header {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 0 8px 24px;
  cursor: pointer;
  border-bottom: 1px solid var(--dd-border);
  margin-bottom: 24px;
}

.logo-emoji {
  font-size: 28px;
}

.logo-text {
  font-size: 20px;
  font-weight: 800;
  letter-spacing: -0.5px;
  background: var(--dd-gradient-primary);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.sidebar-nav {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.nav-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 14px;
  border-radius: var(--dd-radius-sm, 10px);
  color: var(--dd-text-secondary);
  text-decoration: none;
  font-size: 14px;
  font-weight: 600;
  transition: all 0.2s ease;
  cursor: pointer;
}

.nav-item:hover {
  background: var(--dd-surface-hover);
  color: var(--dd-text);
}

.nav-item.active {
  background: var(--dd-gradient-primary);
  color: #ffffff !important;
  box-shadow: 0 4px 12px rgba(108, 92, 231, 0.2);
}

.nav-item.active .nav-icon {
  color: #ffffff !important;
}

.nav-icon {
  font-size: 20px;
  color: var(--dd-text-secondary);
  transition: color 0.2s ease;
}

.nav-item:hover .nav-icon {
  color: var(--ion-color-primary);
}

.sidebar-divider {
  height: 1px;
  background: var(--dd-border);
  margin: 20px 8px;
}

.sidebar-section-title {
  font-size: 11px;
  font-weight: 800;
  text-transform: uppercase;
  letter-spacing: 1px;
  color: var(--dd-text-secondary);
  padding: 0 14px 8px;
  opacity: 0.8;
}

.secondary-nav .nav-item {
  padding: 10px 14px;
}

.play-store-badge {
  cursor: not-allowed;
  position: relative;
}

.play-store-badge.disabled:hover {
  background: transparent;
  color: var(--dd-text-secondary);
}

.play-store-badge .badge-tag {
  font-size: 9px;
  font-weight: 700;
  background: var(--dd-border);
  color: var(--dd-text-secondary);
  padding: 2px 6px;
  border-radius: 4px;
  margin-left: auto;
}

.sidebar-spacer {
  flex: 1;
}

/* Sidebar Footer */
.sidebar-footer {
  background: var(--dd-bg);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md, 16px);
  padding: 16px;
  margin-top: 24px;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.user-info-wrapper {
  display: flex;
  align-items: center;
  gap: 12px;
}

.user-avatar-small {
  width: 42px;
  height: 42px;
  border-radius: 50%;
  background: var(--dd-gradient-primary);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 800;
  font-size: 15px;
  box-shadow: 0 4px 10px rgba(108, 92, 231, 0.2);
}

.user-detail-texts {
  flex: 1;
  overflow: hidden;
}

.user-name-text {
  font-size: 14px;
  font-weight: 700;
  color: var(--dd-text);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.user-level-info {
  font-size: 11px;
  color: var(--dd-text-secondary);
  margin-top: 2px;
}

.sidebar-footer-actions {
  border-top: 1px solid var(--dd-border);
  padding-top: 10px;
}

.footer-action-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  width: 100%;
  padding: 10px;
  background: transparent;
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-sm, 10px);
  color: #ff7675;
  font-size: 13px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.2s ease;
}

.footer-action-btn:hover {
  background: rgba(255, 118, 117, 0.08);
  border-color: #ff7675;
}

.footer-action-btn ion-icon {
  font-size: 16px;
}
</style>
