import { defineStore } from 'pinia';
import { ref, watch } from 'vue';
import type { UserPreferences } from '@/types/settings';
import type { ContentType, Area, Technology, Level } from '@/types/content';
import { DEFAULT_PREFERENCES } from '@/types/settings';
import { api } from '@/services/api';
import { useAuthStore } from './authStore';

export const useSettingsStore = defineStore('settings', () => {
  const preferences = ref<UserPreferences>({ ...DEFAULT_PREFERENCES });

  // Apply dark mode to body
  watch(() => preferences.value.darkMode, (isDark) => {
    document.body.classList.toggle('dark', isDark);
  }, { immediate: true });

  async function fetchSettingsFromServer() {
    try {
      const prefs = await api.get<any>('/api/users/preferences');
      const settings = await api.get<any>('/api/users/settings');

      preferences.value.level = prefs.level;
      preferences.value.contentTypes = prefs.contentTypes;
      preferences.value.areas = prefs.areas;
      preferences.value.technologies = prefs.technologies;

      preferences.value.darkMode = settings.darkMode;
      preferences.value.notificationsEnabled = settings.notificationsEnabled;
      preferences.value.notificationTime = settings.notificationTime;
      preferences.value.onboardingCompleted = true;
    } catch (e) {
      console.error('Error fetching settings from backend', e);
    }
  }

  async function savePreferencesToServer() {
    try {
      await api.put('/api/users/preferences', {
        level: preferences.value.level,
        contentTypes: preferences.value.contentTypes,
        areas: preferences.value.areas,
        technologies: preferences.value.technologies
      });
      const authStore = useAuthStore();
      authStore.setOnboardingCompleted(true);
    } catch (e) {
      console.error('Error saving preferences to backend', e);
    }
  }

  async function saveSettingsToServer() {
    try {
      await api.put('/api/users/settings', {
        darkMode: preferences.value.darkMode,
        notificationsEnabled: preferences.value.notificationsEnabled,
        notificationTime: preferences.value.notificationTime
      });
    } catch (e) {
      console.error('Error saving settings to backend', e);
    }
  }

  function updateContentTypes(types: ContentType[]) {
    preferences.value.contentTypes = types;
  }

  function updateAreas(areas: Area[]) {
    preferences.value.areas = areas;
  }

  function updateTechnologies(techs: Technology[]) {
    preferences.value.technologies = techs;
  }

  function updateLevel(level: Level) {
    preferences.value.level = level;
  }

  async function toggleDarkMode() {
    preferences.value.darkMode = !preferences.value.darkMode;
    await saveSettingsToServer();
  }

  async function setDarkMode(value: boolean) {
    preferences.value.darkMode = value;
    await saveSettingsToServer();
  }

  async function toggleNotifications() {
    preferences.value.notificationsEnabled = !preferences.value.notificationsEnabled;
    await saveSettingsToServer();
  }

  async function setNotificationTime(time: string) {
    preferences.value.notificationTime = time;
    await saveSettingsToServer();
  }

  async function completeOnboarding() {
    preferences.value.onboardingCompleted = true;
    await savePreferencesToServer();
    await saveSettingsToServer();
  }

  function resetPreferences() {
    preferences.value = { ...DEFAULT_PREFERENCES };
  }

  return {
    preferences,
    fetchSettingsFromServer,
    updateContentTypes,
    updateAreas,
    updateTechnologies,
    updateLevel,
    toggleDarkMode,
    setDarkMode,
    toggleNotifications,
    setNotificationTime,
    completeOnboarding,
    resetPreferences,
  };
}, {
  persist: true,
});
