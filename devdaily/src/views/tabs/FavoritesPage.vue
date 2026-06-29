<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-title class="page-title">Favoritos</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true" class="favorites-content">
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large" class="page-title-large">Favoritos ❤️</ion-title>
        </ion-toolbar>
      </ion-header>

      <!-- Search -->
      <div class="search-section" v-if="favoritesStore.favorites.length > 0">
        <div class="search-wrapper">
          <ion-icon :icon="searchOutline" class="search-icon" />
          <input
            v-model="searchQuery"
            type="text"
            placeholder="Buscar en favoritos..."
            class="search-input"
          />
          <button v-if="searchQuery" class="clear-search" @click="searchQuery = ''">
            <ion-icon :icon="closeCircle" />
          </button>
        </div>
      </div>

      <!-- Content -->
      <div class="favorites-list">
        <AppContentCard
          v-for="(item, index) in filteredFavorites"
          :key="item.id"
          :item="item"
          :class="`animate-fade-in-up stagger-${Math.min(index + 1, 8)}`"
        />

        <AppEmptyState
          v-if="favoritesStore.favorites.length === 0"
          emoji="💜"
          title="Sin favoritos aún"
          description="Los contenidos que marques con ❤️ aparecerán aquí para que los consultes cuando quieras."
        />

        <AppEmptyState
          v-else-if="filteredFavorites.length === 0"
          emoji="🔍"
          title="Sin resultados"
          description="No encontramos favoritos que coincidan con tu búsqueda."
        />
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonIcon } from '@ionic/vue';
import { searchOutline, closeCircle } from 'ionicons/icons';
import AppContentCard from '@/components/content/AppContentCard.vue';
import AppEmptyState from '@/components/common/AppEmptyState.vue';
import { useFavoritesStore } from '@/stores/favoritesStore';

const favoritesStore = useFavoritesStore();
const searchQuery = ref('');

const filteredFavorites = computed(() => {
  if (!searchQuery.value) return favoritesStore.favorites;
  const q = searchQuery.value.toLowerCase();
  return favoritesStore.favorites.filter(
    item =>
      item.title.toLowerCase().includes(q) ||
      item.body.toLowerCase().includes(q)
  );
});

onMounted(() => {
  favoritesStore.fetchFavorites();
});
</script>

<style scoped>
.favorites-content {
  --background: var(--dd-bg);
}

.page-title {
  font-weight: 700;
}

.page-title-large {
  font-weight: 800;
}

.search-section {
  padding: 0 16px 12px;
}

.search-wrapper {
  display: flex;
  align-items: center;
  background: var(--dd-surface);
  border: 1px solid var(--dd-border);
  border-radius: var(--dd-radius-sm);
  padding: 0 14px;
}

.search-icon {
  font-size: 18px;
  color: var(--dd-text-secondary);
  margin-right: 10px;
}

.search-input {
  flex: 1;
  border: none;
  background: none;
  padding: 12px 0;
  font-size: 15px;
  color: var(--dd-text);
  outline: none;
  font-family: inherit;
}

.search-input::placeholder {
  color: var(--dd-text-secondary);
  opacity: 0.6;
}

.clear-search {
  background: none;
  border: none;
  color: var(--dd-text-secondary);
  font-size: 18px;
  cursor: pointer;
  padding: 4px;
  display: flex;
}

.favorites-list {
  padding: 0 16px 100px;
}
</style>
