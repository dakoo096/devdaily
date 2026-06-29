<template>
  <div class="empty-state animate-fade-in-up">
    <div class="empty-emoji">{{ emoji }}</div>
    <h3 class="empty-title">{{ title }}</h3>
    <p class="empty-description">{{ description }}</p>
    <slot />
  </div>
</template>

<script setup lang="ts">
defineProps<{
  emoji: string;
  title: string;
  description: string;
}>();
</script>

<style scoped>
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 48px 32px;
  text-align: center;
}

.empty-emoji {
  font-size: 64px;
  margin-bottom: 16px;
  animation: pulse 2s ease-in-out infinite;
}

.empty-title {
  font-size: 20px;
  font-weight: 700;
  color: var(--dd-text);
  margin: 0 0 8px;
}

.empty-description {
  font-size: 15px;
  color: var(--dd-text-secondary);
  margin: 0;
  max-width: 280px;
  line-height: 1.5;
}

@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.1); }
}
</style>
