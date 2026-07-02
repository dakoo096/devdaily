import { defineStore } from 'pinia';
import { ref, watch } from 'vue';
import type { UserPreferences } from '@/types/settings';
import type { ContentType, Area, Technology, Level } from '@/types/content';
import { DEFAULT_PREFERENCES } from '@/types/settings';
import { api } from '@/services/api';
import { useAuthStore } from './authStore';
import { LocalNotifications } from '@capacitor/local-notifications';

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

      await syncLocalNotifications();
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
    const authStore = useAuthStore();
    if (!authStore.isAuthenticated) {
      // Guest user, only persist locally
      return;
    }
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

  async function syncLocalNotifications() {
    try {
      // Cancel previous notification
      await LocalNotifications.cancel({ notifications: [{ id: 1 }] });

      if (preferences.value.notificationsEnabled) {
        const permission = await LocalNotifications.requestPermissions();
        if (permission.display === 'granted') {
          const timeStr = preferences.value.notificationTime || '09:00';
          const [hoursStr, minutesStr] = timeStr.split(':');
          const hour = parseInt(hoursStr, 10);
          const minute = parseInt(minutesStr, 10);

          await LocalNotifications.schedule({
            notifications: [
              {
                title: '⚡ DevDaily',
                body: '¡Tu dosis diaria de desarrollo está lista! 🌅',
                id: 1,
                schedule: {
                  on: {
                    hour,
                    minute
                  },
                  repeats: true,
                  allowWhileIdle: true
                }
              }
            ]
          });
          console.log(`Notification scheduled daily at ${hour}:${minute}`);
        }
      }
    } catch (e) {
      console.warn('Capacitor local notifications not available or blocked:', e);
    }
  }

  async function toggleNotifications() {
    preferences.value.notificationsEnabled = !preferences.value.notificationsEnabled;
    await saveSettingsToServer();
    await syncLocalNotifications();
  }

  async function setNotificationTime(time: string) {
    preferences.value.notificationTime = time;
    await saveSettingsToServer();
    await syncLocalNotifications();
  }

  async function completeOnboarding() {
    preferences.value.onboardingCompleted = true;
    await savePreferencesToServer();
    await saveSettingsToServer();
    await syncLocalNotifications();
  }

  function resetPreferences() {
    preferences.value = { ...DEFAULT_PREFERENCES };
    LocalNotifications.cancel({ notifications: [{ id: 1 }] }).catch(() => {});
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
