import 'package:flutter/material.dart';

const Color _backgroundColor = Color(0xFF131722);
const Color _fieldColor = Color(0xFF262A34);
const Color _primaryBlue = Color(0xFF3B82F6);
const Color _textColorWhite = Colors.white;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _showHospitals = true;
  bool _showWaterPoints = true;
  bool _showAid = false;
  bool _showElectricity = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'Gaza crisis map',
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
              ),
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
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFEFEFEF),
              image: DecorationImage(
                // Placeholder image mimicking a map view
                image: NetworkImage(
                    'https://via.placeholder.com/800x400/E8E7E3/8B92A5?text=Map+View'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xFF8B92A5)),
                      hintText: 'Search.....',
                      hintStyle: const TextStyle(
                          color: Color(0xFF8B92A5), fontSize: 15),
                      filled: true,
                      fillColor: _fieldColor,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Display on Map',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildCustomCheckboxRow(
                    label: 'Hospitals',
                    value: _showHospitals,
                    icon: Icons.add_box,
                    iconColor: Colors.redAccent,
                    onChanged: (val) => setState(() => _showHospitals = val),
                  ),
                  _buildCustomCheckboxRow(
                    label: 'Water Points',
                    value: _showWaterPoints,
                    icon: Icons.water_drop_outlined,
                    iconColor: _primaryBlue,
                    onChanged: (val) => setState(() => _showWaterPoints = val),
                  ),
                  _buildCustomCheckboxRow(
                    label: 'Aid Distribution',
                    value: _showAid,
                    icon: Icons.volunteer_activism_outlined,
                    iconColor: const Color(0xFFB0B0B0),
                    onChanged: (val) => setState(() => _showAid = val),
                  ),
                  _buildCustomCheckboxRow(
                    label: 'Electricity Points',
                    value: _showElectricity,
                    icon: Icons.bolt,
                    iconColor: Colors.amber,
                    onChanged: (val) => setState(() => _showElectricity = val),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom widget to replicate the exact checkbox style + icons
  Widget _buildCustomCheckboxRow({
    required String label,
    required bool value,
    required IconData icon,
    required Color iconColor,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: value ? _primaryBlue : Colors.transparent,
                border: Border.all(
                  color: value ? _primaryBlue : const Color(0xFF8B92A5),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 16),
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
