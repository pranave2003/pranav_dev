import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Bagroundgraph/Bagroundgraph.dart';
import 'Screens/Contactsection.dart';
import 'Screens/Herosection.dart';
import 'Screens/Projectsection.dart';
import 'Screens/SkillSection.dart';
import 'Widgets/NavButton.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pranav - Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan,
        colorScheme: ColorScheme.dark(
          primary: Colors.cyan,
          secondary: Colors.blue,
          surface: const Color(0xFF1E1E2C),
          background: const Color(0xFF121212),
        ),
        fontFamily: 'Poppins',
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;
          bool isTablet =
              constraints.maxWidth > 800 && constraints.maxWidth < 1000;

          return Stack(
            children: [
              // Background subtle pattern
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  backgroundBlendMode: BlendMode.lighten,
                ),
                child: CustomPaint(
                  painter: BackgroundPainter(),
                  size: Size.infinite,
                ),
              ),

              // Main content
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // App Bar
                  SliverAppBar(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.background.withOpacity(0.8),
                    floating: true,
                    pinned: true,
                    elevation: 0,
                    expandedHeight: isMobile ? 70 : 80,
                    title: Row(
                      children: [
                        Text(
                          '__',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    actions:
                        isMobile
                            ? [
                              IconButton(
                                icon: const Icon(Icons.menu),
                                onPressed: () {
                                  // Show drawer or menu for mobile
                                  Scaffold.of(context).openEndDrawer();
                                },
                              ),
                            ]
                            : [
                              NavBarButton(
                                title: 'About',
                                onTap: () => _scrollToSection(0),
                              ),
                              NavBarButton(
                                title: 'Skills',
                                onTap: () => _scrollToSection(1),
                              ),
                              NavBarButton(
                                title: 'Projects',
                                onTap: () => _scrollToSection(2),
                              ),
                              NavBarButton(
                                title: 'Contact',
                                onTap: () => _scrollToSection(3),
                                isHighlighted: true,
                              ),
                            ],
                  ),

                  // Content sections
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          // Hero Section
                          HeroSection(isMobile: isMobile),

                          // Skills Section
                          SkillsSection(isMobile: isMobile),

                          // Projects Section
                          ProjectsSection(isMobile: isMobile, isTab: isTablet),

                          // Contact Section
                          ContactSection(isMobile: isMobile),

                          // Footer
                          const SizedBox(height: 40),
                          const Text(
                            '© 2025 Pranav. All rights reserved.',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _scrollToSection(int index) {
    final double offset =
        index == 0
            ? 0
            : index == 1
            ? 600
            : index == 2
            ? 1200
            : 1800;

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
