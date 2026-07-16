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
          <div class="header-logo mobile-logo-only">
            <span>⚡</span>
          </div>
        </div>

        <!-- Dashboard Grid (Adaptive via media queries) -->
        <div class="dashboard-grid">
          
          <!-- Search Results View (Only visible on Desktop when typing a query) -->
          <div v-if="isDesktop && searchStore.query" class="search-results-wrapper animate-fade-in-up">
            <div class="search-results-header">
              <h2 class="search-title">Resultados para "{{ searchStore.query }}"</h2>
              <button class="clear-query-btn" @click="searchStore.clear">Limpiar</button>
            </div>
            
            <div class="content-list">
              <AppContentCard v-for="item in searchResults" :key="item.id" :item="item" />
              
              <AppEmptyState 
                v-if="searchResults.length === 0" 
                emoji="🔍" 
                title="Sin resultados" 
                description="Prueba con otra palabra clave o tecnología." 
              />
            </div>
          </div>

          <!-- Main Column (Left column in desktop, full width in mobile) -->
          <div v-else class="dashboard-main-column">
            
            <!-- Quick Actions (Desktop only) -->
            <QuickActions class="desktop-only animate-fade-in-up" />

            <!-- Daily Quiz Banner (Visible on mobile/tablet, and nested elsewhere or styled on mobile) -->
            <div class="quiz-banner-card mobile-only animate-fade-in-up" :class="{ completed: isQuizCompleted }" @click="goToQuiz">
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

            <!-- Tip of the Day (Desktop only) -->
            <div class="daily-tip-section desktop-only animate-fade-in-up stagger-1">
              <div class="card-header-row">
                <h3 class="side-card-title">💡 Lección Destacada del Día</h3>
              </div>
              <div v-if="contentStore.isLoading" class="skeleton-wrapper">
                <ContentSkeleton />
              </div>
              <div v-else-if="tipOfDay" class="tip-content">
                <AppContentCard :item="tipOfDay" />
              </div>
              <div v-else class="empty-tip-card">
                <AppEmptyState emoji="💡" title="Lección leída" description="Has completado tus lecturas de hoy. ¡Sigue así!" />
              </div>
            </div>

            <!-- Other Lessons of the Day (Desktop only) -->
            <div v-if="otherLessons.length > 0" class="other-lessons-section desktop-only animate-fade-in-up stagger-2">
              <div class="card-header-row">
                <h3 class="side-card-title">📚 Más Lecciones de Hoy</h3>
              </div>
              <div v-if="contentStore.isLoading" class="skeleton-wrapper">
                <div class="other-lessons-grid">
                  <ContentSkeleton v-for="i in 2" :key="i" />
                </div>
              </div>
              <div v-else class="other-lessons-grid">
                <AppContentCard v-for="item in otherLessons" :key="item.id" :item="item" />
              </div>
            </div>

            <!-- Recent Activity Timeline (Desktop only) -->
            <RecentActivityTimeline class="desktop-only animate-fade-in-up stagger-3" />

            <!-- Mobile Only Section (Filter chips + content list) -->
            <div class="mobile-only filter-and-list">
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

          </div>

          <!-- Side Column (Right column in desktop, hidden in mobile) -->
          <div v-if="!searchStore.query" class="dashboard-side-column desktop-only">
            
            <!-- Quiz del día (Desktop visual card) -->
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

            <!-- Continue Learning -->
            <ContinueLearning class="animate-fade-in-up stagger-1" />

            <!-- Progress & Stats Grid -->
            <DashboardStats class="animate-fade-in-up stagger-2" />

            <!-- Favorite Technologies List -->
            <div class="fav-techs-card animate-fade-in-up stagger-3">
              <h4 class="side-card-title">Tecnologías Preferidas</h4>
              <div class="tech-chips-list">
                <span v-for="tech in settingsStore.preferences.technologies" :key="tech" class="tech-pill-badge">
                  {{ techLabel(tech) }}
                </span>
                <span v-if="!settingsStore.preferences.technologies?.length" class="empty-techs-text">
                  Ninguna seleccionada en tus preferencias.
                </span>
              </div>
            </div>

          </div>

        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage, IonContent, IonRefresher, IonRefresherContent, IonIcon, onIonViewWillEnter } from '@ionic/vue';
import { chevronForward, checkmarkCircle } from 'ionicons/icons';
import AppChip from '@/components/common/AppChip.vue';
import AppContentCard from '@/components/content/AppContentCard.vue';
import ContentSkeleton from '@/components/content/ContentSkeleton.vue';
import AppEmptyState from '@/components/common/AppEmptyState.vue';
import { useContentStore } from '@/stores/contentStore';
import { useSettingsStore } from '@/stores/settingsStore';
import { useAuthStore } from '@/stores/authStore';
import { useFavoritesStore } from '@/stores/favoritesStore';
import { useHistoryStore } from '@/stores/historyStore';
import { useSearchStore } from '@/stores/searchStore';
import { useLayout } from '@/composables/useLayout';
import type { ContentItem, ContentType, Technology } from '@/types/content';
import { CONTENT_TYPE_LABELS, CONTENT_TYPE_EMOJIS, TECHNOLOGY_LABELS } from '@/types/content';

// Desktop subcomponents
import QuickActions from '@/components/desktop/QuickActions.vue';
import DashboardStats from '@/components/desktop/DashboardStats.vue';
import ContinueLearning from '@/components/desktop/ContinueLearning.vue';
import RecentActivityTimeline from '@/components/desktop/RecentActivityTimeline.vue';

