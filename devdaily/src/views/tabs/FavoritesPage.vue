<template>
  <ion-page>
    <ion-content :fullscreen="true" class="favorites-content">
      <div class="favorites-container">
        <h1 class="page-main-title animate-fade-in-up">Favoritos ❤️</h1>

        <!-- Search -->
        <div class="search-section" v-if="favoritesStore.favorites.length > 0">
          <div class="search-wrapper">
            <ion-icon :icon="searchOutline" class="search-icon" />
            <input
              v-model="searchStore.query"
              type="text"
              placeholder="Buscar en favoritos..."
              class="search-input"
            />
            <button v-if="searchStore.query" class="clear-search" @click="searchStore.clear">
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
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { computed, onMounted } from 'vue';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { searchOutline, closeCircle } from 'ionicons/icons';
import AppContentCard from '@/components/content/AppContentCard.vue';
import AppEmptyState from '@/components/common/AppEmptyState.vue';
import { useFavoritesStore } from '@/stores/favoritesStore';
import { useSearchStore } from '@/stores/searchStore';

const favoritesStore = useFavoritesStore();
const searchStore = useSearchStore();

const filteredFavorites = computed(() => {
  if (!searchStore.query) return favoritesStore.favorites;
  const q = searchStore.query.toLowerCase();
  return favoritesStore.favorites.filter(
    item =>
      item.title.toLowerCase().includes(q) ||
      item.body.toLowerCase().includes(q) ||
      item.technology.toLowerCase().includes(q)
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

.page-main-title {
  font-size: 28px;
  font-weight: 800;
  color: var(--dd-text);
  margin: 0 16px 24px;
  line-height: 1.2;
}

.favorites-container {
  padding-top: calc(env(safe-area-inset-top) + 16px);
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

/* Desktop styles */
@media (min-width: 1024px) {
  .favorites-container {
    padding-top: 0;
  }
  
  .page-main-title {
    display: none;
  }
  
  .search-section {
    display: none !important;
  }
  
  .favorites-list {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 20px;
    padding: 0 0 60px;
  }
}
</style>
