enum AppLocale { en, ja }

class S {
  const S(this.locale);
  final AppLocale locale;

  // ── Navbar ──────────────────────────────────────────────────
  String get navFeatures => locale == AppLocale.ja ? '機能' : 'Features';
  String get navDemo => locale == AppLocale.ja ? 'デモ' : 'Live Demo';
  String get navPlatform => locale == AppLocale.ja ? 'プラットフォーム' : 'Platform';
  String get navGetStarted => locale == AppLocale.ja ? '始める' : 'Get Started';

  // ── Hero ────────────────────────────────────────────────────
  String get heroBadge => locale == AppLocale.ja ? '✦ オープンベータ — 今すぐ参加' : '✦ Open Beta — Join Now';
  String get heroTitle1 => locale == AppLocale.ja ? 'つながる。シェアする。' : 'Connect. Share.';
  String get heroTitle2 => locale == AppLocale.ja ? '咲かせよう。ともに。' : 'Thrive. Together.';
  String get heroSubtitle => locale == AppLocale.ja
      ? 'Flutter で一から作られたソーシャルプラットフォーム — 単一コードベースで Web・iOS・Android のネイティブパフォーマンスを実現。'
      : 'The social platform built entirely with Flutter — native performance on Web, iOS, and Android from a single codebase.';
  String get heroCtaPrimary => locale == AppLocale.ja ? '無料で始める' : 'Get Started Free';
  String get heroCtaSecondary => locale == AppLocale.ja ? 'デモを見る ↓' : 'Live Demo ↓';

  // ── Features ────────────────────────────────────────────────
  String get featuresTitle => locale == AppLocale.ja ? 'つながるために必要なすべて' : 'Everything you need to connect';
  String get featuresSubtitle => locale == AppLocale.ja
      ? 'Flutter で一から構築 — すべてのインタラクションが速く、滑らかで、ネイティブ。'
      : 'Built from the ground up with Flutter — every interaction is fast, smooth, and native.';

  List<({String icon, String title, String desc})> get features => locale == AppLocale.ja
      ? [
          (icon: '⚡️', title: 'リアルタイムフィード', desc: '投稿・リアクション・コメントが全デバイスで即時更新 — Flutter のリアクティブ UI で実現。'),
          (icon: '📸', title: 'ストーリー & モーメント', desc: '消えるストーリーで今日を共有。Flutter のアニメーションエンジンで作る没入型フルスクリーン体験。'),
          (icon: '💬', title: 'ダイレクトメッセージ', desc: '既読確認・絵文字リアクション・メディア共有付きの暗号化 DM — すべてのプラットフォームでネイティブ感。'),
          (icon: '🔔', title: 'スマート通知', desc: 'フォーカスタイムを尊重するコンテキスト対応プッシュ通知。Flutter プラグインでプラットフォーム API に直アクセス。'),
          (icon: '🌐', title: 'クロスプラットフォーム', desc: '単一の Dart コードベース。Web・iOS・Android でピクセルパーフェクト。妥協なし、ラッパーなし。'),
          (icon: '🔒', title: 'プライバシーファースト', desc: 'エンドツーエンド暗号化、細かいプライバシー設定、データ販売ゼロ。あなたのデータはあなたのもの。'),
        ]
      : [
          (
            icon: '⚡️',
            title: 'Real-time Feed',
            desc:
                "Posts, reactions, and comments update instantly across all devices — powered by Flutter's reactive UI.",
          ),
          (
            icon: '📸',
            title: 'Stories & Moments',
            desc:
                "Share your day with disappearing stories. Full-screen, immersive — built with Flutter's animation engine.",
          ),
          (
            icon: '💬',
            title: 'Direct Messaging',
            desc:
                'Encrypted DMs with read receipts, emoji reactions, and media sharing — native feel on every platform.',
          ),
          (
            icon: '🔔',
            title: 'Smart Notifications',
            desc:
                'Contextual push notifications that respect your focus time. Powered by platform-native APIs via Flutter plugins.',
          ),
          (
            icon: '🌐',
            title: 'Cross-Platform',
            desc: 'One Dart codebase. Pixel-perfect on Web, iOS, and Android. No compromises, no wrappers.',
          ),
          (
            icon: '🔒',
            title: 'Privacy First',
            desc: 'End-to-end encryption, granular privacy controls, and zero data selling. Your data stays yours.',
          ),
        ];

