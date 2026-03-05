import 'package:flutter/material.dart';

class ProviderCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const ProviderCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    bool isAvail = data['status'] == 'Available';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 28, backgroundImage: NetworkImage(data['img'])),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(data['icon'], size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      data['job'],
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      "${data['rate']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Icon(
                      Icons.verified,
                      color: Color(0xFF3D5CFF),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${data['jobs']} jobs",
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const SizedBox(width: 15),
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${data['dist']} km",
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: isAvail
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFEEEEEE), // Busy رمادي
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              data['status'],
              style: TextStyle(
                color: isAvail ? Colors.green : Colors.grey.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
