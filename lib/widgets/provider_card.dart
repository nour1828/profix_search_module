import 'package:flutter/material.dart';
import '../screens/provider_details_screen.dart';

class ProviderCard extends StatefulWidget {
  final String name, profession, rate, reviews, distance, jobs, imageUrl;
  final bool isAvailable;

  const ProviderCard({
    super.key, required this.name, required this.profession, required this.rate, 
    required this.reviews, required this.distance, required this.isAvailable, 
    required this.jobs, required this.imageUrl,
  });

  @override
  State<ProviderCard> createState() => _ProviderCardState();
}

class _ProviderCardState extends State<ProviderCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProviderDetailsScreen(
          name: widget.name, profession: widget.profession, rate: widget.rate, 
          reviews: widget.reviews, imageUrl: widget.imageUrl,
        )));
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFF1B263B), borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              CircleAvatar(radius: 32, backgroundImage: NetworkImage(widget.imageUrl)),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(widget.profession, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(" ${widget.rate}", style: const TextStyle(color: Colors.white, fontSize: 13)),
                        const SizedBox(width: 10),
                        const Icon(Icons.location_on, color: Colors.grey, size: 14),
                        Text(" ${widget.distance}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Icon(Icons.verified, color: widget.isAvailable ? Colors.cyanAccent : Colors.grey, size: 24),
                  const SizedBox(height: 5),
                  Text(widget.jobs, style: const TextStyle(color: Colors.white70, fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}