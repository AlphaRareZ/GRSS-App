import 'package:cap_and_gown/Home/missing_updates_screen.dart';
import 'package:cap_and_gown/Home/notifications_screen.dart';
import 'package:cap_and_gown/Done/aid_screen.dart';
import 'package:cap_and_gown/map_screen.dart';
import 'package:cap_and_gown/Done/report_missing_person_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Row(
              children: [
                const Text(
                  'Gaza Relief',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6), // Bright blue
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Im safe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                // Clickable Notifications Button
                IconButton(
                  icon: const Icon(Icons.notifications_none,
                      color: Colors.white, size: 26),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationsScreen()),
                    );
                  },
                ),
                const SizedBox(width: 8),
                // Profile Avatar Placeholder
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/logo.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildSocialIcon(
                    Icons.camera_alt_outlined), // Placeholder for Instagram
                const SizedBox(width: 8),
                _buildSocialIcon(Icons.facebook),
              ],
            ),
          ),

          // Main Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Quick Access',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 1. Aid Management Card
                  _buildQuickAccessCard(
                    category: 'Aid Management',
                    title: 'Request or Offer Aid',
                    description:
                        'Request assistance or offer help to those in need.',
                    imageAssetPath: 'assets/aid_image.png',
                    placeholderColor: const Color(0xFFF1D8B1),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AidScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // 2. Missing Persons Card
                  _buildQuickAccessCard(
                    category: 'Missing Persons',
                    title: 'Report or Search',
                    description:
                        'Quickly report a missing person or search for someone.',
                    imageAssetPath: 'assets/missing_image.png',
                    placeholderColor: const Color(0xFFF4DDBA),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ReportMissingPersonScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // 3. Essential Services / Map Card
                  _buildQuickAccessCard(
                    category: 'Essential Services',
                    title: 'Find Services',
                    description:
                        'Locate essential services like medical care and shelters.',
                    imageAssetPath: 'assets/map_image.png',
                    placeholderColor: const Color(0xFFC3D4C1),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MapScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA1B3CC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MissingUpdatesScreen()))
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Missing Updates',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.local_fire_department,
                                  color: Color(0xFF4ADE80),
                                  size: 24), // Green icon
                              const SizedBox(width: 8),
                              const Text(
                                '950',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Color(0xFF2A2E3D),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white70, size: 16),
    );
  }

  // UPDATED: Added `required VoidCallback onTap` to the parameters
  Widget _buildQuickAccessCard({
    required String category,
    required String title,
    required String description,
    required String imageAssetPath,
    required Color placeholderColor,
    required VoidCallback onTap,
  }) {
    // UPDATED: Wrapped the Row in a GestureDetector to make it clickable
    return GestureDetector(
      onTap: onTap,
      // Optional: Add a slight opacity change on tap using InkWell instead if you prefer touch ripples
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Texts
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    color: Color(0xFF8B92A5),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF8B92A5),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
// Right Side: Image
          Expanded(
            flex: 2,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: placeholderColor, // Acts as a fallback/background color
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imageAssetPath),
                  fit: BoxFit
                      .cover, // Ensures the image fills the container nicely
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
