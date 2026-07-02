<template>
  <ion-page>
    <ion-header>
      <ion-toolbar class="quiz-toolbar">
        <ion-buttons slot="start">
          <button class="header-back-btn" @click="handleExit">
            <ion-icon :icon="chevronBack" />
          </button>
        </ion-buttons>
        <ion-title class="quiz-title">Quiz Diario</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true" class="quiz-content">
      <!-- Loading State -->
      <div v-if="loading" class="center-container">
        <ion-spinner name="crescent" color="primary" />
        <p class="loading-text">Cargando tu reto de hoy...</p>
      </div>

      <!-- Already Completed State -->
      <div v-else-if="alreadyCompleted" class="center-container animate-fade-in-up">
        <div class="result-emoji">🎉</div>
        <h2 class="title-text">¡Reto de hoy completado!</h2>
        <p class="subtitle-text">Ya has respondido el quiz de hoy. Regresa mañana para una nueva dosis de conocimiento.</p>
        <button class="action-btn primary-btn" @click="goHome">Volver al Inicio</button>
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="center-container animate-fade-in-up">
        <div class="result-emoji">⚠️</div>
        <h2 class="title-text">¡Ups!</h2>
        <p class="subtitle-text">{{ error }}</p>
        <button class="action-btn primary-btn" @click="goHome">Volver al Inicio</button>
      </div>

      <!-- Intro / Start Screen -->
      <div v-else-if="gameState === 'intro'" class="intro-container animate-fade-in-up">
        <div class="intro-icon">🧠</div>
        <h2 class="intro-title">Pon a prueba tu conocimiento</h2>
        <p class="intro-desc">
          Responde **3 preguntas rápidas** basadas en tus tecnologías de interés.
          ¡Suma puntos y mantén activa tu racha diaria de aprendizaje!
        </p>
        <div class="intro-details">
          <div class="detail-item">
            <span class="detail-icon">🎯</span>
            <span class="detail-text">3 Preguntas rápidas</span>
          </div>
          <div class="detail-item">
            <span class="detail-icon">⚡</span>
            <span class="detail-text">Gana hasta +40 puntos</span>
          </div>
          <div class="detail-item">
            <span class="detail-icon">🔥</span>
            <span class="detail-text">Incrementa tu racha de días</span>
          </div>
        </div>
        <button class="action-btn primary-btn start-btn" @click="startQuiz">
          Comenzar Quiz 🚀
        </button>
      </div>

      <!-- Quiz Questions (Loop) -->
      <div v-else-if="gameState === 'playing' && currentQuestions.length > 0" class="quiz-container">
        <!-- Progress bar -->
        <div class="progress-section">
          <div class="progress-bar">
            <div class="progress-fill" :style="{ width: `${((currentQuestionIndex + 1) / 3) * 100}%` }"></div>
          </div>
          <span class="progress-text">{{ currentQuestionIndex + 1 }} / 3</span>
        </div>

        <!-- Question Card -->
        <div class="question-card animate-fade-in-up" :key="currentQuestionIndex">
          <div class="question-meta">
            <span class="meta-tag technology">{{ activeQuestion.technology.toUpperCase() }}</span>
            <span class="meta-tag difficulty">{{ activeQuestion.difficulty.toUpperCase() }}</span>
          </div>
          
          <h3 class="question-text">{{ activeQuestion.text }}</h3>

          <!-- Code Snippet -->
          <div v-if="activeQuestion.codeSnippet" class="code-container">
            <pre class="code-block"><code>{{ activeQuestion.codeSnippet }}</code></pre>
          </div>

          <!-- Options -->
          <div class="options-list">
            <button
              v-for="option in activeQuestion.options"
              :key="option.id"
              class="option-button"
              :class="{ selected: selectedOptionId === option.id }"
              @click="selectOption(option.id)"
            >
              <span class="option-indicator">{{ getOptionLetter(option.id) }}</span>
              <span class="option-text">{{ option.text }}</span>
            </button>
          </div>
        </div>

        <!-- Next Button -->
        <div class="navigation-section">
          <button
            class="action-btn primary-btn next-btn"
            :disabled="selectedOptionId === null"
            @click="nextQuestion"
          >
            {{ currentQuestionIndex === 2 ? 'Enviar respuestas 💾' : 'Siguiente pregunta' }}
          </button>
        </div>
      </div>

      <!-- Submitting State -->
      <div v-else-if="gameState === 'submitting'" class="center-container">
        <ion-spinner name="crescent" color="primary" />
        <p class="loading-text">Evaluando tus respuestas y guardando tus puntos...</p>
      </div>

      <!-- Results Screen -->
      <div v-else-if="gameState === 'results' && submitResponse" class="results-container animate-fade-in-up">
        <!-- Result Header -->
        <div class="results-header-card">
          <div class="trophy-emoji">🏆</div>
          <h2 class="results-title">¡Quiz Completado!</h2>
          <div class="score-badge">Acertaste: {{ submitResponse.score }} / 3</div>

          <!-- Stats Grid -->
          <div class="stats-mini-grid">
             <div class="stat-mini-card">
               <span class="stat-mini-value">+{{ submitResponse.xpEarned }}</span>
               <span class="stat-mini-label">Dev XP</span>
             </div>
            <div class="stat-mini-card">
              <span class="stat-mini-value">🔥 {{ submitResponse.currentStreak }}</span>
              <span class="stat-mini-label">Racha Días</span>
            </div>
            <div class="stat-mini-card">
              <span class="stat-mini-value">⭐ {{ submitResponse.longestStreak }}</span>
              <span class="stat-mini-label">Racha Récord</span>
            </div>
          </div>
        </div>

        <!-- Review Section -->
        <h3 class="review-section-title">Revisar respuestas</h3>
        <div class="review-list">
          <div
            v-for="(result, index) in submitResponse.results"
            :key="result.questionId"
            class="review-card"
            :class="result.correct ? 'correct' : 'incorrect'"
          >
            <div class="review-q-header">
              <span class="q-number">Pregunta {{ index + 1 }}</span>
              <span class="q-badge" :class="result.correct ? 'correct' : 'incorrect'">
                {{ result.correct ? 'Correcto' : 'Incorrecto' }}
              </span>
            </div>

            <p class="review-q-text">{{ getQuestionText(result.questionId) }}</p>

            <div class="review-answers">
              <p class="answer-row user-answer">
                <strong>Tu respuesta:</strong> {{ getOptionText(result.questionId, result.chosenOptionId) }}
              </p>
              <p v-if="!result.correct" class="answer-row correct-answer">
                <strong>Respuesta correcta:</strong> {{ getOptionText(result.questionId, result.correctOptionId) }}
              </p>
            </div>

            <!-- Explanation -->
            <div class="explanation-box">
              <div class="explanation-title">💡 Explicación:</div>
              <p class="explanation-text">{{ result.explanation }}</p>
            </div>

            <!-- Review Link -->
            <div v-if="result.relatedContentId" class="review-concept-box" @click="reviewConcept(result.relatedContentId)">
              <span class="review-icon">📖</span>
              <span class="review-link-text">
                Repasar tip relacionado: <span class="review-title-underline">{{ result.relatedContentTitle || 'Ver contenido' }}</span>
              </span>
            </div>
          </div>
        </div>

        <button class="action-btn primary-btn finish-btn" @click="goHome">
          Volver al Inicio
        </button>
      </div>

      <!-- Related Content Modal -->
      <ion-modal :is-open="selectedContentToShow !== null" @didDismiss="selectedContentToShow = null" class="concept-modal">
        <ion-header>
          <ion-toolbar class="modal-toolbar">
            <ion-title class="modal-title">Repasar Concepto</ion-title>
            <ion-buttons slot="end">
              <button class="modal-close-btn" @click="selectedContentToShow = null">
                Cerrar
              </button>
            </ion-buttons>
          </ion-toolbar>
        </ion-header>
        <ion-content class="ion-padding modal-content">
          <div v-if="selectedContentToShow" class="content-detail-view">
            <div class="content-detail-header">
              <span class="detail-emoji">{{ selectedContentToShow.emoji || '💡' }}</span>
              <span class="detail-tech">{{ selectedContentToShow.technology }}</span>
            </div>
            <h2 class="detail-title">{{ selectedContentToShow.title }}</h2>
            <div class="detail-divider"></div>
            <p class="detail-body">{{ selectedContentToShow.body }}</p>
          </div>
        </ion-content>
      </ion-modal>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import {
  IonPage, IonHeader, IonToolbar, IonTitle, IonContent,
  IonButtons, IonIcon, IonSpinner, IonModal
} from '@ionic/vue';
import { chevronBack } from 'ionicons/icons';
import { api } from '@/services/api';
import { useAuthStore } from '@/stores/authStore';

