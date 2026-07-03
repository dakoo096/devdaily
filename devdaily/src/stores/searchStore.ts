import { defineStore } from 'pinia';
import { ref } from 'vue';

export const useSearchStore = defineStore('search', () => {
  const query = ref('');

  function clear() {
    query.value = '';
  }

  return {
    query,
    clear
  };
});
