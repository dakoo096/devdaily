<template>
  <div class="dashboard-stats-card">
    <!-- Profile Progress Bar -->
    <div class="progress-section" v-if="authStore.user">
      <div class="progress-header">
        <span class="level-label">Nivel de Desarrollador</span>
        <span class="level-value">Lv. {{ authStore.user.devLevel || 1 }}</span>
      </div>
      <div class="xp-progress-track">
        <div class="xp-progress-fill" :style="{ width: `${xpProgressPercent}%` }"></div>
      </div>
      <div class="xp-text-row">
        <span>{{ xpInCurrentLevel }} / 100 XP</span>
        <span class="xp-to-next">Faltan {{ 100 - xpInCurrentLevel }} XP para el siguiente nivel</span>
      </div>
    </div>

    <!-- Stats Grid -->
    <div class="stats-grid">
      <div class="stat-item">
        <div class="stat-icon-wrap" style="background: rgba(108, 92, 231, 0.1); color: var(--ion-color-primary);">
          <ion-icon :icon="bookOutline" />
        </div>
        <div class="stat-info">
          <span class="stat-val">{{ stats.contentsRead }}</span>
          <span class="stat-lbl">Leídos</span>
        </div>
      </div>

      <div class="stat-item">
        <div class="stat-icon-wrap" style="background: rgba(225, 112, 85, 0.1); color: #E17055;">
          <ion-icon :icon="heartOutline" />
        </div>
        <div class="stat-info">
          <span class="stat-val">{{ stats.favorites }}</span>
          <span class="stat-lbl">Favoritos</span>
        </div>
      </div>

      <div class="stat-item">
        <div class="stat-icon-wrap" style="background: rgba(0, 206, 201, 0.1); color: var(--ion-color-secondary);">
          <ion-icon :icon="helpCircleOutline" />
        </div>
        <div class="stat-info">
          <span class="stat-val">{{ stats.quizzesCompleted }}</span>
          <span class="stat-lbl">Quizzes</span>
        </div>
      </div>

      <div class="stat-item">
        <div class="stat-icon-wrap" style="background: rgba(253, 203, 110, 0.1); color: #f1c40f;">
          <ion-icon :icon="ribbonOutline" />
        </div>
        <div class="stat-info">
          <span class="stat-val">{{ stats.accuracy }}%</span>
          <span class="stat-lbl">Precisión</span>
        </div>
      </div>

      <div class="stat-item">
        <div class="stat-icon-wrap" style="background: rgba(214, 48, 49, 0.1); color: #d63031;">
          <ion-icon :icon="flameOutline" />
        </div>
        <div class="stat-info">
          <span class="stat-val">🔥 {{ stats.longestStreak }}</span>
          <span class="stat-lbl">Racha Máx</span>
        </div>
      </div>

      <div class="stat-item">
        <div class="stat-icon-wrap" style="background: rgba(9, 132, 227, 0.1); color: #0984e3;">
          <ion-icon :icon="calendarOutline" />
        </div>
        <div class="stat-info">
          <span class="stat-val">{{ stats.daysActive }}</span>
          <span class="stat-lbl">Días Activos</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue';
import { IonIcon } from '@ionic/vue';
import { bookOutline, heartOutline, helpCircleOutline, ribbonOutline, flameOutline, calendarOutline } from 'ionicons/icons';
import { useAuthStore } from '@/stores/authStore';
import { useFavoritesStore } from '@/stores/favoritesStore';
import { useHistoryStore } from '@/stores/historyStore';
import { api } from '@/services/api';

const authStore = useAuthStore();
const favoritesStore = useFavoritesStore();
const historyStore = useHistoryStore();

const stats = ref({
  contentsRead: 0,
  favorites: 0,
  quizzesCompleted: 0,
  accuracy: 0,
  longestStreak: 0,
  daysActive: 0,
  xp: 0,
  level: 1
});

const xpInCurrentLevel = computed(() => {
  const xp = authStore.user?.devXp || stats.value.xp || 0;
  return xp % 100;
});

const xpProgressPercent = computed(() => {
  const xp = authStore.user?.devXp || stats.value.xp || 0;
  return xp % 100;
});

async function loadStats() {
  try {
    const statsData = await api.get<any>('/api/users/stats');
    stats.value = statsData;
  } catch (e) {
    console.error('Error loading stats in dashboard stats component', e);
  }
}

onMounted(() => {
  loadStats();
});

watch([
  () => authStore.user?.devXp,
  () => historyStore.totalViewed,
  () => favoritesStore.count
], () => {
  loadStats();
});
</script>

<style scoped>
.dashboard-stats-card {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-lg, 24px);
  padding: 24px;
  box-shadow: var(--dd-shadow-sm);
  display: flex;
  flex-direction: column;
  gap: 24px;
}

/* Progress bar section */
.progress-section {
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding-bottom: 20px;
  border-bottom: 1px solid var(--dd-border);
}

.progress-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.level-label {
  font-size: 14px;
  font-weight: 700;
  color: var(--dd-text-secondary);
}

.level-value {
  font-size: 18px;
  font-weight: 800;
  color: var(--ion-color-primary);
}

.xp-progress-track {
  width: 100%;
  height: 8px;
  background: var(--dd-bg);
  border-radius: var(--dd-radius-full);
  overflow: hidden;
}

.xp-progress-fill {
  height: 100%;
  background: var(--dd-gradient-primary);
  border-radius: var(--dd-radius-full);
  transition: width 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

.xp-text-row {
  display: flex;
  justify-content: space-between;
  font-size: 12px;
  font-weight: 600;
  color: var(--dd-text-secondary);
}

.xp-to-next {
  opacity: 0.8;
}

/* Stats grid section */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 14px;
  background: var(--dd-bg);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md, 16px);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.stat-item:hover {
  transform: translateY(-2px);
  box-shadow: var(--dd-shadow-sm);
  border-color: var(--ion-color-primary);
}

.stat-icon-wrap {
  width: 40px;
  height: 40px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  flex-shrink: 0;
}

.stat-info {
  display: flex;
  flex-direction: column;
}

.stat-val {
  font-size: 16px;
  font-weight: 800;
  color: var(--dd-text);
}

.stat-lbl {
  font-size: 11px;
  font-weight: 600;
  color: var(--dd-text-secondary);
  text-transform: uppercase;
  margin-top: 1px;
}

@media (max-width: 576px) {
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}
</style>
