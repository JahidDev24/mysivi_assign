import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final int index; // Used to generate random colors

  const UserTile({
    super.key,
    required this.name,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Generate a consistent pastel color based on the index
    final avatarColor = Colors.primaries[index % Colors.primaries.length];

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          // Subtle shadow for depth
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar with Online Indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: avatarColor.withOpacity(0.2),
                  child: Text(
                    name[0].toUpperCase(),
                    style: TextStyle(
                      color: avatarColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            // Name and Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Online",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
