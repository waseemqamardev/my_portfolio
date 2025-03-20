import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'sections/home_section.dart';
import 'sections/about_section.dart';
import 'sections/services_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';

import 'utils/animations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF00E5FF), // Cyan accent
          secondary: const Color(0xFF7B1FA2), // Purple
          surface: const Color(0xFF0A192F), // Dark blue surface
          background: const Color(0xFF0A192F), // Dark blue background
          error: const Color(0xFFCF6679),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
            height: 1.1,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            height: 1.2,
            color: Colors.white,
          ),
          displaySmall: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
            height: 1.2,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
            height: 1.3,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            height: 1.6,
            letterSpacing: 0.15,
            color: Colors.white70,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            height: 1.6,
            letterSpacing: 0.15,
            color: Colors.white70,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00E5FF),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF00E5FF),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            side: const BorderSide(color: Color(0xFF00E5FF), width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF112240),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final List<String> _menuItems = [
    'Home',
    'About',
    'Services',
    'Projects',
    'Skills',
    'Contact',
  ];

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'Portfolio',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              if (!isMobile) ...[
                const Spacer(),
                ...List.generate(
                  _menuItems.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: HoverScaleAnimation(
                      scale: 1.1,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                          _scrollToTop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: _selectedIndex == index
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white70,
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          _menuItems[index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: isMobile
            ? [
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
              ]
            : null,
      ),
      endDrawer: isMobile
          ? Drawer(
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      ),
                      child: Center(
                        child: Text(
                          'Portfolio',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ...List.generate(
                      _menuItems.length,
                      (index) => ListTile(
                        title: Text(
                          _menuItems[index],
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white70,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                          Navigator.pop(context);
                          _scrollToTop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Show section based on selected index
            if (_selectedIndex == 0)
              const HomeSection()
            else if (_selectedIndex == 1)
              const AboutSection()
            else if (_selectedIndex == 2)
              const ServicesSection()
            else if (_selectedIndex == 3)
              const ProjectsSection()
            else if (_selectedIndex == 4)
              const SkillsSection()
            else if (_selectedIndex == 5)
              const ContactSection(),
          ],
        ),
      ),
    );
  }
}
