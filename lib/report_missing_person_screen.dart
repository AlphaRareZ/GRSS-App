import 'package:flutter/material.dart';

class ReportMissingPersonScreen extends StatelessWidget {
  const ReportMissingPersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF131722);
    const fieldBackgroundColor = Color(0xFF262A34);
    const primaryBlue = Color(0xFF3B82F6);
    const labelColor = Colors.white;
    const hintColor = Color(0xFF7A808D);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back action
          },
        ),
        title: const Text(
          'Report Missing Person',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  // TODO: Replace with your SANAD logo
                  image: AssetImage('assets/logo.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputGroup(
                label: 'Name',
                hint: 'Enter name',
                fieldBackgroundColor: fieldBackgroundColor,
                hintColor: hintColor,
              ),
              const SizedBox(height: 16),

              _buildInputGroup(
                label: 'Age',
                hint: 'Enter age',
                fieldBackgroundColor: fieldBackgroundColor,
                hintColor: hintColor,
              ),
              const SizedBox(height: 16),

              _buildInputGroup(
                label: 'Gender',
                hint: '', // Empty in design
                fieldBackgroundColor: fieldBackgroundColor,
                hintColor: hintColor,
              ),
              const SizedBox(height: 16),

              _buildInputGroup(
                label: 'Last Known Location',
                hint: '', // Empty in design
                fieldBackgroundColor: fieldBackgroundColor,
                hintColor: hintColor,
              ),
              const SizedBox(height: 16),

              _buildInputGroup(
                label: 'Description',
                hint: 'Enter description',
                maxLines: 3, // Taller box for description
                fieldBackgroundColor: fieldBackgroundColor,
                hintColor: hintColor,
              ),
              const SizedBox(height: 16),

              const Text(
                'Photo',
                style: TextStyle(color: labelColor, fontSize: 14),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // TODO: Handle photo upload logic
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: fieldBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Submit Report',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputGroup({
    required String label,
    required String hint,
    required Color fieldBackgroundColor,
    required Color hintColor,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: hintColor, fontSize: 15),
            filled: true,
            fillColor: fieldBackgroundColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
