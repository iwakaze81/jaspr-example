import 'package:flutter/material.dart';

import '../models/post.dart';
import '../widgets/post_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFFA78BFA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF6366F1),
                          border: Border.all(color: const Color(0xFF0a0a0f), width: 3),
                        ),
                        child: const Center(
                          child: Text('Y', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28)),
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: colorScheme.outline),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Yuki Tanaka', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                  const Text('@yuki_codes', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
                  const SizedBox(height: 8),
                  const Text(
                    'Flutter developer & open source contributor. Building the future of cross-platform apps. 🚀',
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _Stat('342', 'Following'),
                      const SizedBox(width: 24),
                      _Stat('2.1k', 'Followers'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFF1e1e2e)),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => PostCard(post: samplePosts[i % samplePosts.length]),
              childCount: 5,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.value, this.label);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
      ],
    );
  }
}
