import { defineStore } from "pinia";
import { ref } from "vue";
import type { ContentItem } from "@/types/content";
import { api } from "@/services/api";

interface HistoryEntry {
  date: string;
  items: ContentItem[];
}

export const useHistoryStore = defineStore(
  "history",
  () => {
    const entries = ref<HistoryEntry[]>([]);
    const totalViewed = ref(0);
    const daysActive = ref(0);

    async function fetchHistory() {
      try {
        const response = await api.get<any[]>("/api/history");

        // Group by date
        const groups: Record<string, ContentItem[]> = {};

        for (const item of response) {
          const dateStr = item.viewDate;
          if (!groups[dateStr]) {
            groups[dateStr] = [];
          }

          groups[dateStr].push({
            id: String(item.content.id),
            type: item.content.type,
            title: item.content.title,
            body: item.content.body,
            area: item.content.area,
            technology: item.content.technology,
            level: item.content.difficulty,
            date: dateStr,
            isFavorite:
              item.content.favorite !== undefined
                ? item.content.favorite
                : item.content.isFavorite,
            emoji: item.content.emoji,
          });
        }

        // Convert to array and sort by date descending
        const sortedEntries: HistoryEntry[] = Object.keys(groups)
          .sort((a, b) => b.localeCompare(a))
          .map((date) => ({
            date,
            items: groups[date],
          }));

        entries.value = sortedEntries;

        // Sync stats from server
        const stats = await api.get<any>("/api/users/stats");
        daysActive.value = stats.daysActive;
        totalViewed.value = stats.contentsRead;
      } catch (e) {
        console.error("Error fetching history from backend", e);
      }
    }

    function getByDate(date: string): ContentItem[] {
      return entries.value.find((e) => e.date === date)?.items ?? [];
    }

    function clearHistory() {
      entries.value = [];
      totalViewed.value = 0;
      daysActive.value = 0;
    }

    return {
      entries,
      totalViewed,
      daysActive,
      fetchHistory,
      getByDate,
      clearHistory,
    };
  },
  {
    persist: true,
  },
);
