export interface User {
  id: string;
  name: string;
  email: string;
  avatar?: string;
  createdAt: string;
  devXp?: number;
  devLevel?: number;
  currentStreak?: number;
  longestStreak?: number;
  lastQuizDate?: string;
}

export interface LoginCredentials {
  email: string;
  password: string;
}

export interface RegisterData {
  name: string;
  email: string;
  password: string;
}