const router = useRouter();
const authStore = useAuthStore();

// Game States: 'intro', 'playing', 'submitting', 'results'
const gameState = ref<'intro' | 'playing' | 'submitting' | 'results'>('intro');
const loading = ref(true);
const alreadyCompleted = ref(false);
const error = ref<string | null>(null);

const currentQuestions = ref<any[]>([]);
const currentQuestionIndex = ref(0);
const selectedOptionId = ref<number | null>(null);
const userAnswers = ref<Array<{ questionId: number; chosenOptionId: number }>>([]);

const submitResponse = ref<any | null>(null);
const selectedContentToShow = ref<any | null>(null);

const activeQuestion = computed(() => {
  return currentQuestions.value[currentQuestionIndex.value];
});

onMounted(async () => {
  await loadQuiz();
});

async function loadQuiz() {
  loading.value = true;
  error.value = null;
  alreadyCompleted.value = false;

  try {
    const data = await api.get<any[]>('/api/quiz/today');
    currentQuestions.value = data;
    loading.value = false;
  } catch (err: any) {
    loading.value = false;
    if (err.message && err.message.includes('Ya has completado')) {
      alreadyCompleted.value = true;
    } else {
      error.value = err.message || 'No se pudo cargar el quiz de hoy.';
    }
  }
}

