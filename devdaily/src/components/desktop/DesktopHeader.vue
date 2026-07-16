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
      <!-- Notification Center Placeholder -->
      <button class="header-icon-btn" @click="goToNotifications" title="Notificaciones">
        <ion-icon :icon="notificationsOutline" />
        <span class="notification-badge-dot"></span>
      </button>

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
import { computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { IonIcon } from '@ionic/vue';
import { searchOutline, closeCircleOutline, notificationsOutline, optionsOutline } from 'ionicons/icons';
import { useAuthStore } from '@/stores/authStore';
import { useSearchStore } from '@/stores/searchStore';

const route = useRoute();
const router = useRouter();
const authStore = useAuthStore();
const searchStore = useSearchStore();

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

function goToNotifications() {
  router.push('/settings/notifications');
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
