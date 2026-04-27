import 'dart:io';
import 'package:cap_and_gown/common/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as p;

class ReportMissingPersonScreen extends StatefulWidget {
  const ReportMissingPersonScreen({super.key});

  @override
  State<ReportMissingPersonScreen> createState() =>
      _ReportMissingPersonScreenState();
}

class _ReportMissingPersonScreenState extends State<ReportMissingPersonScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _selectedImage;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitReport() async {
    if (_nameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _genderController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and select a photo')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final String fileExtension = p.extension(_selectedImage!.path);
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}$fileExtension';

      await Supabase.instance.client.storage
          .from('missing_persons')
          .upload(fileName, _selectedImage!);

      final String imageUrl = Supabase.instance.client.storage
          .from('missing_persons')
          .getPublicUrl(fileName);

      await FirebaseFirestore.instance.collection('MissingPersons').add({
        'name': _nameController.text.trim(),
        'age': _ageController.text.trim(),
        'gender': _genderController.text.trim(),
        'lastKnownLocation': _locationController.text.trim(),
        'description': _descriptionController.text.trim(),
        'imageUrl': imageUrl,
        'reportedAt': FieldValue.serverTimestamp(),
        'uid': FirebaseAuth.instance.currentUser?.uid
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report submitted successfully')),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
            Navigator.pop(context);
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
                controller: _nameController,
                label: 'Name',
                hint: 'Enter name',
                fieldBackgroundColor: fieldBackgroundColor,
                hintColor: hintColor,
              ),
              const SizedBox(height: 16),
              _buildInputGroup(
                controller: _ageController,
                label: 'Age',
                hint: 'Enter age',
                fieldBackgroundColor: fieldBackgroundColor,
                hintColor: hintColor,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildInputGroup(
                controller: _genderController,
                label: 'Gender',
                hint: '',
                fieldBackgroundColor: fieldBackgroundColor,
                hintColor: hintColor,
              ),
              const SizedBox(height: 16),
              _buildInputGroup(
                controller: _locationController,
                label: 'Last Known Location',
                hint: '',
                fieldBackgroundColor: fieldBackgroundColor,
                hintColor: hintColor,
              ),
              const SizedBox(height: 16),
              _buildInputGroup(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Enter description',
                maxLines: 3,
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
                onTap: _pickImage,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: fieldBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    image: _selectedImage != null
                        ? DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _selectedImage == null
                      ? Center(
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
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 32),
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
                  onPressed: _isLoading ? null : _submitReport,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
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
    required TextEditingController controller,
    required String label,
    required String hint,
    required Color fieldBackgroundColor,
    required Color hintColor,
    int maxLines = 1,
    TextInputType? keyboardType,
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
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
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
