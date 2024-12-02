import 'package:flutter/material.dart';

class PartnersPart extends StatelessWidget {
  const PartnersPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Horizontal scroll for partners
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Image.asset(
              "assets/images/وزارة-الزراعة-مصر-removebg-preview.png",
              height: 140, // Control the height of the image
              width: 180,
              fit: BoxFit.contain, // Control the height of the image
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/logoun.jpg",
                height: 140, // Control the height of the image
                width: 180,
                fit: BoxFit.contain, // Control the height of the image
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/IMG-20210829-WA0011.webp",
                height: 140, // Control the height of the image
                width: 180,
                fit: BoxFit.contain, // Fit the image to the container size
              ),
            ),
          ),
          const SizedBox(
              width: 10), // Spacing between multiple images (if needed)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/2.jpg",
                height: 140, // Control the height of the image
                width: 180,
                fit: BoxFit.contain, // Control the height of the image
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
