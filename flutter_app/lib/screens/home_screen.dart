import 'package:flutter/material.dart';

import '../models/post.dart';
import '../widgets/post_card.dart';
import '../widgets/story_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> _posts = samplePosts;

  void _toggleLike(String postId) {
    setState(() {
      _posts = _posts.map((p) {
        if (p.id != postId) return p;
        return p.copyWith(isLiked: !p.isLiked);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pulse',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22, color: Color(0xFF6366F1)),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.mail_outline), onPressed: () {}),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          children: [
            const StoryRow(),
            const Divider(height: 1, color: Color(0xFF1e1e2e)),
            ..._posts.map((post) => PostCard(post: post, onLike: () => _toggleLike(post.id))),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
