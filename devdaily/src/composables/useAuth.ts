import { computed } from 'vue';
import { storeToRefs } from 'pinia';
import { useAuthStore } from '@/stores/authStore';
import type { LoginCredentials, RegisterData } from '@/types/user';

export function useAuth() {
  const authStore = useAuthStore();
  const { user, isLoading, error, isAuthenticated } = storeToRefs(authStore);

  async function login(credentials: LoginCredentials): Promise<boolean> {
    return authStore.login(credentials);
  }

  async function register(data: RegisterData): Promise<boolean> {
    return authStore.register(data);
  }

  function logout() {
    authStore.logout();
  }

  function updateProfile(name: string, email: string) {
    authStore.updateProfile(name, email);
  }

  function clearError() {
    authStore.clearError();
  }

  return {
    user,
    isLoading,
    error,
    isAuthenticated,
    login,
    register,
    logout,
    updateProfile,
    clearError,
  };
}
