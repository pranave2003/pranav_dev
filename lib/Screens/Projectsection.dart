import 'package:flutter/cupertino.dart';

import '../Widgets/Projectcard.dart';
import '../Widgets/SectionTile.dart';
import '../main.dart';

class ProjectsSection extends StatelessWidget {
  final bool isMobile;
  final bool isTab;

  const ProjectsSection({Key? key, required this.isMobile, required this.isTab})
    : super(key: key);

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
              : isTab
              ? GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 50,
                childAspectRatio: 1.3,
                children: _buildProjectCards(context),
              )
              : GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 50,
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
