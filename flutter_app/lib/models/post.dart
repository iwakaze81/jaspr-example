class Post {
  const Post({
    required this.id,
    required this.authorName,
    required this.authorHandle,
    required this.avatarColor,
    required this.body,
    required this.timestamp,
    required this.likes,
    required this.comments,
    this.isLiked = false,
  });

  final String id;
  final String authorName;
  final String authorHandle;
  final int avatarColor;
  final String body;
  final String timestamp;
  final int likes;
  final int comments;
  final bool isLiked;

  Post copyWith({bool? isLiked, int? likes}) => Post(
    id: id,
    authorName: authorName,
    authorHandle: authorHandle,
    avatarColor: avatarColor,
    body: body,
    timestamp: timestamp,
    likes: likes ?? this.likes,
    comments: comments,
    isLiked: isLiked ?? this.isLiked,
  );
}

const samplePosts = [
  Post(
    id: '1',
    authorName: 'Yuki Tanaka',
    authorHandle: '@yuki_codes',
    avatarColor: 0xFF6366F1,
    body:
        'Flutter makes cross-platform feel native 🚀 Just shipped a feature that works identically on Web, iOS, and Android with zero platform-specific code.',
    timestamp: '2m ago',
    likes: 142,
    comments: 38,
  ),
  Post(
    id: '2',
    authorName: 'Taro Mori',
    authorHandle: '@taro_m',
    avatarColor: 0xFFEC4899,
    body:
        'Just shipped the new Stories feature ✨ Built entirely with Flutter animations — the transition feels buttery smooth on every device.',
    timestamp: '15m ago',
    likes: 98,
    comments: 21,
  ),
  Post(
    id: '3',
    authorName: 'Hanako Sato',
    authorHandle: '@hanako_dev',
    avatarColor: 0xFF10B981,
    body:
        'I love that Pulse uses Jaspr for the landing page. Fast load, great SEO, and Flutter inside the page — genuinely impressive architecture.',
    timestamp: '1h ago',
    likes: 203,
    comments: 54,
  ),
  Post(
    id: '4',
    authorName: 'Kenji Watanabe',
    authorHandle: '@k_watanabe',
    avatarColor: 0xFFF59E0B,
    body:
        'The real-time feed updates are insanely fast. You can see reactions happening live across the app with no perceptible delay.',
    timestamp: '3h ago',
    likes: 67,
    comments: 12,
  ),
  Post(
    id: '5',
    authorName: 'Aoi Nakamura',
    authorHandle: '@aoi_ux',
    avatarColor: 0xFF8B5CF6,
    body:
        'Privacy-first social media is the future. Love that Pulse gives me granular controls over who sees what. Finally a social app I trust.',
    timestamp: '5h ago',
    likes: 319,
    comments: 87,
  ),
];
