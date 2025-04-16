import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
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
                          ProjectsSection(isMobile: isMobile),

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
    // Calculate positions for scrolling to different sections
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

class NavBarButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool isHighlighted;

  const NavBarButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.isHighlighted = false,
  }) : super(key: key);

  @override
  State<NavBarButton> createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color:
                widget.isHighlighted
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                    : _isHovered
                    ? Colors.white.withOpacity(0.05)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border:
                widget.isHighlighted
                    ? Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    )
                    : null,
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              color:
                  widget.isHighlighted || _isHovered
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final bool isMobile;

  const HeroSection({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 16 : 40,
      ),
      child:
          isMobile
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAvatar(context),
                  const SizedBox(height: 40),
                  _buildIntroText(context),
                ],
              )
              : Row(
                children: [
                  Expanded(flex: 3, child: _buildIntroText(context)),
                  Expanded(flex: 2, child: _buildAvatar(context)),
                ],
              ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Center(
      child: Container(
        width: isMobile ? 200 : 300,
        height: isMobile ? 200 : 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset('Assets/Skills/pranav.jpeg', fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildIntroText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hello, I\'m',
          style: TextStyle(fontSize: isMobile ? 18 : 24, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          'Pranav',
          style: TextStyle(
            fontSize: isMobile ? 40 : 60,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'Flutter Developer',
          style: TextStyle(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Based in Calicut, I specialize in creating beautiful, responsive, and user-friendly mobile applications using Flutter.',
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            color: Colors.grey[300],
            height: 1.5,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'View Projects',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Contact Me'),
            ),
          ],
        ),
      ],
    );
  }
}

class SkillsSection extends StatelessWidget {
  final bool isMobile;

