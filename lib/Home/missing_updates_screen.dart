import 'package:flutter/material.dart';

class MissingPerson {
  final String name;
  final String age;
  final String healthStatus;
  final String location;
  final bool isInitiallyExpanded;
  final String avatarAsset;

  MissingPerson({
    required this.name,
    required this.age,
    this.healthStatus = '',
    this.location = '',
    this.isInitiallyExpanded = false,
    required this.avatarAsset,
  });
}

class MissingUpdatesScreen extends StatefulWidget {
  const MissingUpdatesScreen({super.key});

  @override
  State<MissingUpdatesScreen> createState() => _MissingUpdatesScreenState();
}

class _MissingUpdatesScreenState extends State<MissingUpdatesScreen> {
  final List<MissingPerson> missingPersons = [
    MissingPerson(
      name: 'Ahmed Mahmoud',
      age: '30',
      healthStatus: 'Minor Condition',
      location:
          'He is staying in a shelter at Al-Shifa Hospital - Gaza and is in good condition.',
      isInitiallyExpanded: true,
      avatarAsset: 'assets/avatar1.png', // Replace with your assets
    ),
    MissingPerson(
      name: 'Ibrahim Khalil',
      age: '18',
      healthStatus: 'Minor Condition',
      location:
          'He is staying in a shelter at Al-Shifa Hospital - Gaza and is in good condition.',
      isInitiallyExpanded: true,
      avatarAsset: 'assets/avatar1.png', // Replace with your assets
    ),
    MissingPerson(
      name: 'Sami Khaled',
      age: '23',
      healthStatus: 'Minor Condition',
      location:
          'He is staying in a shelter at Al-Shifa Hospital - Gaza and is in good condition.',
      isInitiallyExpanded: true,
      avatarAsset: 'assets/avatar1.png', // Replace with your assets
    ),
    MissingPerson(
      name: 'Fatima samer',
      age: '33',
      avatarAsset: 'assets/avatar4.png',
    ),
    MissingPerson(
      name: 'Yousef Mahmoud',
      age: '20',
      avatarAsset: 'assets/avatar5.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF10151E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF10151E),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back navigation
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Missing Updates',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none,
                color: Colors.white, size: 26),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8.0),
            child: Container(
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
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        itemCount: missingPersons.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ExpandablePersonCard(person: missingPersons[index]),
          );
        },
      ),
    );
  }
}

class ExpandablePersonCard extends StatefulWidget {
  final MissingPerson person;

  const ExpandablePersonCard({super.key, required this.person});

  @override
  State<ExpandablePersonCard> createState() => _ExpandablePersonCardState();
}

class _ExpandablePersonCardState extends State<ExpandablePersonCard> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.person.isInitiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF253140), // Slate blue-grey card background
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(
                        0xFFE2C9B1),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.person, color: Color(0xFF253140)),
                  ),
                ),
                const SizedBox(width: 14),

                // Name
                Expanded(
                  child: Text(
                    widget.person.name,
                    style: const TextStyle(
                      color: Color(0xFFD1D5DB), // Light grey text
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // Age
                Text(
                  'Age:${widget.person.age}',
                  style: const TextStyle(
                    color: Color(0xFF4F83F5), // Bright blue
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            if (isExpanded) ...[
              const SizedBox(height: 16),

              // Health Status
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Health Status: ',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF), // Medium grey
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: widget.person.healthStatus,
                      style: const TextStyle(
                        color: Color(0xFF22C55E), // Green
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Current Location
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Current Location:',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: widget.person.location,
                      style: const TextStyle(
                        color: Color(0xFFD1D5DB), // Light grey
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
