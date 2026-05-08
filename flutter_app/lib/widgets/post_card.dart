import 'package:flutter/material.dart';

import '../models/post.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post, this.onLike});

  final Post post;
  final VoidCallback? onLike;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(post.avatarColor),
                  child: Text(
                    post.authorName[0],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      Text(
                        '${post.authorHandle} · ${post.timestamp}',
                        style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withValues(alpha: 0.5)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(post.body, style: const TextStyle(fontSize: 15, height: 1.5)),
            const SizedBox(height: 12),
            Row(
              children: [
                _ActionButton(
                  icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                  label: '${post.isLiked ? post.likes + 1 : post.likes}',
                  color: post.isLiked ? const Color(0xFFEC4899) : null,
                  onTap: onLike,
                ),
                const SizedBox(width: 24),
                _ActionButton(icon: Icons.chat_bubble_outline, label: '${post.comments}'),
                const SizedBox(width: 24),
                _ActionButton(icon: Icons.share_outlined, label: 'Share'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.label, this.color, this.onTap});

  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = color ?? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5);
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: textColor),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 13, color: textColor)),
        ],
      ),
    );
  }
}
