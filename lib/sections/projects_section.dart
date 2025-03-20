import 'package:flutter/material.dart';
import '../utils/animations.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  double _getImageHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= 400) return 160; // Small mobile
    if (width <= 600) return 180; // Mobile
    if (width <= 800) return 200; // Large mobile/Small tablet
    if (width <= 1200) return 220; // Tablet
    return 250; // Desktop
  }

  double _getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= 400) return 12.0;
    if (width <= 600) return 16.0;
    if (width <= 960) return 32.0;
    if (width <= 1200) return 64.0;
    return 80.0;
  }

  int _getCrossAxisCount(double screenWidth) {
    if (screenWidth <= 650) return 1; // Mobile
    if (screenWidth <= 960) return 2; // Tablet
    if (screenWidth <= 1200) return 2; // Small desktop
    return 3; // Large desktop
  }

  double _getMainAxisExtent(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= 400) return 460; // Small mobile
    if (width <= 600) return 480; // Mobile
    if (width <= 960) return 500; // Tablet
    return 520; // Desktop
  }

  Widget _buildProjectCard(
    BuildContext context, {
    required String title,
    required String description,
    required List<String> technologies,
    required String imageAsset,
    String? liveUrl,
    String? githubUrl,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;
    final imageHeight = _getImageHeight(context);

    return HoverScaleAnimation(
      scale: 1.02,
      child: Card(
        elevation: 4,
        shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).cardTheme.color!,
                Theme.of(context).cardTheme.color!.withOpacity(0.8),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      imageAsset,
                      height: imageHeight,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: imageHeight,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                              ],
                            ),
                          ),
                          child: Icon(
                            Icons.code,
                            size: isMobile ? 48 : 64,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      },
                    ),
                  ),
                  if (liveUrl != null || githubUrl != null)
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Row(
                        children: [
                          if (liveUrl != null)
                            HoverScaleAnimation(
                              scale: 1.1,
                              child: Material(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(8),
                                child: InkWell(
                                  onTap: () => _launchUrl(liveUrl),
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: EdgeInsets.all(isMobile ? 6.0 : 8.0),
                                    child: const Icon(Icons.launch, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          if (githubUrl != null) ...[
                            SizedBox(width: isMobile ? 6 : 8),
                            HoverScaleAnimation(
                              scale: 1.1,
                              child: Material(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(8),
                                child: InkWell(
                                  onTap: () => _launchUrl(githubUrl),
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: EdgeInsets.all(isMobile ? 6.0 : 8.0),
                                    child: const Icon(Icons.code, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: isMobile ? 18 : 20,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isMobile ? 8 : 12),
                      Expanded(
                        child: Text(
                          description,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: isMobile ? 13 : 14,
                          ),
                          maxLines: isMobile ? 4 : 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: isMobile ? 12 : 16),
                      Wrap(
                        spacing: isMobile ? 6 : 8,
                        runSpacing: isMobile ? 6 : 8,
                        children: technologies.map((tech) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 8 : 12,
                            vertical: isMobile ? 4 : 6,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            tech,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: isMobile ? 11 : 12,
                            ),
                          ),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
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
    final isMobile = screenWidth <= 600;
    final isTablet = screenWidth > 600 && screenWidth < 1200;
    final crossAxisCount = _getCrossAxisCount(screenWidth);
    final mainAxisExtent = _getMainAxisExtent(context);

    final projects = [
      {
        'title': 'ET Bank',
        'description': 'A modern banking application built with Flutter, featuring secure transactions, real-time balance updates, and biometric authentication. The app includes features like fund transfers, bill payments, and transaction history with detailed analytics.',
        'technologies': ['Flutter', 'Firebase', 'REST API', 'Provider'],
        'imageAsset': 'assets/projects/ET Bank.png',
        'liveUrl': 'https://etbank.com',
        'githubUrl': 'https://github.com/username/et-bank',
      },
      {
        'title': 'Soltridge Recruitment App',
        'description': 'A smart recruitment app connecting job seekers with relevant job opportunities. It provides a seamless experience for both candidates and employers, making job searches simpler and more efficient.',
        'technologies': ['Flutter', 'Bloc', 'SQLite', 'REST API'],
        'imageAsset': 'assets/projects/LOGO.png',
        'liveUrl': 'https://recruitment-app.com',
      },
      {
        'title': 'Cricspotter App',
        'description': 'CricSpotter is a dynamic platform for cricket enthusiasts to organize, participate in, and promote cricket events. Whether it\'s a T20, ODI, or Test match, CricSpotter makes it easy to create events, enroll players and teams, and connect with fellow cricketers. Our goal is to bring together a community of passionate cricket players and fans, fostering collaboration, networking, and event promotion within the sport. Join us today to take your cricket journey to the next level!',
        'technologies': ['Flutter', 'Firebase', 'WebSocket', 'GetX'],
        'imageAsset': 'assets/projects/CricSpotter.png',
        'githubUrl': 'https://github.com/username/cricspotter',
      },
      {
        'title': 'Notyred',
        'description': 'NotyRed is a user-friendly mobile app designed to provide a seamless experience for staying updated with trending news and social media feeds. Featuring multi-platform integration across Facebook, Instagram, Twitter, and YouTube. It enables effortless navigation and personalized content, including saved articles, dark mode, and notification management. NotyRed combines intuitive design with fast, reliable performance, offering an engaging and efficient way to explore stories that matter.',
        'technologies': ['Flutter', 'MQTT', 'Node.js', 'MongoDB'],
        'imageAsset': 'assets/projects/NT.png',
        'liveUrl': 'https://smarthomehub.com',
        'githubUrl': 'https://github.com/username/smart-home'
      },
      {
        'title': 'PROMENICS',
        'description': 'Promenics is your all-in-one attendance app designed to streamline organizational time tracking and management. Stay on top of your work hours, whether you\'re online or offline, with seamless syncing once you regain internet connectivity. Easily check your attendance status, capture clock-in and clock-out times, and track your work hours with precision. The app ensures accurate location credentials and supports image processing for secure time logging. With intuitive features and a user-friendly interface, Promenics empowers organizations to maintain efficient attendance records, foster productivity, and simplify workforce management—all at your fingertips. Stay connected to your work hours, anytime, anywhere!',
        'technologies': ['Flutter', 'BLoC', 'HealthKit', 'GraphQL'],
        'imageAsset': 'assets/projects/Promenics.png',
        'liveUrl': 'https://fittrackpro.com'
      },
      {
        'title': 'Medifinders',
        'description': 'Medifinders is a cutting-edge mobile application designed to bridge the gap between patients and healthcare providers. Our mission is to streamline the process of finding and scheduling appointments with qualified medical professionals while offering a robust platform for doctors to easily manage their practices. With Medifinders, healthcare is just a tap away, providing a seamless and secure way for doctors and patients to connect in the digital space.',
        'technologies': ['Flutter', 'WebRTC', 'Firebase', 'Riverpod'],
        'imageAsset': 'assets/projects/MD.png',
        'githubUrl': 'https://github.com/username/edulearn'
      },
    ];

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _getHorizontalPadding(context),
          vertical: isMobile ? 40.0 : isTablet ? 60.0 : 80.0,
        ),
        child: Column(
          children: [
            FadeSlideTransition(
              child: Column(
                children: [
                  Text(
                    'Featured Projects',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: isMobile ? 24 : isTablet ? 28 : 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 8 : 12),
                  Text(
                    'Here are some of my notable projects',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                      fontSize: isMobile ? 14 : 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: isMobile ? 24 : isTablet ? 32 : 48),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: isMobile ? 16 : 20,
                crossAxisSpacing: isMobile ? 16 : 20,
                mainAxisExtent: mainAxisExtent,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return FadeSlideTransition(
                  delay: Duration(milliseconds: 200 * (index + 1)),
                  child: _buildProjectCard(
                    context,
                    title: project['title'] as String,
                    description: project['description'] as String,
                    technologies: (project['technologies'] as List<dynamic>).cast<String>(),
                    imageAsset: project['imageAsset'] as String,
                    liveUrl: project['liveUrl'] as String?,
                    githubUrl: project['githubUrl'] as String?,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 