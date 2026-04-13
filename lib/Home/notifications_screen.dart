import 'package:flutter/material.dart';

// --- DATA MODEL ---
class NotificationItem {
  final String timeText;
  final String message;

  NotificationItem({
    required this.timeText,
    required this.message,
  });
}

// --- MAIN SCREEN ---
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Data matching the screenshot
  final List<NotificationItem> notifications = [
    NotificationItem(
      timeText: '5 minutes ago',
      message: '"Ahmed Youssef has been found safe in Al-Nuseirat Camp, Gaza."',
    ),
    NotificationItem(
      timeText: '30 minutes ago',
      message: '"Ahmed Khaled has been found atAl-Shifa Hospital, Gaza."',
    ),
    NotificationItem(
      timeText: '4 hours ago',
      message: '"Medical supplies delivered to Al-Shifa Hospital, Gaza."',
    ),
    NotificationItem(
      timeText: '6 hours ago',
      message: '"Food supplies are now available atAl-Maqdes Shelter, Gaza."',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF10141D),
        elevation: 0,
        // Centering the title and icon together
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Notifications',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.notifications_active_outlined, // Ringing bell icon
              color: Colors.white,
              size: 26,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: NotificationCard(item: notifications[index]),
          );
        },
      ),
    );
  }
}

// --- CUSTOM NOTIFICATION CARD WIDGET ---
class NotificationCard extends StatelessWidget {
  final NotificationItem item;

  const NotificationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF253241), // Slate blue-grey card background
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Time text at the top right
          Text(
            item.timeText,
            style: const TextStyle(
              color: Color(0xFF9CA3AF), // Light grey text
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 6),
          // Message text aligned to the left
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              item.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.4, // Line height for readability
                fontWeight: FontWeight.w600, // Semi-bold for the quote
              ),
            ),
          ),
        ],
      ),
    );
  }
}