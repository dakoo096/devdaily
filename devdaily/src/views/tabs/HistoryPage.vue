<template>
  <ion-page>
    <ion-content :fullscreen="true" class="history-content">
      <div class="history-container">
        
        <!-- Desktop Header Title and Tabs Filters -->
        <div v-if="!isMobile" class="history-desktop-header">
          <div class="header-left">
            <h1 class="desktop-title font-title-lg">Historial de Lectura 📅</h1>
            <p class="desktop-subtitle">Revisa todos los temas que has aprendido a lo largo del tiempo.</p>
          </div>
          <!-- Type Filter Tabs -->
          <div class="desktop-filters-row">
            <button 
              v-for="type in filterTypes" 
              :key="type.value" 
              class="filter-tab-btn" 
              :class="{ active: activeFilter === type.value }"
              @click="activeFilter = type.value"
            >
              {{ type.label }}
            </button>
          </div>
        </div>

        <h1 v-else class="page-main-title animate-fade-in-up">Historial 📅</h1>

        <!-- 1. Mobile History View (Grouped & Collapsible) -->
        <div v-if="isMobile" class="mobile-history-timeline">
          <template v-if="filteredEntries.length > 0">
            <div
              v-for="(entry, entryIdx) in filteredEntries"
              :key="entry.date"
              class="history-day animate-fade-in-up"
              :class="`stagger-${Math.min(entryIdx + 1, 6)}`"
            >
              <!-- Date Header -->
              <div class="day-header">
                <div class="day-dot"></div>
                <div class="day-info">
                  <span class="day-label">{{ formatDate(entry.date) }}</span>
                  <span class="day-count">{{ entry.items.length }} contenidos</span>
                </div>
              </div>

              <!-- Day Items -->
              <div class="day-items" :class="{ expanded: expandedDates.includes(entry.date) }">
                <AppContentCard
                  v-for="item in getVisibleItems(entry)"
                  :key="item.id"
                  :item="item"
                />

                <button
                  v-if="entry.items.length > 2"
                  class="show-more-button"
                  @click="toggleExpanded(entry.date)"
                >
                  {{ expandedDates.includes(entry.date)
                    ? 'Mostrar menos'
                    : `Ver ${entry.items.length - 2} más` }}
                </button>
              </div>
            </div>
          </template>

          <AppEmptyState
            v-else
            emoji="📅"
            title="Sin historial"
            description="El contenido que veas cada día se guardará aquí automáticamente."
          />
        </div>

        <!-- 2. Desktop/Tablet History View (Modern Horizontal Card Rows) -->
        <div v-else class="desktop-history-list">
          <template v-if="flatHistoryItems.length > 0">
            <div 
              v-for="item in flatHistoryItems" 
              :key="item.id" 
              class="history-row-card animate-fade-in-up"
              :class="{ 'is-expanded': expandedItems.includes(item.id) }"
            >
              <div class="row-card-main">
                <!-- Date -->
                <div class="row-cell date-cell">
                  <span class="cell-emoji">📅</span>
                  <span class="cell-text">{{ formatDate(item.date) }}</span>
                </div>
                
                <!-- Type badge -->
                <div class="row-cell type-cell">
                  <span class="type-badge" :class="`badge-${item.type}`">
                    {{ item.emoji }} {{ typeLabel(item.type) }}
                  </span>
                </div>
                
                <!-- Tech badge -->
                <div class="row-cell tech-cell">
                  <span class="tech-pill">{{ techLabel(item.technology) }}</span>
                </div>
                
                <!-- Area -->
                <div class="row-cell area-cell">
                  <span class="area-text">{{ areaLabel(item.area) }}</span>
                </div>
                
                <!-- Level Stars -->
                <div class="row-cell level-cell">
                  <span class="stars-text">{{ getStars(item.level) }}</span>
                </div>
                
                <!-- Actions -->
                <div class="row-cell actions-cell">
                  <button 
                    class="row-action-btn favorite-btn" 
                    :class="{ active: isFavorite(item.id) }" 
                    @click.stop="toggleFavorite(item)"
                    title="Guardar en Favoritos"
                  >
                    <ion-icon :icon="isFavorite(item.id) ? heart : heartOutline" />
                  </button>
                  <button 
                    class="row-action-btn expand-btn" 
                    @click.stop="toggleExpandItem(item.id)"
                    title="Ver Detalles"
                  >
                    <ion-icon :icon="expandedItems.includes(item.id) ? chevronUp : chevronDown" />
                  </button>
                </div>
              </div>

              <!-- Expanded Details block -->
              <transition name="slide-fade">
                <div v-if="expandedItems.includes(item.id)" class="row-expanded-detail">
                  <h4 class="detail-title">{{ item.title }}</h4>
                  <p class="detail-body">{{ item.body }}</p>
                </div>
              </transition>
            </div>
          </template>
          
          <AppEmptyState
            v-else
            emoji="🔍"
            title="Sin historial"
            description="No encontramos lecciones leídas que coincidan con la búsqueda o filtros."
          />
        </div>

      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { heart, heartOutline, chevronDown, chevronUp } from 'ionicons/icons';