function startQuiz() {
  gameState.value = 'playing';
}

function selectOption(id: number) {
  selectedOptionId.value = id;
}

function getOptionLetter(id: number): string {
  if (!activeQuestion.value) return '';
  const idx = activeQuestion.value.options.findIndex((o: any) => o.id === id);
  return String.fromCharCode(65 + idx); // A, B, C, D...
}

function nextQuestion() {
  if (selectedOptionId.value === null) return;

  // Save current answer
  userAnswers.value.push({
    questionId: activeQuestion.value.id,
    chosenOptionId: selectedOptionId.value
  });

  if (currentQuestionIndex.value < 2) {
    currentQuestionIndex.value++;
    selectedOptionId.value = null;
  } else {
    submitQuiz();
  }
}

async function submitQuiz() {
  gameState.value = 'submitting';
  try {
    const response = await api.post<any>('/api/quiz/submit', {
      answers: userAnswers.value
    });
    submitResponse.value = response;
    
    // Update user profile immediately in authStore
    await authStore.fetchCurrentUser();
    
    gameState.value = 'results';
  } catch (err: any) {
    gameState.value = 'intro';
    error.value = err.message || 'Error al enviar las respuestas del quiz.';
  }
}

async function reviewConcept(contentId: number) {
  try {
    const data = await api.get<any>(`/api/content/${contentId}`);
    selectedContentToShow.value = data;
  } catch (err: any) {
    console.error('Error loading content for review', err);
  }
}

function getQuestionText(qId: number): string {
  const q = currentQuestions.value.find(item => item.id === qId);
  return q ? q.text : '';
}

function getOptionText(qId: number, oId: number): string {
  const q = currentQuestions.value.find(item => item.id === qId);
  if (!q) return '';
  const o = q.options.find((item: any) => item.id === oId);
  return o ? o.text : '';
}

function goHome() {
  router.replace('/app/home');
}

function handleExit() {
  if (gameState.value === 'playing') {
    // Confirm exiting
    if (confirm('¿Seguro que deseas salir? Perderás el progreso del quiz de hoy.')) {
      goHome();
    }
  } else {
    goHome();
  }
}
</script>

<style scoped>
.quiz-toolbar {
  --background: var(--dd-surface);
  --border-color: var(--dd-border);
}

.quiz-title {
  font-weight: 700;
  color: var(--dd-text);
  text-align: center;
}

.header-back-btn {
  background: none;
  border: none;
  font-size: 24px;
  color: var(--dd-text-secondary);
  display: flex;
  align-items: center;
  padding: 8px;
  cursor: pointer;
}

.quiz-content {
  --background: var(--dd-bg);
}

.center-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 70vh;
  padding: 24px;
  text-align: center;
}

.result-emoji {
  font-size: 64px;
  margin-bottom: 20px;
}

.title-text {
  font-size: 22px;
  font-weight: 800;
  color: var(--dd-text);
  margin-bottom: 12px;
}

.subtitle-text {
  font-size: 15px;
  color: var(--dd-text-secondary);
  max-width: 320px;
  line-height: 1.5;
  margin-bottom: 32px;
}

/* Intro Screen */
.intro-container {
  padding: 40px 24px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  min-height: 80vh;
  justify-content: center;
}

.intro-icon {
  font-size: 72px;
  margin-bottom: 24px;
  animation: pulse 3s ease-in-out infinite;
}

.intro-title {
  font-size: 26px;
  font-weight: 800;
  color: var(--dd-text);
  margin-bottom: 16px;
}

.intro-desc {
  font-size: 15px;
  color: var(--dd-text-secondary);
  max-width: 340px;
  line-height: 1.6;
  margin-bottom: 32px;
}

