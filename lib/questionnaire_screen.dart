import 'package:cap_and_gown/Home/home_screen.dart';
import 'package:cap_and_gown/common/main_screen.dart';
import 'package:flutter/material.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  bool? _electricityAvailable = true;
  bool? _internetAccess = false;
  bool? _childrenElderly = false;
  bool? _cleanWater = true;
  bool? _injuriesNeeds = false;
  bool? _urgentMedical = false;

  final Color _backgroundColor = const Color(0xFF131722);
  final Color _fieldBackgroundColor = const Color(0xFF262A34);
  final Color _primaryBlue = const Color(0xFF3B82F6);
  final Color _textColorWhite = Colors.white;
  final Color _hintColor = const Color(0xFF7A808D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        title: const Text(
          'Questionnaire',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How many family members are there?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 15),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child:
                        Icon(Icons.people_alt, color: _primaryBlue, size: 20),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 0, minHeight: 0),
                  hintText: 'Enter number',
                  hintStyle: TextStyle(color: _hintColor, fontSize: 15),
                  filled: true,
                  fillColor: _fieldBackgroundColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildQuestionGroup(
                question: 'Is electricity available?',
                currentValue: _electricityAvailable,
                onChanged: (val) => setState(() => _electricityAvailable = val),
              ),
              _buildQuestionGroup(
                question: 'Do you have access to the internet?',
                currentValue: _internetAccess,
                onChanged: (val) => setState(() => _internetAccess = val),
              ),
              _buildQuestionGroup(
                question: 'Are there children or elderly?',
                currentValue: _childrenElderly,
                onChanged: (val) => setState(() => _childrenElderly = val),
              ),
              _buildQuestionGroup(
                question: 'Do you have access to clean drinking water?',
                currentValue: _cleanWater,
                onChanged: (val) => setState(() => _cleanWater = val),
              ),
              _buildQuestionGroup(
                question: 'Are there injuries or special needs?',
                currentValue: _injuriesNeeds,
                onChanged: (val) => setState(() => _injuriesNeeds = val),
              ),
              _buildQuestionGroup(
                question: 'Is urgent medical care needed?',
                currentValue: _urgentMedical,
                onChanged: (val) => setState(() => _urgentMedical = val),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()));
                  },
                  child: const Text(
                    'Submit Data',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionGroup({
    required String question,
    required bool? currentValue,
    required ValueChanged<bool?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildCustomRadioButton(
                label: 'Yes',
                value: true,
                groupValue: currentValue,
                onChanged: onChanged,
              ),
              const SizedBox(width: 16),
              _buildCustomRadioButton(
                label: 'No',
                value: false,
                groupValue: currentValue,
                onChanged: onChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomRadioButton({
    required String label,
    required bool value,
    required bool? groupValue,
    required ValueChanged<bool?> onChanged,
  }) {
    final bool isSelected = value == groupValue;

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: _fieldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: isSelected ? _primaryBlue : Colors.white,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
