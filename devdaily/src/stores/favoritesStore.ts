import { defineStore } from 'pinia';
import { ref, computed } from 'vue';
import type { ContentItem } from '@/types/content';
import { api } from '@/services/api';

export const useFavoritesStore = defineStore('favorites', () => {
  const favorites = ref<ContentItem[]>([]);

  const count = computed(() => favorites.value.length);

  async function fetchFavorites() {
    try {
      const response = await api.get<any[]>('/api/favorites');
      favorites.value = response.map(item => ({
        id: String(item.id),
        type: item.type,
        title: item.title,
        body: item.body,
        area: item.area,
        technology: item.technology,
        level: item.difficulty,
        date: new Date().toISOString().split('T')[0],
        isFavorite: true,
        emoji: item.emoji
      }));
    } catch (e) {
      console.error('Error fetching favorites', e);
    }
  }

  async function toggleFavorite(item: ContentItem) {
    try {
      const isFavNow = await api.post<boolean>(`/api/favorites/${item.id}/toggle`);
      
      if (isFavNow) {
        if (!isFavorite(item.id)) {
          favorites.value.push({ ...item, isFavorite: true });
        }
      } else {
        favorites.value = favorites.value.filter(f => f.id !== item.id);
      }
    } catch (e) {
      console.error('Error toggling favorite on server', e);
    }
  }

  function isFavorite(id: string): boolean {
    return favorites.value.some(f => f.id === id);
  }

  function clearAll() {
    favorites.value = [];
  }

  return {
    favorites,
    count,
    fetchFavorites,
    toggleFavorite,
    isFavorite,
    clearAll,
  };
}, {
  persist: true,
});