.intro-details {
  display: flex;
  flex-direction: column;
  gap: 16px;
  width: 100%;
  max-width: 300px;
  margin-bottom: 40px;
  text-align: left;
}

.detail-item {
  display: flex;
  align-items: center;
  gap: 16px;
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  padding: 14px 20px;
  border-radius: var(--dd-radius-md);
}

.detail-icon {
  font-size: 24px;
}

.detail-text {
  font-size: 14px;
  font-weight: 600;
  color: var(--dd-text);
}

/* Game Playing Screen */
.quiz-container {
  padding: 20px 20px 100px;
}

.progress-section {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 24px;
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
  transition: width 0.3s ease;
}

.progress-text {
  font-size: 13px;
  font-weight: 700;
  color: var(--dd-text-secondary);
}

.question-card {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-lg);
  padding: 24px 20px;
  margin-bottom: 24px;
  box-shadow: var(--dd-shadow-sm);
}

.question-meta {
  display: flex;
  gap: 8px;
  margin-bottom: 16px;
}

.meta-tag {
  font-size: 11px;
  font-weight: 700;
  padding: 4px 8px;
  border-radius: 4px;
  letter-spacing: 0.5px;
}

.meta-tag.technology {
  background: rgba(108, 92, 231, 0.1);
  color: #6c5ce7;
}

.meta-tag.difficulty {
  background: rgba(0, 206, 201, 0.1);
  color: #00cec9;
}

.question-text {
  font-size: 19px;
  font-weight: 800;
  color: var(--dd-text);
  line-height: 1.4;
  margin: 0 0 20px;
}

.code-container {
  margin-bottom: 20px;
  border-radius: var(--dd-radius-md);
  overflow: hidden;
  border: 1px solid var(--dd-border);
}

.code-block {
  margin: 0;
  padding: 16px;
  background: #1e1e1e;
  overflow-x: auto;
}

.code-block code {
  font-family: 'Fira Code', 'Courier New', Courier, monospace;
  font-size: 13px;
  color: #d4d4d4;
  line-height: 1.5;
}

.options-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.option-button {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px 20px;
  background: var(--dd-bg);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md);
  text-align: left;
  cursor: pointer;
  transition: all 0.2s ease;
  font-family: inherit;
  width: 100%;
}

.option-button:hover {
  background: var(--dd-surface-hover);
}

.option-button.selected {
  border-color: var(--ion-color-primary);
  background: rgba(var(--ion-color-primary-rgb), 0.05);
  box-shadow: 0 0 0 3px rgba(var(--ion-color-primary-rgb), 0.08);
}

.option-indicator {
  width: 28px;
  height: 28px;
  border-radius: 8px;
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 13px;
  font-weight: 700;
  color: var(--dd-text-secondary);
  flex-shrink: 0;
}

.option-button.selected .option-indicator {
  background: var(--dd-gradient-primary);
  color: #fff;
  border-color: transparent;
}

.option-text {
  font-size: 14px;
  font-weight: 600;
  color: var(--dd-text);
  line-height: 1.4;
}

/* Actions & Buttons */
.action-btn {
  border: none;
  font-family: inherit;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.25s ease;
  width: 100%;
  max-width: 320px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.primary-btn {
  padding: 16px 32px;
  background: var(--dd-gradient-primary);
  color: #fff;
  border-radius: var(--dd-radius-md);
  box-shadow: 0 4px 16px rgba(108, 92, 231, 0.3);
}

.primary-btn:active {
  transform: scale(0.97);
}

.primary-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  box-shadow: none;
}

.start-btn, .finish-btn {
  margin-top: 12px;
}

/* Results Screen */
.results-container {
  padding: 20px;
}

.results-header-card {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-lg);
  padding: 32px 20px;
  text-align: center;
  margin-bottom: 32px;
  box-shadow: var(--dd-shadow-sm);
}

.trophy-emoji {
  font-size: 64px;
  margin-bottom: 16px;
  animation: bounce 2s infinite;
}

.results-title {
  font-size: 24px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0 0 12px;
}

.score-badge {
  display: inline-block;
  background: rgba(0, 206, 201, 0.1);
  color: #00cec9;
  font-size: 16px;
  font-weight: 800;
  padding: 8px 16px;
  border-radius: 20px;
  margin-bottom: 24px;
}

.stats-mini-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
}

.stat-mini-card {
  background: var(--dd-bg);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md);
  padding: 12px 8px;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.stat-mini-value {
  font-size: 18px;
  font-weight: 800;
  color: var(--dd-text);
}

.stat-mini-label {
  font-size: 11px;
  color: var(--dd-text-secondary);
  font-weight: 500;
}

