import type { ContentType, Area, Technology, Level } from './content';

export interface UserPreferences {
  contentTypes: ContentType[];
  areas: Area[];
  technologies: Technology[];
  level: Level;
  darkMode: boolean;
  notificationsEnabled: boolean;
  notificationTime: string;
  onboardingCompleted: boolean;
}

export const DEFAULT_PREFERENCES: UserPreferences = {
  contentTypes: ['tip'],
  areas: ['frontend'],
  technologies: ['javascript'],
  level: 'junior',
  darkMode: false,
  notificationsEnabled: true,
  notificationTime: '09:00',
  onboardingCompleted: false,
};