  // ── Demo section ────────────────────────────────────────────
  String get demoTitle1 => locale == AppLocale.ja ? 'アプリを体験しよう、' : 'Experience the app,';
  String get demoTitle2 => locale == AppLocale.ja ? 'ここで、今すぐ。' : 'right here.';
  String get demoDesc => locale == AppLocale.ja
      ? 'このインタラクティブデモは、jaspr_flutter_embed を使って HTML ページに直接埋め込まれた本物の Flutter ウィジェットです。iframe なし、リダイレクトなし — Flutter が DOM の中で動いています。'
      : 'This interactive demo is a real Flutter widget embedded directly in this HTML page using jaspr_flutter_embed. No iframe, no redirect — Flutter running inside the DOM.';
  String get demoPoint1 => locale == AppLocale.ja ? '⚡️ ネイティブ Flutter レンダリング' : '⚡️ Native Flutter rendering';
  String get demoPoint2 => locale == AppLocale.ja ? '🎨 Flutter アニメーション & ジェスチャー' : '🎨 Flutter animations & gestures';
  String get demoPoint3 => locale == AppLocale.ja ? '🔗 Jaspr の状態と連携' : '🔗 Communicates with Jaspr state';
  String get demoCaption =>
      locale == AppLocale.ja ? '↑ これはブラウザでネイティブに動く Flutter です' : '↑ This is Flutter, running natively in your browser';

  // ── Platform section ─────────────────────────────────────────
  String get platformTitle1 => locale == AppLocale.ja ? 'ひとつのコードベース。' : 'One codebase.';
  String get platformTitle2 => locale == AppLocale.ja ? 'すべてのプラットフォーム。' : 'Every platform.';
  String get platformSubtitle => locale == AppLocale.ja
      ? 'Flutter はモバイルでネイティブ ARM コードに、Web では WebAssembly にコンパイルされます。ブリッジなし。ラッパーなし。'
      : 'Flutter compiles to native ARM code on mobile and WebAssembly on the web. No bridges. No wrappers.';

  List<({String icon, String title, String desc, List<String> features})> get platforms => locale == AppLocale.ja
      ? [
          (
            icon: '🌐',
            title: 'Web',
            desc: 'Jaspr + Flutter Web で構築。SEO 対応 LP に Flutter ウィジェットを埋め込み。',
            features: ['Progressive Web App', 'WebAssembly ターゲット', 'JS フレームワーク不要'],
          ),
          (
            icon: '📱',
            title: 'iOS',
            desc: 'ネイティブ ARM64 にコンパイル。Flutter プラグイン経由でプラットフォーム API に直アクセス。',
            features: ['ネイティブパフォーマンス', 'プラットフォーム外観', 'App Store 対応'],
          ),
          (
            icon: '🤖',
            title: 'Android',
            desc: 'ネイティブ ARM64/x86 にコンパイル。Flutter のレンダリングエンジンで Material Design を実現。',
            features: ['Google Play 対応', 'アダプティブアイコン', 'Material You 対応'],
          ),
        ]
      : [
          (
            icon: '🌐',
            title: 'Web',
            desc: 'Built with Jaspr + Flutter Web. SEO-friendly LP with embedded Flutter widgets.',
            features: ['Progressive Web App', 'WebAssembly target', 'No JavaScript frameworks'],
          ),
          (
            icon: '📱',
            title: 'iOS',
            desc: 'Compiled to native ARM64. Uses platform APIs directly via Flutter plugins.',
            features: ['Native performance', 'Platform look & feel', 'App Store ready'],
          ),
          (
            icon: '🤖',
            title: 'Android',
            desc: "Compiled to native ARM64/x86. Material Design with Flutter's render engine.",
            features: ['Google Play ready', 'Adaptive icons', 'Material You support'],
          ),
        ];