.review-section-title {
  font-size: 16px;
  font-weight: 800;
  color: var(--dd-text);
  margin-bottom: 16px;
}

.review-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
  margin-bottom: 32px;
}

.review-card {
  background: var(--dd-surface);
  border-left: 4px solid;
  border-radius: var(--dd-radius-md);
  padding: 18px 16px;
  box-shadow: var(--dd-shadow-sm);
}

.review-card.correct {
  border-left-color: var(--ion-color-success);
}

.review-card.incorrect {
  border-left-color: var(--ion-color-danger);
}

.review-q-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.q-number {
  font-size: 12px;
  font-weight: 700;
  color: var(--dd-text-secondary);
  text-transform: uppercase;
}

.q-badge {
  font-size: 11px;
  font-weight: 700;
  padding: 4px 8px;
  border-radius: 4px;
}

.q-badge.correct {
  background: rgba(45, 211, 111, 0.1);
  color: var(--ion-color-success);
}

.q-badge.incorrect {
  background: rgba(235, 68, 90, 0.1);
  color: var(--ion-color-danger);
}

.review-q-text {
  font-size: 15px;
  font-weight: 700;
  color: var(--dd-text);
  line-height: 1.4;
  margin: 0 0 16px;
}

.review-answers {
  background: var(--dd-bg);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md);
  padding: 12px 14px;
  margin-bottom: 14px;
}

.answer-row {
  font-size: 13px;
  line-height: 1.4;
  margin: 0;
}

.answer-row.user-answer {
  color: var(--dd-text);
  margin-bottom: 6px;
}

.answer-row.correct-answer {
  color: var(--ion-color-success);
}

.explanation-box {
  background: rgba(253, 203, 110, 0.08);
  border: 1px dashed rgba(253, 203, 110, 0.4);
  border-radius: var(--dd-radius-md);
  padding: 12px 14px;
}

.explanation-title {
  font-size: 12px;
  font-weight: 700;
  color: #e1b12c;
  margin-bottom: 4px;
}

.explanation-text {
  font-size: 13px;
  color: var(--dd-text-secondary);
  line-height: 1.4;
  margin: 0;
}

.finish-btn {
  margin: 0 auto;
}

/* Animations */
@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

@keyframes bounce {
  0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
  40% { transform: translateY(-15px); }
  60% { transform: translateY(-7px); }
}

/* Concept Review Box & Link */
.review-concept-box {
  margin-top: 14px;
  display: flex;
  align-items: center;
  gap: 8px;
  background: rgba(var(--ion-color-primary-rgb), 0.05);
  border: 1px solid rgba(var(--ion-color-primary-rgb), 0.15);
  border-radius: var(--dd-radius-md);
  padding: 10px 14px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.review-concept-box:active {
  background: rgba(var(--ion-color-primary-rgb), 0.1);
  transform: scale(0.98);
}

.review-icon {
  font-size: 16px;
}

.review-link-text {
  font-size: 13px;
  font-weight: 600;
  color: var(--ion-color-primary);
}

.review-title-underline {
  text-decoration: underline;
  font-weight: 700;
}

/* Modal styling */
.concept-modal {
  --background: var(--dd-bg);
  --border-color: var(--dd-border);
  --border-radius: 16px;
}

.modal-toolbar {
  --background: var(--dd-surface);
  --border-color: var(--dd-border);
}

.modal-title {
  font-weight: 700;
  color: var(--dd-text);
}

.modal-close-btn {
  background: none;
  border: none;
  font-size: 14px;
  font-weight: 600;
  color: var(--ion-color-primary);
  padding: 8px 16px;
  cursor: pointer;
}

.modal-content {
  --background: var(--dd-bg);
}

.content-detail-view {
  padding: 12px 4px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.content-detail-header {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  margin-bottom: 16px;
}

.detail-emoji {
  font-size: 48px;
  line-height: 1;
}

.detail-tech {
  font-size: 11px;
  font-weight: 800;
  color: var(--ion-color-primary);
  background: rgba(var(--ion-color-primary-rgb), 0.1);
  padding: 4px 10px;
  border-radius: 4px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.detail-title {
  font-size: 22px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0 0 16px;
  line-height: 1.3;
}

.detail-divider {
  width: 40px;
  height: 4px;
  background: var(--dd-gradient-primary);
  border-radius: 2px;
  margin-bottom: 24px;
}

.detail-body {
  font-size: 15px;
  color: var(--dd-text-secondary);
  line-height: 1.6;
  margin: 0;
  text-align: left;
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  padding: 20px;
  border-radius: var(--dd-radius-md);
  width: 100%;
}
</style>
