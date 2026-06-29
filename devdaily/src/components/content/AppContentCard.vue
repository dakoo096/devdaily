<template>
  <div class="content-card animate-fade-in-up" :class="[`type-${item.type}`, { 'is-favorite': isFav }]">
    <div class="card-header">
      <div class="card-type-badge" :class="`badge-${item.type}`">
        <span class="badge-emoji">{{ item.emoji }}</span>
        <span class="badge-label">{{ typeLabel }}</span>
      </div>
      <button class="fav-button" :class="{ active: isFav }" @click.stop="onToggleFavorite">
        <ion-icon :icon="isFav ? heart : heartOutline" />
      </button>
    </div>

    <h3 class="card-title">{{ item.title }}</h3>
    <p class="card-body">{{ item.body }}</p>

    <div class="card-footer">
      <div class="card-tags">
        <span class="tag area-tag">{{ areaLabel }}</span>
        <span class="tag tech-tag">{{ techLabel }}</span>
        <span class="tag level-tag">{{ levelEmoji }} {{ levelLabel }}</span>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { IonIcon } from '@ionic/vue';
import { heart, heartOutline } from 'ionicons/icons';
import type { ContentItem } from '@/types/content';
import { CONTENT_TYPE_LABELS, AREA_LABELS, TECHNOLOGY_LABELS, LEVEL_LABELS, LEVEL_EMOJIS } from '@/types/content';
import { useFavoritesStore } from '@/stores/favoritesStore';

const props = defineProps<{
  item: ContentItem;
}>();

const favoritesStore = useFavoritesStore();

const isFav = computed(() => favoritesStore.isFavorite(props.item.id));
const typeLabel = computed(() => CONTENT_TYPE_LABELS[props.item.type]);
const areaLabel = computed(() => AREA_LABELS[props.item.area]);
const techLabel = computed(() => TECHNOLOGY_LABELS[props.item.technology]);
const levelLabel = computed(() => LEVEL_LABELS[props.item.level]);
const levelEmoji = computed(() => LEVEL_EMOJIS[props.item.level]);

function onToggleFavorite() {
  favoritesStore.toggleFavorite(props.item);
}
</script>

<style scoped>
.content-card {
  background: var(--dd-surface);
  border-radius: var(--dd-radius-md);
  padding: 20px;
  margin-bottom: 16px;
  border: 1px solid var(--dd-border);
  box-shadow: var(--dd-shadow-sm);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  overflow: hidden;
}

.content-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  border-radius: var(--dd-radius-md) var(--dd-radius-md) 0 0;
  opacity: 0.9;
}

.content-card.type-tip::before { background: var(--dd-gradient-primary); }
.content-card.type-curiosity::before { background: var(--dd-gradient-turquoise); }
.content-card.type-phrase::before { background: var(--dd-gradient-accent); }
.content-card.type-concept::before { background: linear-gradient(135deg, #6C5CE7, #00CEC9); }
.content-card.type-question::before { background: var(--dd-gradient-warm); }
.content-card.type-shortcut::before { background: linear-gradient(135deg, #636E72, #B2BEC3); }

.content-card:active {
  transform: scale(0.98);
}

.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;
}

.card-type-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 4px 12px;
  border-radius: var(--dd-radius-full);
  font-size: 12px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.badge-tip { background: rgba(var(--ion-color-primary-rgb), 0.12); color: var(--ion-color-primary); }
.badge-curiosity { background: rgba(var(--ion-color-secondary-rgb), 0.12); color: var(--ion-color-secondary); }
.badge-phrase { background: rgba(var(--ion-color-tertiary-rgb), 0.12); color: var(--ion-color-tertiary); }
.badge-concept { background: rgba(var(--ion-color-primary-rgb), 0.12); color: var(--ion-color-primary); }
.badge-question { background: rgba(225, 112, 85, 0.12); color: #E17055; }
.badge-shortcut { background: rgba(99, 110, 114, 0.12); color: var(--dd-text-secondary); }

.badge-emoji {
  font-size: 14px;
}

.fav-button {
  background: none;
  border: none;
  padding: 8px;
  cursor: pointer;
  color: var(--dd-text-secondary);
  font-size: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
  border-radius: 50%;
}

.fav-button:active {
  transform: scale(0.85);
}

.fav-button.active {
  color: #E74C3C;
  animation: heartBeat 0.6s ease;
}

@keyframes heartBeat {
  0% { transform: scale(1); }
  14% { transform: scale(1.3); }
  28% { transform: scale(1); }
  42% { transform: scale(1.3); }
  70% { transform: scale(1); }
}

.card-title {
  font-size: 17px;
  font-weight: 700;
  color: var(--dd-text);
  margin: 0 0 8px;
  line-height: 1.3;
}

.card-body {
  font-size: 14px;
  color: var(--dd-text-secondary);
  margin: 0 0 16px;
  line-height: 1.6;
  white-space: pre-line;
}

.card-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.card-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.tag {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 3px 10px;
  border-radius: var(--dd-radius-full);
  font-size: 11px;
  font-weight: 500;
}

.area-tag {
  background: rgba(var(--ion-color-primary-rgb), 0.08);
  color: var(--ion-color-primary);
}

.tech-tag {
  background: rgba(var(--ion-color-secondary-rgb), 0.08);
  color: var(--ion-color-secondary);
}

.level-tag {
  background: rgba(var(--ion-color-tertiary-rgb), 0.08);
  color: var(--ion-color-tertiary);
}
</style>
