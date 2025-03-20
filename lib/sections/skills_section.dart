import 'package:flutter/material.dart';
import '../utils/animations.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  Widget _buildSkillBar(BuildContext context, {
    required String skill,
    required double percentage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          skill,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        FadeSlideTransition(
          child: Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${percentage.toInt()}%',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 120.0 : 24.0,
        vertical: 80.0,
      ),
      child: Column(
        children: [
          FadeSlideTransition(
            child: Text(
              'My Skills',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const SizedBox(height: 16),
          FadeSlideTransition(
            child: Text(
              'My creative skills & experiences.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 24),
          FadeSlideTransition(
            child: Text(
              'With two years of programming experience, I initially began with learning C++. Later, I delved into Java, focusing on object-oriented programming. As my journey progressed, I ventured into web development before ultimately transitioning to Dart for Flutter development. Presently, I am an adept Flutter developer, skilled in front-end development, API testing, state management, Firebase integration, and converting designs from Figma to Flutter.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildSkillBar(context, skill: 'Flutter UI', percentage: 90),
                    _buildSkillBar(context, skill: 'Dart', percentage: 90),
                    _buildSkillBar(context, skill: 'State Management (Provider/Bloc)', percentage: 85),
                    _buildSkillBar(context, skill: 'Firebase', percentage: 80),
                    _buildSkillBar(context, skill: 'REST API Integration', percentage: 90),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: [
                    _buildSkillBar(context, skill: 'Flutter Animations', percentage: 85),
                    _buildSkillBar(context, skill: 'Local Storage (Hive/SQLite)', percentage: 80),
                    _buildSkillBar(context, skill: 'Flutter Testing', percentage: 75),
                    _buildSkillBar(context, skill: 'CI/CD', percentage: 70),
                    _buildSkillBar(context, skill: 'Clean Architecture', percentage: 85),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 