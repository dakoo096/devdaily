<template>
  <header class="desktop-header-inner">
    <!-- Breadcrumb Title -->
    <div class="breadcrumb-container">
      <span class="breadcrumb-parent">DevBloom</span>
      <span class="breadcrumb-separator">/</span>
      <span class="breadcrumb-active">{{ activePageName }}</span>
    </div>

    <!-- Search Input -->
    <div class="header-search-bar">
      <ion-icon :icon="searchOutline" class="search-icon" />
      <input 
        type="text" 
        v-model="searchStore.query" 
        placeholder="Buscar en favoritos, historial, tecnologías..." 
        class="search-input-field" 
      />
      <button v-if="searchStore.query" class="clear-search-btn" @click="searchStore.clear">
        <ion-icon :icon="closeCircleOutline" />
      </button>
    </div>

    <!-- Right Side Actions & User Info -->
    <div class="header-right-side">
      <!-- Notification Center -->
      <div class="notification-wrapper" ref="notifWrapperRef">
        <button class="header-icon-btn" ref="bellBtnRef" @click="toggleNotifications" title="Notificaciones">
          <ion-icon :icon="notificationsOutline" />
          <span v-if="hasPendingNotifications" class="notification-badge-dot"></span>
        </button>

        <Teleport to="body">
          <div v-if="showNotifications" class="notification-panel" :style="panelPositionStyle" ref="notifPanelRef">
            <div class="notification-panel-header">
              <h4>Notificaciones</h4>
            </div>
            <div class="notification-list">
              <button v-if="isQuizPending" class="notification-item" @click="goToQuizFromNotif">
                <span class="notif-icon quiz">🧠</span>
                <div class="notif-text">
                  <strong>Quiz diario pendiente</strong>
                  <p>Respondé el reto de hoy y sumá Dev XP.</p>
                </div>
              </button>
              <button v-if="unreadTipsCount > 0" class="notification-item" @click="goToHomeFromNotif">
                <span class="notif-icon tip">💡</span>
                <div class="notif-text">
                  <strong>{{ unreadTipsCount }} {{ unreadTipsCount === 1 ? 'lección sin leer' : 'lecciones sin leer' }}</strong>
                  <p>Todavía tenés contenido de hoy por revisar.</p>
                </div>
              </button>
              <div v-if="!isQuizPending && unreadTipsCount === 0" class="notification-empty">
                <span class="notif-empty-emoji">🎉</span>
                <p>¡Estás al día! No tenés notificaciones pendientes.</p>
              </div>
            </div>
          </div>
        </Teleport>
      </div>

      <!-- Settings Icon -->
      <button class="header-icon-btn" @click="goToSettings" title="Preferencias">
        <ion-icon :icon="optionsOutline" />
      </button>

      <div class="header-divider"></div>

      <!-- User Avatar / Info -->
      <div class="user-avatar-profile" @click="goToProfile" title="Ver Perfil">
        <div class="avatar-circle">
          <span>{{ userInitials }}</span>
        </div>
        <span class="avatar-name">{{ authStore.user?.name || 'Dev' }}</span>
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
import { computed, onMounted, onUnmounted, ref, nextTick } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { IonIcon } from '@ionic/vue';
import { searchOutline, closeCircleOutline, notificationsOutline, optionsOutline } from 'ionicons/icons';
import { useAuthStore } from '@/stores/authStore';
import { useSearchStore } from '@/stores/searchStore';
import { useContentStore } from '@/stores/contentStore';
import { useHistoryStore } from '@/stores/historyStore';

const route = useRoute();
const router = useRouter();
const authStore = useAuthStore();
const searchStore = useSearchStore();
const contentStore = useContentStore();
const historyStore = useHistoryStore();

const showNotifications = ref(false);
const notifWrapperRef = ref<HTMLElement | null>(null);
const notifPanelRef = ref<HTMLElement | null>(null);
const bellBtnRef = ref<HTMLElement | null>(null);
const panelPositionStyle = ref({ top: '0px', right: '0px' });

const todayStr = computed(() => new Date().toISOString().split('T')[0]);

const isQuizPending = computed(() => {
  return authStore.user?.lastQuizDate !== todayStr.value;
});

const unreadTipsCount = computed(() => {
  const readTodayIds = new Set(historyStore.getByDate(todayStr.value).map(item => item.id));
  return contentStore.dailyContent.filter(item => !readTodayIds.has(item.id)).length;
});

const hasPendingNotifications = computed(() => isQuizPending.value || unreadTipsCount.value > 0);

function updatePanelPosition() {
  if (!bellBtnRef.value) return;
  const rect = bellBtnRef.value.getBoundingClientRect();
  panelPositionStyle.value = {
    top: `${rect.bottom + 12}px`,
    right: `${window.innerWidth - rect.right}px`,
  };
}

function toggleNotifications() {
  showNotifications.value = !showNotifications.value;
  if (showNotifications.value) {
    nextTick(updatePanelPosition);
  }
}

function closeNotifications() {
  showNotifications.value = false;
}

function handleClickOutside(event: MouseEvent) {
  const target = event.target as Node;
  const clickedWrapper = !!notifWrapperRef.value?.contains(target);
  const clickedPanel = !!notifPanelRef.value?.contains(target);
  if (!clickedWrapper && !clickedPanel) {
    closeNotifications();
  }
}

onMounted(() => {
  document.addEventListener('click', handleClickOutside);
  if (contentStore.dailyContent.length === 0) contentStore.fetchDailyContent();
  if (historyStore.entries.length === 0) historyStore.fetchHistory();
});

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside);
});

