import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              hintText: 'Search Pulse',
              leading: const Icon(Icons.search),
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(const Color(0xFF1a1a2e)),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _topics.length,
              itemBuilder: (context, i) => _TopicCard(topic: _topics[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Topic {
  const _Topic(this.label, this.postCount, this.color);
  final String label;
  final String postCount;
  final int color;
}

const _topics = [
  _Topic('Flutter', '12.4k posts', 0xFF6366F1),
  _Topic('Dart', '8.2k posts', 0xFF3B82F6),
  _Topic('Open Source', '31k posts', 0xFF10B981),
  _Topic('Mobile Dev', '19k posts', 0xFFEC4899),
  _Topic('Web', '44k posts', 0xFFF59E0B),
  _Topic('Design', '27k posts', 0xFF8B5CF6),
];

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic});
  final _Topic topic;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Color(topic.color), Color(topic.color).withValues(alpha: 0.4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(topic.label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 4),
          Text(topic.postCount, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12)),
        ],
      ),
    );
  }
}
