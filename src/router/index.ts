import { createRouter, createWebHistory } from '@ionic/vue-router';
import { RouteRecordRaw } from 'vue-router';
import TabsPage from '@/views/tabs/TabsPage.vue';

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    redirect: '/login',
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/auth/LoginPage.vue'),
    meta: { requiresGuest: true },
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('@/views/auth/RegisterPage.vue'),
    meta: { requiresGuest: true },
  },
  {
    path: '/onboarding',
    name: 'Onboarding',
    component: () => import('@/views/onboarding/OnboardingPage.vue'),
    meta: { requiresAuth: true },
  },
  {
    path: '/tabs/',
    component: TabsPage,
    meta: { requiresAuth: true, requiresOnboarding: true },
    children: [
      {
        path: '',
        redirect: '/tabs/home',
      },
      {
        path: 'home',
        name: 'Home',
        component: () => import('@/views/tabs/HomePage.vue'),
      },
      {
        path: 'favorites',
        name: 'Favorites',
        component: () => import('@/views/tabs/FavoritesPage.vue'),
      },
      {
        path: 'history',
        name: 'History',
        component: () => import('@/views/tabs/HistoryPage.vue'),
      },
      {
        path: 'profile',
        name: 'Profile',
        component: () => import('@/views/tabs/ProfilePage.vue'),
      },
    ],
  },
  {
    path: '/settings/profile',
    name: 'EditProfile',
    component: () => import('@/views/settings/EditProfilePage.vue'),
    meta: { requiresAuth: true },
  },
  {
    path: '/settings/notifications',
    name: 'Notifications',
    component: () => import('@/views/settings/NotificationsPage.vue'),
    meta: { requiresAuth: true },
  },
];

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
});

// Navigation Guards
router.beforeEach((to, _from, next) => {
  const authData = localStorage.getItem('auth');

  let isAuthenticated = false;
  let onboardingCompleted = false;

  try {
    if (authData) {
      const parsed = JSON.parse(authData);
      isAuthenticated = !!parsed.token;
      onboardingCompleted = parsed.onboardingCompleted ?? false;
    }
  } catch (e) {
    // Ignore parse errors
  }

  // Guest-only routes (login, register)
  if (to.meta.requiresGuest && isAuthenticated) {
    if (!onboardingCompleted) {
      return next('/onboarding');
    }
    return next('/tabs/home');
  }

  // Auth required routes
  if (to.meta.requiresAuth && !isAuthenticated) {
    return next('/login');
  }

  // Onboarding required routes
  if (to.meta.requiresOnboarding && !onboardingCompleted) {
    return next('/onboarding');
  }

  next();
});

export default router;