const router = useRouter();
const contentStore = useContentStore();
const settingsStore = useSettingsStore();
const authStore = useAuthStore();
const favoritesStore = useFavoritesStore();
const historyStore = useHistoryStore();
const searchStore = useSearchStore();
const { isDesktop } = useLayout();

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
  let items = contentStore.filterByType(activeFilter.value);
  if (searchStore.query) {
    const q = searchStore.query.toLowerCase();
    items = items.filter(
      item =>
        item.title.toLowerCase().includes(q) ||
        item.body.toLowerCase().includes(q) ||
        item.technology.toLowerCase().includes(q)
    );
  }
  return items;
});

const tipOfDay = computed(() => {
  // Find first item in daily content that is a tip or concept
  return contentStore.dailyContent.find(c => c.type === 'tip') || contentStore.dailyContent[0];
});

const otherLessons = computed(() => {
  if (!tipOfDay.value) return [];
  return contentStore.dailyContent.filter(c => c.id !== tipOfDay.value.id);
});

const searchResults = computed(() => {
  if (!searchStore.query) return [];
  const q = searchStore.query.toLowerCase();
  
  const results: ContentItem[] = [];
  const seenIds = new Set<string>();

  const addUnique = (item: ContentItem) => {
    if (!seenIds.has(item.id)) {
      seenIds.add(item.id);
      results.push(item);
    }
  };

  // 1. Search in Daily Content
  contentStore.dailyContent.forEach(item => {
    if (item.title.toLowerCase().includes(q) || item.body.toLowerCase().includes(q) || item.technology.toLowerCase().includes(q)) {
      addUnique(item);
    }
  });

  // 2. Search in Favorites
  favoritesStore.favorites.forEach(item => {
    if (item.title.toLowerCase().includes(q) || item.body.toLowerCase().includes(q) || item.technology.toLowerCase().includes(q)) {
      addUnique(item);
    }
  });

  // 3. Search in History
  historyStore.entries.forEach(entry => {
    entry.items.forEach(item => {
      if (item.title.toLowerCase().includes(q) || item.body.toLowerCase().includes(q) || item.technology.toLowerCase().includes(q)) {
        addUnique(item);
      }
    });
  });

  return results;
});

function techLabel(tech: string) {
  return TECHNOLOGY_LABELS[tech as Technology] || tech;
}

async function handleRefresh(event: CustomEvent) {
  await Promise.all([
    authStore.fetchCurrentUser(),
    contentStore.fetchDailyContent(),
    favoritesStore.fetchFavorites(),
    historyStore.fetchHistory()
  ]);
  (event.target as HTMLIonRefresherElement).complete();
}

function goToQuiz() {
  router.push('/quiz/daily');
}

onMounted(() => {
  authStore.fetchCurrentUser();
  contentStore.fetchDailyContent();
  favoritesStore.fetchFavorites();
  historyStore.fetchHistory();
});

onIonViewWillEnter(() => {
  authStore.fetchCurrentUser();
  contentStore.fetchDailyContent();
  favoritesStore.fetchFavorites();
  historyStore.fetchHistory();
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
  border: 1px solid var(--dd-border);
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

/* Responsive visibility helper styles */
.desktop-only {
  display: none !important;
}

.mobile-only {
  display: block;
}

.mobile-logo-only {
  display: flex;
}

/* Dashboard Side Card list styles */
.fav-techs-card {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-lg, 24px);
  padding: 24px;
  box-shadow: var(--dd-shadow-sm);
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.side-card-title {
  font-size: 16px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0;
  letter-spacing: -0.2px;
}

.tech-chips-list {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.tech-pill-badge {
  font-size: 12px;
  font-weight: 700;
  background: var(--dd-bg);
  border: 1px solid var(--dd-border);
  color: var(--dd-text-secondary);
  padding: 6px 12px;
  border-radius: var(--dd-radius-sm, 10px);
}

.empty-techs-text {
  font-size: 13px;
  color: var(--dd-text-secondary);
}

.daily-tip-section {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

/* Search results styles */
.search-results-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.search-title {
  font-size: 18px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0;
}

.clear-query-btn {
  font-size: 13px;
  font-weight: 700;
  color: var(--ion-color-primary);
  background: none;
  border: none;
  cursor: pointer;
}

/* DESKTOP MEDIA QUERIES (>=1024px) */
@media (min-width: 1024px) {
  .desktop-only {
    display: flex !important;
  }
  
  .desktop-only.quick-actions-card {
    display: flex !important;
  }
  
  .mobile-only {
    display: none !important;
  }
  
  .mobile-logo-only {
    display: none !important;
  }
  
  .home-container {
    padding: 0;
  }
  
  .home-header {
    margin-bottom: 28px;
  }
  
  .greeting {
    font-size: 32px;
    font-weight: 800;
    letter-spacing: -0.8px;
  }
  
  .dashboard-grid {
    display: grid;
    grid-template-columns: minmax(0, 2.2fr) minmax(0, 1fr);
    gap: 32px;
    align-items: start;
    padding-bottom: 60px;
  }
  
  .dashboard-main-column {
    display: flex;
    flex-direction: column;
    gap: 28px;
  }
  
  .dashboard-side-column {
    display: flex;
    flex-direction: column;
    gap: 28px;
    position: sticky;
    top: 24px;
  }
  
  .search-results-wrapper {
    grid-column: span 2;
  }

  .other-lessons-section {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  .other-lessons-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 20px;
  }

  .other-lessons-grid :deep(.content-card) {
    margin-bottom: 0;
  }
}
</style>