import AppContentCard from '@/components/content/AppContentCard.vue';
import AppEmptyState from '@/components/common/AppEmptyState.vue';
import { useHistoryStore } from '@/stores/historyStore';
import { useFavoritesStore } from '@/stores/favoritesStore';
import { useSearchStore } from '@/stores/searchStore';
import { useLayout } from '@/composables/useLayout';
import { CONTENT_TYPE_LABELS, TECHNOLOGY_LABELS, AREA_LABELS } from '@/types/content';
import type { ContentItem, ContentType, Technology, Area } from '@/types/content';

const historyStore = useHistoryStore();
const favoritesStore = useFavoritesStore();
const searchStore = useSearchStore();
const { isMobile } = useLayout();

const expandedDates = ref<string[]>([]);
const expandedItems = ref<string[]>([]);
const activeFilter = ref<string>('all');

const filterTypes = [
  { label: 'Todos', value: 'all' },
  { label: 'Tips', value: 'tip' },
  { label: 'Conceptos', value: 'concept' },
  { label: 'Quizzes', value: 'question' },
  { label: 'Atajos', value: 'shortcut' }
];

const filteredEntries = computed(() => {
  if (!searchStore.query) return historyStore.entries;
  const q = searchStore.query.toLowerCase();
  
  return historyStore.entries.map(entry => {
    const items = entry.items.filter(
      item =>
        item.title.toLowerCase().includes(q) ||
        item.body.toLowerCase().includes(q) ||
        item.technology.toLowerCase().includes(q)
    );
    return {
      ...entry,
      items
    };
  }).filter(entry => entry.items.length > 0);
});

const flatHistoryItems = computed(() => {
  const list: any[] = [];
  
  historyStore.entries.forEach(entry => {
    entry.items.forEach(item => {
      // Filter by search query
      if (searchStore.query) {
        const q = searchStore.query.toLowerCase();
        const matchesSearch = 
          item.title.toLowerCase().includes(q) ||
          item.body.toLowerCase().includes(q) ||
          item.technology.toLowerCase().includes(q);
        if (!matchesSearch) return;
      }
      
      // Filter by active type filter
      if (activeFilter.value && activeFilter.value !== 'all') {
        if (item.type !== activeFilter.value) return;
      }
      
      list.push({
        ...item,
        date: entry.date
      });
    });
  });
  
  return list;
});

function isFavorite(id: string): boolean {
  return favoritesStore.isFavorite(id);
}

function toggleFavorite(item: ContentItem) {
  favoritesStore.toggleFavorite(item);
}

function toggleExpandItem(id: string) {
  const idx = expandedItems.value.indexOf(id);
  if (idx >= 0) {
    expandedItems.value.splice(idx, 1);
  } else {
    expandedItems.value.push(id);
  }
}

