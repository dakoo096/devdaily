<template>
  <div class="app-chip" :class="{ selected, small }" @click="$emit('click')">
    <span v-if="emoji" class="chip-emoji">{{ emoji }}</span>
    <span class="chip-label">{{ label }}</span>
    <ion-icon v-if="selected" :icon="checkmarkCircle" class="chip-check" />
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { checkmarkCircle } from 'ionicons/icons';

defineProps<{
  label: string;
  emoji?: string;
  selected?: boolean;
  small?: boolean;
}>();

defineEmits<{
  click: [];
}>();
</script>

<style scoped>
.app-chip {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 10px 16px;
  border-radius: var(--dd-radius-full);
  background: var(--dd-surface);
  border: 2px solid var(--dd-border);
  font-size: 14px;
  font-weight: 500;
  color: var(--dd-text);
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  user-select: none;
  -webkit-user-select: none;
}

.app-chip:active {
  transform: scale(0.95);
}

.app-chip.selected {
  background: var(--ion-color-primary);
  border-color: var(--ion-color-primary);
  color: #fff;
  box-shadow: 0 4px 12px rgba(var(--ion-color-primary-rgb), 0.3);
}

.app-chip.small {
  padding: 6px 12px;
  font-size: 12px;
}

.chip-emoji {
  font-size: 16px;
  line-height: 1;
}

.app-chip.small .chip-emoji {
  font-size: 14px;
}

.chip-check {
  font-size: 16px;
  color: #fff;
}

.chip-label {
  white-space: nowrap;
}
</style>
