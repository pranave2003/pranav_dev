import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Widgets/Contactinfo.dart';
import '../Widgets/SectionTile.dart';
import '../Widgets/SocialButton.dart';
import '../main.dart';

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