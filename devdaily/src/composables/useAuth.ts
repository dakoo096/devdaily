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

  async function socialLogin(data: { name: string; email: string; provider: string; providerId: string; }): Promise<boolean> {
    return authStore.socialLogin(data);
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
    socialLogin,
    logout,
    updateProfile,
    clearError,
  };
}
