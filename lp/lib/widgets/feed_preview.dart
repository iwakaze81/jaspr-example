import 'package:flutter/material.dart';

// Jaspr の FlutterEmbedView に渡す Flutter Widget
// このファイルは @Import.onWeb 経由で Web のみロードされる
class FeedPreviewWidget extends StatelessWidget {
  const FeedPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFF111118),
      ),
      home: const _FeedScreen(),
    );
  }
}

class _FeedScreen extends StatelessWidget {
  const _FeedScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0a0a0f),
        title: const Text(
          'Pulse',
          style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6366F1)),
        ),
        centerTitle: false,
        actions: [
          IconButton(icon: const Icon(Icons.add_box_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          _StoryRow(),
          SizedBox(height: 16),
          _FeedPost(
            username: 'yuki_t',
            displayName: 'Yuki Tanaka',
            avatarColor: Color(0xFF6366F1),
            content:
                'Flutter makes cross-platform feel truly native 🚀 No more compromise between performance and developer experience.',
            likes: 142,
            comments: 38,
            timeAgo: '2m',
          ),
          SizedBox(height: 12),
          _FeedPost(
            username: 'taro_m',
            displayName: 'Taro Mori',
            avatarColor: Color(0xFFEC4899),
            content: 'Just shipped the new Stories feature ✨ Built entirely with Flutter animations. Check it out!',
            likes: 98,
            comments: 21,
            timeAgo: '15m',
            hasImage: true,
          ),
          SizedBox(height: 12),
          _FeedPost(
            username: 'hanako_s',
            displayName: 'Hanako Sato',
            avatarColor: Color(0xFF10B981),
            content: 'One codebase, three platforms. This is why we chose Flutter for Pulse 💪',
            likes: 234,
            comments: 57,
            timeAgo: '1h',
          ),
        ],
      ),
    );
  }
}

class _StoryRow extends StatelessWidget {
  const _StoryRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _StoryItem(label: 'Your Story', color: const Color(0xFF1e1e2e), isAdd: true),
          _StoryItem(label: 'Yuki', color: const Color(0xFF6366F1)),
          _StoryItem(label: 'Taro', color: const Color(0xFFEC4899)),
          _StoryItem(label: 'Hana', color: const Color(0xFF10B981)),
          _StoryItem(label: 'Kenji', color: const Color(0xFFF97316)),
        ],
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  const _StoryItem({required this.label, required this.color, this.isAdd = false});
  final String label;
  final Color color;
  final bool isAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(color: const Color(0xFF6366F1), width: isAdd ? 0 : 2),
            ),
            child: isAdd ? const Icon(Icons.add, color: Color(0xFF6366F1)) : null,
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
        ],
      ),
    );
  }
}

class _FeedPost extends StatefulWidget {
  const _FeedPost({
    required this.username,
    required this.displayName,
    required this.avatarColor,
    required this.content,
    required this.likes,
    required this.comments,
    required this.timeAgo,
    this.hasImage = false,
  });

  final String username;
  final String displayName;
  final Color avatarColor;
  final String content;
  final int likes;
  final int comments;
  final String timeAgo;
  final bool hasImage;

  @override
  State<_FeedPost> createState() => _FeedPostState();
}

class _FeedPostState extends State<_FeedPost> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a2e),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1e1e2e)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: widget.avatarColor, radius: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.displayName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    Text(
                      '@${widget.username} · ${widget.timeAgo}',
                      style: const TextStyle(color: Color(0xFF475569), fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(widget.content, style: const TextStyle(fontSize: 13, height: 1.5, color: Color(0xFFCBD5E1))),
          if (widget.hasImage) ...[
            const SizedBox(height: 10),
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFFA78BFA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(child: Icon(Icons.play_circle_outline, size: 40, color: Colors.white)),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _liked = !_liked),
                child: Row(
                  children: [
                    Icon(
                      _liked ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: _liked ? const Color(0xFFEC4899) : const Color(0xFF475569),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.likes + (_liked ? 1 : 0)}',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  const Icon(Icons.chat_bubble_outline, size: 18, color: Color(0xFF475569)),
                  const SizedBox(width: 4),
                  Text('${widget.comments}', style: const TextStyle(fontSize: 12, color: Color(0xFF475569))),
                ],
              ),
              const Spacer(),
              const Icon(Icons.share_outlined, size: 18, color: Color(0xFF475569)),
            ],
          ),
        ],
      ),
    );
  }
}
