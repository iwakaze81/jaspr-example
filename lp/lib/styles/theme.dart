import 'package:jaspr/dom.dart';

// ── カラーパレット ─────────────────────────────────────────────────────────
// CSS Custom Properties 経由で参照することで、ライト/ダーク切替に追従する。
// 実体は main.server.dart の `:root` / `[data-theme="light"]` / `[data-theme="dark"]` で定義。
const primaryColor = Color('var(--color-primary)');
const primaryDarkColor = Color('var(--color-primary-dark)');
const primaryGlowColor = Color('var(--color-primary)'); // with opacity in CSS

const bgColor = Color('var(--color-bg)');
const surfaceColor = Color('var(--color-surface)');
const surfaceElevatedColor = Color('var(--color-surface-elevated)');
const borderColor = Color('var(--color-border)');

const textPrimaryColor = Color('var(--color-text-primary)');
const textSecondaryColor = Color('var(--color-text-secondary)');
const textMutedColor = Color('var(--color-text-muted)');

// ── スペーシング ──────────────────────────────────────────────────────────
final sectionPaddingV = 6.rem;
final containerMaxWidth = 1200.px;

// ── ボーダーラジアス ───────────────────────────────────────────────────────
final radiusSm = 0.5.rem;
final radiusMd = 0.75.rem;
final radiusLg = 1.rem;
final radiusXl = 1.5.rem;
final radiusFull = 9999.px;
