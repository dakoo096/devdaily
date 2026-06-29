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
            <h1 class="greeting">¡Hola, {{ userName }}! 👋</h1>
            <p class="date-text">{{ formattedDate }}</p>
          </div>
          <div class="header-logo">
            <span>⚡</span>
          </div>
        </div>

        <!-- Daily Quiz Banner -->
        <div class="quiz-banner-card animate-fade-in-up" :class="{ completed: isQuizCompleted }" @click="goToQuiz">
          <div class="quiz-banner-main">
            <div class="quiz-banner-left">
              <span class="quiz-banner-badge" :class="{ completed: isQuizCompleted }">
                {{ isQuizCompleted ? 'COMPLETADO' : 'RETO DIARIO' }}
              </span>
              <h2 class="quiz-banner-title">
                {{ isQuizCompleted ? '¡Reto de hoy completo! 🎉' : 'Quiz de Hoy 🧠' }}
              </h2>
              <p class="quiz-banner-desc">
                {{ isQuizCompleted ? 'Volvé mañana para una nueva dosis de conocimiento.' : 'Responde 3 preguntas y gana Dev XP.' }}
              </p>
            </div>
            <div class="quiz-banner-right">
              <div v-if="userStreak > 0" class="quiz-banner-streak">
                <span class="streak-fire">🔥</span>
                <span class="streak-count">{{ userStreak }}</span>
              </div>
              <div class="quiz-banner-play" :class="{ completed: isQuizCompleted }">
                <ion-icon :icon="isQuizCompleted ? checkmarkCircle : chevronForward" />
              </div>
            </div>
          </div>
        </div>

        <!-- Type Filter Chips -->
        <div class="filter-section animate-fade-in-up stagger-1">
          <div class="filter-scroll">
            <AppChip label="Todos" :selected="!activeFilter" small @click="activeFilter = null" />
            <AppChip v-for="type in settingsStore.preferences.contentTypes" :key="type"
              :label="CONTENT_TYPE_LABELS[type]" :emoji="CONTENT_TYPE_EMOJIS[type]" :selected="activeFilter === type"
              small @click="activeFilter = activeFilter === type ? null : type" />
          </div>
        </div>

        <!-- Loading Skeletons -->
        <div v-if="contentStore.isLoading" class="content-list">
          <ContentSkeleton v-for="i in 4" :key="i" />
        </div>

        <!-- Content Cards -->
        <div v-else class="content-list">
          <AppContentCard v-for="(item, index) in filteredContent" :key="item.id" :item="item"
            :class="`animate-fade-in-up stagger-${Math.min(index + 1, 8)}`" />

          <AppEmptyState v-if="filteredContent.length === 0" emoji="🔍" title="No hay contenido"
            description="No encontramos contenido para este filtro. Prueba con otro tipo." />
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage, IonContent, IonRefresher, IonRefresherContent, IonIcon } from '@ionic/vue';
import { chevronForward, checkmarkCircle } from 'ionicons/icons';
import AppChip from '@/components/common/AppChip.vue';
import AppContentCard from '@/components/content/AppContentCard.vue';
import ContentSkeleton from '@/components/content/ContentSkeleton.vue';
import AppEmptyState from '@/components/common/AppEmptyState.vue';
import { useContentStore } from '@/stores/contentStore';
import { useSettingsStore } from '@/stores/settingsStore';
import { useAuthStore } from '@/stores/authStore';
import type { ContentType } from '@/types/content';
import { CONTENT_TYPE_LABELS, CONTENT_TYPE_EMOJIS } from '@/types/content';

const router = useRouter();
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

const userStreak = computed(() => authStore.user?.currentStreak || 0);

const isQuizCompleted = computed(() => {
  if (!authStore.user?.lastQuizDate) return false;
  const todayStr = new Date().toISOString().split('T')[0];
  return authStore.user.lastQuizDate === todayStr;
});

const filteredContent = computed(() => {
  return contentStore.filterByType(activeFilter.value);
});

async function handleRefresh(event: CustomEvent) {
  await Promise.all([
    authStore.fetchCurrentUser(),
    contentStore.fetchDailyContent()
  ]);
  (event.target as HTMLIonRefresherElement).complete();
}

function goToQuiz() {
  router.push('/quiz/daily');
}

onMounted(() => {
  authStore.fetchCurrentUser();
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
}

.greeting {
  font-size: 26px;
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
  margin-bottom: 12px;
}

.filter-scroll {
  display: flex;
  gap: 8px;
  overflow-x: auto;
  padding: 8px 4px;
  margin: -8px -4px;
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

/* Quiz Banner Card */
.quiz-banner-card {
  background: var(--dd-surface);
  border: 2px solid var(--dd-border);
  border-radius: var(--dd-radius-md);
  padding: 16px 20px;
  margin-bottom: 20px;
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: var(--dd-shadow-sm);
  position: relative;
  overflow: hidden;
}

.quiz-banner-card:active {
  transform: scale(0.98);
}

.quiz-banner-card.completed {
  border-color: rgba(45, 211, 111, 0.3);
  background: rgba(45, 211, 111, 0.03);
}

.quiz-banner-main {
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 1;
  position: relative;
}

.quiz-banner-left {
  flex: 1;
  padding-right: 16px;
}

.quiz-banner-badge {
  display: inline-block;
  font-size: 10px;
  font-weight: 800;
  color: var(--ion-color-primary);
  background: rgba(var(--ion-color-primary-rgb), 0.1);
  padding: 4px 8px;
  border-radius: 4px;
  letter-spacing: 0.5px;
  margin-bottom: 8px;
}

.quiz-banner-badge.completed {
  color: var(--ion-color-success);
  background: rgba(45, 211, 111, 0.1);
}

.quiz-banner-title {
  font-size: 18px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0 0 4px;
}

.quiz-banner-desc {
  font-size: 13px;
  color: var(--dd-text-secondary);
  margin: 0;
  line-height: 1.4;
}

.quiz-banner-right {
  display: flex;
  align-items: center;
  gap: 12px;
}

.quiz-banner-streak {
  display: flex;
  align-items: center;
  gap: 4px;
  background: rgba(253, 203, 110, 0.1);
  padding: 6px 10px;
  border-radius: 12px;
  border: 1px solid rgba(253, 203, 110, 0.2);
}

.streak-fire {
  font-size: 16px;
}

.streak-count {
  font-size: 13px;
  font-weight: 700;
  color: #e1b12c;
}

.quiz-banner-play {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: var(--dd-gradient-primary);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  box-shadow: 0 4px 12px rgba(108, 92, 231, 0.25);
  transition: all 0.2s ease;
}

.quiz-banner-play.completed {
  background: var(--ion-color-success);
  box-shadow: 0 4px 12px rgba(45, 211, 111, 0.25);
}
</style>
