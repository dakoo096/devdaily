import type { ContentItem, ContentType } from '@/types/content';
import type { UserPreferences } from '@/types/settings';
import { tips } from '@/data/tips';
import { curiosities } from '@/data/curiosities';
import { phrases } from '@/data/phrases';
import { concepts } from '@/data/concepts';
import { questions } from '@/data/questions';
import { shortcuts } from '@/data/shortcuts';

type RawContent = Omit<ContentItem, 'id' | 'date' | 'isFavorite'>;

const ALL_CONTENT: Record<ContentType, RawContent[]> = {
  tip: tips,
  curiosity: curiosities,
  phrase: phrases,
  concept: concepts,
  question: questions,
  shortcut: shortcuts,
};

/**
 * Simple seeded random number generator for consistent daily content.
 * Uses the date string as a seed so the same date always produces the same content.
 */
function seededRandom(seed: string): () => number {
  let hash = 0;
  for (let i = 0; i < seed.length; i++) {
    const char = seed.charCodeAt(i);
    hash = ((hash << 5) - hash) + char;
    hash = hash & hash; // Convert to 32bit integer
  }

  return () => {
    hash = (hash * 16807) % 2147483647;
    return (hash - 1) / 2147483646;
  };
}

/**
 * Shuffle array using Fisher-Yates with a seeded RNG
 */
function shuffleWithSeed<T>(array: T[], rng: () => number): T[] {
  const shuffled = [...array];
  for (let i = shuffled.length - 1; i > 0; i--) {
    const j = Math.floor(rng() * (i + 1));
    [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
  }
  return shuffled;
}

/**
 * Generate daily content based on date and user preferences.
 * Returns 5-8 items that match the user's configured preferences.
 */
export function generateDailyContent(
  dateStr: string,
  preferences: UserPreferences
): ContentItem[] {
  const rng = seededRandom(dateStr);
  const result: ContentItem[] = [];

  // Gather all matching content from selected content types
  const pool: RawContent[] = [];

  for (const type of preferences.contentTypes) {
    const items = ALL_CONTENT[type] || [];
    pool.push(...items);
  }

  // Filter by preferences
  const filtered = pool.filter(item => {
    const areaMatch = preferences.areas.includes(item.area);
    const techMatch = preferences.technologies.includes(item.technology);
    const levelMatch = isLevelCompatible(item.level, preferences.level);
    // At least area or tech should match, and level should be compatible
    return (areaMatch || techMatch) && levelMatch;
  });

  // If filtered is too small, also include area-only matches without level filter
  const candidates = filtered.length >= 5
    ? filtered
    : [...filtered, ...pool.filter(item =>
        preferences.areas.includes(item.area) || preferences.technologies.includes(item.technology)
      )];

  // Remove duplicates
  const uniqueCandidates = Array.from(
    new Map(candidates.map(c => [`${c.type}-${c.title}`, c])).values()
  );

  // Shuffle and take 5-8 items
  const shuffled = shuffleWithSeed(uniqueCandidates, rng);
  const count = Math.min(Math.max(5, Math.floor(rng() * 4) + 5), shuffled.length);

  for (let i = 0; i < count && i < shuffled.length; i++) {
    result.push({
      ...shuffled[i],
      id: `${dateStr}-${i}-${shuffled[i].type}`,
      date: dateStr,
      isFavorite: false,
    });
  }

  return result;
}

/**
 * Check if a content level is compatible with user level.
 * Users see content at their level and below.
 */
function isLevelCompatible(contentLevel: string, userLevel: string): boolean {
  const levels = ['student', 'junior', 'semi-senior', 'senior'];
  const contentIdx = levels.indexOf(contentLevel);
  const userIdx = levels.indexOf(userLevel);
  return contentIdx <= userIdx;
}

/**
 * Get all available content items (for search/browse)
 */
export function getAllContent(): RawContent[] {
  return Object.values(ALL_CONTENT).flat();
}
