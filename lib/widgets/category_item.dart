import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;

  const CategoryItem({
    super.key, 
    required this.title, 
    required this.icon, 
    this.isSelected = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Animated container for smooth selection transition
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF4A68FF) : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              if(!isSelected) 
                BoxShadow(
                  color: Colors.black.withOpacity(0.05), 
                  blurRadius: 5,
                  offset: const Offset(0, 2)
                )
            ],
          ),
          child: Icon(
            icon, 
            color: isSelected ? Colors.white : const Color(0xFF4A68FF),
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title, 
          style: TextStyle(
            fontSize: 11, 
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? const Color(0xFF4A68FF) : Colors.black87,
          ),
        ),
      ],
    );
  }
}