const activePageName = computed(() => {
  switch (route.name) {
    case 'Home': return 'Hoy';
    case 'Favorites': return 'Favoritos';
    case 'History': return 'Historial';
    case 'Profile': return 'Perfil';
    default: return 'Dashboard';
  }
});

const userInitials = computed(() => {
  const name = authStore.user?.name || 'D';
  return name.split(' ').map(n => n[0]).join('').toUpperCase().slice(0, 2);
});

function goToProfile() {
  router.push('/app/profile');
}

function goToSettings() {
  router.push('/onboarding');
}

function goToQuizFromNotif() {
  closeNotifications();
  router.push('/quiz/daily');
}

function goToHomeFromNotif() {
  closeNotifications();
  router.push('/app/home');
}
</script>

<style scoped>
.desktop-header-inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  height: 100%;
  padding: 0 32px;
  background: var(--dd-glass-bg);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid var(--dd-border);
}

/* Breadcrumb styling */
.breadcrumb-container {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  font-weight: 600;
}

.breadcrumb-parent {
  color: var(--dd-text-secondary);
}

.breadcrumb-separator {
  color: var(--dd-border);
  font-weight: 400;
}

.breadcrumb-active {
  color: var(--dd-text);
  font-weight: 700;
}

/* Search bar styling */
.header-search-bar {
  position: relative;
  max-width: 420px;
  width: 100%;
  margin: 0 32px;
  display: flex;
  align-items: center;
}

.search-icon {
  position: absolute;
  left: 14px;
  color: var(--dd-text-secondary);
  font-size: 18px;
  pointer-events: none;
}

.search-input-field {
  width: 100%;
  padding: 10px 16px 10px 42px;
  background: var(--dd-bg);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-sm, 10px);
  color: var(--dd-text);
  font-size: 14px;
  font-family: inherit;
  outline: none;
  transition: all 0.25s ease;
}

.search-input-field:focus {
  border-color: var(--ion-color-primary);
  box-shadow: 0 0 0 3px rgba(108, 92, 231, 0.15);
  background: var(--dd-surface);
}

.clear-search-btn {
  position: absolute;
  right: 14px;
  background: none;
  border: none;
  color: var(--dd-text-secondary);
  font-size: 18px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0;
}

.clear-search-btn:hover {
  color: var(--dd-text);
}

/* Right side user & actions */
.header-right-side {
  display: flex;
  align-items: center;
  gap: 16px;
}

.header-icon-btn {
  position: relative;
  background: none;
  border: none;
  color: var(--dd-text-secondary);
  font-size: 22px;
  cursor: pointer;
  padding: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  transition: all 0.2s ease;
}

.header-icon-btn:hover {
  background: var(--dd-surface-hover);
  color: var(--dd-text);
}

.notification-badge-dot {
  position: absolute;
  top: 8px;
  right: 8px;
  width: 8px;
  height: 8px;
  background: #ff7675;
  border-radius: 50%;
  border: 2px solid var(--dd-surface);
}

.notification-wrapper {
  position: relative;
}

.notification-panel {
  position: fixed;
  width: 340px;
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md, 16px);
  box-shadow: var(--dd-shadow-lg);
  overflow: hidden;
  z-index: 50;
  animation: fadeInUp 0.2s ease;
}

.notification-panel-header {
  padding: 16px 20px;
  border-bottom: 1px solid var(--dd-border);
}

.notification-panel-header h4 {
  margin: 0;
  font-size: 15px;
  font-weight: 800;
  color: var(--dd-text);
}

.notification-list {
  display: flex;
  flex-direction: column;
  padding: 8px;
  max-height: 360px;
  overflow-y: auto;
}

.notification-item {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  width: 100%;
  padding: 12px;
  background: none;
  border: none;
  border-radius: var(--dd-radius-sm, 10px);
  text-align: left;
  cursor: pointer;
  font-family: inherit;
  transition: background 0.2s ease;
}

.notification-item:hover {
  background: var(--dd-surface-hover);
}

.notif-icon {
  font-size: 22px;
  flex-shrink: 0;
  line-height: 1;
}

.notif-text {
  min-width: 0;
}

.notif-text strong {
  display: block;
  font-size: 14px;
  font-weight: 700;
  color: var(--dd-text);
  margin-bottom: 2px;
}

.notif-text p {
  margin: 0;
  font-size: 12px;
  color: var(--dd-text-secondary);
  line-height: 1.4;
}

.notification-empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  padding: 24px 16px;
  gap: 8px;
}

.notif-empty-emoji {
  font-size: 28px;
}

.notification-empty p {
  margin: 0;
  font-size: 13px;
  color: var(--dd-text-secondary);
}

.header-divider {
  width: 1px;
  height: 24px;
  background: var(--dd-border);
  margin: 0 4px;
}

.user-avatar-profile {
  display: flex;
  align-items: center;
  gap: 12px;
  cursor: pointer;
  padding: 6px 12px 6px 6px;
  border-radius: var(--dd-radius-full);
  transition: background 0.2s ease;
}

.user-avatar-profile:hover {
  background: var(--dd-surface-hover);
}

.avatar-circle {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: var(--dd-gradient-primary);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 800;
  font-size: 13px;
  box-shadow: 0 2px 8px rgba(108, 92, 231, 0.15);
}

.avatar-name {
  font-size: 14px;
  font-weight: 700;
  color: var(--dd-text);
}
</style>
