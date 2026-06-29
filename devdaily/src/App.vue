<template>
  <ion-app>
    <ion-router-outlet />
  </ion-app>
</template>

<script setup lang="ts">
import { onMounted } from 'vue';
import { IonApp, IonRouterOutlet } from '@ionic/vue';
import { useDarkMode } from '@/composables/useDarkMode';

const darkMode = useDarkMode();

onMounted(() => {
  darkMode.initFromSystem();
});
</script>

<style>
/* Global overrides that can't be scoped */
body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
}

/* Ensure toggle styling aligns with theme */
ion-toggle {
  --track-background: var(--dd-border);
  --track-background-checked: var(--ion-color-primary);
  --handle-background: #fff;
  --handle-background-checked: #fff;
}
</style>
