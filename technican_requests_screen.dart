import 'package:flutter/material.dart';

class TechnicanRequestsScreen extends StatefulWidget {
  const TechnicanRequestsScreen({super.key});

  @override
  State<TechnicanRequestsScreen> createState() =>
      _TechnicanRequestsScreenState();
}

class _TechnicanRequestsScreenState extends State<TechnicanRequestsScreen> {
  // اللون الأزرق المظبوط (أغمق سنة)
  final Color primaryBlue = const Color(0xFF3D5CFF);

  String selectedCategory = 'All'; // التصنيف المختار
  String selectedDistance = 'Any Distance'; // المسافة المختارة
  bool showFilters = false; // إظهار فلاتر المسافة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
              child: Text(
                "Find Requests",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF424242),
                ),
              ),
            ),

            // بار البحث والفلترة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Search by description...",
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => setState(() => showFilters = !showFilters),
                    child: Icon(
                      Icons.tune,
                      color: showFilters ? primaryBlue : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // تصنيفات الخدمة (الفلترة)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  _catChip("All", Icons.build),
                  _catChip("Plumbing", Icons.water_drop),
                  _catChip("Electricity", Icons.lightbulb),
                  _catChip("Carpentry", Icons.handyman),
                ],
              ),
            ),

            // فلاتر المسافة (بتظهر وتلون لما تضغطي)
            if (showFilters)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    "Any Distance",
                    "< 2 km",
                    "< 5 km",
                    "< 10 km",
                  ].map((d) => _distChip(d)).toList(),
                ),
              ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              child: Text(
                "Requests",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // قائمة الطلبات مع الفلترة الذكية
            Expanded(
              child: ListView(
                children: [
                  // الطلب يظهر فقط لو اخترنا All أو Electricity
                  if (selectedCategory == "All" ||
                      selectedCategory == "Electricity")
                    _buildRequestCard(),

                  // لو اخترنا حاجة تانية ومفيش طلبات، يظهر نص بسيط
                  if (selectedCategory != "All" &&
                      selectedCategory != "Electricity")
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          "No requests found for this category",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // الـ Widget بتاع تصنيف الخدمة (بيغير الـ selectedCategory)
  Widget _catChip(String label, IconData icon) {
    bool isSelected = selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => selectedCategory = label),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? primaryBlue : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // الـ Widget بتاع المسافة (بيتلون لما تضغطي عليه)
  Widget _distChip(String label) {
    bool isSelected = selectedDistance == label;
    return GestureDetector(
      onTap: () => setState(() => selectedDistance = label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? primaryBlue : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb, color: Colors.amber, size: 30),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Electrician Service",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Apt 4B area • 0.9 km",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Pending",
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            "Install new ceiling fan in bedroom",
            style: TextStyle(color: Color(0xFF555555), fontSize: 14),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View Details >",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Accept Request",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
}
