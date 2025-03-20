import 'package:flutter/material.dart';
import '../utils/animations.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final isMobile = screenWidth < 600;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 120.0 : 24.0,
        vertical: 80.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeSlideTransition(
                  child: Text(
                    'Hello, my name is',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 16),
                FadeSlideTransition(
                  child: Text(
                    'Waseem Qamar',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                const SizedBox(height: 16),
                FadeSlideTransition(
                  child: Text(
                    'And I\'m a Flutter Developer',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                const SizedBox(height: 32),
                FadeSlideTransition(
                  child: Row(
                    children: [
                      HoverScaleAnimation(
                        child: ElevatedButton(
                          onPressed: () {
                            _launchUrl('https://www.linkedin.com/in/waseem-qamar-b02b41183/');
                          },
                          child: const Text('Hire me on LinkedIn'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      HoverScaleAnimation(
                        child: ElevatedButton(
                          onPressed: () {
                            _launchUrl('https://www.fiverr.com/s/wkZE9P');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1DBF73), // Fiverr green color
                          ),
                          child: const Text('Hire me on Fiverr'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isDesktop)
            Expanded(
              child: FadeSlideTransition(
                child: Center(
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/waseem.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(BuildContext context, IconData icon, bool isMobile) {
    final Map<IconData, String> socialLinks = {
      Icons.facebook: 'https://facebook.com',
      Icons.link: 'https://linkedin.com',
      Icons.camera_alt: 'https://instagram.com',
      Icons.telegram: 'https://telegram.org',
    };

    return HoverScaleAnimation(
      child: GestureDetector(
        onTap: () => _launchUrl(socialLinks[icon]!),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 8 : 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(isMobile ? 8 : 12),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: isMobile ? 20 : 24,
          ),
        ),
      ),
    );
  }
} 