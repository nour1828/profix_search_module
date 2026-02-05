import 'package:flutter/material.dart';
import 'dart:ui';
import '../widgets/provider_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";
  String selectedFilter = "All";
  
  // Logic Variables
  double minRating = 0.0;
  double maxDistance = 50.0;
  bool availableOnly = false;

  final List<Map<String, dynamic>> allProviders = [
    {'name': 'Ahmed Hassan', 'profession': 'Plumber', 'rate': '4.9', 'reviews': '127', 'distance': 1.2, 'isAvailable': true, 'jobs': '234 jobs', 'imageUrl': 'https://randomuser.me/api/portraits/men/32.jpg'},
    {'name': 'Karim Mahmoud', 'profession': 'Electrician', 'rate': '4.8', 'reviews': '201', 'distance': 1.8, 'isAvailable': true, 'jobs': '278 jobs', 'imageUrl': 'https://randomuser.me/api/portraits/men/46.jpg'},
    {'name': 'Hassan Youssef', 'profession': 'Plumber', 'rate': '4.5', 'reviews': '88', 'distance': 3.1, 'isAvailable': true, 'jobs': '112 jobs', 'imageUrl': 'https://randomuser.me/api/portraits/men/11.jpg'},
    {'name': 'Omar Khaled', 'profession': 'Carpenter', 'rate': '4.7', 'reviews': '156', 'distance': 0.8, 'isAvailable': true, 'jobs': '312 jobs', 'imageUrl': 'https://randomuser.me/api/portraits/men/22.jpg'},
    {'name': 'Youssef Ibrahim', 'profession': 'Electrician', 'rate': '4.6', 'reviews': '142', 'distance': 9.5, 'isAvailable': true, 'jobs': '310 jobs', 'imageUrl': 'https://randomuser.me/api/portraits/men/52.jpg'},
    {'name': 'Mahmoud Ali', 'profession': 'Carpenter', 'rate': '4.4', 'reviews': '75', 'distance': 14.2, 'isAvailable': false, 'jobs': '89 jobs', 'imageUrl': 'https://randomuser.me/api/portraits/men/65.jpg'},
    {'name': 'Mostafa Saad', 'profession': 'Plumber', 'rate': '4.8', 'reviews': '190', 'distance': 1.5, 'isAvailable': true, 'jobs': '412 jobs', 'imageUrl': 'https://randomuser.me/api/portraits/men/33.jpg'},
    {'name': 'Ali Zaki', 'profession': 'Electrician', 'rate': '4.9', 'reviews': '210', 'distance': 0.5, 'isAvailable': true, 'jobs': '500 jobs', 'imageUrl': 'https://randomuser.me/api/portraits/men/85.jpg'},
    {'name': 'Hany Ramzy', 'profession': 'Carpenter', 'rate': '4.3', 'reviews': '45', 'distance': 26.0, 'isAvailable': true, 'jobs': '67 jobs', 'imageUrl': 'https://randomuser.me/api/portraits/men/29.jpg'},
    {'name': 'Tarek Fouad', 'profession': 'Plumber', 'rate': '4.7', 'reviews': '110', 'distance': 2.1, 'isAvailable': true, 'jobs': '145 jobs', 'imageUrl': 'https://randomuser.me/api/portraits/men/18.jpg'},
  ];

  List<Map<String, dynamic>> get filteredProviders {
    return allProviders.where((p) {
      final matchesSearch = p['name'].toLowerCase().contains(searchQuery.toLowerCase()) || 
                           p['profession'].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = true;
      if (selectedFilter == "Top Rated") {
        matchesCategory = double.parse(p['rate']) >= 4.8;
      } else if (selectedFilter != "All") {
        matchesCategory = p['profession'] == selectedFilter;
      }

      final matchesRating = double.parse(p['rate']) >= minRating;
      final matchesDistance = p['distance'] <= maxDistance;
      final matchesAvailability = availableOnly ? p['isAvailable'] == true : true;

      return matchesSearch && matchesCategory && matchesRating && matchesDistance && matchesAvailability;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = filteredProviders;
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('/search', style: TextStyle(color: Colors.cyanAccent, fontSize: 13, letterSpacing: 2)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Find Technicians', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(color: const Color(0xFF1B263B), borderRadius: BorderRadius.circular(15)),
                        child: TextField(
                          onChanged: (v) => setState(() => searchQuery = v),
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Search...', 
                            hintStyle: TextStyle(color: Colors.grey), 
                            prefixIcon: Icon(Icons.search, color: Colors.cyanAccent), 
                            border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    _buildFilterButton(results.length),
                  ],
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ["All", "Top Rated", "Plumber", "Electrician", "Carpenter"].map((f) => _buildQuickFilter(f)).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('${results.length} technicians found', style: const TextStyle(color: Colors.white70, fontSize: 14)),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: results.isEmpty 
              ? const Center(child: Text("No results match your filters", style: TextStyle(color: Colors.white24)))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: results.length,
                  itemBuilder: (context, index) => ProviderCard(
                    name: results[index]['name'],
                    profession: results[index]['profession'],
                    rate: results[index]['rate'],
                    reviews: results[index]['reviews'],
                    distance: "${results[index]['distance']} km",
                    isAvailable: results[index]['isAvailable'],
                    jobs: results[index]['jobs'],
                    imageUrl: results[index]['imageUrl'],
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(int count) {
    return GestureDetector(
      onTap: () => _showFilterBottomSheet(),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.cyanAccent, borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.tune, color: Colors.black),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              color: Color(0xEE1B263B), 
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))
            ),
            child: Column(
              children: [
                Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Filters", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 30),
                        _buildLabel("Minimum Rating", minRating.toStringAsFixed(1)),
                        Slider(
                          value: minRating, min: 0, max: 5, activeColor: Colors.cyanAccent,
                          onChanged: (v) {
                            setModalState(() => minRating = v);
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 20),
                        _buildLabel("Max Distance", "${maxDistance.toInt()} km"),
                        Slider(
                          value: maxDistance, min: 1, max: 50, activeColor: Colors.cyanAccent,
                          onChanged: (v) {
                            setModalState(() => maxDistance = v);
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Available only", style: TextStyle(color: Colors.white, fontSize: 16)),
                            Switch(
                              value: availableOnly, activeColor: Colors.cyanAccent,
                              onChanged: (v) {
                                setModalState(() => availableOnly = v);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent, 
                      padding: const EdgeInsets.all(15), 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text("Show ${filteredProviders.length} results", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70)),
        Text(value, style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildQuickFilter(String title) {
    bool isSelected = selectedFilter == title;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = title),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.cyanAccent : Colors.transparent, 
          borderRadius: BorderRadius.circular(20), 
          border: Border.all(color: isSelected ? Colors.cyanAccent : Colors.white24)
        ),
        child: Text(title, style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}