  const SkillsSection({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 16 : 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Skills'),
          const SizedBox(height: 40),

          // Skills grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 2 : 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              SkillCard(
                isMobile: isMobile,
                title: 'Flutter',
                iconPath:
                    'https://cdn.iconscout.com/icon/free/png-256/free-flutter-logo-icon-download-in-svg-png-gif-file-formats--programming-language-coding-development-logos-icons-1720090.png?f=webp',
                description: 'Expert in building cross-platform apps',
              ),
              SkillCard(
                isMobile: isMobile,
                title: 'Dart',
                iconPath:
                    'https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png',
                description: 'Proficient in Dart programming language',
              ),
              SkillCard(
                isMobile: isMobile,
                title: 'Firebase',
                iconPath:
                    'https://miro.medium.com/v2/resize:fill:128:128/1*DoeJ0VLtJ0TX9yZdw_FFfg.png',
                description: 'Experience with Firebase for backend services',
              ),
              SkillCard(
                isMobile: isMobile,
                title: 'Android Studio',
                iconPath:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Android_Studio_Logo_2024.svg/2048px-Android_Studio_Logo_2024.svg.png',
                description: 'Skilled in Android Studio IDE',
              ),
              SkillCard(
                isMobile: isMobile,
                title: 'Git',
                iconPath:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Git_icon.svg/2048px-Git_icon.svg.png',
                description: 'Version control with Git',
              ),
              SkillCard(
                isMobile: isMobile,
                title: 'GitHub',
                iconPath:
                    'https://static-00.iconduck.com/assets.00/github-icon-512x512-bgdhvgjm.png',
                description: 'Collaboration using GitHub',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SkillCard extends StatefulWidget {
  final String title;
  final String iconPath;
  final String description;
  final bool isMobile;

  const SkillCard({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.description,
    required this.isMobile,
  }) : super(key: key);

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform:
            _isHovered
                ? Matrix4.translationValues(0, -5, 0)
                : Matrix4.translationValues(0, 0, 0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color:
                  _isHovered
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                      : Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(
            color:
                _isHovered
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.iconPath,
              width: widget.isMobile ? 20 : 60,
              height: widget.isMobile ? 20 : 60,
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: widget.isMobile ? 12 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: widget.isMobile ? 10 : 14,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  final bool isMobile;

  const ProjectsSection({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 16 : 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Projects'),
          const SizedBox(height: 40),

          // Projects list
          isMobile
              ? Column(children: _buildProjectCards(context))
              : GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                childAspectRatio: 1.3,
                children: _buildProjectCards(context),
              ),
        ],
      ),
    );
  }

  List<Widget> _buildProjectCards(BuildContext context) {
    return [
      ProjectCard(
        title: 'E-Commerce App',
        description:
            'A Flutter e-commerce application with clean UI and smooth animations.',
        imagePath:
            'https://www.bleepstatic.com/content/hl-images/2021/05/10/GitHub-headpic.jpg',
        tags: ['Flutter', 'Firebase', 'State Management'],
        isMobile: isMobile,
      ),
      ProjectCard(
        title: 'Weather App',
        description:
            'A beautiful weather application with real-time updates and forecasts.',
        imagePath:
            'https://www.bleepstatic.com/content/hl-images/2021/05/10/GitHub-headpic.jpg',
        tags: ['Flutter', 'API Integration', 'Animations'],
        isMobile: isMobile,
      ),
      ProjectCard(
        title: 'Task Manager',
        description:
            'https://www.bleepstatic.com/content/hl-images/2021/05/10/GitHub-headpic.jpg',
        imagePath:
            'https://www.bleepstatic.com/content/hl-images/2021/05/10/GitHub-headpic.jpg',
        tags: ['Flutter', 'SQLite', 'Local Notifications'],
        isMobile: isMobile,
      ),
      ProjectCard(
        title: 'Social Media App',
        description:
            'A social networking application with real-time chat and post sharing.',
        imagePath:
            'https://www.bleepstatic.com/content/hl-images/2021/05/10/GitHub-headpic.jpg',
        tags: ['Flutter', 'Firebase', 'Cloud Functions'],
        isMobile: isMobile,
      ),
    ];
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final List<String> tags;
  final bool isMobile;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.tags,
    required this.isMobile,
  }) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        margin:
            widget.isMobile
                ? const EdgeInsets.only(bottom: 30)
                : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:
                  _isHovered
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                      : Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project image with overlay
            Stack(
              children: [
                Image.network(
                  widget.imagePath,
                  width: double.infinity,
                  height: widget.isMobile ? 200 : 180,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _isHovered ? 0.9 : 0,
                    child: Container(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.8),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text('View Project'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Project details
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        widget.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  final bool isMobile;

  const ContactSection({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 16 : 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Contact'),
          const SizedBox(height: 40),

          isMobile
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContactInfo(context),
                  const SizedBox(height: 40),
                  _buildContactForm(context),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildContactInfo(context)),
                  const SizedBox(width: 60),
                  Expanded(flex: 3, child: _buildContactForm(context)),
                ],
              ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get in Touch',
          style: TextStyle(
            fontSize: isMobile ? 24 : 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I\'m always open to discussing new projects, creative ideas or opportunities to be part of your vision.',
          style: TextStyle(fontSize: 16, color: Colors.grey[300], height: 1.6),
        ),
        const SizedBox(height: 30),

        // Contact details
        const ContactInfoItem(
          icon: Icons.email_outlined,
          title: 'Email',
          value: 'pranav@example.com',
        ),
        const SizedBox(height: 16),
        const ContactInfoItem(
          icon: Icons.location_on_outlined,
          title: 'Location',
          value: 'Calicut, Kerala, India',
        ),
        const SizedBox(height: 30),

        // Social links
        Row(
          children: [
            SocialButton(
              icon: FontAwesomeIcons.github,
              url: 'https://github.com/',
              color: Colors.white,
            ),
            const SizedBox(width: 16),
            SocialButton(
              icon: FontAwesomeIcons.linkedin,
              url: 'https://linkedin.com/',
              color: const Color(0xFF0A66C2),
            ),
            const SizedBox(width: 16),
            SocialButton(
              icon: FontAwesomeIcons.twitter,
              url: 'https://twitter.com/',
              color: const Color(0xFF1DA1F2),
            ),
            const SizedBox(width: 16),
            SocialButton(
              icon: FontAwesomeIcons.instagram,
              url: 'https://instagram.com/',
              color: const Color(0xFFE1306C),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send a Message',
            style: TextStyle(
              fontSize: isMobile ? 20 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Form fields
          const TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Subject',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Message',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),

          // Submit button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Send Message',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ContactInfoItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
            ),
          ],
        ),
      ],
    );
  }
}

class SocialButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final Color color;

  const SocialButton({
    Key? key,
    required this.icon,
    required this.url,
    required this.color,
  }) : super(key: key);

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _launchURL(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered ? widget.color : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: widget.color, width: 2),
          ),
          child: FaIcon(
            widget.icon,
            color: _isHovered ? Colors.black : widget.color,
            size: 18,
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.03)
          ..strokeWidth = 1;

    // Draw a grid pattern
    for (var i = 0; i < size.width; i += 30) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        paint,
      );
    }

    for (var i = 0; i < size.height; i += 30) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
