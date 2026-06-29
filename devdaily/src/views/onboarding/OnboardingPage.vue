<template>
  <ion-page>
    <ion-content :fullscreen="true" class="onboarding-content">
      <div class="onboarding-container">
        <!-- Close Button -->
        <div v-if="authStore.onboardingCompleted" class="header-section">
          <button class="close-button" @click="handleCancel">
            <ion-icon :icon="closeOutline" />
          </button>
        </div>

        <!-- Progress Bar -->
        <div class="progress-section">
          <div class="progress-bar">
            <div class="progress-fill" :style="{ width: `${((currentStep + 1) / 4) * 100}%` }"></div>
          </div>
          <span class="progress-text">{{ currentStep + 1 }} / 4</span>
        </div>

        <!-- Step 1: Content Types -->
        <div v-if="currentStep === 0" class="step-content animate-fade-in-up" key="step-0">
          <div class="step-emoji">📦</div>
          <h2 class="step-title">¿Qué tipo de contenido te interesa?</h2>
          <p class="step-subtitle">Selecciona uno o más tipos</p>
          <div class="chips-grid">
            <AppChip
              v-for="(label, key) in CONTENT_TYPE_LABELS"
              :key="key"
              :label="label"
              :emoji="CONTENT_TYPE_EMOJIS[key as ContentType]"
              :selected="selectedContentTypes.includes(key as ContentType)"
              @click="toggleSelection(selectedContentTypes, key as ContentType)"
            />
          </div>
        </div>

        <!-- Step 2: Areas -->
        <div v-if="currentStep === 1" class="step-content animate-fade-in-up" key="step-1">
          <div class="step-emoji">🎯</div>
          <h2 class="step-title">¿Qué áreas te interesan?</h2>
          <p class="step-subtitle">Selecciona tus áreas de enfoque</p>
          <div class="chips-grid">
            <AppChip
              v-for="(label, key) in AREA_LABELS"
              :key="key"
              :label="label"
              :emoji="AREA_EMOJIS[key as Area]"
              :selected="selectedAreas.includes(key as Area)"
              @click="toggleSelection(selectedAreas, key as Area)"
            />
          </div>
        </div>

        <!-- Step 3: Technologies -->
        <div v-if="currentStep === 2" class="step-content animate-fade-in-up" key="step-2">
          <div class="step-emoji">🛠️</div>
          <h2 class="step-title">¿Con qué tecnologías trabajas?</h2>
          <p class="step-subtitle">Selecciona tus tecnologías</p>
          <div class="chips-grid">
            <AppChip
              v-for="(label, key) in TECHNOLOGY_LABELS"
              :key="key"
              :label="label"
              :selected="selectedTechnologies.includes(key as Technology)"
              @click="toggleSelection(selectedTechnologies, key as Technology)"
            />
          </div>
        </div>

        <!-- Step 4: Level -->
        <div v-if="currentStep === 3" class="step-content animate-fade-in-up" key="step-3">
          <div class="step-emoji">📊</div>
          <h2 class="step-title">¿Cuál es tu nivel?</h2>
          <p class="step-subtitle">Esto nos ayuda a personalizar tu contenido</p>
          <div class="level-options">
            <button
              v-for="(label, key) in LEVEL_LABELS"
              :key="key"
              class="level-card"
              :class="{ selected: selectedLevel === key }"
              @click="selectedLevel = key as Level"
            >
              <span class="level-emoji">{{ LEVEL_EMOJIS[key as Level] }}</span>
              <span class="level-label">{{ label }}</span>
              <span class="level-desc">{{ LEVEL_DESCRIPTIONS[key as Level] }}</span>
            </button>
          </div>
        </div>

        <!-- Navigation Buttons -->
        <div class="nav-buttons">
          <button
            v-if="currentStep > 0"
            class="nav-button secondary"
            @click="currentStep--"
          >
            Atrás
          </button>
          <div v-else></div>

          <button
            class="nav-button primary"
            :disabled="!canProceed"
            @click="handleNext"
          >
            {{ currentStep === 3 ? '¡Empezar! 🚀' : 'Siguiente' }}
          </button>
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { closeOutline } from 'ionicons/icons';
import AppChip from '@/components/common/AppChip.vue';
import { useSettingsStore } from '@/stores/settingsStore';
import { useAuthStore } from '@/stores/authStore';
import type { ContentType, Area, Technology, Level } from '@/types/content';
import {
  CONTENT_TYPE_LABELS,
  CONTENT_TYPE_EMOJIS,
  AREA_LABELS,
  AREA_EMOJIS,
  TECHNOLOGY_LABELS,
  LEVEL_LABELS,
  LEVEL_EMOJIS,
} from '@/types/content';

const router = useRouter();
const settingsStore = useSettingsStore();
const authStore = useAuthStore();

