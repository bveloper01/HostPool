import 'package:flutter/material.dart';
import 'package:hostpool/models/experience_model.dart';

class ExperienceCard extends StatelessWidget {
  final Experience experience;
  final bool isSelected;
  final VoidCallback onTap;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16, bottom: 8, top: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(experience.imageUrl),
            fit: BoxFit.cover,
            colorFilter: isSelected
                ? null
                : const ColorFilter.mode(Colors.grey, BlendMode.saturation),
          ),
        ),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black54, Colors.transparent],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
