<template>
  <div class="skeleton-card">
    <div class="skeleton-header">
      <div class="skeleton-badge skeleton-loading"></div>
      <div class="skeleton-circle skeleton-loading"></div>
    </div>
    <div class="skeleton-title skeleton-loading"></div>
    <div class="skeleton-line skeleton-loading"></div>
    <div class="skeleton-line short skeleton-loading"></div>
    <div class="skeleton-tags">
      <div class="skeleton-tag skeleton-loading"></div>
      <div class="skeleton-tag skeleton-loading"></div>
    </div>
  </div>
</template>

<style scoped>
.skeleton-card {
  background: var(--dd-surface);
  border-radius: var(--dd-radius-md);
  padding: 20px;
  margin-bottom: 16px;
  border: 1px solid var(--dd-border);
}

.skeleton-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.skeleton-badge {
  width: 100px;
  height: 26px;
  border-radius: var(--dd-radius-full);
}

.skeleton-circle {
  width: 32px;
  height: 32px;
  border-radius: 50%;
}

.skeleton-title {
  width: 70%;
  height: 20px;
  margin-bottom: 12px;
}

.skeleton-line {
  width: 100%;
  height: 14px;
  margin-bottom: 8px;
}

.skeleton-line.short {
  width: 60%;
}

.skeleton-tags {
  display: flex;
  gap: 8px;
  margin-top: 16px;
}

.skeleton-tag {
  width: 72px;
  height: 22px;
  border-radius: var(--dd-radius-full);
}
</style>
