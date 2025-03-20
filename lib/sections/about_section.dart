import 'package:flutter/material.dart';
import '../utils/animations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  int _currentIndex = 0;
  final List<String> _titles = [
    "a Freelancer",
    "a Dart Developer",
    "a Flutter Developer",
    "an Application Developer",
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _titles.length;
      });
    });
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
              'About Me',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const SizedBox(height: 48),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isDesktop)
                Expanded(
                  flex: 2,
                  child: FadeSlideTransition(
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary.withOpacity(0.2),
                            Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                          ],
                        ),
                      ),
                      child: Image.asset('assets/images/waseem.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
              if (isDesktop) const SizedBox(width: 48),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeSlideTransition(
                      child: Row(
                        children: [
                          Text(
                            'I\'m Waseem Qamar and I\'m ',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              // color: Theme.of(context).colorScheme.primary,
                                                          fontWeight: FontWeight.w500,

                            ),
                          ),
                     
      SizedBox(
                      height: 60, // Fixed height for the animated text
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, 0.5),
                              end: Offset.zero,
                            ).animate(animation),
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          _titles[_currentIndex],
                          key: ValueKey<int>(_currentIndex),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                        ],
                      ),
                    ),
              
                    const SizedBox(height: 24),
                    FadeSlideTransition(
                      child: Text(
                        'I am a skilled Flutter developer and individual freelancer specializing in transforming Figma designs into captivating and responsive Flutter front-end applications. With a keen eye for detail and expertise in Flutter, I create high-quality mobile, web, and desktop applications that not only look stunning but also provide seamless user experiences. As a dedicated professional, I prioritize client satisfaction, clear communication, and timely project delivery. With personalized attention to every project, I ensure the best possible outcome.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 32),
                    FadeSlideTransition(
                      child: HoverScaleAnimation(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _launchUrl('https://drive.google.com/file/d/1IeiMVXVNyVAtHdQPRFFMmh9-wyynkoUO/view?usp=sharing');
                          },
                          icon: const Icon(Icons.download),
                          label: const Text('Download CV'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
} 