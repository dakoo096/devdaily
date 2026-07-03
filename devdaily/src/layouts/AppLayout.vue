<template>
  <ion-page>
    <!-- Desktop Layout Layout -->
    <div v-if="isDesktop" class="desktop-layout-container">
      <DesktopSidebar class="sidebar-aside" />
      <div class="desktop-main-wrapper">
        <DesktopHeader class="header-top" />
        <div class="desktop-content-area">
          <ion-router-outlet></ion-router-outlet>
        </div>
      </div>
    </div>

    <!-- Mobile/Tablet Layout (Standard tabs layout) -->
    <ion-tabs v-else>
      <ion-router-outlet></ion-router-outlet>
      <ion-tab-bar slot="bottom">
        <ion-tab-button tab="home" href="/app/home" id="tab-home">
          <ion-icon :icon="todayOutline" />
          <ion-label>Hoy</ion-label>
        </ion-tab-button>

        <ion-tab-button tab="favorites" href="/app/favorites" id="tab-favorites">
          <ion-icon :icon="heartOutline" />
          <ion-label>Favoritos</ion-label>
        </ion-tab-button>

        <ion-tab-button tab="history" href="/app/history" id="tab-history">
          <ion-icon :icon="timeOutline" />
          <ion-label>Historial</ion-label>
        </ion-tab-button>

        <ion-tab-button tab="profile" href="/app/profile" id="tab-profile">
          <ion-icon :icon="personOutline" />
          <ion-label>Perfil</ion-label>
        </ion-tab-button>
      </ion-tab-bar>
    </ion-tabs>
  </ion-page>
</template>

<script setup lang="ts">
import {
  IonPage,
  IonTabs,
  IonRouterOutlet,
  IonTabBar,
  IonTabButton,
  IonIcon,
  IonLabel,
} from '@ionic/vue';
import { todayOutline, heartOutline, timeOutline, personOutline } from 'ionicons/icons';
import { useLayout } from '@/composables/useLayout';
import DesktopSidebar from '@/components/desktop/DesktopSidebar.vue';
import DesktopHeader from '@/components/desktop/DesktopHeader.vue';

const { isDesktop } = useLayout();
</script>

<style scoped>
.desktop-layout-container {
  display: flex;
  width: 100vw;
  height: 100vh;
  background: var(--dd-bg);
  overflow: hidden;
}

.sidebar-aside {
  width: 260px;
  height: 100%;
  flex-shrink: 0;
  border-right: 1px solid var(--dd-border);
}

.desktop-main-wrapper {
  flex: 1;
  display: flex;
  flex-direction: column;
  height: 100%;
  overflow: hidden;
}

.header-top {
  height: 70px;
  flex-shrink: 0;
}

.desktop-content-area {
  flex: 1;
  position: relative;
  background: var(--dd-bg);
}

/* Deep override for Ionic page stacking on desktop */
.desktop-content-area :deep(ion-page) {
  position: relative !important;
  height: 100% !important;
  width: 100% !important;
  display: flex !important;
  flex-direction: column !important;
  contain: none !important;
  z-index: 1 !important;
}

.desktop-content-area :deep(ion-content) {
  --background: var(--dd-bg);
  --padding-top: 32px;
  --padding-bottom: 32px;
  --padding-start: 32px;
  --padding-end: 32px;
}
</style>
