import 'package:flutter/material.dart';
import '../widgets/provider_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedCat = "All";
  String searchQuery = "";
  String activeSort = "";
  bool isMapVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  final List<Map<String, dynamic>> technicians = [
    {
      'name': 'Mostafa Mahmoud',
      'job': 'Carpenter',
      'rate': 4.9,
      'jobs': '120',
      'dist': 1.5,
      'status': 'Available',
      'img': 'https://api.dicebear.com/7.x/avataaars/png?seed=Mostafa',
      'icon': Icons.handyman,
    },
    {
      'name': 'Ahmed Hassan',
      'job': 'Carpenter',
      'rate': 4.7,
      'jobs': '156',
      'dist': 3.1,
      'status': 'Busy',
      'img': 'https://api.dicebear.com/7.x/avataaars/png?seed=Ahmed',
      'icon': Icons.handyman,
    },
    {
      'name': 'Omar Salem',
      'job': 'Electrician',
      'rate': 4.9,
      'jobs': '315',
      'dist': 1.1,
      'status': 'Available',
      'img': 'https://api.dicebear.com/7.x/avataaars/png?seed=Omar',
      'icon': Icons.bolt,
    },
    {
      'name': 'Kareem Sayed',
      'job': 'Plumber',
      'rate': 4.8,
      'jobs': '210',
      'dist': 0.9,
      'status': 'Available',
      'img': 'https://api.dicebear.com/7.x/avataaars/png?seed=Kareem',
      'icon': Icons.plumbing,
    },
    {
      'name': 'Hany Ramzy',
      'job': 'Plumber',
      'rate': 4.6,
      'jobs': '85',
      'dist': 4.2,
      'status': 'Busy',
      'img': 'https://api.dicebear.com/7.x/avataaars/png?seed=Hany',
      'icon': Icons.plumbing,
    },
    {
      'name': 'Youssef Ali',
      'job': 'Carpenter',
      'rate': 4.5,
      'jobs': '90',
      'dist': 2.2,
      'status': 'Available',
      'img': 'https://api.dicebear.com/7.x/avataaars/png?seed=Youssef',
      'icon': Icons.handyman,
    },
    {
      'name': 'Yassin Ammar',
      'job': 'Electrician',
      'rate': 4.7,
      'jobs': '130',
      'dist': 2.5,
      'status': 'Available',
      'img': 'https://api.dicebear.com/7.x/avataaars/png?seed=Yassin',
      'icon': Icons.bolt,
    },
    {
      'name': 'Tarek Fouad',
      'job': 'Plumber',
      'rate': 4.4,
      'jobs': '55',
      'dist': 5.1,
      'status': 'Available',
      'img': 'https://api.dicebear.com/7.x/avataaars/png?seed=Tarek',
      'icon': Icons.plumbing,
    },
    {
      'name': 'Ziad Ezz',
      'job': 'Electrician',
      'rate': 4.2,
      'jobs': '40',
      'dist': 6.4,
      'status': 'Busy',
      'img': 'https://api.dicebear.com/7.x/avataaars/png?seed=Ziad',
      'icon': Icons.bolt,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredList = technicians.where((t) {
      bool matchesCat = selectedCat == "All" || t['job'] == selectedCat;
      bool matchesSearch = t['name'].toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      bool matchesTab = _tabController.index == 0 || t['rate'] >= 4.8;
      return matchesCat && matchesSearch && matchesTab;
    }).toList();

    if (activeSort == "Rating")
      filteredList.sort((a, b) => b['rate'].compareTo(a['rate']));
    if (activeSort == "Distance")
      filteredList.sort((a, b) => a['dist'].compareTo(b['dist']));
    if (activeSort == "Availability")
      filteredList = filteredList
          .where((t) => t['status'] == "Available")
          .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                "Find Technicians",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: (v) => setState(() => searchQuery = v),
                decoration: InputDecoration(
                  hintText: "Search by name...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: ["All", "Plumber", "Carpenter", "Electrician"].map((
                  cat,
                ) {
                  bool isSel = selectedCat == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ActionChip(
                      label: Text(cat),
                      onPressed: () => setState(() => selectedCat = cat),
                      backgroundColor: isSel
                          ? const Color(0xFF3D5CFF)
                          : const Color(0xFF627184),
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: const StadiumBorder(),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  _filterBtn("Rating", Icons.star_border),
                  _filterBtn("Distance", Icons.location_on_outlined),
                  _filterBtn("Availability", Icons.access_time),
                  const SizedBox(width: 30), // المسافة المعتدلة
                  GestureDetector(
                    onTap: () => setState(() => isMapVisible = !isMapVisible),
                    child: Row(
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 18,
                          color: isMapVisible
                              ? const Color(0xFF3D5CFF)
                              : Colors.black54,
                        ),
                        const Text(
                          " Map",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isMapVisible) _buildMapSection(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "${filteredList.length} technician found",
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) =>
                    ProviderCard(data: filteredList[index]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_outlined, "Home", false),
          _navItem(Icons.search, "Search", true),
          _navItem(Icons.assignment_outlined, "Requests", false),
          _navItem(Icons.person_outline, "Profile", false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isSelected) {
    const Color primaryBlue = Color(0xFF3D5CFF);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isSelected ? primaryBlue : Colors.grey),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? primaryBlue : Colors.grey,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _filterBtn(String label, IconData icon) {
    bool isActive = activeSort == label;
    return GestureDetector(
      onTap: () => setState(() => activeSort = isActive ? "" : label),
      child: Container(
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.grey.shade400 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 12, color: Colors.black54),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          CustomPaint(
            size: const Size(double.infinity, 180),
            painter: MapLinesPainter(),
          ),
          const Center(
            child: Icon(Icons.location_on, color: Color(0xFF3D5CFF), size: 40),
          ),
          Positioned(
            right: 15,
            top: 30,
            child: Column(
              children: [
                _mapTool(Icons.add),
                const SizedBox(height: 8),
                _mapTool(Icons.remove),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapTool(IconData icon) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 18, color: const Color(0xFF3D5CFF)),
    );
  }
}

class MapLinesPainter extends CustomPainter {
  get primaryBlue => null;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(0, size.height * 0.4),
      Offset(size.width, size.height * 0.6),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.5, 0),
      Offset(size.width * 0.5, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

@override
bool shouldRepaint(CustomPainter oldDelegate) => false;