function formatDate(dateStr: string): string {
  const date = new Date(dateStr + 'T12:00:00');
  const today = new Date();
  const yesterday = new Date(today);
  yesterday.setDate(yesterday.getDate() - 1);

  if (dateStr === today.toISOString().split('T')[0]) return 'Hoy';
  if (dateStr === yesterday.toISOString().split('T')[0]) return 'Ayer';

  return date.toLocaleDateString('es-ES', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
  });
}

function toggleExpanded(date: string) {
  const idx = expandedDates.value.indexOf(date);
  if (idx >= 0) {
    expandedDates.value.splice(idx, 1);
  } else {
    expandedDates.value.push(date);
  }
}

function getVisibleItems(entry: { date: string; items: any[] }) {
  if (expandedDates.value.includes(entry.date)) {
    return entry.items;
  }
  return entry.items.slice(0, 2);
}

function typeLabel(type: string) {
  return CONTENT_TYPE_LABELS[type as ContentType] || type;
}

function techLabel(tech: string) {
  return TECHNOLOGY_LABELS[tech as Technology] || tech;
}

function areaLabel(area: string) {
  return AREA_LABELS[area as Area] || area;
}

function getStars(level: string) {
  switch (level) {
    case 'student': return '★☆☆☆☆';
    case 'junior': return '★★☆☆☆';
    case 'semi-senior': return '★★★☆☆';
    case 'senior': return '★★★★☆';
    default: return '★☆☆☆☆';
  }
}

onMounted(() => {
  historyStore.fetchHistory();
  favoritesStore.fetchFavorites();
});
</script>

<style scoped>
.history-content {
  --background: var(--dd-bg);
}

.page-main-title {
  font-size: 28px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0 0 24px;
  line-height: 1.2;
}

.history-container {
  padding: 16px 16px 100px;
  padding-top: calc(env(safe-area-inset-top) + 16px);
}

/* Timeline Day */
.history-day {
  position: relative;
  padding-left: 24px;
  margin-bottom: 24px;
}

.history-day::before {
  content: '';
  position: absolute;
  left: 7px;
  top: 24px;
  bottom: 0;
  width: 2px;
  background: var(--dd-border);
}

.history-day:last-child::before {
  display: none;
}

/* Day Header */
.day-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 12px;
  position: relative;
}

.day-dot {
  position: absolute;
  left: -20px;
  width: 14px;
  height: 14px;
  border-radius: 50%;
  background: var(--dd-gradient-primary);
  border: 3px solid var(--dd-bg);
  box-shadow: 0 0 0 2px var(--ion-color-primary);
}

.day-info {
  display: flex;
  flex-direction: column;
}

.day-label {
  font-size: 16px;
  font-weight: 700;
  color: var(--dd-text);
  text-transform: capitalize;
}

.day-count {
  font-size: 13px;
  color: var(--dd-text-secondary);
}

/* Show More */
.show-more-button {
  width: 100%;
  padding: 12px;
  background: var(--dd-surface);
  border: 1px dashed var(--dd-border);
  border-radius: var(--dd-radius-sm);
  color: var(--ion-color-primary);
  font-size: 14px;
  font-weight: 600;
  font-family: inherit;
  cursor: pointer;
  transition: all 0.2s ease;
}

.show-more-button:active {
  transform: scale(0.98);
}

/* DESKTOP STYLING (>=1024px) */
.history-desktop-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-bottom: 24px;
  border-bottom: 1px solid var(--dd-border);
  margin-bottom: 32px;
}

.desktop-title {
  font-size: 28px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0 0 6px;
  letter-spacing: -0.8px;
}

.desktop-subtitle {
  font-size: 14px;
  color: var(--dd-text-secondary);
  margin: 0;
}

/* Filter tabs on desktop */
.desktop-filters-row {
  display: flex;
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-sm, 10px);
  padding: 4px;
}

