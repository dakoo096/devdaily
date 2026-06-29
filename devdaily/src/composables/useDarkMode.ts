import { computed } from 'vue';
import { useSettingsStore } from '@/stores/settingsStore';

export function useDarkMode() {
  const settingsStore = useSettingsStore();

  const isDark = computed(() => settingsStore.preferences.darkMode);

  function toggle() {
    settingsStore.toggleDarkMode();
  }

  function set(value: boolean) {
    settingsStore.setDarkMode(value);
  }

  // Initialize from system preference if not previously set
  function initFromSystem() {
    if (typeof window !== 'undefined') {
      const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
      // Only apply system preference on first load (when dark mode hasn't been manually toggled)
      if (!localStorage.getItem('settings')) {
        set(prefersDark);
      }
    }
  }

  return {
    isDark,
    toggle,
    set,
    initFromSystem,
  };
}
