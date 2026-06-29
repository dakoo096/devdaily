import { defineStore } from 'pinia';
import { ref, computed } from 'vue';
import type { User, LoginCredentials, RegisterData } from '@/types/user';
import { api } from '@/services/api';

interface AuthResponse {
  token: string;
  tokenType: string;
  id: number;
  name: string;
  email: string;
  role: string;
  onboardingCompleted: boolean;
}

export const useAuthStore = defineStore('auth', () => {
  const user = ref<User | null>(null);
  const token = ref<string | null>(null);
  const onboardingCompleted = ref(false);
  const isLoading = ref(false);
  const error = ref<string | null>(null);

  const isAuthenticated = computed(() => !!token.value);

  async function login(credentials: LoginCredentials): Promise<boolean> {
    isLoading.value = true;
    error.value = null;

    try {
      const response = await api.post<AuthResponse>('/api/auth/login', credentials);

      token.value = response.token;
      onboardingCompleted.value = response.onboardingCompleted;
      user.value = {
        id: String(response.id),
        name: response.name,
        email: response.email,
        createdAt: new Date().toISOString(), // Optional audit fallback
      };

      return true;
    } catch (e: any) {
      error.value = e.message || 'Error al iniciar sesión';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  async function register(data: RegisterData): Promise<boolean> {
    isLoading.value = true;
    error.value = null;

    try {
      const response = await api.post<AuthResponse>('/api/auth/register', data);

      token.value = response.token;
      onboardingCompleted.value = response.onboardingCompleted;
      user.value = {
        id: String(response.id),
        name: response.name,
        email: response.email,
        createdAt: new Date().toISOString(),
      };

      return true;
    } catch (e: any) {
      error.value = e.message || 'Error al registrar';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  function logout() {
    user.value = null;
    token.value = null;
    onboardingCompleted.value = false;
    error.value = null;
  }

  async function updateProfile(name: string, email: string): Promise<boolean> {
    isLoading.value = true;
    error.value = null;
    try {
      const response = await api.put<{ id: number; name: string; email: string }>('/api/users/profile', { name, email });
      if (user.value) {
        user.value.name = response.name;
        user.value.email = response.email;
      }
      return true;
    } catch (e: any) {
      error.value = e.message || 'Error al actualizar perfil';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  function setOnboardingCompleted(value: boolean) {
    onboardingCompleted.value = value;
  }

  function clearError() {
    error.value = null;
  }

  return {
    user,
    token,
    onboardingCompleted,
    isLoading,
    error,
    isAuthenticated,
    login,
    register,
    logout,
    updateProfile,
    setOnboardingCompleted,
    clearError,
  };
}, {
  persist: true,
});
