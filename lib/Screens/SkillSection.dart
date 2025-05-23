import 'package:flutter/cupertino.dart';

import '../Widgets/SectionTile.dart';
import '../Widgets/SkillCard.dart';
import '../main.dart';

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
