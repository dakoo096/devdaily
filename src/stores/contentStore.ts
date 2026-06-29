import { defineStore } from 'pinia';
import { ref, computed } from 'vue';
import type { ContentItem, ContentType } from '@/types/content';
import { api } from '@/services/api';

export const useContentStore = defineStore('content', () => {
  const dailyContent = ref<ContentItem[]>([]);
  const currentDate = ref(new Date().toISOString().split('T')[0]);
  const isLoading = ref(false);

  const contentByType = computed(() => {
    const map: Partial<Record<ContentType, ContentItem[]>> = {};
    for (const item of dailyContent.value) {
      if (!map[item.type]) map[item.type] = [];
      map[item.type]!.push(item);
    }
    return map;
  });

  async function fetchDailyContent() {
    isLoading.value = true;
    try {
      const response = await api.get<any[]>('/api/content/today');
      
      const content: ContentItem[] = response.map(item => ({
        id: String(item.id),
        type: item.type,
        title: item.title,
        body: item.body,
        area: item.area,
        technology: item.technology,
        level: item.difficulty, // Maps backend content difficulty to level badge
        date: currentDate.value,
        isFavorite: item.favorite !== undefined ? item.favorite : item.isFavorite,
        emoji: item.emoji
      }));

      dailyContent.value = content;
    } catch (e) {
      console.error('Error fetching daily content from backend', e);
    } finally {
      isLoading.value = false;
    }
  }

  function filterByType(type: ContentType | null): ContentItem[] {
    if (!type) return dailyContent.value;
    return dailyContent.value.filter(item => item.type === type);
  }

  return {
    dailyContent,
    currentDate,
    isLoading,
    contentByType,
    fetchDailyContent,
    filterByType,
  };
});