const currentStep = ref(0);
const selectedContentTypes = ref<ContentType[]>([...settingsStore.preferences.contentTypes]);
const selectedAreas = ref<Area[]>([...settingsStore.preferences.areas]);
const selectedTechnologies = ref<Technology[]>([...settingsStore.preferences.technologies]);
const selectedLevel = ref<Level>(settingsStore.preferences.level || 'junior');

const LEVEL_DESCRIPTIONS: Record<Level, string> = {
  student: 'Estoy aprendiendo a programar',
  junior: 'Menos de 2 años de experiencia',
  'semi-senior': '2-5 años de experiencia',
  senior: 'Más de 5 años de experiencia',
};

function toggleSelection<T>(arr: T[], item: T) {
  const index = arr.indexOf(item);
  if (index >= 0) {
    arr.splice(index, 1);
  } else {
    arr.push(item);
  }
}

const canProceed = computed(() => {
  switch (currentStep.value) {
    case 0: return selectedContentTypes.value.length > 0;
    case 1: return selectedAreas.value.length > 0;
    case 2: return selectedTechnologies.value.length > 0;
    case 3: return !!selectedLevel.value;
    default: return false;
  }
});

function handleNext() {
  if (currentStep.value < 3) {
    currentStep.value++;
  } else {
    // Save preferences and complete onboarding
    settingsStore.updateContentTypes(selectedContentTypes.value);
    settingsStore.updateAreas(selectedAreas.value);
    settingsStore.updateTechnologies(selectedTechnologies.value);
    settingsStore.updateLevel(selectedLevel.value);
    settingsStore.completeOnboarding();
    router.replace('/tabs/home');
  }
}

function handleCancel() {
  router.back();
}
</script>

<style scoped>
.onboarding-content {
  --background: var(--dd-bg);
}

.onboarding-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  padding: 24px;
  padding-top: calc(env(safe-area-inset-top) + 24px);
}

/* Progress */
.progress-section {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 32px;
}

.progress-bar {
  flex: 1;
  height: 6px;
  background: var(--dd-border);
  border-radius: 3px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: var(--dd-gradient-primary);
  border-radius: 3px;
  transition: width 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.progress-text {
  font-size: 13px;
  font-weight: 600;
  color: var(--dd-text-secondary);
  min-width: 32px;
  text-align: right;
}

/* Step Content */
.step-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.step-emoji {
  font-size: 56px;
  margin-bottom: 16px;
}

.step-title {
  font-size: 24px;
  font-weight: 800;
  color: var(--dd-text);
  text-align: center;
  margin: 0 0 8px;
  line-height: 1.3;
}

.step-subtitle {
  font-size: 15px;
  color: var(--dd-text-secondary);
  margin: 0 0 32px;
  text-align: center;
}

.chips-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  justify-content: center;
  max-width: 400px;
}

/* Level Cards */
.level-options {
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: 100%;
  max-width: 360px;
}

.level-card {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 16px 20px;
  background: var(--dd-surface);
  border: 2px solid var(--dd-border);
  border-radius: var(--dd-radius-md);
  cursor: pointer;
  transition: all 0.25s ease;
  text-align: left;
  font-family: inherit;
}

.level-card:active {
  transform: scale(0.98);
}

.level-card.selected {
  border-color: var(--ion-color-primary);
  background: rgba(var(--ion-color-primary-rgb), 0.06);
  box-shadow: 0 0 0 4px rgba(var(--ion-color-primary-rgb), 0.08);
}

.level-emoji {
  font-size: 28px;
  flex-shrink: 0;
}

.level-label {
  font-size: 16px;
  font-weight: 700;
  color: var(--dd-text);
  display: block;
}

.level-desc {
  font-size: 13px;
  color: var(--dd-text-secondary);
  display: block;
  margin-top: 2px;
}

/* Navigation */
.nav-buttons {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 24px;
  padding-bottom: env(safe-area-inset-bottom);
  margin-top: auto;
}

.nav-button {
  padding: 14px 32px;
  border-radius: var(--dd-radius-sm);
  font-size: 15px;
  font-weight: 600;
  font-family: inherit;
  cursor: pointer;
  transition: all 0.25s ease;
  border: none;
}

.nav-button:active {
  transform: scale(0.96);
}

.nav-button.primary {
  background: var(--dd-gradient-primary);
  color: #fff;
  box-shadow: 0 4px 16px rgba(108, 92, 231, 0.3);
}

.nav-button.primary:disabled {
  opacity: 0.4;
  cursor: not-allowed;
  box-shadow: none;
}

.nav-button.secondary {
  background: var(--dd-surface);
  color: var(--dd-text-secondary);
  border: 1px solid var(--dd-border);
}

.header-section {
  display: flex;
  justify-content: flex-end;
  margin-bottom: 12px;
}

.close-button {
  background: none;
  border: none;
  color: var(--dd-text-secondary);
  font-size: 28px;
  cursor: pointer;
  padding: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s ease;
  border-radius: 50%;
}

.close-button:active {
  color: var(--dd-text);
  background: var(--dd-surface-hover);
}
</style>
