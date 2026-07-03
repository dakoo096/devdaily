import { ref, computed, onMounted, onUnmounted } from 'vue';

export function useLayout() {
  const width = ref(typeof window !== 'undefined' ? window.innerWidth : 1024);

  const handleResize = () => {
    width.value = window.innerWidth;
  };

  onMounted(() => {
    window.addEventListener('resize', handleResize);
    handleResize(); // Initial sync
  });

  onUnmounted(() => {
    window.removeEventListener('resize', handleResize);
  });

  const isMobile = computed(() => width.value < 768);
  const isTablet = computed(() => width.value >= 768 && width.value < 1024);
  const isDesktop = computed(() => width.value >= 1024);

  return {
    isMobile,
    isTablet,
    isDesktop,
    width
  };
}
