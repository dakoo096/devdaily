<template>
  <ion-page>
    <ion-content :fullscreen="true" class="home-content">
      <ion-refresher slot="fixed" @ionRefresh="handleRefresh($event)">
        <ion-refresher-content />
      </ion-refresher>

      <div class="home-container">
        <!-- Header -->
        <div class="home-header animate-fade-in-up">
          <div class="greeting-section">
            <h1 class="greeting">¡Hola, {{ userName }}!&nbsp;👋</h1>
            <p class="date-text">{{ formattedDate }}</p>
          </div>
          <div class="header-logo">
            <span>⚡</span>
          </div>
        </div>

        <!-- Type Filter Chips -->
        <div class="filter-section animate-fade-in-up stagger-1">
          <div class="filter-scroll">
            <AppChip
              label="Todos"
              :selected="!activeFilter"
              small
              @click="activeFilter = null"
            />
            <AppChip
              v-for="type in settingsStore.preferences.contentTypes"
              :key="type"
              :label="CONTENT_TYPE_LABELS[type]"
              :emoji="CONTENT_TYPE_EMOJIS[type]"
              :selected="activeFilter === type"
              small
              @click="activeFilter = activeFilter === type ? null : type"
            />
          </div>
        </div>

        <!-- Loading Skeletons -->
        <div v-if="contentStore.isLoading" class="content-list">
          <ContentSkeleton v-for="i in 4" :key="i" />
        </div>

        <!-- Content Cards -->
        <div v-else class="content-list">
          <AppContentCard
            v-for="(item, index) in filteredContent"
            :key="item.id"
            :item="item"
            :class="`animate-fade-in-up stagger-${Math.min(index + 1, 8)}`"
          />

          <AppEmptyState
            v-if="filteredContent.length === 0"
            emoji="🔍"
            title="No hay contenido"
            description="No encontramos contenido para este filtro. Prueba con otro tipo."
          />
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { IonPage, IonContent, IonRefresher, IonRefresherContent } from '@ionic/vue';
import AppChip from '@/components/common/AppChip.vue';
import AppContentCard from '@/components/content/AppContentCard.vue';
import ContentSkeleton from '@/components/content/ContentSkeleton.vue';
import AppEmptyState from '@/components/common/AppEmptyState.vue';
import { useContentStore } from '@/stores/contentStore';
import { useSettingsStore } from '@/stores/settingsStore';
import { useAuthStore } from '@/stores/authStore';
import type { ContentType } from '@/types/content';
import { CONTENT_TYPE_LABELS, CONTENT_TYPE_EMOJIS } from '@/types/content';

const contentStore = useContentStore();
const settingsStore = useSettingsStore();
const authStore = useAuthStore();

const activeFilter = ref<ContentType | null>(null);

const userName = computed(() => authStore.user?.name || 'Dev');

const formattedDate = computed(() => {
  return new Date().toLocaleDateString('es-ES', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });
});

const filteredContent = computed(() => {
  return contentStore.filterByType(activeFilter.value);
});

async function handleRefresh(event: CustomEvent) {
  await contentStore.fetchDailyContent();
  (event.target as HTMLIonRefresherElement).complete();
}

onMounted(() => {
  contentStore.fetchDailyContent();
});
</script>

<style scoped>
.home-content {
  --background: var(--dd-bg);
}

.home-container {
  padding: 16px;
  padding-top: calc(env(safe-area-inset-top) + 16px);
}

/* Header */
.home-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 20px;
  gap: 16px;
}

.greeting-section {
  flex: 1;
  min-width: 0;
}

.greeting {
  font-size: 24px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0;
  line-height: 1.2;
}

.date-text {
  font-size: 14px;
  color: var(--dd-text-secondary);
  margin: 6px 0 0;
  text-transform: capitalize;
}

.header-logo {
  width: 48px;
  height: 48px;
  border-radius: 14px;
  background: var(--dd-gradient-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  flex-shrink: 0;
  box-shadow: 0 4px 12px rgba(108, 92, 231, 0.25);
}

/* Filter */
.filter-section {
  margin-bottom: 20px;
}

.filter-scroll {
  display: flex;
  gap: 8px;
  overflow-x: auto;
  padding-bottom: 4px;
  -webkit-overflow-scrolling: touch;
  scrollbar-width: none;
}

.filter-scroll::-webkit-scrollbar {
  display: none;
}

/* Content List */
.content-list {
  padding-bottom: 100px;
}
</style>