  String get metricCodebase => locale == AppLocale.ja ? 'コードベース' : 'Codebase';
  String get metricCodebaseSub => locale == AppLocale.ja ? 'すべてのプラットフォーム' : 'for all platforms';
  String get metricRendering => locale == AppLocale.ja ? 'レンダリング' : 'Rendering';
  String get metricRenderingSub => locale == AppLocale.ja ? 'すべてのデバイスで' : 'on all devices';
  String get metricColdStart => locale == AppLocale.ja ? '初回起動' : 'Cold start';
  String get metricColdStartSub => locale == AppLocale.ja ? 'Web (WASM)' : 'on web (WASM)';
  String get metricLighthouse => locale == AppLocale.ja ? 'Lighthouse' : 'Lighthouse';
  String get metricLighthouseSub => locale == AppLocale.ja ? 'パフォーマンススコア' : 'performance score';

  // ── Testimonials ─────────────────────────────────────────────
  String get testimonialsTitle => locale == AppLocale.ja ? 'コミュニティに愛されています' : 'Loved by the community';

  List<({String quote, String name, String handle, String avatarHex})> get testimonials => locale == AppLocale.ja
      ? [
          (
            quote: '"iPhone でも Web でも同じ体験ができる初めてのソーシャルアプリ。妥協がない。"',
            name: 'Yuki Tanaka',
            handle: '@yuki_codes',
            avatarHex: '#6366f1',
          ),
          (
            quote: '"Flutter ベースの UI は本当になめらか。フィードのスクロールは今まで使ったどのネイティブアプリより気持ちいい。"',
            name: 'Taro Mori',
            handle: '@taro_m',
            avatarHex: '#ec4899',
          ),
          (
            quote: '"LP に Jaspr を使ってるのが最高。高速ロード、SEO 対策、中は Flutter — 天才的な設計。"',
            name: 'Hanako Sato',
            handle: '@hanako_dev',
            avatarHex: '#10b981',
          ),
        ]
      : [
          (
            quote:
                '"Pulse is the first social app that actually feels the same on my iPhone and on the web. No compromises."',
            name: 'Yuki Tanaka',
            handle: '@yuki_codes',
            avatarHex: '#6366f1',
          ),
          (
            quote:
                '"The Flutter-based UI is silky smooth. Scrolling through the feed feels better than any native app I\'ve used."',
            name: 'Taro Mori',
            handle: '@taro_m',
            avatarHex: '#ec4899',
          ),
          (
            quote:
                '"I love that the web version uses Jaspr for the landing page. Fast load, great SEO, and Flutter inside — genius."',
            name: 'Hanako Sato',
            handle: '@hanako_dev',
            avatarHex: '#10b981',
          ),
        ];

  // ── CTA ─────────────────────────────────────────────────────
  String get ctaTitle1 => locale == AppLocale.ja ? '参加しませんか、' : 'Ready to join';
  String get ctaTitle2 => locale == AppLocale.ja ? 'Pulse へ？' : 'Pulse?';
  String get ctaDesc1 =>
      locale == AppLocale.ja ? '無料で始めよう。Web・iOS・Android 対応。' : 'Start for free. Available on Web, iOS, and Android.';
  String get ctaDesc2 =>
      locale == AppLocale.ja ? 'Flutter で構築 — ひとつのアプリで、どこでも。' : 'Built with Flutter — one app, everywhere.';
  String get ctaTryWeb => locale == AppLocale.ja ? 'Web アプリを試す' : 'Try Web App';
  String get ctaAppStore => locale == AppLocale.ja ? '↓ App Store' : '↓ App Store';
  String get ctaGooglePlay => locale == AppLocale.ja ? '↓ Google Play' : '↓ Google Play';
  String get ctaNote =>
      locale == AppLocale.ja ? 'クレジットカード不要。個人利用は永久無料。' : 'No credit card required. Free forever for personal use.';

  // ── Footer ───────────────────────────────────────────────────
  String get footerTagline =>
      locale == AppLocale.ja ? 'Flutter で作られた、Flutter のためのプラットフォーム。' : 'The platform built with Flutter, for everyone.';
}
