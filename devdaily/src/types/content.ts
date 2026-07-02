export type ContentType = 'tip' | 'curiosity' | 'phrase' | 'concept' | 'question' | 'shortcut';

export type Area = 'frontend' | 'backend' | 'databases' | 'uiux' | 'devops' | 'testing' | 'cybersecurity' | 'mobile';

export type Technology = 'java' | 'spring-boot' | 'vue' | 'react' | 'javascript' | 'typescript' | 'docker' | 'git' | 'mysql' | 'postgresql';

export type Level = 'student' | 'junior' | 'semi-senior' | 'senior';

export interface ContentItem {
  id: string;
  type: ContentType;
  title: string;
  body: string;
  area: Area;
  technology: Technology;
  level: Level;
  date: string;
  isFavorite: boolean;
  emoji: string;
}

export const CONTENT_TYPE_LABELS: Record<ContentType, string> = {
  tip: 'Consejo',
  curiosity: 'Curiosidad',
  phrase: 'Frase',
  concept: 'Concepto',
  question: 'Pregunta Técnica',
  shortcut: 'Atajo',
};

export const CONTENT_TYPE_EMOJIS: Record<ContentType, string> = {
  tip: '💡',
  curiosity: '🔍',
  phrase: '💬',
  concept: '📚',
  question: '❓',
  shortcut: '⌨️',
};

export const AREA_LABELS: Record<Area, string> = {
  frontend: 'Frontend',
  backend: 'Backend',
  databases: 'Bases de Datos',
  uiux: 'UI/UX',
  devops: 'DevOps',
  testing: 'Testing',
  cybersecurity: 'Ciberseguridad',
  mobile: 'Mobile',
};

export const AREA_EMOJIS: Record<Area, string> = {
  frontend: '🎨',
  backend: '⚙️',
  databases: '🗄️',
  uiux: '✨',
  devops: '🚀',
  testing: '🧪',
  cybersecurity: '🔒',
  mobile: '📱',
};

export const TECHNOLOGY_LABELS: Record<Technology, string> = {
  java: 'Java',
  'spring-boot': 'Spring Boot',
  vue: 'Vue',
  react: 'React',
  javascript: 'JavaScript',
  typescript: 'TypeScript',
  docker: 'Docker',
  git: 'Git',
  mysql: 'MySQL',
  postgresql: 'PostgreSQL',
};

export const LEVEL_LABELS: Record<Level, string> = {
  student: 'Estudiante',
  junior: 'Junior',
  'semi-senior': 'Semi Senior',
  senior: 'Senior',
};

export const LEVEL_EMOJIS: Record<Level, string> = {
  student: '🎓',
  junior: '🌱',
  'semi-senior': '🌿',
  senior: '🌳',
};
