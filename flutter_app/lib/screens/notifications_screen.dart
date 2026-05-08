import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity')),
      body: ListView.separated(
        itemCount: _notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFF1e1e2e)),
        itemBuilder: (context, i) => _NotificationTile(notification: _notifications[i]),
      ),
    );
  }
}

class _Notification {
  const _Notification(this.actor, this.action, this.time, this.color, this.icon);
  final String actor;
  final String action;
  final String time;
  final int color;
  final IconData icon;
}

const _notifications = [
  _Notification('Yuki Tanaka', 'liked your post', '2m ago', 0xFFEC4899, Icons.favorite),
  _Notification('Taro Mori', 'commented: "Totally agree!"', '15m ago', 0xFF6366F1, Icons.chat_bubble),
  _Notification('Hanako Sato', 'followed you', '1h ago', 0xFF10B981, Icons.person_add),
  _Notification('Kenji Watanabe', 'liked your post', '3h ago', 0xFFEC4899, Icons.favorite),
  _Notification('Aoi Nakamura', 'mentioned you in a post', '5h ago', 0xFF6366F1, Icons.alternate_email),
  _Notification('Yuki Tanaka', 'shared your post', '1d ago', 0xFFF59E0B, Icons.share),
];

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification});
  final _Notification notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Color(notification.color),
            child: Text(notification.actor[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Color(notification.color),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF0a0a0f), width: 2),
              ),
              child: Icon(notification.icon, size: 10, color: Colors.white),
            ),
          ),
        ],
      ),
      title: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14),
          children: [
            TextSpan(text: notification.actor, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
            TextSpan(text: ' ${notification.action}', style: const TextStyle(color: Color(0xFF94A3B8))),
          ],
        ),
      ),
      trailing: Text(notification.time, style: const TextStyle(fontSize: 12, color: Color(0xFF475569))),
    );
  }
}
