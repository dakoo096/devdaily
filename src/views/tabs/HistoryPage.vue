<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-title class="page-title">Historial</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true" class="history-content">
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large" class="page-title-large">Historial 📅</ion-title>
        </ion-toolbar>
      </ion-header>

      <div class="history-container">
        <template v-if="historyStore.entries.length > 0">
          <div
            v-for="(entry, entryIdx) in historyStore.entries"
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

            <!-- Day Items (collapsed, shows toggle) -->
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
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent } from '@ionic/vue';
import AppContentCard from '@/components/content/AppContentCard.vue';
import AppEmptyState from '@/components/common/AppEmptyState.vue';
import { useHistoryStore } from '@/stores/historyStore';

const historyStore = useHistoryStore();
const expandedDates = ref<string[]>([]);

onMounted(() => {
  historyStore.fetchHistory();
});

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
</script>

<style scoped>
.history-content {
  --background: var(--dd-bg);
}

.page-title { font-weight: 700; }
.page-title-large { font-weight: 800; }

.history-container {
  padding: 0 16px 100px;
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
</style>
