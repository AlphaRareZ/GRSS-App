import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  String _selectedCategory = 'Hospitals';
  final TextEditingController _searchController = TextEditingController();

  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  List<QueryDocumentSnapshot> _currentDocs = [];
  List<QueryDocumentSnapshot> _searchResults = [];

  static const CameraPosition _gazaPosition = CameraPosition(
    target: LatLng(30.057769044399876, 31.32743352573923),
    zoom: 11.0,
  );

  @override
  void initState() {
    super.initState();
    _fetchMarkersForCategory(_selectedCategory);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchMarkersForCategory(String category) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('MapPoints')
          .where('category', isEqualTo: category)
          .get();

      _currentDocs = snapshot.docs;
      _applySearchFilter(_searchController.text);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load map points: $e')),
        );
      }
    }
  }

  void _applySearchFilter(String query) {
    final Set<Marker> newMarkers = {};
    final List<QueryDocumentSnapshot> newSearchResults = [];
    final String lowerQuery = query.toLowerCase().trim();

    for (var doc in _currentDocs) {
      final data = doc.data() as Map<String, dynamic>;

      final String title = (data['title'] ?? '').toString().toLowerCase();
      final String description =
          (data['description'] ?? '').toString().toLowerCase();

      if (lowerQuery.isEmpty ||
          title.contains(lowerQuery) ||
          description.contains(lowerQuery)) {
        if (lowerQuery.isNotEmpty) {
          newSearchResults.add(doc);
        }

        if (data['latitude'] != null && data['longitude'] != null) {
          newMarkers.add(
            Marker(
              markerId: MarkerId(doc.id),
              position: LatLng(data['latitude'], data['longitude']),
              infoWindow: InfoWindow(
                title: data['title'] ?? 'Unknown Location',
                snippet: data['description'] ?? '',
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                _selectedCategory == 'Hospitals'
                    ? BitmapDescriptor.hueRed
                    : BitmapDescriptor.hueAzure,
              ),
            ),
          );
        }
      }
    }

    setState(() {
      _markers = newMarkers;
      _searchResults = newSearchResults;
    });
  }

  void _onCategorySelected(String category) {
    if (_selectedCategory != category) {
      setState(() {
        _selectedCategory = category;
        _searchController.clear();
        _searchResults.clear();
      });
      _fetchMarkersForCategory(category);
    }
  }

  void _navigateToMapLocation(Map<String, dynamic> data) {
    FocusScope.of(context).unfocus();

    if (data['latitude'] != null && data['longitude'] != null) {
      final LatLng targetPosition = LatLng(data['latitude'], data['longitude']);

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(targetPosition, 16.0),
      );

      setState(() {
        _searchResults.clear();
      });
    }
  }

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
          onPressed: () {
            Navigator.pop(context);
          },
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
                image: DecorationImage(
                  image: AssetImage('assets/logo.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 220,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: _gazaPosition,
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                _mapController = controller;
              },
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
                    controller: _searchController,
                    onChanged: _applySearchFilter,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xFF8B92A5)),
                      hintText: 'Search title or description...',
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
                  if (_searchResults.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      constraints: const BoxConstraints(maxHeight: 250),
                      decoration: BoxDecoration(
                        color: _fieldColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: _searchResults.length,
                        separatorBuilder: (context, index) => const Divider(
                          color: Color(0xFF4A5060),
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final data = _searchResults[index].data()
                              as Map<String, dynamic>;
                          return ListTile(
                            leading: const Icon(Icons.location_on,
                                color: _primaryBlue),
                            title: Text(
                              data['title'] ?? 'Unknown Location',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              data['description'] ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Color(0xFF8B92A5), fontSize: 13),
                            ),
                            onTap: () => _navigateToMapLocation(data),
                          );
                        },
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
                  _buildCustomRadioRow(
                    label: 'Hospitals',
                    icon: Icons.add_box,
                    iconColor: Colors.redAccent,
                  ),
                  _buildCustomRadioRow(
                    label: 'Water Points',
                    icon: Icons.water_drop_outlined,
                    iconColor: _primaryBlue,
                  ),
                  _buildCustomRadioRow(
                    label: 'Aid Distribution',
                    icon: Icons.volunteer_activism_outlined,
                    iconColor: const Color(0xFFB0B0B0),
                  ),
                  _buildCustomRadioRow(
                    label: 'Electricity Points',
                    icon: Icons.bolt,
                    iconColor: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomRadioRow({
    required String label,
    required IconData icon,
    required Color iconColor,
  }) {
    final bool isSelected = _selectedCategory == label;

    return GestureDetector(
      onTap: () => _onCategorySelected(label),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? _primaryBlue : Colors.transparent,
                border: Border.all(
                  color: isSelected ? _primaryBlue : const Color(0xFF8B92A5),
                  width: 1.5,
                ),
                shape: BoxShape.circle,
              ),
              child: isSelected
                  ? const Icon(Icons.circle, size: 8, color: Colors.white)
                  : null,
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
