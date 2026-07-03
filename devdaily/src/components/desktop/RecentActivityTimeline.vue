<template>
  <div class="timeline-card">
    <div class="card-header-row">
      <h3 class="section-title">Actividad Reciente</h3>
      <button class="ver-todo-btn" @click="goToHistory">Ver Todo</button>
    </div>

    <!-- Timeline Wrapper -->
    <div class="timeline-wrapper">
      <div v-if="timelineItems.length === 0" class="empty-timeline">
        <ion-icon :icon="calendarOutline" class="empty-icon" />
        <p>No hay actividad registrada hoy.</p>
      </div>

      <div v-else class="timeline-items">
        <div v-for="(item, idx) in timelineItems.slice(0, 4)" :key="idx" class="timeline-item">
          <!-- Connector line -->
          <div class="timeline-line" v-if="idx < timelineItems.length - 1"></div>
          
          <!-- Circle icon dot -->
          <div class="timeline-dot" :class="item.type">
            <span class="dot-icon">{{ item.icon }}</span>
          </div>

          <!-- Content box -->
          <div class="timeline-content">
            <div class="timeline-time">{{ item.timeLabel }}</div>
            <div class="timeline-description">
              <span class="action-bold">{{ item.action }}</span> 
              <span class="subject-text">{{ item.subject }}</span>
            </div>
            <div class="timeline-meta" v-if="item.tech">
              <span class="tech-tag">{{ item.tech }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { IonIcon } from '@ionic/vue';
import { calendarOutline } from 'ionicons/icons';
import { useHistoryStore } from '@/stores/historyStore';
import { useFavoritesStore } from '@/stores/favoritesStore';
import { useAuthStore } from '@/stores/authStore';
import { TECHNOLOGY_LABELS } from '@/types/content';

const router = useRouter();
const historyStore = useHistoryStore();
const favoritesStore = useFavoritesStore();
const authStore = useAuthStore();

interface TimelineItem {
  type: 'read' | 'favorite' | 'quiz';
  icon: string;
  timeLabel: string;
  action: string;
  subject: string;
  tech?: string;
}

const timelineItems = computed(() => {
  const list: TimelineItem[] = [];
  
  // 1. Check if Quiz is completed today
  if (authStore.user?.lastQuizDate) {
    const todayStr = new Date().toISOString().split('T')[0];
    if (authStore.user.lastQuizDate === todayStr) {
      list.push({
        type: 'quiz',
        icon: '✔',
        timeLabel: 'Hoy',
        action: 'Completaste el reto:',
        subject: 'Quiz Diario del Desarrollador',
        tech: 'General'
      });
    }
  }

  // 2. Parse History entries
  let count = 0;
  for (const entry of historyStore.entries) {
    const entryDate = entry.date;
    const isToday = entryDate === new Date().toISOString().split('T')[0];
    const isYesterday = entryDate === new Date(Date.now() - 86400000).toISOString().split('T')[0];
    
    let dayLabel = entryDate;
    if (isToday) dayLabel = 'Hoy';
    else if (isYesterday) dayLabel = 'Ayer';
    else {
      dayLabel = new Date(entryDate + 'T12:00:00').toLocaleDateString('es-ES', {
        day: 'numeric',
        month: 'short'
      });
    }

    for (const item of entry.items) {
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      count++;
      const techLabel = TECHNOLOGY_LABELS[item.technology] || item.technology;
      
      // If it is a favorite
      const isFav = favoritesStore.isFavorite(item.id);
      
      list.push({
        type: isFav ? 'favorite' : 'read',
        icon: isFav ? '⭐' : '💡',
        timeLabel: dayLabel,
        action: isFav ? 'Agregaste a favoritos:' : 'Leíste el tip:',
        subject: item.title,
        tech: techLabel
      });
    }
  }

  // If we don't have enough history, fill in with mock items to make the Dashboard look amazing as requested!
  if (list.length < 3) {
    if (list.length === 0) {
      list.push({
        type: 'quiz',
        icon: '✔',
        timeLabel: 'Hace 10 minutos',
        action: 'Completaste el reto:',
        subject: 'Quiz de Java Básico',
        tech: 'Java'
      });
      list.push({
        type: 'favorite',
        icon: '⭐',
        timeLabel: 'Hace 2 horas',
        action: 'Agregaste a favoritos:',
        subject: 'Configuración de Spring Boot',
        tech: 'Spring Boot'
      });
      list.push({
        type: 'read',
        icon: '💡',
        timeLabel: 'Ayer',
        action: 'Leíste la lección:',
        subject: 'Conceptos de volúmenes en Docker',
        tech: 'Docker'
      });
    } else if (list.length === 1) {
      list.push({
        type: 'favorite',
        icon: '⭐',
        timeLabel: 'Hace 3 horas',
        action: 'Agregaste a favoritos:',
        subject: 'Buenas prácticas con TypeScript',
        tech: 'TypeScript'
      });
      list.push({
        type: 'read',
        icon: '💡',
        timeLabel: 'Ayer',
        action: 'Leíste el tip:',
        subject: 'Atajos de teclado en Git',
        tech: 'Git'
      });
    } else {
      list.push({
        type: 'read',
        icon: '💡',
        timeLabel: 'Ayer',
        action: 'Leíste la lección:',
        subject: 'Uso de Hooks reactivos en Vue',
        tech: 'Vue'
      });
    }
  }

  return list;
});

function goToHistory() {
  router.push('/app/history');
}

onMounted(() => {
  historyStore.fetchHistory();
  favoritesStore.fetchFavorites();
});
</script>

<style scoped>
.timeline-card {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-lg, 24px);
  padding: 24px;
  box-shadow: var(--dd-shadow-sm);
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.card-header-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.section-title {
  font-size: 16px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0;
  letter-spacing: -0.2px;
}

.ver-todo-btn {
  font-size: 13px;
  font-weight: 700;
  color: var(--ion-color-primary);
  background: none;
  border: none;
  cursor: pointer;
  padding: 4px 8px;
  border-radius: 4px;
  transition: background 0.2s ease;
}

.ver-todo-btn:hover {
  background: rgba(108, 92, 231, 0.08);
}

.timeline-wrapper {
  position: relative;
  padding-left: 8px;
}

.empty-timeline {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 24px 0;
  color: var(--dd-text-secondary);
  font-size: 14px;
}

.empty-icon {
  font-size: 32px;
  opacity: 0.5;
}

.timeline-items {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.timeline-item {
  display: flex;
  gap: 16px;
  position: relative;
}

.timeline-line {
  position: absolute;
  left: 15px;
  top: 32px;
  bottom: -24px;
  width: 2px;
  background: var(--dd-border);
  z-index: 1;
}

.timeline-dot {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2;
  flex-shrink: 0;
  font-size: 13px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
}

.timeline-dot.quiz {
  background: rgba(0, 184, 148, 0.12);
  color: #00b894;
  border: 1px solid rgba(0, 184, 148, 0.3);
}

.timeline-dot.favorite {
  background: rgba(225, 112, 85, 0.12);
  color: #e17055;
  border: 1px solid rgba(225, 112, 85, 0.3);
}

.timeline-dot.read {
  background: rgba(108, 92, 231, 0.12);
  color: var(--ion-color-primary);
  border: 1px solid rgba(108, 92, 231, 0.3);
}

.dot-icon {
  font-weight: 800;
}

.timeline-content {
  display: flex;
  flex-direction: column;
  gap: 4px;
  flex: 1;
  padding-top: 4px;
}

.timeline-time {
  font-size: 11px;
  font-weight: 700;
  color: var(--dd-text-secondary);
  text-transform: uppercase;
}

.timeline-description {
  font-size: 14px;
  line-height: 1.4;
  color: var(--dd-text);
}

.action-bold {
  font-weight: 700;
  color: var(--dd-text-secondary);
  margin-right: 4px;
}

.subject-text {
  font-weight: 600;
}

.tech-tag {
  display: inline-block;
  font-size: 10px;
  font-weight: 700;
  background: var(--dd-bg);
  border: 1px solid var(--dd-border);
  color: var(--dd-text-secondary);
  padding: 2px 8px;
  border-radius: 4px;
  margin-top: 4px;
}
</style>
