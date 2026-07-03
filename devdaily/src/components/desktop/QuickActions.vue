<template>
  <div class="quick-actions-card">
    <div class="section-title">Acciones Rápidas</div>
    <div class="actions-grid">
      <button class="action-btn primary-action" @click="goToQuiz">
        <div class="action-icon-box">
          <ion-icon :icon="sparklesOutline" />
        </div>
        <div class="action-text">
          <span class="action-title">Nuevo Quiz</span>
          <span class="action-desc">Pon a prueba tu mente</span>
        </div>
      </button>

      <button class="action-btn" @click="goToFavorites">
        <div class="action-icon-box fav">
          <ion-icon :icon="heartOutline" />
        </div>
        <div class="action-text">
          <span class="action-title">Favoritos</span>
          <span class="action-desc">Revisa tus marcadores</span>
        </div>
      </button>

      <button class="action-btn" @click="goToHistory">
        <div class="action-icon-box hist">
          <ion-icon :icon="timeOutline" />
        </div>
        <div class="action-text">
          <span class="action-title">Historial</span>
          <span class="action-desc">Lecciones leídas</span>
        </div>
      </button>

      <button class="action-btn" @click="goToProfile">
        <div class="action-icon-box prof">
          <ion-icon :icon="createOutline" />
        </div>
        <div class="action-text">
          <span class="action-title">Editar Perfil</span>
          <span class="action-desc">Ajusta tu cuenta</span>
        </div>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
import { IonIcon } from '@ionic/vue';
import { sparklesOutline, heartOutline, timeOutline, createOutline } from 'ionicons/icons';

const router = useRouter();

function goToQuiz() {
  router.push('/quiz/daily');
}

function goToFavorites() {
  router.push('/app/favorites');
}

function goToHistory() {
  router.push('/app/history');
}

function goToProfile() {
  router.push('/settings/profile');
}
</script>

<style scoped>
.quick-actions-card {
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-lg, 24px);
  padding: 24px;
  box-shadow: var(--dd-shadow-sm);
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.section-title {
  font-size: 16px;
  font-weight: 800;
  color: var(--dd-text);
  letter-spacing: -0.2px;
}

.actions-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
}

.action-btn {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 14px 16px;
  background: var(--dd-bg);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-md, 16px);
  color: var(--dd-text);
  cursor: pointer;
  text-align: left;
  transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.action-btn:hover {
  transform: translateY(-4px);
  box-shadow: var(--dd-shadow-sm);
  border-color: var(--ion-color-primary);
}

.action-btn:active {
  transform: translateY(-1px);
}

.action-icon-box {
  width: 40px;
  height: 40px;
  border-radius: 12px;
  background: rgba(108, 92, 231, 0.1);
  color: var(--ion-color-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  flex-shrink: 0;
  transition: transform 0.3s ease;
}

.action-icon-box.fav {
  background: rgba(225, 112, 85, 0.1);
  color: #E17055;
}

.action-icon-box.hist {
  background: rgba(9, 132, 227, 0.1);
  color: #0984e3;
}

.action-icon-box.prof {
  background: rgba(0, 206, 201, 0.1);
  color: var(--ion-color-secondary);
}

.action-btn:hover .action-icon-box {
  transform: scale(1.1) rotate(5deg);
}

/* Highlight primary action */
.primary-action {
  border-color: rgba(108, 92, 231, 0.3);
  background: radial-gradient(circle at 100% 0%, rgba(108, 92, 231, 0.08) 0%, var(--dd-bg) 70%);
}

.action-text {
  display: flex;
  flex-direction: column;
}

.action-title {
  font-size: 14px;
  font-weight: 700;
  color: var(--dd-text);
}

.action-desc {
  font-size: 11px;
  color: var(--dd-text-secondary);
  margin-top: 2px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

@media (max-width: 992px) {
  .actions-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 576px) {
  .actions-grid {
    grid-template-columns: 1fr;
  }
}
</style>
