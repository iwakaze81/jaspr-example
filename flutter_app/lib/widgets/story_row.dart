import 'package:flutter/material.dart';

class StoryRow extends StatelessWidget {
  const StoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _stories.length,
        itemBuilder: (context, i) => _StoryItem(story: _stories[i]),
      ),
    );
  }
}

class _Story {
  const _Story(this.name, this.color, this.isOwn);
  final String name;
  final int color;
  final bool isOwn;
}

const _stories = [
  _Story('Your Story', 0xFF6366F1, true),
  _Story('Yuki', 0xFFEC4899, false),
  _Story('Taro', 0xFF10B981, false),
  _Story('Hanako', 0xFFF59E0B, false),
  _Story('Kenji', 0xFF8B5CF6, false),
  _Story('Aoi', 0xFF3B82F6, false),
];

class _StoryItem extends StatelessWidget {
  const _StoryItem({required this.story});
  final _Story story;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: story.isOwn
                  ? null
                  : const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFFA78BFA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              color: story.isOwn ? const Color(0xFF1a1a2e) : null,
              border: story.isOwn ? Border.all(color: const Color(0xFF1e1e2e), width: 2) : null,
            ),
            child: story.isOwn
                ? const Icon(Icons.add, color: Color(0xFF6366F1))
                : Center(
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(story.color),
                      ),
                      child: Center(
                        child: Text(
                          story.name[0],
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            story.name,
            style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
