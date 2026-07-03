<template>
  <div class="continue-learning-card">
    <div class="card-title-row">
      <span class="card-badge">RUTA DE APRENDIZAJE</span>
      <span class="card-percent">{{ progressValue }}%</span>
    </div>
    
    <h3 class="card-main-title">Continúa aprendiendo</h3>
    
    <div class="card-track-info">
      <span class="track-area">{{ activeArea }}</span>
      <span class="track-sep">/</span>
      <span class="track-tech">{{ activeTech }}</span>
    </div>

    <!-- Progress bar -->
    <div class="track-progress-bar">
      <div class="track-progress-fill" :style="{ width: `${progressValue}%` }"></div>
    </div>

    <div class="card-footer-row">
      <span class="footer-desc">Completado 13 de 20 lecciones</span>
      <button class="seguir-btn" @click="scrollBtnClick">
        <span>Seguir</span>
        <ion-icon :icon="arrowForwardOutline" />
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { IonIcon } from '@ionic/vue';
import { arrowForwardOutline } from 'ionicons/icons';
import { useSettingsStore } from '@/stores/settingsStore';
import { TECHNOLOGY_LABELS } from '@/types/content';
import type { Technology } from '@/types/content';

const settingsStore = useSettingsStore();

// Dynamically read from settings
const activeTech = computed(() => {
  const selected = settingsStore.preferences.technologies || [];
  if (selected.length > 0) {
    const key = selected[0];
    return TECHNOLOGY_LABELS[key as Technology] || 'Vue';
  }
  return 'Vue';
});

const activeArea = computed(() => {
  const tech = activeTech.value.toLowerCase();
  if (tech.includes('vue') || tech.includes('react') || tech.includes('javascript') || tech.includes('typescript')) {
    return 'Frontend';
  } else if (tech.includes('spring') || tech.includes('java')) {
    return 'Backend';
  } else if (tech.includes('mysql') || tech.includes('postgresql') || tech.includes('database')) {
    return 'Bases de Datos';
  } else {
    return 'Fullstack';
  }
});

const progressValue = computed(() => {
  // Let's keep it stable around 65% for style, or slightly offset it by level
  return 65;
});

function scrollBtnClick() {
  const cardsElement = document.querySelector('.content-list');
  if (cardsElement) {
    cardsElement.scrollIntoView({ behavior: 'smooth', block: 'start' });
  }
}
</script>

<style scoped>
.continue-learning-card {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-lg, 24px);
  padding: 24px;
  box-shadow: var(--dd-shadow-sm);
  display: flex;
  flex-direction: column;
  position: relative;
  overflow: hidden;
  background: radial-gradient(circle at 0% 100%, rgba(0, 206, 201, 0.08) 0%, var(--dd-surface) 60%);
}

.continue-learning-card::after {
  content: '';
  position: absolute;
  top: 0;
  right: 0;
  width: 150px;
  height: 150px;
  background: radial-gradient(circle, rgba(108, 92, 231, 0.05) 0%, transparent 70%);
  z-index: 1;
  pointer-events: none;
}

.card-title-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
  z-index: 2;
}

.card-badge {
  font-size: 10px;
  font-weight: 800;
  color: var(--ion-color-secondary);
  background: rgba(0, 206, 201, 0.1);
  padding: 4px 10px;
  border-radius: var(--dd-radius-full, 9999px);
  letter-spacing: 0.5px;
}

.card-percent {
  font-size: 20px;
  font-weight: 800;
  color: var(--dd-text);
}

.card-main-title {
  font-size: 18px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0 0 6px;
  z-index: 2;
}

.card-track-info {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 13px;
  font-weight: 600;
  color: var(--dd-text-secondary);
  margin-bottom: 20px;
  z-index: 2;
}

.track-area {
  color: var(--dd-text);
}

.track-tech {
  color: var(--ion-color-primary);
  font-weight: 700;
}

.track-sep {
  color: var(--dd-border);
}

.track-progress-bar {
  width: 100%;
  height: 8px;
  background: var(--dd-bg);
  border-radius: var(--dd-radius-full);
  margin-bottom: 20px;
  overflow: hidden;
  z-index: 2;
}

.track-progress-fill {
  height: 100%;
  background: linear-gradient(90deg, var(--ion-color-primary) 0%, var(--ion-color-secondary) 100%);
  border-radius: var(--dd-radius-full);
  transition: width 0.6s ease;
}

.card-footer-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 2;
}

.footer-desc {
  font-size: 12px;
  color: var(--dd-text-secondary);
  font-weight: 600;
}

.seguir-btn {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 18px;
  background: var(--dd-gradient-primary);
  color: #fff;
  border: none;
  border-radius: var(--dd-radius-sm, 10px);
  font-size: 13px;
  font-weight: 700;
  cursor: pointer;
  box-shadow: 0 4px 10px rgba(108, 92, 231, 0.2);
  transition: all 0.2s ease;
}

.seguir-btn:hover {
  transform: translateX(3px);
  box-shadow: 0 6px 14px rgba(108, 92, 231, 0.35);
}

.seguir-btn ion-icon {
  font-size: 14px;
}
</style>
