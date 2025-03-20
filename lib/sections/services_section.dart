import 'package:flutter/material.dart';
import '../utils/animations.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return HoverScaleAnimation(
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
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
              'My Services',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              return GridView.count(
                crossAxisCount: isDesktop ? 3 : 1,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: isDesktop ? 1 : 0.8,
                children: [
                  FadeSlideTransition(
                    child: _buildServiceCard(
                      context,
                      icon: Icons.flutter_dash,
                      title: 'Flutter Development',
                      description: 'Building high-performance, cross-platform mobile applications using Flutter. Creating beautiful, responsive UIs with custom animations and seamless user experiences.',
                    ),
                  ),
                  FadeSlideTransition(
                    child: _buildServiceCard(
                      context,
                      icon: Icons.design_services,
                      title: 'UI/UX Design',
                      description: 'Crafting intuitive and engaging user interfaces with Material Design and Cupertino widgets. Creating custom themes, animations, and responsive layouts for optimal user experience.',
                    ),
                  ),
                  FadeSlideTransition(
                    child: _buildServiceCard(
                      context,
                      icon: Icons.integration_instructions,
                      title: 'App Integration',
                      description: 'Seamless integration of third-party services, APIs, and native functionalities. Implementation of authentication, payment gateways, maps, and other essential features.',
                    ),
                  ),
                  FadeSlideTransition(
                    child: _buildServiceCard(
                      context,
                      icon: Icons.speed,
                      title: 'Performance Optimization',
                      description: 'Optimizing app performance through efficient state management, memory optimization, and code refactoring. Ensuring smooth animations and minimal load times.',
                    ),
                  ),
                  FadeSlideTransition(
                    child: _buildServiceCard(
                      context,
                      icon: Icons.build,
                      title: 'App Maintenance',
                      description: 'Providing ongoing support, bug fixes, and updates to ensure your app stays current with the latest Flutter versions and platform requirements. Regular performance monitoring and optimization.',
                    ),
                  ),
                  FadeSlideTransition(
                    child: _buildServiceCard(
                      context,
                      icon: Icons.phone_android,
                      title: 'Cross-Platform Development',
                      description: 'Developing and deploying apps for iOS, Android, and web platforms from a single codebase. Ensuring consistent functionality and native feel across all platforms.',
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
} 