.filter-tab-btn {
  padding: 8px 16px;
  font-size: 13px;
  font-weight: 700;
  color: var(--dd-text-secondary);
  background: transparent;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.filter-tab-btn:hover {
  color: var(--dd-text);
}

.filter-tab-btn.active {
  background: var(--dd-bg);
  color: var(--ion-color-primary);
  box-shadow: var(--dd-shadow-sm);
}

/* Horizontal History Row Cards */
.desktop-history-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
  padding-bottom: 60px;
}

.history-row-card {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-sm, 10px);
  padding: 16px 24px;
  box-shadow: var(--dd-shadow-sm);
  display: flex;
  flex-direction: column;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
}

.history-row-card:hover {
  transform: translateY(-2px);
  box-shadow: var(--dd-shadow-md);
  border-color: var(--ion-color-primary);
}

.row-card-main {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
}

.row-cell {
  display: flex;
  align-items: center;
  font-size: 14px;
}

.date-cell {
  width: 16%;
  font-weight: 700;
  color: var(--dd-text);
  gap: 8px;
}

.type-cell {
  width: 18%;
}

.type-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 4px 12px;
  border-radius: var(--dd-radius-full);
  font-size: 12px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* Colors matching main badge colors */
.badge-tip { background: rgba(var(--ion-color-primary-rgb), 0.1); color: var(--ion-color-primary); }
.badge-curiosity { background: rgba(var(--ion-color-secondary-rgb), 0.1); color: var(--ion-color-secondary); }
.badge-phrase { background: rgba(var(--ion-color-tertiary-rgb), 0.1); color: var(--ion-color-tertiary); }
.badge-concept { background: rgba(var(--ion-color-primary-rgb), 0.1); color: var(--ion-color-primary); }
.badge-question { background: rgba(225, 112, 85, 0.1); color: #E17055; }
.badge-shortcut { background: rgba(99, 110, 114, 0.1); color: var(--dd-text-secondary); }

.tech-cell {
  width: 16%;
}

.tech-pill {
  font-size: 12px;
  font-weight: 700;
  color: var(--ion-color-secondary);
  background: rgba(var(--ion-color-secondary-rgb), 0.08);
  padding: 4px 12px;
  border-radius: 8px;
}

.area-cell {
  width: 18%;
  color: var(--dd-text-secondary);
  font-weight: 600;
}

.level-cell {
  width: 14%;
}

.stars-text {
  color: #f1c40f;
  font-weight: 700;
  font-size: 16px;
  letter-spacing: 1px;
}

.actions-cell {
  width: 10%;
  justify-content: flex-end;
  gap: 12px;
}

.row-action-btn {
  background: transparent;
  border: none;
  font-size: 18px;
  color: var(--dd-text-secondary);
  cursor: pointer;
  padding: 8px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s ease;
}

.row-action-btn:hover {
  background: var(--dd-bg);
  color: var(--dd-text);
}

.favorite-btn:hover {
  color: #ff4757;
}

.favorite-btn.active {
  color: #ff4757;
}

.expand-btn:hover {
  color: var(--ion-color-primary);
}

/* Expanded Detail panel */
.row-expanded-detail {
  margin-top: 16px;
  padding: 20px;
  background: var(--dd-bg);
  border: 1px solid var(--dd-border);
  border-radius: 8px;
  border-left: 4px solid var(--ion-color-primary);
}

.detail-title {
  font-size: 16px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0 0 10px;
}

.detail-body {
  font-size: 14px;
  color: var(--dd-text-secondary);
  margin: 0;
  line-height: 1.6;
  white-space: pre-line;
}

/* Slide fade animation */
.slide-fade-enter-active,
.slide-fade-leave-active {
  transition: all 0.3s ease;
}

.slide-fade-enter-from,
.slide-fade-leave-to {
  transform: translateY(-10px);
  opacity: 0;
}

@media (min-width: 1024px) {
  .history-container {
    padding: 0;
  }
}
</style>
